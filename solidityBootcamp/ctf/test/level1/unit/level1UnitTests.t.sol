// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {Test} from "@forge-std/Test.sol";
import {Level1Template} from "@level1/solution.sol";

contract Level1UnitTests is Test {
    Level1Template level1;

    function setUp() public {
        level1 = new Level1Template();
    }

    function testMaxSuboptimalMatrixAddition(
        uint256[2][3] calldata matrix1,
        uint256[2][3] calldata matrix2
    ) external view returns (bytes memory _calldata, bytes memory res) {
        _calldata = abi.encodeWithSignature(
            "solution(uint256[2][3] calldata,uint256[2][3] calldata)",
            matrix1,
            matrix2
        );
        (, res) = address(level1).staticcall(_calldata);
    }
}
