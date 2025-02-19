// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library uint256Ext {
    // -------------------------------------

    //------------UINT256 EXT-------------------

    //--------------------------------------

    /**
     * @dev helper function to make a letter upper case
     * @notice function only used to reverse the uint256 to padded left
     *
     * @param input uint256 result of raw decoding a string into an uint256
     */
    function reverseUint256(
        uint256 input
    ) external pure returns (uint256 output) {
        for (uint256 i = 0; i < 32; i++) {
            output = (output << 8) | (input & 0xff);
            input >>= 8;
        }
    }
}
