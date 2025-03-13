// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level5Template} from "@level5/solution.sol";

contract level5Script is Script {
    Level5Template private level5;
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level5 = new Level5Template();
        vm.stopBroadcast();
    }
}
