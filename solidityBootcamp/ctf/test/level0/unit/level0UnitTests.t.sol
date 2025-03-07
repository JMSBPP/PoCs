// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "@forge-std/Test.sol";
import {Level0Template} from "@level0/solution.sol";

contract level0UnitTests is Test {
    Level0Template private level0;
    function setUp() public {
        level0 = new Level0Template();
    }

    function testShouldReturn42() public returns (uint8) {
        uint8 res = level0.solution();
        assertEq(res, uint8(42));
    }
}
