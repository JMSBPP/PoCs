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
}
