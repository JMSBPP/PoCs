// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {graphTypes} from "./graphTypes.sol";
import {vertexExt} from "./libraries/vertexExt.sol";
import {edgesExt} from "./libraries/edgesExt.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";
import {IgraphStorage} from "./interfaces/IgraphStorage.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {bytes32Ext} from "./libraries/bytes32Ext.sol";

contract graphStorage is IgraphStorage, graphTypes {
    using stringToBytes32Parser for *;
    using bytes32ToStringParser for *;
    using bytes32Ext for *;
    using bytes32ArrayExt for *;
    using vertexExt for *;
    using edgesExt for *;

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
     * @dev Removes a given vertex from the graph.
     *      The function checks if the vertex is in the graph and if it is connected to any edges.
     *      If it is connected to any edges, the edges are removed from the graph.
     * @param _vertex The vertex to be removed, represented as a string.
     */
    function removeVertex(string memory _vertex) public {
        //verify if the valid vertex is in the vertex array
        bytes32 encodedUpperVertex = _vertex
            .stringToBytes32()
            .upperCapEncodedString();
        if (_getVertices().searchBytes32(encodedUpperVertex)) {
            //verify if the vertex is connected to any edges
            bytes32[][] memory currentEdges = _getEdges();
            bytes32[][] memory edgesToBeRemoved = currentEdges.sharedEdges(
                encodedUpperVertex
            );
            // remove the edges connected to the vertex
            graphState.edges = edgesToBeRemoved.removeEdges(currentEdges);
        }
    }

    /**
     * @dev Sets the vertices of the graph.
     * @param _vertices An array of vertices, where each vertex is represented as a bytes32 value.
     */
    function setVertices(string[] memory _vertices) internal {
        bytes32[] memory validVertices = _vertices.validVertices().diff(
            graphState.vertices
        );
        graphState.vertices = validVertices;
        setId();
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
