// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV1} from "../src/CounterV1.sol";
import {CounterV2} from "../src/CounterV2.sol";
import {BuggyUUPSProxy} from "../src/BuggyUUPSProxy.sol";

contract BuggyUUPSProxyTest is Test {
    CounterV1 instance;
    address proxy;
    address developerAddress = address(this);
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    function setUp() public {
        vm.startPrank(developerAddress);
        proxy = Upgrades.deployUUPSProxy(
            "CounterV1.sol",
            abi.encodeCall(CounterV1.initialize, (developerAddress))
        );

        instance = CounterV1(payable(proxy));
        vm.stopPrank();
    }

    function test__shouldIncrementToOne() external {
        vm.startPrank(alice);

        instance.increment();
        assertEq(1, instance.getCount());
        vm.stopPrank();
    }

    function test__fuzz__shouldUpgradeAndIncrementToOneHundred(
        uint256 _timeStamp,
        uint256 _delay,
        uint256 _timeStampDelta
    ) external {
        uint256 timeStamp = bound(
            _timeStamp,
            uint256(type(uint32).max),
            uint256(type(uint48).max)
        );

        uint256 delay = bound(
            _delay,
            instance.getMinDelay(),
            uint256(type(uint32).max)
        );

        uint256 timeStampDelta = bound(
            _timeStampDelta,
            0,
            uint256(type(uint32).max)
        );

        vm.warp(timeStamp);

        address counterV1Address = Upgrades.getImplementationAddress(proxy);
        bytes32 upgradeId = instance.scheduleUpgrade(delay);
        vm.warp(timeStamp + timeStampDelta);

        vm.startPrank(developerAddress);
        if (block.timestamp <= timeStamp + delay) {
            instance.increment();
            assertEq(1, instance.getCount());
            vm.expectRevert("InvalidCall__UpgradeTimeHasNotPassed()");
        }

        Upgrades.upgradeProxy(
            payable(proxy),
            "CounterV2.sol",
            ""
        );

        CounterV2(payable(address(instance))).increment();
        assertEq(100, CounterV2(payable(address(instance))).getCount());

        vm.stopPrank();
    }
}
