// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {graphTypes} from "./graphTypes.sol";
import {stringUtilsExt} from "../src/libraries/stringUtilsExt.sol";

contract GraphStorageAccess is graphTypes {
    using stringUtilsExt for *;
    Graph private graphState;

    modifier isNotInitialized() {
        require(graphState.initialized == false, "Graph is not initialized");
        _;
    }

    modifier isInitialized() {
        require(graphState.initialized == true, "Graph is not initialized");
        _;
    }

    constructor() {
        graphState.initialized = false;
    }

    function initialize(
        string[] calldata _vertices,
        string[][] memory _edges
    ) public isNotInitialized {
        setEncodableGraph(_vertices, _edges, true);
    }

    function setEncodableGraph(
        string[] calldata _vertices,
        string[][] memory _edges,
        bool _initialized
    ) public {
        graphState.vertices = _vertices.upperStringArray();
        validateVertices();

        if (_validEdges(_edges)) {
            graphState.edges = _edges.upperStringMatrix();
        }

        validateEdges();
        graphState.initialized = _initialized;
        graphState.encodedGraph = bytes32(abi.encode(_vertices, _edges));
    }
    function validateVertices() private {
        //1. removes duplicates
        //2. removes empty strings
        //3. removes invalid characters
    }
    function validateEdges() private {
        //1. removes duplicates
        //2. removes invalid edges (edges that do not connect two vertices)
        //3. removes empty strings
    }

    //Edges must be built from the vertices
    //1. given the list of vertices
    //1.1 it is a valid edge if both vertiices are in vertices.
    function isValidEdge(
        string[] memory edge
    ) private view returns (bool _isValidEdge) {
        _isValidEdge = false;
        for (uint256 i = 0; i < edge.length; i++) {
            if (edge[i].searchString(graphState.vertices)) {
                _isValidEdge = true;
                break;
            }
        }
    }

    function _validEdges(
        string[][] memory _edges
    ) private view returns (bool _isValidEdges) {
        _isValidEdges = false;
        for (uint256 i = 0; i < _edges.length; i++) {
            if (isValidEdge(_edges[i])) {
                _isValidEdges = true;
                break;
            }
        }
    }

    function getVertices() public view returns (bytes32[] memory _vertices) {
        _vertices = graphState.vertices;
    }

    function getEdges() public view returns (bytes32[][] memory _edges) {
        _edges = graphState.edges;
    }
    function getEncodedGraph() public view returns (bytes32 encodedGraph) {
        encodedGraph = graphState.encodedGraph;
    }
}
