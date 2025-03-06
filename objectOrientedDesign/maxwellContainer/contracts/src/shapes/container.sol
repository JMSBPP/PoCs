//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./shapes.sol";
import {Math} from "@math/Math.sol";
import {IContainer} from "./interfaces/IContainer.sol";

contract container is Rectangle, IContainer {
    using Math for uint256;

    Segment[4] internal segments;
    VertexCoordinates internal vertexCoordinates;

    enum InitializationState {
        notInitalized,
        readyForDeployment,
        deployed,
        initialized
    }

    InitializationState internal initializationState;

    error alreadyInitialized();

    constructor() {
        //deterministically determine de addresses
        initializationState = InitializationState.notInitalized;
    }

    function setPosition(int256 _x, uint256 _y) public {
        vertexCoordinates.bottomLeft = Point({x: _x, y: _y});
        vertexCoordinates.bottomRight = Point({
            x: vertexCoordinates.bottomLeft.x + int256(size.width),
            y: vertexCoordinates.bottomLeft.y
        });
        vertexCoordinates.topRight = Point({
            x: vertexCoordinates.bottomRight.x,
            y: vertexCoordinates.bottomRight.y + uint256(size.height)
        });
        vertexCoordinates.topLeft = Point({
            x: vertexCoordinates.bottomLeft.x,
            y: vertexCoordinates.bottomLeft.y + uint256(size.height)
        });
        setSegments();
    }
    function getPosition() public view returns (int256 x, uint256 y) {
        x = vertexCoordinates.bottomLeft.x;
        y = vertexCoordinates.bottomLeft.y;
    }

    function setSegments() internal {
        segments[0] = Segment({
            initialPoint: vertexCoordinates.bottomLeft,
            finalPoint: vertexCoordinates.topLeft
        });

        segments[1] = Segment({
            initialPoint: vertexCoordinates.bottomRight,
            finalPoint: vertexCoordinates.topRight
        });

        segments[2] = Segment({
            initialPoint: vertexCoordinates.topLeft,
            finalPoint: vertexCoordinates.topRight
        });

        segments[3] = Segment({
            initialPoint: vertexCoordinates.bottomLeft,
            finalPoint: vertexCoordinates.bottomRight
        });
    }

    function getBottomLeftToTopLeftSideCoordinates()
        public
        view
        override(IContainer)
        returns (Point memory bottomLeft, Point memory topLeft)
    {
        bottomLeft = segments[0].initialPoint;
        topLeft = segments[0].finalPoint;
    }
    function getBottomLeftToBottomRightSideCoordinates()
        public
        view
        override(IContainer)
        returns (Point memory bottomLeft, Point memory bottomRight)
    {
        bottomLeft = segments[3].initialPoint;
        bottomRight = segments[3].finalPoint;
    }
    function getTopLeftToTopRightSideCoordinates()
        public
        view
        override(IContainer)
        returns (Point memory topLeft, Point memory topRight)
    {
        topLeft = segments[2].initialPoint;
        topRight = segments[2].finalPoint;
    }

    function getTopRightToBottomRightSideCoordinates()
        public
        view
        override(IContainer)
        returns (Point memory topRight, Point memory bottomRight)
    {
        topRight = segments[1].initialPoint;
        bottomRight = segments[1].finalPoint;
    }

    /**
     * @dev Creates a container with the specified width and height.
     * Reverts if the container has already been initialized.
     * @param width The width of the container.
     * @param height The height of the container.
     */
    function createContainer(uint256 width, uint256 height) public {
        if (initializationState != InitializationState.notInitalized) {
            revert alreadyInitialized();
        }

        setSize(width, height);
    }
}
