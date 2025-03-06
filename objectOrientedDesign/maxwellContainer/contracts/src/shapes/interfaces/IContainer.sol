//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {types} from "@types/types.sol";
interface IContainer is types {
    function setPosition(int256 x, uint256 y) external;
    function getPosition() external returns (int256 x, uint256 y);
    function getBottomLeftToTopLeftSideCoordinates()
        external
        returns (Point memory bottomLeft, Point memory topLeft);
    function getBottomLeftToBottomRightSideCoordinates()
        external
        returns (Point memory bottomLeft, Point memory bottomRight);
    function getTopLeftToTopRightSideCoordinates()
        external
        returns (Point memory topLeft, Point memory topRight);
    function getTopRightToBottomRightSideCoordinates()
        external
        returns (Point memory topRight, Point memory bottomRight);
}
