//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@math/Math.sol";
import {Chambers} from "./Chambers.sol";
import {Demons} from "./Demons.sol";

contract maxwellContainerClient is Chambers {
    using Math for uint256;

    address private immutable owner;

    Demons private demons;
    address private _demons;
    bool private called;

    event initialized(
        address indexed chamber1,
        address indexed chamber2,
        uint256 blockTime
    );

    error OnlyCallableOnce();
    error OnlyCallableByOwner();
    constructor(address _owner) {
        owner = _owner;
        called = false;
    }

    function onlyOwner() private view returns (bool _onlyOwner) {
        _onlyOwner = (msg.sender == owner);
    }

    function create(uint256 width, uint256 height) public {
        if (!(onlyOwner())) {
            revert OnlyCallableByOwner();
        }

        if (called == true) {
            revert OnlyCallableOnce();
        }

        createContainer(width, height);
        demons = new Demons(height);
        setDemons(_demons);
        setPosition(-int256(width.ceilDiv(uint256(2))), uint256(0));
        //LOGIC EXCLUSIVE OF CONTAINER
        initializationState = InitializationState.readyForDeployment;
        deployChambers();
        createChambers(width, height);
        initializationState = InitializationState.initialized;
        emit initialized(_leftChamber, _rightChamber, block.timestamp);
        called = true;
    }

    function setDemons(address __demons) public {
        _demons = __demons;
    }

    function getDemons() public view returns (address __demons) {
        __demons = _demons;
    }

    function addDemon(uint256 y) public {
        (bool res, ) = _demons.call(
            abi.encodeWithSignature("appendDemon(uint256)", y)
        );
        assembly {
            if iszero(res) {
                revert(0, 0)
            }
        }
    }
    // function removeDemon(uint256 y) public {}
}
