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
    /// @notice Sorts the given list of edges alphabetically.
    /// @dev This function is used to sort the edges before comparing them.
    /// @param _edges The list of edges to be sorted.
    /// @return _sortedEdges The sorted list of edges.
    function sortEdges(
        string[][] memory _edges
    ) external returns (string[][] memory _sortedEdges) {
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

    /// @notice Gets the edges connected to the given vertex.
    /// @dev This function is used by the removeVertex function to filter out the edges that are connected to the removed vertex.
    /// @param currentEdges The current list of edges in the graph.
    /// @param _vertex The vertex to be removed.
    /// @return _sharedEdges The list of edges connected to the given vertex.
    function sharedEdges(
        bytes32[][] memory currentEdges,
        bytes32 _vertex
    ) external returns (bytes32[][] memory _sharedEdges) {
        uint count = 0;

        // Count edges connected to the given vertex
        for (uint i = 0; i < currentEdges.length; i++) {
            if (
                currentEdges[i][0] == _vertex || currentEdges[i][1] == _vertex
            ) {
                count++;
            }
        }

        // Allocate memory for filtered edges
        _sharedEdges = new bytes32[][](count);
        uint index = 0;

        // Store only the edges connected to the vertex
        for (uint i = 0; i < currentEdges.length; i++) {
            if (
                currentEdges[i][0] == _vertex || currentEdges[i][1] == _vertex
            ) {
                _sharedEdges[index] = currentEdges[i];
                index++;
            }
        }
    }

    /// @notice Compares two edges lexicographically.
    /// @dev This function is used to sort the edges alphabetically.
    /// @param edge1 The first edge to be compared.
    /// @param edge2 The second edge to be compared.
    /// @return True if edge1 is lexicographically greater than edge2, false otherwise.
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

    /// @notice Removes specified edges from the list of edges.
    /// @dev This function iterates over the list of edges and excludes those found in the _edgesToRemove list.
    /// @param _edgesToRemove The list of edges to be removed.
    /// @param _edges The current list of edges.
    /// @return remainingEdges The list of edges after removal.
    function removeEdges(
        bytes32[][] memory _edgesToRemove,
        bytes32[][] memory _edges
    ) public pure returns (bytes32[][] memory) {
        uint count = 0;

        // Count edges that will remain after removal
        for (uint i = 0; i < _edges.length; i++) {
            bool toRemove = false;
            for (uint j = 0; j < _edgesToRemove.length; j++) {
                if (
                    (_edges[i][0] == _edgesToRemove[j][0] &&
                        _edges[i][1] == _edgesToRemove[j][1]) ||
                    (_edges[i][0] == _edgesToRemove[j][1] &&
                        _edges[i][1] == _edgesToRemove[j][0])
                ) {
                    toRemove = true;
                    break;
                }
            }
            if (!toRemove) {
                count++;
            }
        }

        // Create a new array for remaining edges
        bytes32[][] memory remainingEdges = new bytes32[][](count);
        uint index = 0;

        // Populate the new array with edges not marked for removal
        for (uint i = 0; i < _edges.length; i++) {
            bool toRemove = false;
            for (uint j = 0; j < _edgesToRemove.length; j++) {
                if (
                    (_edges[i][0] == _edgesToRemove[j][0] &&
                        _edges[i][1] == _edgesToRemove[j][1]) ||
                    (_edges[i][0] == _edgesToRemove[j][1] &&
                        _edges[i][1] == _edgesToRemove[j][0])
                ) {
                    toRemove = true;
                    break;
                }
            }
            if (!toRemove) {
                remainingEdges[index] = _edges[i];
                index++;
            }
        }

        return remainingEdges;
    }
}
