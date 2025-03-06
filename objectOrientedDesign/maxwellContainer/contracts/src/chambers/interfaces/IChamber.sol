//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IContainer} from "@shapes/interfaces/IContainer.sol";

interface IChamber is IContainer {
    function create(uint256 width, uint256 height) external;
}
