//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract A {
    uint8 private value;
    function increment(address B) public {
        (bool ok, bytes memory res) = B.delegatecall(
            abi.encodeWithSignature("sum2()")
        );
    }

    function getValue() public view returns (uint8 _value) {
        _value = value;
    }
}
contract B {
    uint256 private number;
    function sum2() public {
        number += 2;
    }

    function getNumber() public view returns (uint256 _number) {
        _number = number;
    }
}
