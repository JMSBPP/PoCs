//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {A, B} from "../src/BasicExample.sol";
import {Storage, Logic} from "../src/BasicExample2.sol";
contract ExamplesTest is Test {
    A a;
    B b;
    Storage s;
    Logic l;
    function setUp() public {
        a = new A();
        b = new B();
        s = new Storage();
        l = new Logic();
    }

    function test__basicDelegateCall() external {
        a.increment(address(b));
        assertEq(b.getNumber(), 0);
        assertEq(a.getValue(), 2);
    }

    function test__basicDelegateCall2() external {
        l.setReadValue(2);
        console2.log(l.getReadValue());
        s.modifyValue(address(l), 1);
        console2.log(s.getValueToBeUpdated());
    }
}
