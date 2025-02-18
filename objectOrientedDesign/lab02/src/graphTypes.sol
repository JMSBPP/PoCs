// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface graphTypes {
    struct Graph {
        bytes32 encodedGraph;
        bytes32[] vertices;
        bytes32[][] edges;
        bool initialized;
    }
}
