// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {bytes32ArrayExt} from "../../src/libraries/bytes32ArrayExt.sol";
import {bytes32ArrExtHelper} from "./helpers/bytes32ArrExtHelper.sol";
import {bytes32MatrixExtHelper} from "./helpers/bytes32MatrixExtHelper.sol";
import {bytes32Ext} from "../../src/libraries/bytes32Ext.sol";

contract testBytes32Libs is Test {
    using bytes32ArrayExt for bytes32[];
    using bytes32Ext for *;

    bytes32ArrExtHelper helperbytes32Arr;
    bytes32MatrixExtHelper helperbytes32Matrix;
    function setUp() public {
        helperbytes32Arr = new bytes32ArrExtHelper();
        helperbytes32Matrix = new bytes32MatrixExtHelper();
    }

    function testUnitIsSubsetOfSucceds() external {
        assertTrue(helperbytes32Arr.isSubsetTrue());
        assertFalse(helperbytes32Arr.isSubsetFalse());
    }

    //WHERE DOES IsSubsetOf REVERTS

    function testOnlySubsetsOf() external returns (bytes32[][] memory subsets) {
        //EXPECTED ---[[0x02,0x04]]
        bytes32[][] memory expectedSubsets = new bytes32[][](1);
        bytes32[] memory expectedSubset = new bytes32[](2);
        expectedSubset[0] = bytes32(uint256(0x02));
        expectedSubset[1] = bytes32(uint256(0x04));
        expectedSubsets[0] = expectedSubset;
        subsets = helperbytes32Matrix.unitStateSetUp();

        assertEq(
            keccak256(abi.encode(subsets)),
            keccak256(abi.encode(expectedSubsets))
        );
    }

    function testRemoveDuplicatesUnitbytes32Array()
        external
        returns (bytes32[] memory resultingArray)
    {
        bytes32[] memory vertices = new bytes32[](4);
        vertices[0] = "DDYA";
        vertices[1] = "MYSD";
        vertices[2] = "DOPO";
        vertices[3] = "Dopo";
        resultingArray = vertices.removeDuplicatesBytes32Array();
    }

    function testUpperCappedEncodedChar() external returns (bytes1 B) {
        bytes1 b = bytes1(uint8(66));
        B = b.upperCapEncodedChar();
    }

    function testUpperCapEncodedStringArray()
        external
        returns (bytes32[] memory resultingArray)
    {
        bytes32[] memory vertices = new bytes32[](4);
        vertices[0] = "DDYA";
        vertices[1] = "MYSD";
        vertices[2] = "DOPO";
        vertices[3] = "dopo";
        resultingArray = vertices
            .upperCapEncodedStringArray()
            .removeDuplicatesBytes32Array();
    }
}
