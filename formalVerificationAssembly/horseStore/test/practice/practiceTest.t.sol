// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import {Test} from "../../lib/forge-std/src/Test.sol";
import {practice} from "../../src/practice/practice.sol";

contract practiceTest is Test {
    practice p;

    function setUp() public {
        p = new practice();
    }

    function testgetK2Data(
        address k1,
        uint256 k2,
        uint256 value
    ) external view returns (bytes32 _k2) {
        bytes memory data = p.receiveData(k1, k2, value);
        _k2 = p.retreiveK2(data);
    }

    function testdataPlusSelector(
        address k1,
        uint256 k2,
        uint256 value
    ) external view returns (bytes memory data) {
        data = p.dataPlusSelector(k1, k2, value);
    }
}
