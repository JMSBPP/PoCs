// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "@forge-std/Test.sol";

contract encodingPracticeTests is Test {
    function setUp() public {}

    function testEncodeFixedSizeMatrix()
        external
        pure
        returns (bytes memory _calldata)
    {
        uint256[2] memory colOne;
        colOne[0] = 1;
        colOne[1] = 2;
        uint256[2] memory colTwo;
        colTwo[0] = 3;
        colTwo[1] = 4;
        uint256[2] memory colThree;
        colThree[0] = 5;
        colThree[1] = 6;
        uint256[2][3] memory matrix1;
        matrix1[0] = colOne;
        matrix1[1] = colTwo;
        matrix1[2] = colThree;
        uint256[2] memory _colOne;
        _colOne[0] = 7;
        _colOne[1] = 8;
        uint256[2] memory _colTwo;
        _colTwo[0] = 9;
        _colTwo[1] = 10;
        uint256[2] memory _colThree;
        _colThree[0] = 11;
        _colThree[1] = 12;
        uint256[2][3] memory matrix2;
        matrix2[0] = _colOne;
        matrix2[1] = _colTwo;
        matrix2[2] = _colThree;
        _calldata = abi.encodeWithSignature(
            "solution(uint256[2][3] calldata,uint256[2][3] calldata)",
            matrix1,
            matrix2
        );
    }
}
