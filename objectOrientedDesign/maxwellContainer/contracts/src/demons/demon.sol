//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Idemon} from "./interfaces/Idemon.sol";
import {Demons} from "@maxwellContainer/Demons.sol";
contract demon is Idemon {
    Point private position;
    address private immutable DEMONS;
    uint256 private maxHeight;
    error OutofBounds();
    constructor(address _demons) {
        position.x = int256(0);
        DEMONS = _demons;
    }

    function allowedPosition(uint256 y) private returns (bool _allowed) {
        (bool res, bytes memory data) = DEMONS.staticcall(
            abi.encodeWithSignature("getHeight()")
        );
        assembly {
            if iszero(res) {
                revert(0, 0)
            }
        }

        uint256 _maxHeight = abi.decode(data, (uint256));
        setMaxHeight(_maxHeight);
        _allowed = y <= maxHeight;
    }

    function setMaxHeight(uint256 _maxHeight) private {
        maxHeight = _maxHeight;
    }
    function setPosition(uint256 y) public {
        if (!(allowedPosition(y))) {
            revert OutofBounds();
        }

        position.y = y;
    }
}
