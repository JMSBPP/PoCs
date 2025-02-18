//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HorseStoreYul {
    uint256 numberOfHorses;

    function updateHorseNumber(uint256 newNumber) public {
        assembly {
            sstore(numberOfHorses.slot, newNumber)
        }
    }

    function readNumberOfHorses() public view returns (uint256) {
        assembly {
            let numb := sload(numberOfHorses.slot)
            mstore(0, numb)
            return(0, 0x20)
        }
    }
}
