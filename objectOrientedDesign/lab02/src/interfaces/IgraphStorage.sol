// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IgraphStorage {
    function initialize(
        string[] memory vertices,
        string[][] memory edges
    ) external;
    function _getVertices() external returns (bytes32[] memory);
    function _getEdges() external returns (bytes32[][] memory);
    function getId() external returns (uint256);
}
