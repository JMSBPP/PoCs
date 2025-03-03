// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Character {
    function fight() public view virtual returns (string memory message);
}
