//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IshapesCanvas} from "./IshapesCanvas.sol";
interface IRectangle is IshapesCanvas {
    function setSize(uint256 height, uint256 width) external;
    function getSize() external returns (uint256 width, uint256 heigth);
}
