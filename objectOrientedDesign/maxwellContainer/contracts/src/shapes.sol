//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

struct Point {
    int256 x;
    int256 y;
}

struct Size {
    uint256 height;
    uint256 width;
}

abstract contract shapesAPI {
    Point internal bottomLetfCoordinate;
    //NOTE: encoded color name OR
    //we can also do the front end color conversion here
    bytes32 internal color;
    bool internal isVisible;

    /**
     * @dev Sets the position of the rectangle by updating its bottom left coordinate.
     * @param x The x-coordinate of the bottom left corner.
     * @param y The y-coordinate of the bottom left corner.
     */
    function setPosition(int256 x, int256 y) public {
        bottomLetfCoordinate = Point({x: x, y: y});
    }
    /**
     * @dev Returns the position of the rectangle as its bottom left coordinate.
     * @return x The x-coordinate of the bottom left corner.
     * @return y The y-coordinate of the bottom left corner.
     */
    function getPosition() public view returns (int256 x, int256 y) {
        x = bottomLetfCoordinate.x;
        y = bottomLetfCoordinate.y;
    }

    /**
     * @dev Sets the color of the rectangle.
     * @param newColor The new color to set, represented as a bytes32 value.
     
     */
    function setColor(bytes32 newColor) public {
        color = newColor;
    }
    /**
     * @dev Returns the current color of the rectangle.
     * @return _color The color of the rectangle, represented as a bytes32 value.
     */
    function getColor() public view returns (bytes32 _color) {
        _color = color;
    }
    /**
     * @dev Sets the visibility of the rectangle.
     * @param _isVisible The new visibility state of the rectangle. True for visible, false for invisible.
     */
    function setVisibility(bool _isVisible) public {
        isVisible = _isVisible;
    }

    /**
     * @dev Returns the visibility state of the rectangle.
     * @return _isVisible True if the rectangle is visible, false if it is invisible.
     */
    function getVisibility() public view returns (bool _isVisible) {
        _isVisible = isVisible;
    }
}
/**
 * @dev Rectangle class
 * @notice The methods draw() and erase are handled by the front end
 *
 */

abstract contract Rectangle is shapesAPI {
    Size private size;

    constructor() {
        //NOTE: Starts in white
        color = bytes32(0x00);
        isVisible = true;
    }

    /**
     * @dev Sets the size of the rectangle.
     * @param height The new height of the rectangle.
     * @param width The new width of the rectangle.
     */
    function setSize(uint256 height, uint256 width) public {
        size = Size({height: height, width: width});
    }

    /**
     * @dev Returns the size of the rectangle.
     * @return width The width of the rectangle.
     * @return heigth The height of the rectangle.
     */
    function getSize() public view returns (uint256 width, uint256 heigth) {
        width = size.width;
        heigth = size.height;
    }
}

abstract contract Circle is shapesAPI {
    uint256 private constant WAD = 18;
    //NOTE: PI with 18 decimal precision
    uint256 private constant PI = 3141592653589793238;
    uint256 private diameter;

    /**
     * @dev Sets the diameter of the circle.
     * @param _diameter The new diameter of the circle.
     */
    function setDiameter(uint256 _diameter) public {
        diameter = _diameter;
    }
}
