//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseTestV1, IHorseStore} from "./BaseTestv1.t.sol";
import {HorseStoreYul} from "../../src/v1/HorseStoreYul.sol";
contract HorseStoreYulTest is BaseTestV1 {
    function setUp() public override {
        horseStore = IHorseStore(address(new HorseStoreYul()));
    }
}
