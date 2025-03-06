//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {types} from "@types/types.sol";
interface IshapesCanvas is types {
    function setColor(bytes32 newColor) external;
    function getColor() external returns (bytes32 _color);
    function setVisibility(bool _isVisible) external;
    function getVisibility() external returns (bool _isVisible);
}
