// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {bytes32Ext} from "./bytes32Ext.sol";
import {bytes32ArrayExt} from "./bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./bytes32MatrixExt.sol";
import {stringToBytes32Parser} from "./stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./bytes32ToStringParser.sol";

library vertexExt {
    using bytes32Ext for bytes32;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];
    using stringToBytes32Parser for *;
    using bytes32ToStringParser for *;
    /// @notice Validates and processes the list of vertices.
    /// @dev A valid vertex is an upper-cased character string with no duplicates or invalid characters.
    /// @param _vertices The array of vertices to be validated.
    /// @return _validVertices The processed array of valid vertices.
    function validVertices(
        string[] memory _vertices
    ) public pure returns (bytes32[] memory _validVertices) {
        bytes32[] memory encodedVertices = _vertices
            .stringArrayToBytes32Array();

        _validVertices = encodedVertices
            .upperCapEncodedStringArray()
            .removeDuplicatesBytes32Array();
    }

    /// @notice Returns the difference between two arrays of vertices.
    /// @dev The function takes two arrays of vertices and returns a new array
    /// containing all the vertices that are in the first array but not in the second.
    /// @param _vertices1 The first array of vertices.
    /// @param _vertices2 The second array of vertices.
    /// @return _vertices1MinusVertices2 The difference between the two arrays.
    function diff(
        bytes32[] memory _vertices1,
        bytes32[] memory _vertices2
    ) external returns (bytes32[] memory _vertices1MinusVertices2) {
        uint256 count = 0;
        bytes32[] memory tempDiff = new bytes32[](_vertices1.length);

        for (uint256 i = 0; i < _vertices1.length; i++) {
            bool found = false;
            for (uint256 j = 0; j < _vertices2.length; j++) {
                if (_vertices1[i] == _vertices2[j]) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                tempDiff[count] = _vertices1[i];
                count++;
            }
        }

        _vertices1MinusVertices2 = new bytes32[](count);
        for (uint256 k = 0; k < count; k++) {
            _vertices1MinusVertices2[k] = tempDiff[k];
        }
    }
}
