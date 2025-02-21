// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {graphTypes} from "./graphTypes.sol";
import {vertexExt} from "./libraries/vertexExt.sol";
import {edgesExt} from "./libraries/edgesExt.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";
import {IgraphStorage} from "./interfaces/IgraphStorage.sol";
contract graphStorage is IgraphStorage, graphTypes {
    using stringToBytes32Parser for *;
    using bytes32ToStringParser for bytes32;

    using vertexExt for string[];
    using edgesExt for string[][];

    Graph internal graphState;

    constructor() {}
    /**
     * @dev Initializes the graph with a given set of vertices and edges.
     *      The graph is validated, and any invalid vertices or edges are removed.
     * @param _vertices An array of vertices, where each vertex is represented as a string.
     * @param _edges An array of edges, where each edge is represented as an array of two strings, representing the two vertices that the edge connects.
     */
    function initialize(
        string[] memory _vertices,
        string[][] memory _edges
    ) public {
        setVertices(_vertices);
        setEdges(_edges, graphState.vertices);
        setId();
    }

    /**
     * @dev Sets the vertices of the graph.
     * @param _vertices An array of vertices, where each vertex is represented as a bytes32 value.
     */
    function setVertices(string[] memory _vertices) internal {
        bytes32[] memory validVertices = _vertices.validVertices();
        graphState.vertices = validVertices;
    }

    /**
     * @dev Sets the edges of the graph.
     * @param _edges An array of edges, where each edge is represented as a bytes32[][] value.
     */
    function setEdges(
        string[][] memory _edges,
        bytes32[] memory validVertices
    ) internal {
        bytes32[][] memory validEdges = _edges.validEdges(validVertices);
        graphState.edges = validEdges;
    }

    /**
     * @dev Sets the ID of the graph based on its current state.
     *      The ID is computed by hashing the current vertices and edges.
     */
    function setId() internal {
        graphState.id = uint256(
            keccak256(abi.encode(graphState.vertices, graphState.edges))
        );
    }

    /**
     * @dev Returns the vertices of the graph.
     * @return An array of vertices, where each vertex is represented as a bytes32 value.
     */
    function _getVertices() public view returns (bytes32[] memory) {
        return graphState.vertices;
    }

    /**
     * @dev Returns the edges of the graph.
     * @return An array of edges, where each edge is represented as an array of two vertices.
     */
    function _getEdges() public view returns (bytes32[][] memory) {
        return graphState.edges;
    }

    /**
     * @dev Returns the ID of the graph.
     * @return The ID of the graph as a uint256 value.
     */
    function getId() public view returns (uint256) {
        return graphState.id;
    }
}
