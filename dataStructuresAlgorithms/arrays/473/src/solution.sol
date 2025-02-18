// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/openzeppelin-contracts/contracts/utils/Arrays.sol";

contract Solution {
    using Arrays for uint256[];

    function receiveMatchSticks(
        uint256[] calldata matchSticks
    ) public pure returns (uint256) {
        require(matchSticks.length >= 4, "CAN NOT MAKE A SQUARE");
        uint256 minNumberOfMaxs = matchSticks.length - 4;
        uint256 max = matchSticks.sort()[matchSticks.length - 1];
        uint256 counter = 0;

        for (uint256 index = 0; index < matchSticks.length; index++) {
            if (matchSticks[index] == max) {
                counter += 1;
            }
        }
        require(counter >= minNumberOfMaxs, "CAN NOT MAKE A SQUARE");
        return counter;
    }
}
