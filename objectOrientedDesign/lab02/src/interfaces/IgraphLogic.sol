// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {GraphStorageAccess} from "../graphStorageAccess.sol";
import {graphTypes} from "../graphTypes.sol";
interface IgraphLogic is graphTypes {
    function contains(
        string memory vertexName
    ) external returns (bool isInGraph);

    function path(
        string memory fromVertex,
        string memory toVertex
    ) external returns (bytes32 _pathGraphEncoded);

    function union(
        string memory g1
    ) external returns (bytes32 g1UnionCurrentGraph);
    function vertices() external returns (uint256 numberOfVertices);
    function edges() external returns (uint256 numberOfEdges);
}
