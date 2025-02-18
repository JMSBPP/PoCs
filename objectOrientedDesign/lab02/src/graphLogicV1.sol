// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IgraphLogic} from "./interfaces/IgraphLogic.sol";
import {GraphStorageAccess} from "./graphStorageAccess.sol";
import {stringUtilsExt} from "../src/libraries/stringUtilsExt.sol";
contract GraphLogicV1 is IgraphLogic {
    using stringUtilsExt for *;
    GraphStorageAccess private graph;

    constructor(address _graphStorage) {
        graph = GraphStorageAccess(_graphStorage);
    }

    function contains(
        string memory vertexName
    ) external view returns (bool isInGraph) {
        isInGraph = vertexName.searchString(graph.getVertices());
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
        numberOfVertices = graph.getVertices().length;
    }
    function edges() external view returns (uint256 numberOfEdges) {
        numberOfEdges = graph.getEdges().length;
    }
}
