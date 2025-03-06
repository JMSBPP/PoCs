//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IChamber} from "@chambers/interfaces/IChamber.sol";
import "@shapes/shapes.sol";
import {IRectangle} from "@shapes/interfaces/IRectangle.sol";
import {container} from "@shapes/container.sol";

abstract contract chamber is container {
    enum Color {
        blue,
        red
    }

    Color public takesColor;
}
