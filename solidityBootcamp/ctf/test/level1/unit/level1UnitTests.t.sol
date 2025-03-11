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
    ) external view returns (uint256[2][3] memory result) {
        bytes memory _calldata = abi.encodeWithSignature(
            "solution(uint256[2][3] calldata,uint256[2][3] calldata)",
            matrix1,
            matrix2
        );
        (, bytes memory res) = address(level1).staticcall(_calldata);
        result = abi.decode(res, (uint256[2][3]));
    }
}
