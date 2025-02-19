// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IgraphLogic} from "./interfaces/IgraphLogic.sol";
import {graphStorage} from "./graphStorage.sol";
import {stringToBytes32Parser} from "./libraries/stringToBytes32Parser.sol";
import {bytes32ToStringParser} from "./libraries/bytes32ToStringParser.sol";
import {bytes32Ext} from "./libraries/bytes32Ext.sol";
import {bytes32ArrayExt} from "./libraries/bytes32ArrayExt.sol";
import {bytes32MatrixExt} from "./libraries/bytes32MatrixExt.sol";
contract graphLogicV1 is IgraphLogic {
    using bytes32Ext for bytes32;
    using bytes32ToStringParser for bytes32;
    using bytes32ArrayExt for bytes32[];
    using bytes32MatrixExt for bytes32[][];
    using stringToBytes32Parser for string;

    graphStorage private graphData;

    constructor(address _graphStorage) {
        graphData = graphStorage(_graphStorage);
    }

    function contains(
        string memory vertexName
    ) external view returns (bool isInGraph) {
        bytes32 encodedVertexName = vertexName.stringToBytes32();
        isInGraph = graphData.getVertices().searchBytes32(encodedVertexName);
    }
    //NOTE: MISSING IMPLEMENTATION
    function path(
        string memory fromVertex,
        string memory toVertex
    ) external returns (bytes32 _pathGraphEncoded) {
        _pathGraphEncoded = bytes32(0);
    }

    //NOTE: MISSING IMPLEMENTATION

    function union(
        string memory g1
    ) external returns (bytes32 g1UnionCurrentGraph) {
        g1UnionCurrentGraph = bytes32(0);
    }

    function vertices() external view returns (uint256 numberOfVertices) {
        numberOfVertices = graphData.getVertices().length;
    }
    function edges() external view returns (uint256 numberOfEdges) {
        numberOfEdges = graphData.getEdges().length;
    }
}
