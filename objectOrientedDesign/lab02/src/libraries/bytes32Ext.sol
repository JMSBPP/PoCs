// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {uint256Ext} from "./uint256Ext.sol";
library bytes32Ext {
    using uint256Ext for uint256;
    // -------------------------------------

    //------------bytes32 EXT-------------------

    //--------------------------------------

    /**
     * @dev Uppercase the first 32 bytes of a `bytes32` encoded string.
     * @param encodedString The `bytes32` encoded string to uppercase.
     * @return encodedCappedString The `bytes32` encoded string with the first 32 bytes uppercased.
     */
    function upperCapEncodedString(
        bytes32 encodedString
    ) external pure returns (bytes32 encodedCappedString) {
        bytes32 result;
        for (uint256 i = 0; i < 32; i++) {
            bytes1 char = encodedString[i];
            // Check if the character is a lowercase letter (a-z)
            if (char >= 0x61 && char <= 0x7A) {
                // Convert to uppercase by subtracting 32
                char = bytes1(uint8(char) - 32);
            }
            // Shift the character into the correct position in the result
            result |= bytes32(char) >> (i * 8);
        }
        return result;
    }
}
