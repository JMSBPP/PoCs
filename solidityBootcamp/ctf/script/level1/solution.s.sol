// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level1Template} from "@level1/solution.sol";

contract level1Script is Script {
    Level1Template private level1;
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level1 = new Level1Template();
        vm.stopBroadcast();
    }
}
