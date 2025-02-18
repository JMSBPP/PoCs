// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {stringUtilsExt} from "../src/libraries/stringUtilsExt.sol";
contract graphCalcTest is Test {
    using stringUtilsExt for *;
    function setUp() public {}

    function testUpperStringFuzz(
        string memory _string
    ) external pure returns (bytes32 encodedString) {
        encodedString = _string.upperString();
    }
    //this test is stateful test.
    //1. adds some strings string[] array
    //2. creates a new string
    //3. calls the search function.
    function testSearchFuzz(
        bytes32 _string,
        bytes32[] memory _array,
        uint256 numberOfStrings
    ) external pure returns (bool isInArray) {
        for (uint256 i = 0; i < numberOfStrings; i++) {
            _array[i] = _string;
        }
        isInArray = _string.search(_array);
    }
}
