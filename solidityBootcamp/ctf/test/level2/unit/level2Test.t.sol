// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@forge-std/Test.sol";
import {Level2Template} from "@level2/solution.sol";
import {level2BenchMark} from "@level2/benchmark.sol";
contract level2UnitTest is Test {
    Level2Template private level2;
    level2BenchMark private benchmark;

    function setUp() public {
        level2 = new Level2Template();
        benchmark = new level2BenchMark();
    }

    function overFlowHelper(uint256[10] calldata unsortedArray) private pure {
        for (uint256 i = 0; i < 10; i++) {
            bound(unsortedArray[i], 0, type(uint256).max);
        }
    }

    function testShouldSortArrayInefficient(
        uint256[10] calldata unsortedArray
    ) public returns (uint256[10] memory sortedArray) {
        overFlowHelper(unsortedArray);
        sortedArray = benchmark.solutionInefficient(unsortedArray);
    }

    function testShouldSortArrayLowLevelBubbleSort(
        uint256[10] calldata unsortedArray
    ) public returns (uint256[10] memory sortedArray) {
        overFlowHelper(unsortedArray);
        sortedArray = level2.solution(unsortedArray);
    }

    function testBenchMarkShouldEqualSolution(
        uint256[10] calldata unsortedArray
    ) external {
        overFlowHelper(unsortedArray);
        uint256[10] memory inefficientRes = testShouldSortArrayInefficient(
            unsortedArray
        );
        uint256[10] memory efficientRes = testShouldSortArrayLowLevelBubbleSort(
            unsortedArray
        );
        for (uint256 index = 0; index < 10; index++) {
            assertEq(inefficientRes[index], efficientRes[index]);
        }
    }
}
