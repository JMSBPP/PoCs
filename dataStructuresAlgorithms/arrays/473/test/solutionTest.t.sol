// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Solution} from "../src/solution.sol";
import {Test} from "../lib/forge-std/src/Test.sol";

contract TestSolution is Test {
    Solution public solution;

    function setUp() public {
        solution = new Solution();
    }

    function testReceiveMatchSticks() public {
        uint256[] memory matchSticks = new uint256[](4);
        matchSticks[0] = 1;
        matchSticks[1] = 2;
        matchSticks[2] = 2;
        matchSticks[3] = 2;
        matchSticks[3] = 1;

        solution.receiveMatchSticks(matchSticks);
    }
}
