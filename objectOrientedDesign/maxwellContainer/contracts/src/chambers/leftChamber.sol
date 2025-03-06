//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {chamber} from "./abstracts/chamber.sol";
import {Math} from "@math/Math.sol";
contract leftChamber is chamber {
    using Math for uint256;
    constructor() {
        takesColor = Color.blue;
    }

    function create(uint256 width, uint256 height) external {
        createContainer(width, height);
        setPosition(-int256(size.width), uint256(0));
    }
}
