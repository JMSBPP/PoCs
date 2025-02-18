// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {practiceBaseTest, IiteratedMapping} from "../practice/practiceBaseTest.t.sol";
import {HuffDeployer} from "@HUFF/HuffDeployer.sol";

contract practiceTestHuff is practiceBaseTest {
    string public constant ITERATED_MAPPING_HUFF_LOCATION =
        "practice/IteratedMapping";

    function setUp() public override {
        iteratedMapping = IiteratedMapping(
            HuffDeployer.config().deploy(ITERATED_MAPPING_HUFF_LOCATION)
        );
    }
}
