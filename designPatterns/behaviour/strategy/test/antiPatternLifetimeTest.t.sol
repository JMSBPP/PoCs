// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/antiPattern/BlockBasedLifeTime.sol";
import "../src/antiPattern/TimeBasedLifeTime.sol";

contract AntiPatternLifetimeTest is Test {
    BlockBasedLifetime blockBasedLifetime;
    TimeBasedLifetime timeBasedLifetime;

    function setUp() public {
        blockBasedLifetime = new BlockBasedLifetime();
        timeBasedLifetime = new TimeBasedLifetime();
    }

    function test__blockBasedLifeTime__setValidBornParam() external {
        vm.roll(100);
        uint256 requestedBornParam = uint256(block.number) + 1;
        blockBasedLifetime.setBornParam(
            IERC7818.EPOCH_TYPE.BLOCKS_BASED,
            requestedBornParam
        );
        assertEq(blockBasedLifetime.getBornParam(), requestedBornParam);

        //Testing if given a wrong value we get the right error
        uint256 wrongValue = uint256(block.number) - 1;
        vm.expectRevert(
            abi.encodeWithSignature("BlockBasedLifetime__InvalidBornParam()")
        );
        blockBasedLifetime.setBornParam(
            IERC7818.EPOCH_TYPE.BLOCKS_BASED,
            wrongValue
        );
    }

    function test__timeBasedLifeTime__setValidBornParam() external {
        vm.warp(1641070800);
        uint256 requestedBornParam = uint256(block.timestamp) + 1;
        timeBasedLifetime.setBornParam(
            IERC7818.EPOCH_TYPE.TIME_BASED,
            requestedBornParam
        );
        assertEq(timeBasedLifetime.getBornParam(), requestedBornParam);

        //Testing if given a wrong value we get the right error
        uint256 wrongValue = uint256(block.timestamp) - 1;
        vm.expectRevert(
            abi.encodeWithSignature("TimeBasedLifetime__InvalidBornParam()")
        );
        timeBasedLifetime.setBornParam(
            IERC7818.EPOCH_TYPE.TIME_BASED,
            wrongValue
        );
    }
}
