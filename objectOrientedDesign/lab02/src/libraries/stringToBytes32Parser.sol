// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library stringToBytes32Parser {
    /**
     * @dev This function converts a string to a bytes32. It will also be used by the client to create the same bytes32
     * @param _string The string to be converted
     * @return _bytes32 The bytes32 representation of the string
     * @notice This function is public because it will also be used for the client, in a future version it will be changed to internal
     */
    function stringToBytes32(
        string memory _string
    ) public pure returns (bytes32 _bytes32) {
        bytes memory temp = bytes(_string);
        _bytes32 = bytes32(temp);
    }

    /**
     * @dev This function takes a string array and converts it to a bytes32 array. It will also be used by the client to create the same bytes32 array
     * @param _stringArray The string array to be converted
     * @return bytes32Array The bytes32 array representation of the string array
     * @notice This function is public because it will also be used for the client, in a future version it will be changed to internal
     */
    function stringArrayToBytes32Array(
        string[] memory _stringArray
    ) external pure returns (bytes32[] memory bytes32Array) {
        bytes32Array = new bytes32[](_stringArray.length);
        for (uint i = 0; i < _stringArray.length; i++) {
            bytes32Array[i] = stringToBytes32(_stringArray[i]);
        }
    }

    /**
     * @dev This function takes a string matrix and converts it to a bytes32 matrix. It will also be used by the client to create the same bytes32 matrix
     * @param stringMatrix The string matrix to be converted
     * @return bytes32Matrix The bytes32 matrix representation of the string matrix
     * @notice This function is public because it will also be used for the client, in a future version it will be changed to internal
     */
    function stringMatrixToBytes32Matrix(
        string[][] memory stringMatrix
    ) external pure returns (bytes32[][] memory bytes32Matrix) {
        bytes32Matrix = new bytes32[][](stringMatrix.length);
        for (uint256 i = 0; i < stringMatrix.length; i++) {
            bytes32Matrix[i] = new bytes32[](stringMatrix[i].length);
            for (uint256 j = 0; j < stringMatrix[i].length; j++) {
                bytes32Matrix[i][j] = stringToBytes32(stringMatrix[i][j]);
            }
        }
    }
}
