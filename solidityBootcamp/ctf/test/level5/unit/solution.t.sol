// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@forge-std/Test.sol";
import {Level5Template} from "@level5/solution.sol";

contract Level5Test is Test {
    Level5Template private level5;

    function setUp() public {
        level5 = new Level5Template();
    }

    function testAverageUnit() external {
        int256 a = 2;
        int256 b = 2;
        assertEq(level5.solution(a, b), 2s);
    }

    function testAverageFuzz(int256 a, int256 b) external {
        int256 res = level5.solution(a, b);
    }
}
