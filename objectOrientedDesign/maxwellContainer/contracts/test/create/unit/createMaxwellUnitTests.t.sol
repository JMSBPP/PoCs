//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@forge-std/Test.sol";
import {maxwellContainerClient} from "@maxwellContainer/client.sol";
import {Math} from "@math/Math.sol";
import {CreateStateHandler} from "../../createStateHandler.sol";
import {types} from "@types/types.sol";

contract createUnitTests is Test, CreateStateHandler, types {
    using Math for uint256;

    maxwellContainerClient private client;
    CreateStateHandler private createStateHandler;
    address dummyOwner = address(1);
    function setUp() public {
        client = new maxwellContainerClient(dummyOwner);
        createStateHandler = new CreateStateHandler();
    }

    function testShouldSuceedCreatingMaxWellContainer() external {
        client.create(WIDTH, HEIGHT);
        (Point memory topLeft, Point memory topRight) = client
            .getTopLeftToTopRightSideCoordinates();
        assertEq(topRight.y, expectedContainerTopRightYPosition);
        assertEq(topRight.x, expectedContainerTopRightXPosition);
        assertEq(topLeft.y, expectedContainerTopLeftYPosition);
        assertEq(topLeft.x, expectedContainerTopLeftXPosition);
        (Point memory bottomLeft, Point memory bottomRight) = client
            .getBottomLeftToBottomRightSideCoordinates();
        assertEq(bottomLeft.x, expectedContainerBottomLeftXPosition);
        assertEq(bottomLeft.y, expectedRightChamberBottomLeftYPosition);
        assertEq(bottomRight.x, expectedContainerBottomRightXPosition);
        assertEq(bottomRight.y, expectedContainerBottomRightYPosition);
    }

    function testShouldSuceedCreatingRightChamber() external {
        client.create(WIDTH, HEIGHT);
        address right = client.getRightChamberAddress();
        (, bytes memory topLeftTopRight) = right.staticcall(
            abi.encodeWithSignature("getTopLeftToTopRightSideCoordinates()")
        );
        (Point memory topLeft, Point memory topRight) = abi.decode(
            topLeftTopRight,
            (Point, Point)
        );
        assertEq(topRight.y, expectedRightChamberTopRightYPosition);
        assertEq(topRight.x, expectedRightChamberTopRightXPosition);
        assertEq(topLeft.y, expectedRightChamberTopLeftYPosition);
        assertEq(topLeft.x, expectedRightChamberTopLeftXPosition);
        (, bytes memory bottomLeftBottomRight) = right.staticcall(
            abi.encodeWithSignature(
                "getBottomLeftToBottomRightSideCoordinates()"
            )
        );
        (Point memory bottomLeft, Point memory bottomRight) = abi.decode(
            bottomLeftBottomRight,
            (Point, Point)
        );
        assertEq(bottomLeft.x, expectedRightChamberBottomLeftXPosition);
        assertEq(bottomLeft.y, expectedRightChamberBottomLeftYPosition);
        assertEq(bottomRight.x, expectedRightChamberBottomRightXPosition);
        assertEq(bottomRight.y, expectedRightChamberBottomRightYPosition);
    }
    function testShouldSuceedCreatingLeftChamber() external {
        client.create(WIDTH, HEIGHT);
        address left = client.getLeftChamberAddress();
        (, bytes memory topLeftTopRight) = left.staticcall(
            abi.encodeWithSignature("getTopLeftToTopRightSideCoordinates()")
        );
        (Point memory topLeft, Point memory topRight) = abi.decode(
            topLeftTopRight,
            (Point, Point)
        );

        assertEq(topRight.y, expectedLeftChamberTopRightYPosition);
        assertEq(topRight.x, expectedLeftChamberTopRightXPosition);
        assertEq(topLeft.y, expectedLeftChamberTopLeftYPosition);
        assertEq(topLeft.x, expectedLeftChamberTopLeftXPosition);
        (, bytes memory bottomLeftBottomRight) = left.staticcall(
            abi.encodeWithSignature(
                "getBottomLeftToBottomRightSideCoordinates()"
            )
        );
        (Point memory bottomLeft, Point memory bottomRight) = abi.decode(
            bottomLeftBottomRight,
            (Point, Point)
        );

        assertEq(bottomLeft.x, expectedLeftChamberBottomLeftXPosition);
        assertEq(bottomLeft.y, expectedLeftChamberBottomLeftYPosition);
        assertEq(bottomRight.x, expectedLeftChamberBottomRightXPosition);
        assertEq(bottomRight.y, expectedLeftChamberBottomRightYPosition);
    }
}
