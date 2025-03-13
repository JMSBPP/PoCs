// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@forge-std/Test.sol";
import {Level4Template} from "@level4/solution.sol";

contract Level4Test is Test {
    Level4Template private level4;

    function setUp() public {
        level4 = new Level4Template();
    }
    // stdin: 1                     stdout: 1 or 2**0
    // stdin: 10                    stdout: 8 or 2**3
    // stdin: 21                    stdout: 16 or 2**4
    // stdin: 2048                  stdout: 2048 or 2**11
    // stdin: 9223372036854775808   stdout: 9223372036854775808 or 2**63
    // stdin: 0xffffffff            stdout: 2147483648 or 0x80000000 or 2**31

    function testSolutionPower2() public {
        assertEq(level4.solution(1), 1);
        assertEq(level4.solution(10), 8);
        assertEq(level4.solution(21), 16);
        assertEq(level4.solution(2048), 2048);
        assertEq(level4.solution(9223372036854775808), 9223372036854775808);
        assertEq(level4.solution(0xffffffff), 2147483648);
    }
}
