// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library bytes32Ext {
    /**
     * @dev Converts a single lowercase ASCII character [a-z] to uppercase [A-Z].
     * If the character is not in the range [a-z], it is returned unchanged.
     */
    function upperCapEncodedChar(bytes1 char) internal pure returns (bytes1) {
        uint8 code = uint8(char);
        // If [a–z], subtract 0x20 to convert to [A–Z].
        if (code >= 0x61 && code <= 0x7A) {
            code -= 0x20;
        }
        return bytes1(code);
    }

    /**
     * @dev Moves all non-zero bytes to the left side of the 32-byte array,
     *      preserving their order, and leaves 0x00 bytes on the right.
     *
     *      Example:
     *         [0x00, 0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0x00, ... ]
     *      becomes
     *         [0xDE, 0xAD, 0xBE, 0xEF, 0x00, 0x00, 0x00, ... ].
     *
     * @param original The `bytes32` value to be shifted.
     * @return The left-aligned `bytes32` value.
     */
    function padLeftEncodedString(
        bytes32 original
    ) internal pure returns (bytes32) {
        bytes memory buffer = new bytes(32);

        // indexOut tracks where we store the next non-zero byte
        uint256 indexOut = 0;
        for (uint256 i = 0; i < 32; i++) {
            bytes1 b = original[i];
            if (b != 0x00) {
                buffer[indexOut] = b;
                indexOut++;
            }
        }

        return bytes32(buffer);
    }

    /**
     * @dev Moves all non-zero bytes to the right side of the 32-byte array,
     *      preserving their order, and leaves 0x00 bytes on the left.
     *
     *      Example:
     *         [0x00, 0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0x00, ... ]
     *      becomes
     *         [... 0x00, 0xDE, 0xAD, 0xBE, 0xEF].
     *
     * @param original The `bytes32` value to be shifted.
     * @return The right-aligned `bytes32` value.
     */
    function padRightBytes32(bytes32 original) internal pure returns (bytes32) {
        bytes memory buffer = new bytes(32);

        // Count how many non-zero bytes we have
        uint256 countNonZero = 0;
        for (uint256 i = 0; i < 32; i++) {
            if (original[i] != 0x00) {
                countNonZero++;
            }
        }

        // indexOut points to where the first non-zero byte should go on the right
        uint256 indexOut = 32 - countNonZero;
        for (uint256 i = 0; i < 32; i++) {
            bytes1 b = original[i];
            if (b != 0x00) {
                buffer[indexOut] = b;
                indexOut++;
            }
        }

        return bytes32(buffer);
    }

    /**
     * @dev Converts all lowercase ASCII bytes in a `bytes32` string to uppercase,
     *      then either left-aligns or right-aligns them (as an example).
     *      Adjust as needed for your use case.
     *
     * @param original The `bytes32` string to be uppercased and padded.
     * @return The resulting `bytes32` string after uppercase conversion and alignment.
     */
    function upperCapEncodedString(
        bytes32 original
    ) external pure returns (bytes32) {
        // First, uppercase all characters
        bytes memory temp = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            temp[i] = upperCapEncodedChar(original[i]);
        }

        // Convert to bytes32 again
        bytes32 uppercased = bytes32(temp);

        // Example: left-align after uppercasing
        return padLeftEncodedString(uppercased);

        // or, if you need right-align, do:
        // return padRightBytes32(uppercased);
    }
}
