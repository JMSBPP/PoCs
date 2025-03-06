//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@math/Math.sol";

contract CreateStateHandler {
    using Math for uint256;

    uint256 public constant HEIGHT = uint256(100);
    uint256 public constant WIDTH = uint256(100);

    //-------------------MAXWELL-CONTAINER--------------------------------
    int256 public constant expectedContainerTopRightXPosition = int256(50);
    uint256 public constant expectedContainerTopRightYPosition = uint256(100);

    int256 public constant expectedContainerBottomRightXPosition = int256(50);
    uint256 public constant expectedContainerBottomRightYPosition = uint256(0);

    int256 public constant expectedContainerTopLeftXPosition = int256(-50);
    uint256 public constant expectedContainerTopLeftYPosition = uint256(100);

    int256 public constant expectedContainerBottomLeftXPosition = int256(-50);
    uint256 public constant expectedContainerBottomLeftYPosition = uint256(0);

    //-------------------LEFT-CHAMBER--------------------------------
    int256 public constant expectedLeftChamberTopRightXPosition = int256(0);
    uint256 public constant expectedLeftChamberTopRightYPosition = uint256(100);

    int256 public constant expectedLeftChamberBottomRightXPosition = int256(0);
    uint256 public constant expectedLeftChamberBottomRightYPosition =
        uint256(0);

    int256 public constant expectedLeftChamberTopLeftXPosition = int256(-50);
    uint256 public constant expectedLeftChamberTopLeftYPosition = uint256(100);

    int256 public constant expectedLeftChamberBottomLeftXPosition = int256(-50);
    uint256 public constant expectedLeftChamberBottomLeftYPosition = uint256(0);

    //-------------------RIGHT-CHAMBER--------------------------------
    int256 public constant expectedRightChamberTopRightXPosition = int256(50);
    uint256 public constant expectedRightChamberTopRightYPosition =
        uint256(100);

    int256 public constant expectedRightChamberBottomRightXPosition =
        int256(50);
    uint256 public constant expectedRightChamberBottomRightYPosition =
        uint256(0);

    int256 public constant expectedRightChamberTopLeftXPosition = int256(0);
    uint256 public constant expectedRightChamberTopLeftYPosition = uint256(100);

    int256 public constant expectedRightChamberBottomLeftXPosition = int256(0);
    uint256 public constant expectedRightChamberBottomLeftYPosition =
        uint256(0);
}
