//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseTestV1, IHorseStore} from "./BaseTestv1.t.sol";
import {HuffDeployer} from "@HUFF/HuffDeployer.sol";
contract HorseStoreHuffTest is BaseTestV1 {
    string public constant HORSE_STORE_HUFF_LOCATION = "v1/HorseStore";
    function setUp() public override {
        horseStore = IHorseStore(
            HuffDeployer.config().deploy(HORSE_STORE_HUFF_LOCATION)
        );
    }
}
