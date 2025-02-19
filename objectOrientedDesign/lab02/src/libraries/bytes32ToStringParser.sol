// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library bytes32ToStringParser {
    /**
     * @dev Converts a bytes32 to a string.
     * @param _bytes32 The bytes32 to be converted.
     * @return _string The string representation of the bytes32.
     */
    function bytes32ToString(
        bytes32 _bytes32
    ) public pure returns (string memory _string) {
        bytes memory decodabledBytes = abi.encodePacked(_bytes32);
        _string = abi.decode(decodabledBytes, (string));
    }

    /**
     * @dev Converts an array of bytes32 into an array of strings.
     * @param _bytes32Array The bytes32 array to be converted.
     * @return stringArray The string array representation of the bytes32 array.
     */
    function bytes32ArrayToStringArray(
        bytes32[] memory _bytes32Array
    ) public pure returns (string[] memory stringArray) {
        stringArray = new string[](_bytes32Array.length);
        for (uint i = 0; i < _bytes32Array.length; i++) {
            stringArray[i] = bytes32ToString(_bytes32Array[i]);
        }
    }

    /**
     * @dev Converts a bytes32 matrix into a string matrix.
     * @param stringMatrix The bytes32 matrix to be converted.
     * @return bytes32Matrix The string matrix representation of the bytes32 matrix.
     */
    function bytes32MatrixToStringMatrix(
        bytes32[][] memory stringMatrix
    ) external pure returns (string[][] memory bytes32Matrix) {
        bytes32Matrix = new string[][](stringMatrix.length);
        for (uint i = 0; i < stringMatrix.length; i++) {
            bytes32Matrix[i] = bytes32ArrayToStringArray(stringMatrix[i]);
        }
    }
}
