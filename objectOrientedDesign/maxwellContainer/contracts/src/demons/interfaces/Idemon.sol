//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {types} from "@types/types.sol";
interface Idemon is types {
    function setPosition(uint256 y) external;
}
