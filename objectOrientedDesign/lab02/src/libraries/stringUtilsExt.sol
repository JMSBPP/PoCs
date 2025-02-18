// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library stringUtilsExt {
    //TODO: add support to make strings upperCase and searching
    modifier validChar(string memory char) {
        bytes1 actualChar = bytes(char)[0];
        require(
            (actualChar < "A" || actualChar > "z") &&
                (actualChar < "a" || actualChar > "z"),
            "Enter a valid character [a-zA-Z]"
        );
        _;
    }
    /**
     * @dev if the charcter provided is a vowel, it makes it upper cases
     * @notice Only supports characters of length one, wil revert with no error log if
     * the character is not a vowel or if it is not a single character
     * @param char character to be upper cased
     */
    function upperChar(
        string memory char
    ) internal pure returns (string memory CHAR) {
        CHAR = char;
        bytes1 actualChar = bytes(char)[0];
        uint256 offset = uint256(bytes32(abi.encode(32)));
        uint256 operableChar = reverseUint256(uint256(bytes32(actualChar)));
        if (actualChar >= "a" && actualChar <= "z") {
            bytes1 actualCharUpper = bytes1(uint8(operableChar - offset));
            CHAR = string(abi.encodePacked(actualCharUpper));
        }
    }
    /**
     * @dev helper function to make a letter upper case
     * @notice function only used to reverse the uint256 to padded left
     *
     * @param input uint256 result of raw decoding a string into an uint256
     */
    function reverseUint256(
        uint256 input
    ) private pure returns (uint256 output) {
        for (uint256 i = 0; i < 32; i++) {
            output = (output << 8) | (input & 0xff);
            input >>= 8;
        }
    }
    /**
     * @dev main function of the library, converts all vowel chars of string in upper case
     * @param _string _string to have its vowels upper cased
     */
    function upperString(
        string memory _string
    ) internal pure returns (bytes32 res) {
        string memory _STRING = "";
        uint256 stringLength = bytes(_string).length;
        for (uint256 i = 0; i < stringLength; i++) {
            string memory char = string(abi.encodePacked(bytes(_string)[i]));
            string memory _upperChar = upperChar(char);
            _STRING = string(abi.encodePacked(_STRING, _upperChar));
            res = bytes32(bytes(_STRING));
        }
    }

    /**
     * @dev searches through a bytes32 array and returns if a given _string
     * is in the array
     * @param _encodedString string to be searched
     * @param _array array where the _encodedString will be searched
     */
    function search(
        bytes32 _encodedString,
        bytes32[] memory _array
    ) external pure returns (bool isInArray) {
        isInArray = false;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_encodedString == _array[i]) {
                isInArray = true;
                break;
            }
        }
    }

    function searchString(
        string memory _string,
        bytes32[] memory _array
    ) internal pure returns (bool isInArray) {
        isInArray = false;
        for (uint256 i = 0; i < _array.length; i++) {
            if (bytes32(abi.encodePacked(_string)) == _array[i]) {
                isInArray = true;
                break;
            }
        }
    }

    function upperStringArray(
        string[] memory _stringArray
    ) external pure returns (bytes32[] memory encodedString) {
        encodedString = new bytes32[](_stringArray.length);
        for (uint256 i = 0; i < _stringArray.length; i++) {
            encodedString[i] = upperString(_stringArray[i]);
        }
    }
    function upperStringMatrix(
        string[][] memory _stringMatrix
    ) external pure returns (bytes32[][] memory encodedStringMatrix) {
        encodedStringMatrix = new bytes32[][](_stringMatrix.length);
        for (uint256 i = 0; i < _stringMatrix.length; i++) {
            encodedStringMatrix[i] = new bytes32[](_stringMatrix[i].length);
            for (uint256 j = 0; j < _stringMatrix[i].length; j++) {
                encodedStringMatrix[i][j] = upperString(_stringMatrix[i][j]);
            }
        }
    }
}
