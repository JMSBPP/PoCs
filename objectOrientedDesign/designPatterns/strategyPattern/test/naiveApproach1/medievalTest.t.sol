// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {StdInvariant} from "../../lib/forge-std/src/StdInvariant.sol";
import {King} from "../../src/naiveApproach1/king.sol";
contract combatBehaviourTest is Test {
    King private king;

    function setUp() public {
        king = new King();
    }

    function testKingAttack() external {
        string memory attackMessage = king.fight();
        string memory expectedMessage = "knife";
        assertEq(
            keccak256(bytes(attackMessage)),
            keccak256(bytes(expectedMessage))
        );
    }
}
