//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HorseStore {
    uint256 numberOfHorses;

    function updateHorseNumber(uint256 newNumber) public {
        numberOfHorses = newNumber;
    }

    function readNumberOfHorses() public view returns (uint256) {
        return numberOfHorses;
    }
}
