// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {graphCalculatorStorage} from "../../src/graphCalculatorStorage.sol";
import {graphCalculatorv1} from "../../src/graphCalculatorLogicv1.sol";

contract graphCalculatorUnitTest is Test {
    graphCalculatorv1 private calculator;

    function setUp() external {
        calculator = new graphCalculatorv1();
    }

    /// @notice Test that a graph name can be created
    function testShouldCreateNameUnit() external {
        //pre
        assertFalse(calculator.nameExists("HELLO"));
        calculator.create("HELLO");
        //post
        assertTrue(calculator.nameExists("HELLO"));
    }
    /// @notice Test that a graph name cannot be created twice
    function testShouldNotCreateNameUnit() external {
        //pre
        calculator.create("HELLO");
        //post
        assertTrue(calculator.nameExists("HELLO"));
        vm.expectRevert();
        calculator.create("HELLO");
    }

    /// @notice Test that a graph can be assigned to a name
    /// @dev Test that a graph can be assigned to a name
    function testShouldAssignNameToGraphUnit() external {
        calculator.create("HELLO");
        string[] memory vertices = new string[](3);
        vertices[0] = "sAS";
        vertices[1] = "OPo";
        vertices[2] = "acasa";
        string[][] memory edges = new string[][](2);
        edges[0] = new string[](2);
        edges[0][0] = "sAS";
        edges[0][1] = "OPo";
        edges[1] = new string[](2);
        edges[1][0] = "OPo";
        edges[1][1] = "acasa";
        calculator.assign("HELLO", vertices, edges);
        //post
        calculator.getGraph("HELLO");
    }
}
