//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {demon} from "@demons/demon.sol";
contract Demons {
    uint256 private height;
    mapping(uint256 => address) private demons;

    error OutofBounds();
    error positionMustBeGreaterThankZero();
    constructor(uint256 _height) {
        setHeight(_height);
    }
    function setHeight(uint256 _height) internal {
        height = _height;
    }

    function getHeight() public view returns (uint256 _height) {
        _height = height;
    }
    function appendDemon(uint256 y) public {
        if (y > height) {
            revert OutofBounds();
        }
        if (y == 0) {
            revert positionMustBeGreaterThankZero();
        }
        demon _demon = new demon(address(this));
        demons[y] = address(_demon);
    }
    function isBusy(uint256 y) private view returns (bool _isBusy) {
        _isBusy = (demons[y] != address(0));
    }

    function getDemon(uint256 y) public view returns (address _demon) {
        _demon = demons[y];
    }
}
