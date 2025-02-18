// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {GraphStorageAccess} from "../src/graphStorageAccess.sol";
import {GraphLogicV1} from "../src/graphLogicV1.sol";
contract graphTest is Test {
    GraphStorageAccess private graph;
    GraphLogicV1 private graphLogic;
    function setUp() public {
        graph = new GraphStorageAccess();
        graphLogic = new GraphLogicV1(address(graph));
    }

    function testShouldCreateEmptyGraph() public {
        string[] memory vertices = new string[](0);
        string[][] memory edges = new string[][](0);
        graph.initialize(vertices, edges);
        assertEq(0, graphLogic.vertices());
        assertEq(0, graphLogic.edges());
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
        graph.initialize(vertices, edges);
        assertEq(3, graphLogic.vertices());
        assertEq(2, graphLogic.edges());
    }
}
