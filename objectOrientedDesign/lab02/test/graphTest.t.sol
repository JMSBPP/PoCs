// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {graphStorage} from "../src/graphStorage.sol";
import {graphLogicV1} from "../src/graphLogicV1.sol";
contract graphTest is Test {
    graphStorage private graphData;
    graphLogicV1 private graphMethods;
    function setUp() public {
        graphData = new graphStorage();
        graphMethods = new graphLogicV1(address(graphData));
    }

    function testShouldCreateEmptyGraph() public {
        string[] memory vertices = new string[](0);
        string[][] memory edges = new string[][](0);
        graphData.initialize(vertices, edges);
        assertEq(0, graphMethods.vertices());
        assertEq(0, graphMethods.edges());
    }

    // public void ShouldCreateGraphs(){
    //     String [] vertices ={"DDYA","MYSD","DOPO"};
    //     String [][] edges = {{"DDYA","MYSD"},{"DDYA","DOPO"}};
    //     assertEquals(3, new Graph(vertices,edges).vertices());
    //     assertEquals(2, new Graph(vertices,edges).edges());
    // }
    function testShouldCreateGraphs() public {
        string[] memory vertices = new string[](3);
        string[][] memory edges = new string[][](2);
        vertices[0] = "DDYA";
        vertices[1] = "MYSD";
        vertices[2] = "DOPO";
        edges[0] = new string[](2);
        edges[0][0] = "DDYA";
        edges[0][1] = "MYSD";
        edges[1] = new string[](2);
        edges[1][0] = "DDYA";
        edges[1][1] = "DOPO";
        graphData.initialize(vertices, edges);
        assertEq(3, graphMethods.vertices());
        assertEq(2, graphMethods.edges());
    }
}
