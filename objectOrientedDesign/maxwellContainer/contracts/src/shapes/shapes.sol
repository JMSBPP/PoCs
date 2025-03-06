//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IshapesCanvas.sol";
import {IRectangle} from "./interfaces/IRectangle.sol";
import {ICircle} from "./interfaces/ICircle.sol";

contract shapesCanvas is IshapesCanvas {
    Point internal bottomLetfCoordinate;
    //NOTE: encoded color name OR
    //we can also do the front end color conversion here
    bytes32 internal color;
    bool internal isVisible;

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

contract Rectangle is shapesCanvas, IRectangle {
    Size internal size;

    constructor() {
        //NOTE: Starts in white
        color = bytes32(0x00);
        isVisible = true;
    }

    function setSize(uint256 _width, uint256 _height) public {
        size = Size({width: _width, height: _height});
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

contract Circle is shapesCanvas, ICircle {
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
