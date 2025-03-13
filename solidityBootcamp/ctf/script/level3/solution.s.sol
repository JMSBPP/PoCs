// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level3Template} from "@level3/solution.sol";

contract level3Script is Script {
    Level3Template private level3;
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level3 = new Level3Template();
        vm.stopBroadcast();
    }
}
