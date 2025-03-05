//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "../lib/forge-std/src/Test.sol";
import {maxwellContainer} from "../src/maxwellContainer.sol";
// import {leftChamber} from "../src/leftChamber.sol";
// import {rightChamber} from "../src/rightContainer.sol";
import {Math} from "@math/Math.sol";

contract maxwellTests is Test {
    using Math for uint256;

    maxwellContainer private container;
    // leftChamber private left;
    // rightChamber private right;

    function setUp() public {
        container = new maxwellContainer();
        // left = new leftChamber();
        // right = new rightChamber();
    }

    function testInitializeMaxWellContainer() external {
        uint256 heigth = uint256(100);
        uint256 width = uint256(100);
        container.create(width, heigth);
        int256 expectedXPositionContainer = -int256(width.ceilDiv(uint256(2)));
        int256 expectedYPositionContainer = int256(0);
        (int256 xPositionContainer, int256 yPositionContainer) = container
            .getPosition();
        assertEq(expectedXPositionContainer, xPositionContainer);
        assertEq(expectedYPositionContainer, yPositionContainer);
    }
}
