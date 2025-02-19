// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {bytes32Ext} from "./libraries/bytes32Ext.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./libraries/bytes32MatrixExt.sol";

import {graphTypes} from "./graphTypes.sol";

contract graphInvariants is graphTypes {
    //TODO document invariants contract purpose

    using bytes32Ext for bytes32;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];

    Graph internal graphState;

    function validateVertices(bytes32[] memory _vertices) internal {
        //-------STREAM----------
        //1 A vertex is a collection of upper cased chars in [a-z]
        //2. removes duplicates
        //3. removes empty strings
        //4. removes invalid characters
        graphState.vertices = _vertices
            .upperCapEncodedStringArray()
            .removeDuplicatesBytes32Array();
    }

    function validateEdges(bytes32[][] memory _edges) internal {
        //related to vertices
        graphState.edges = _edges
            .onlySubsetsOf(graphState.vertices)
            .removeDuplicatesBytes32Matrix();
        //1. All edges must have both of its vertices in the vertices array
        //2. removes invalid edges (edges that do not connect two vertices)
        //3. removes empty strings
    }
}
