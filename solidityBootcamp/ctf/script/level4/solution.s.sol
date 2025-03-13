// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level4Template} from "@level4/solution.sol";

contract level4Script is Script {
    Level4Template private level4;
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level4 = new Level4Template();
        vm.stopBroadcast();
    }
}
