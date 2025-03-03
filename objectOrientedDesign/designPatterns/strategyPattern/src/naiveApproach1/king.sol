// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Character} from "./character.sol";
import {Knife} from "./knife.sol";

contract King is Character {
    Knife private weapon;

    constructor() {
        weapon = new Knife();
    }

    function fight() public view override returns (string memory message) {
        message = weapon.attack();
    }
}
