// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {bytes32Ext} from "./bytes32Ext.sol";
import {bytes32ArrayExt} from "./bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./bytes32MatrixExt.sol";
import {stringToBytes32Parser} from "./stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./bytes32ToStringParser.sol";

library edgesExt {
    using bytes32Ext for bytes32;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];
    using stringToBytes32Parser for *;
    using bytes32ToStringParser for *;

    /// @notice Validates and processes the list of edges.
    /// @dev A valid edge is an array of two upper-cased character strings where both strings are valid vertices.
    /// @param _edges The array of edges to be validated.
    /// @param validatedVertices The list of valid vertices.
    /// @return _validEdges The processed array of valid edges.
    function validEdges(
        string[][] memory _edges,
        bytes32[] memory validatedVertices
    ) public returns (bytes32[][] memory _validEdges) {
        //related to vertices
        bytes32[][] memory encodedEdges = _edges.stringMatrixToBytes32Matrix();
        _validEdges = encodedEdges
            .upperCapStringMatrix()
            .onlySubsetsOf(validatedVertices)
            .removeDuplicatesBytes32Matrix();
        //1. All edges must have both of its vertices in the vertices array
        //2. removes invalid edges (edges that do not connect two vertices)
        //3. removes empty strings
    }

    // Helper function to sort edges alphabetically
    function sortEdges(
        string[][] memory _edges
    ) external returns (string[][] memory) {
        // Bubble sort for simplicity (replace with a more efficient algorithm if needed)
        for (uint256 i = 0; i < _edges.length; i++) {
            for (uint256 j = i + 1; j < _edges.length; j++) {
                // Compare the two edges as strings
                if (compareEdges(_edges[i], _edges[j])) {
                    // Swap edges if they are out of order
                    string[] memory temp = _edges[i];
                    _edges[i] = _edges[j];
                    _edges[j] = temp;
                }
            }
        }
        return _edges;
    }

    function compareEdges(
        string[] memory edge1,
        string[] memory edge2
    ) internal pure returns (bool) {
        // Compare the first vertex of each edge
        if (
            keccak256(abi.encodePacked(edge1[0])) !=
            keccak256(abi.encodePacked(edge2[0]))
        ) {
            return
                keccak256(abi.encodePacked(edge1[0])) >
                keccak256(abi.encodePacked(edge2[0]));
        }
        // If the first vertices are equal, compare the second vertices
        return
            keccak256(abi.encodePacked(edge1[1])) >
            keccak256(abi.encodePacked(edge2[1]));
    }
}
