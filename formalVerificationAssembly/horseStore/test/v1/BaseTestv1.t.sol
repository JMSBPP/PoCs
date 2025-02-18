//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHorseStore} from "../../src/v1/interfaces/IHorseStore.sol";
import {HorseStore} from "../../src/v1/HorseStore.sol";
import {Test, console2} from "@forge-std/Test.sol";
abstract contract BaseTestV1 is Test {
    IHorseStore public horseStore;

    // bytes public yulcode =
    //     hex"5ff3fe5f3560dc1c8063cdfead2e1460245763e026c01714601b575f80fd5b5f545f5260205ff35b60243610603256004355f55005b5f80fd";
    function setUp() public virtual {
        horseStore = IHorseStore(address(new HorseStore()));
    }

    function testReadValue() public {
        uint256 initialValue = horseStore.readNumberOfHorses();
        assertEq(initialValue, 0);
    }
    function testWriteValue() public {
        uint256 numberOfHorses = 777;
        horseStore.updateHorseNumber(numberOfHorses);
        assertEq(horseStore.readNumberOfHorses(), numberOfHorses);
    }
}
