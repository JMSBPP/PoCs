// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseTest, Deploy1} from "./BaseTest.t.sol";
import {HuffDeployer} from "@foundry-huff/HuffDeployer.sol";

contract BaseTestHuffDeployer is BaseTest {
    string public deploy1Location = "Deploy1Optimized";
    function setUp() public override {
        deploy1 = Deploy1(HuffDeployer.config().deploy(deploy1Location));
    }
}
