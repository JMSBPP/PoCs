// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "@forge-std/Test.sol";
import {Deploy1} from "../src/Deploy1.sol";

abstract contract BaseTest is Test {
    Deploy1 deploy1;

    function setUp() public virtual {
        deploy1 = new Deploy1();
    }

    function testStorageSlot() external view returns (uint256) {
        uint256 expected = 17;
        uint256 actual = deploy1.read();
        return actual;
    }
}
