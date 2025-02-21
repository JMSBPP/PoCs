// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IgraphCalculatorLogic} from "./interfaces/IgraphCalculatorLogic.sol";
import {graphCalculatorStorage, IgraphLogic} from "./graphCalculatorStorage.sol";
import {bytes32Ext} from "./libraries/bytes32Ext.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./libraries/bytes32MatrixExt.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {IgraphCalculatorStorageAPI} from "./interfaces/IgraphCalculatorStorageAPI.sol";
contract graphCalculatorv1 is graphCalculatorStorage {
    using bytes32Ext for bytes32;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];
    using bytes32ToStringParser for *;
    using stringToBytes32Parser for *;

    constructor() {}

    /// @notice Creates a new graph with a given name
    /// @param name The name of the graph to create
    /// @dev Reverts if a graph with the same name already exists
    function create(string memory name) public {
        bytes32 encodedName = name.stringToBytes32();
        if (nameExists(encodedName)) {
            revert nameAlreadyExists();
        }
        addKey(encodedName);
    }

    /// @notice Creates a new graph and assigns it to a given name
    /// @param graphName The name of the graph to assign
    /// @param _vertices The vertices of the graph
    /// @param _edges The edges of the graph
    /// @dev Reverts if a graph with the same name already exists
    function assign(
        string memory graphName,
        string[] memory _vertices,
        string[][] memory _edges
    ) public {
        bytes32 encodedName = graphName.stringToBytes32();
        if (nameExists(encodedName)) {
            addGraph(graphName, _vertices, _edges);
        } else {
            create(graphName);
            assign(graphName, _vertices, _edges);
        }
    }

    /// @notice Gets the vertices and edges of a graph with a given name
    /// @param name The name of the graph to get
    /// @return _vertices The vertices of the graph
    /// @return _edges The edges of the graph
    /// @dev Reverts if the graph does not exist
    function getGraph(
        string memory name
    ) public returns (string[] memory _vertices, string[][] memory _edges) {
        bytes32 encodedName = name.stringToBytes32();
        if (nameExists(encodedName)) {
            address _graphAddress = getGraphAddress(encodedName);
            if (_graphAddress != address(0)) {
                _vertices = IgraphLogic(_graphAddress).getVertices();
                _edges = IgraphLogic(_graphAddress).getEdges();
            } else {
                _vertices = new string[](0);
                _edges = new string[][](0);
            }
        }
    }
}
