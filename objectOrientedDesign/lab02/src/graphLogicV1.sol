// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IgraphLogic} from "./interfaces/IgraphLogic.sol";
import {graphStorage} from "./graphStorage.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";
import {bytes32Ext} from "./libraries/bytes32Ext.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./libraries/bytes32MatrixExt.sol";
import {vertexExt} from "./libraries/vertexExt.sol";
import {edgesExt} from "./libraries/edgesExt.sol";

contract graphLogicV1 is IgraphLogic, graphStorage {
    using bytes32Ext for bytes32;
    using bytes32ToStringParser for *;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];
    using stringToBytes32Parser for string;
    using vertexExt for *;
    using edgesExt for *;

    constructor() {}

    /// @notice Check if a vertex is in the graph
    /// @param vertexName The name of the vertex to check
    /// @return isInGraph True if the vertex is in the graph, false otherwise
    function contains(
        string memory vertexName
    ) external view returns (bool isInGraph) {
        bytes32 encodedVertexName = vertexName.stringToBytes32();
        isInGraph = _getVertices().searchBytes32(encodedVertexName);
    }
    //NOTE: MISSING IMPLEMENTATION
    function path(
        string memory fromVertex,
        string memory toVertex
    ) external returns (bytes32 _pathGraphEncoded) {
        _pathGraphEncoded = bytes32(0);
    }

    //NOTE: MISSING IMPLEMENTATION

    function union(
        string memory g1
    ) external returns (bytes32 g1UnionCurrentGraph) {
        g1UnionCurrentGraph = bytes32(0);
    }

    function vertices() external view returns (uint256 numberOfVertices) {
        numberOfVertices = _getVertices().length;
    }
    /**
     * @dev Returns the number of edges in the graph.
     * @return numberOfEdges The total count of edges.
     */
    function edges() external view returns (uint256 numberOfEdges) {
        numberOfEdges = _getEdges().length;
    }

    /**
     * @notice Compares the current graph with another graph by their unique IDs.
     * @dev This function takes a graph represented as a struct with vertices and edges,
     *      validates the data, and then compares the resulting ID with the ID of the current graph.
     *      The IDs are computed by hashing the current vertices and edges.
     * @param otherGraph The other graph to compare with, represented as a struct with vertices and edges.
     * @return areGraphsEqual A boolean indicating whether the two graphs are equal.
     */
    function equals(
        Graph memory otherGraph
    ) external returns (bool areGraphsEqual) {
        string[] memory otherGraphVerticesToValidate = otherGraph
            .vertices
            .bytes32ArrayToStringArray();
        string[][] memory otherGraphEdgesToValidate = otherGraph
            .edges
            .bytes32MatrixToStringMatrix();
        bytes32[] memory otherGraphVertices = otherGraphVerticesToValidate
            .validVertices();
        bytes32[][] memory otherGraphEdges = otherGraphEdgesToValidate
            .validEdges(otherGraphVertices);
        uint256 otherGraphID = uint256(
            keccak256(abi.encode(otherGraphVertices, otherGraphEdges))
        );
        // Assuming that our graph is already initialized
        uint256 currentGraphID = getId();
        areGraphsEqual = currentGraphID == otherGraphID;
    }

    /**
     * @notice Compares the current graph with another graph by their unique IDs.
     * @param otherGraphDataAddress The address of the other graph's storage contract.
     * @return areGraphsEqual A boolean indicating whether the two graphs are equal.
     */
    function equalsGraph(
        address otherGraphDataAddress
    ) external view returns (bool areGraphsEqual) {
        (, bytes memory data) = otherGraphDataAddress.staticcall(
            abi.encodeWithSignature("getId()")
        );
        uint256 otherGraphID = abi.decode(data, (uint256));
        uint256 currentGraphID = getId();
        areGraphsEqual = currentGraphID == otherGraphID;
    }

    /**
     * @notice Returns a string representation of the graph.
     * @return graphString A string representation of the graph, where each line is a vertex and each semicolon
     *      separates an edge.
     */
    function toString() external returns (string memory graphString) {
        // Get the edges from storage
        bytes32[][] memory encodedEdges = _getEdges();
        string[][] memory _edges = encodedEdges.bytes32MatrixToStringMatrix();

        // Sort the edges alphabetically
        _edges = _edges.sortEdges();

        // Build the result string
        bytes memory result;
        for (uint256 i = 0; i < _edges.length; i++) {
            // Add the opening parenthesis and first vertex
            result = abi.encodePacked(
                result,
                "(",
                _edges[i][0],
                ", ",
                _edges[i][1],
                ")"
            );

            // Add a space between edges (except after the last edge)
            if (i < _edges.length - 1) {
                result = abi.encodePacked(result, " ");
            }
        }

        // Convert the result to a string
        graphString = string(result);
    }

    /**
     * @notice Sets the graph to the given vertices and edges.
     * @dev This function sets the graph to the given vertices and edges.
     *      The graph is validated, and any invalid vertices or edges are removed.
     * @param _vertices An array of strings representing the vertices in the graph.
     * @param _edges An array of arrays of strings representing the edges in the graph.
     *      Each inner array contains two strings representing the two vertices that the edge connects.
     */
    function setGraph(
        string[] memory _vertices,
        string[][] memory _edges
    ) external {
        initialize(_vertices, _edges);
    }

    /**
     * @notice Returns an array of the vertices in the graph.
     * @return _vertices An array of strings representing the vertices in the graph.
     */
    function getVertices() external view returns (string[] memory _vertices) {
        bytes32[] memory encodedVertices = _getVertices();
        _vertices = encodedVertices.bytes32ArrayToStringArray();
    }

    /**
     * @notice Returns an array of the edges in the graph.
     * @return _edges An array of arrays of strings representing the edges in the graph.
     *      Each inner array contains two strings representing the two vertices that the edge connects.
     */
    function getEdges() external view returns (string[][] memory _edges) {
        bytes32[][] memory encodedEdges = _getEdges();
        _edges = encodedEdges.bytes32MatrixToStringMatrix();
    }
}
