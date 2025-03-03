// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Knife {
    function attack() external pure returns (string memory attackMessage) {
        attackMessage = "knife";
    }
}
