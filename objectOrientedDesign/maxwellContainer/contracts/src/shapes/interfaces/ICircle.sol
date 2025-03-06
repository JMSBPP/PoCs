//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IshapesCanvas} from "./IshapesCanvas.sol";

interface ICircle is IshapesCanvas {
    function setDiameter(uint256 _diameter) external;
}
