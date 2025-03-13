// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {Test} from "@forge-std/Test.sol";
import {benchmark} from "@level3/benchmark.sol";

contract level3Test is Test {
    benchmark private _benchmark;
    function setUp() public {
        _benchmark = new benchmark();
    }

    function testShouldDecodeInefficient(bytes memory data) external {
        (uint16 a, bool b, bytes6 c) = _benchmark.solution(data);
    }
}
