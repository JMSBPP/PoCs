// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IgraphCalculatorStorageAPI} from "./interfaces/IgraphCalculatorStorageAPI.sol";
import {graphTypes} from "./graphTypes.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {IgraphLogic} from "./interfaces/IgraphLogic.sol";
import {graphLogicV1} from "./graphLogicV1.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
contract graphCalculatorStorage is graphTypes {
    using bytes32ArrayExt for bytes32[];
    using stringToBytes32Parser for *;
    // NOTE: This mapping uses a string as a key, but this string is not the actual key
    // used in the mapping. Instead, the key is the keccak256 hash of the string.
    // This is done to ensure that the mapping is not vulnerable to reentrancy attacks.
    // See https://consensys.github.io/smart-contract-best-practices/reentrancy/

    mapping(bytes32 => address) private variables;
    bytes32[] private availableKeys;

    error nameAlreadyExists();
    error graphNotFound();
    constructor() {}

    /**
     * @dev Checks if a given name has been assigned to a graph.
     * @param encodedName The encoded name to check.
     * @return _nameExists True if the name has been assigned, false otherwise.
     */
    function nameExists(
        bytes32 encodedName
    ) public view returns (bool _nameExists) {
        _nameExists = availableKeys.searchBytes32(encodedName);
    }

    /**
     * @dev Adds a new key to the list of available keys.
     * @param encodedName The encoded name to add as a key.
     */
    function addKey(bytes32 encodedName) public {
        availableKeys.push(encodedName);
    }

    /**
     * @dev Creates a new graph with the given name, vertices, and edges and adds it to the mapping.
     * @param name The name of the graph.
     * @param vertices The vertices of the graph.
     * @param edges The edges of the graph.
     */
    function addGraph(
        string memory name,
        string[] memory vertices,
        string[][] memory edges
    ) public {
        //creates the graph

        //deploy graph
        graphLogicV1 graph = new graphLogicV1();
        //set graph
        IgraphLogic(address(graph)).setGraph(vertices, edges);
        //add it to variables
        variables[name.stringToBytes32()] = address(graph);
    }

    /**
     * @dev Returns the address of the graph associated with the given name.
     * @param name The name of the graph.
     * @return The address of the graph.
     */
    function getGraphAddress(bytes32 name) public view returns (address) {
        return variables[name];
    }
}
