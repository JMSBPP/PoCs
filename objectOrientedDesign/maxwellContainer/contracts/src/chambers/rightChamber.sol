//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {chamber} from "./abstracts/chamber.sol";
import {Math} from "@math/Math.sol";
contract rightChamber is chamber {
    using Math for uint256;

    constructor() {
        takesColor = Color.red;
    }

    function create(uint256 width, uint256 height) external {
        createContainer(width, height);
        setPosition(int256(0), uint256(0));
    }
}
