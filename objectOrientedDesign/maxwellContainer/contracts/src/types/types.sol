//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface types {
    struct Point {
        int256 x;
        uint256 y;
    }

    struct Size {
        uint256 width;
        uint256 height;
    }

    struct VertexCoordinates {
        Point bottomLeft;
        Point bottomRight;
        Point topRight;
        Point topLeft;
    }

    struct Segment {
        Point initialPoint;
        Point finalPoint;
    }
}
