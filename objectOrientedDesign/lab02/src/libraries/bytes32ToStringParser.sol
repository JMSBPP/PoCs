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
    ) public pure returns (string memory) {
        uint8 i = 0;
        while (i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (uint8 j = 0; j < i; j++) {
            bytesArray[j] = _bytes32[j];
        }
        return string(bytesArray);
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
     * @param matrix The bytes32 matrix to be converted.
     * @return stringMatrix The string matrix representation of the bytes32 matrix.
     */
    function bytes32MatrixToStringMatrix(
        bytes32[][] memory matrix
    ) public pure returns (string[][] memory) {
        string[][] memory result = new string[][](matrix.length);
        for (uint256 i = 0; i < matrix.length; i++) {
            result[i] = new string[](matrix[i].length);
            for (uint256 j = 0; j < matrix[i].length; j++) {
                result[i][j] = bytes32ToString(matrix[i][j]);
            }
        }
        return result;
    }
}
