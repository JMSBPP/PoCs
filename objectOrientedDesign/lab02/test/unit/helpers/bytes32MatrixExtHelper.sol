// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {bytes32MatrixExt} from "../../../src/libraries/bytes32MatrixExt.sol";

contract bytes32MatrixExtHelper {
    using bytes32MatrixExt for bytes32[][];
    function unitStateSetUp() external returns (bytes32[][] memory subsets) {
        bytes32[][] memory collectionOfSubsets = new bytes32[][](3);
        bytes32[] memory referencePowerSet = new bytes32[](3);
        referencePowerSet[0] = bytes32(uint256(0x02));
        referencePowerSet[1] = bytes32(uint256(0x01));
        referencePowerSet[2] = bytes32(uint256(0x04));
        collectionOfSubsets[0] = new bytes32[](2);

        //-----THIS ONE SHOULD NOT BE ADDED----
        bytes32[] memory firstSubset = new bytes32[](2);
        firstSubset[0] = bytes32(uint256(0x00));
        firstSubset[1] = bytes32(uint256(0x01));
        //
        collectionOfSubsets[0] = firstSubset;
        //---THIS SHOULD BE ADDED-----
        bytes32[] memory secondSubset = new bytes32[](2);
        secondSubset[0] = bytes32(uint256(0x02));
        secondSubset[1] = bytes32(uint256(0x04));
        collectionOfSubsets[1] = secondSubset;
        //EXPECTED ---[[0x02,0x04]]
        subsets = new bytes32[][](1);
        subsets = collectionOfSubsets.onlySubsetsOf(referencePowerSet);
    }
}
