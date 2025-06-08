//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract A {
    uint8 private value;
    function increment(
        address bImplementation
    ) public returns (address sender) {
        (bool ok, bytes memory res) = bImplementation.delegatecall(
            abi.encodeWithSignature("sum2()")
        );
        if (ok) {
            sender = abi.decode(res, (address));
        }
    }

    function getValue() public view returns (uint8 _value) {
        _value = value;
    }
    function setValue(uint8 _value) public {
        value = _value;
    }
}
contract B {
    uint256 private number;
    function sum2() public returns (address sender) {
        number += 2;
        sender = address(this);
    }

    function getNumber() public view returns (uint256 _number) {
        _number = number;
    }
}
