// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import {Script, console} from "@forge-std/Script.sol";
import {Level0Template} from "@level0/solution.sol";
import {HuffDeployer} from "@huff/HuffDeployer.sol";

contract level0Script is Script {
    Level0Template private level0;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address adr = HuffDeployer.deploy("src/level0/solution");
        vm.stopBroadcast();
    }
}
