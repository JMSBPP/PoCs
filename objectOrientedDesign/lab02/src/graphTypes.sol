// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface graphTypes {
    struct Graph {
        uint256 id;
        bytes32[] vertices;
        bytes32[][] edges;
    }
}
