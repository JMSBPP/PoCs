// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level2Template} from "@level2/solution.sol";

contract level2Script is Script {
    Level2Template private level2;
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level2 = new Level2Template();
        vm.stopBroadcast();
    }
}
