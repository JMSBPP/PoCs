//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {A, B} from "../src/BasicExample.sol";
contract ExamplesTest is Test {
    A a;
    B b;
    function setUp() public {
        a = new A();
        b = new B();
    }

    function test__basicDelegateCall() external {
        address sender = a.increment(address(b));
        assertEq(sender, address(a));
        assertEq(b.getNumber(), 0);
        assertEq(a.getValue(), 2);
    }
}
