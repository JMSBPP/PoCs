// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "@Test/Test.sol";
import {graphStorage} from "../../src/graphStorage.sol";
import {graphLogicV1} from "../../src/graphLogicV1.sol";
contract graphUnitTest is Test {
    //graph 1

    graphLogicV1 private graph_api;
    //graph2
    graphLogicV1 private other_graph_api;

    function setUp() public {
        // graph 1
        graph_api = new graphLogicV1();

        //graph 2
        other_graph_api = new graphLogicV1();
    }

    function testShouldCreateEmptyGraph() public {
        string[] memory vertices = new string[](0);
        string[][] memory edges = new string[][](0);
        graph_api.setGraph(vertices, edges);
        assertEq(0, graph_api.vertices());
        assertEq(0, graph_api.edges());
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
        graph_api.setGraph(vertices, edges);
        assertEq(3, graph_api.vertices());
        assertEq(2, graph_api.edges());
    }
    // public void shouldNotHaveDuplicateVerticesEdges(){
    //     String [] vertices ={"DDYA","MYSD","DOPO","DOPO"};
    //     String [][] edges = {{"DDYA","MYSD"},{"DDYA","DOPO"},{"DDYA","DOPO"}};
    //     assertEquals(3, new Graph(vertices,edges).vertices());
    //     assertEquals(2, new Graph(vertices,edges).edges());
    // }
    function testShouldNotHaveDuplicateVerticesEdges() external {
        string[] memory vertices = new string[](4);
        string[][] memory edges = new string[][](3);
        vertices[0] = "DDYA";
        vertices[1] = "MYSD";
        vertices[2] = "DOPO";
        vertices[3] = "DOPO";
        edges[0] = new string[](2);
        edges[0][0] = "DDYA";
        edges[0][1] = "MYSD";
        edges[1] = new string[](2);
        edges[1][0] = "DDYA";
        edges[1][1] = "DOPO";
        edges[2] = new string[](2);
        edges[2][0] = "DDYA";
        edges[2][1] = "DOPO";
        graph_api.setGraph(vertices, edges);
        assertEq(3, graph_api.vertices());
        assertEq(2, graph_api.edges());
    }
    // public void shouldNotBeCaseSensitive(){
    //     String [] vertices ={"Ddya","MYSD","DOPO","dopo"};
    //     String [][] edges = {{"DDYA","Mysd"},{"ddya","dopo"},{"DDya","doPo"}};
    //     assertEquals(3, new Graph(vertices,edges).vertices());
    //     assertEquals(2, new Graph(vertices,edges).edges());
    // }
    function testShouldNotBeCaseSensitive()
        external
        returns (string[] memory _vertices)
    {
        string[] memory vertices = new string[](4);
        string[][] memory edges = new string[][](3);
        vertices[0] = "Ddya";
        vertices[1] = "MYSD";
        vertices[2] = "DOPO";
        vertices[3] = "dopo";
        edges[0] = new string[](2);
        edges[0][0] = "DDYA";
        edges[0][1] = "Mysd";
        edges[1] = new string[](2);
        edges[1][0] = "DDYA";
        edges[1][1] = "dopo";
        edges[2] = new string[](2);
        edges[2][0] = "DDYA";
        edges[2][1] = "doPo";
        graph_api.initialize(vertices, edges);
        _vertices = graph_api.getVertices();
        assertEq(3, graph_api.vertices());
        assertEq(2, graph_api.edges());
    }
    // @Test
    // public void shouldValityEquality(){
    //     String [] vertices ={};
    //     String [][] edges = {};
    //     assertEquals(new Graph(vertices,edges),new Graph(vertices,edges));
    //     String [] verticesA ={"DDYA","MYSD","DOPO"};
    //     String [][] edgesA = {{"DDYA","MYSD"},{"DDYA","DOPO"}};
    //     String [] verticesB ={"Ddya","MYSD","DOPO","dopo"};
    //     String [][] edgesB = {{"DDYA","Mysd"},{"ddya","dopo"},{"DDya","doPo"}};
    //     assertEquals(new Graph(verticesA,edgesA),new Graph(verticesB,edgesB));
    // }

    function shouldValityEqualityOne() internal {
        string[] memory verticesA = new string[](0);
        string[][] memory edgesA = new string[][](0);
        graph_api.setGraph(verticesA, edgesA);
        other_graph_api.setGraph(verticesA, edgesA);
        assertTrue(graph_api.equalsGraph(address(other_graph_api)));
    }
    //     String [] verticesA ={"DDYA","MYSD","DOPO"};
    //     String [][] edgesA = {{"DDYA","MYSD"},{"DDYA","DOPO"}};
    //     String [] verticesB ={"Ddya","MYSD","DOPO","dopo"};
    //     String [][] edgesB = {{"DDYA","Mysd"},{"ddya","dopo"},{"DDya","doPo"}};
    //     assertEquals(new Graph(verticesA,edgesA),new Graph(verticesB,edgesB));
    // }
    function shouldValityEqualityTwo() internal {
        string[] memory verticesA = new string[](3);
        string[][] memory edgesA = new string[][](2);
        verticesA[0] = "DDYA";
        verticesA[1] = "MYSD";
        verticesA[2] = "DOPO";
        edgesA[0] = new string[](2);
        edgesA[0][0] = "DDYA";
        edgesA[0][1] = "MYSD";
        edgesA[1] = new string[](2);
        edgesA[1][0] = "DDYA";
        edgesA[1][1] = "DOPO";
        graph_api.initialize(verticesA, edgesA);
        string[] memory verticesB = new string[](3);
        string[][] memory edgesB = new string[][](3);
        verticesB[0] = "Ddya";
        verticesB[1] = "MYSD";
        verticesB[2] = "DOPO";
        edgesB[0] = new string[](2);
        edgesB[0][0] = "DDYA";
        edgesB[0][1] = "Mysd";
        edgesB[1] = new string[](2);
        edgesB[1][0] = "ddya";
        edgesB[1][1] = "dopo";
        edgesB[2] = new string[](2);
        edgesB[2][0] = "DDya";
        edgesB[2][1] = "doPo";
        other_graph_api.initialize(verticesB, edgesB);
        assertTrue(graph_api.equalsGraph(address(other_graph_api)));
    }

    function testShouldValidateEquality() external {
        shouldValityEqualityOne();
        shouldValityEqualityTwo();
    }

    // @Test
    // public void shouldConvertToString(){
    //     String [] vertices ={"DDYA","MYSD","DOPO"};
    //     String [][] edges = {{"DDYA","MYSD"},{"DDYA","DOPO"}};
    //     String data= "(DDYA, DOPO) (DDYA, MYSD)";
    //     assertEquals(data, new Graph(vertices,edges).toString());
    // }
    function testShouldConvertToString() external {
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
        graph_api.setGraph(vertices, edges);
        string memory expectedString = "(DDYA, DOPO) (DDYA, MYSD)";
        uint256 expected = uint256(keccak256(abi.encode(expectedString)));
        uint256 res = uint256(keccak256(abi.encode(graph_api.toString())));
        assertEq(expected, res);
    }
}
