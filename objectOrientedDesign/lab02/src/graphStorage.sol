// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {graphTypes} from "./graphTypes.sol";
import {graphInvariants} from "../src/graphInvariants.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";

contract graphStorage is graphTypes, graphInvariants {
    using stringToBytes32Parser for string;
    using bytes32ToStringParser for bytes32;

    constructor() {}
    function initialize(
        string[] memory _vertices,
        string[][] memory _edges
    ) public {
        uint256 vertexCount = _vertices.length;
        uint256 edgeCount = _edges.length;
        bytes32[] memory encodedVertices = new bytes32[](vertexCount);
        bytes32[][] memory encodedEdges = new bytes32[][](edgeCount);

        for (uint256 i = 0; i < vertexCount; i++) {
            encodedVertices[i] = _vertices[i].stringToBytes32();
        }
        for (uint256 i = 0; i < edgeCount; i++) {
            encodedEdges[i] = new bytes32[](_edges[i].length);
            for (uint256 j = 0; j < _edges[i].length; j++) {
                encodedEdges[i][j] = _edges[i][j].stringToBytes32();
            }
        }
        validateVertices(encodedVertices);
        validateEdges(encodedEdges);
    }

    /**
     * @dev Returns the vertices of the graph.
     * @return An array of vertices, where each vertex is represented as a bytes32 value.
     */
    function getVertices() public view returns (bytes32[] memory) {
        return graphState.vertices;
    }

    /**
     * @dev Returns the edges of the graph.
     * @return An array of edges, where each edge is represented as an array of two vertices.
     */
    function getEdges() public view returns (bytes32[][] memory) {
        return graphState.edges;
    }

    /**
     * @dev Returns the entire graph as a single bytes32 value.
     * This is currently unused, but may be useful for future
     * optimization or verification of the graph.
     * @return encodedGraph The entire graph as a single bytes32 value.
     */
    function getEncodedGraph() public view returns (bytes32 encodedGraph) {
        encodedGraph = graphState.encodedGraph;
    }
}
