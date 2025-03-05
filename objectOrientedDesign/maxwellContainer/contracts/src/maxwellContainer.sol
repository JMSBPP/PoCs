//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Container} from "./abstracts/container.sol";
import {Math} from "@math/Math.sol";
//inherit the interfaxce of the ledt chamber
//inherit the interface of the right chamber
enum InitializationState {
    notInitalized,
    readyForDeployment,
    deployed,
    initialized
}

contract maxwellContainer is Container {
    using Math for uint256;

    address private leftChamber;
    address private rightChamber;
    InitializationState private initializationState;

    event initialized(address chamber1, address chamber2, uint32 blockTime);
    error alreadyInitialized();
    error NotReadyForDeployment();
    constructor() {
        //deterministically determine de addresses
        initializationState = InitializationState.notInitalized;
    }

    function create(uint256 width, uint256 height) public {
        if (initializationState != InitializationState.notInitalized) {
            revert alreadyInitialized();
        }

        setSize(height, width);
        int256 xPosition = -int256(width.ceilDiv(uint256(2)));
        int256 yPosition = int256(0);
        setPosition(xPosition, yPosition);
        //logic for deployment of chambers
        initializationState = InitializationState.readyForDeployment;
    }

    function setLeftChamber(address leftChamberAddress) private {
        leftChamber = leftChamberAddress;
    }

    function setRightChamber(address rightChamberAddress) private {
        rightChamber = rightChamberAddress;
    }

    //NOTE: Only callable after create and ONCE
    function deployChambers() private {
        if (initializationState != InitializationState.readyForDeployment) {
            revert NotReadyForDeployment();
        }

        //logic for deploying the right chamber
        //logic for storing the right chamber address

        //logic for deploying the left chamber
        //logic for storing the left chamber address
    }
}
