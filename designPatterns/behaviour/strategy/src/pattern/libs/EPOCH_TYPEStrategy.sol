// SPDX-License-Identifier: CC0-1.0
pragma solidity >=0.8.0 <0.9.0;

import "../../interfaces/IERC7818.sol";

library EPOCH_TYPEStrategy {
    function setBornParam(
        IERC7818.EPOCH_TYPE epochType,
        uint256 requestedBornParam
    ) external pure {
        assembly ("memory-safe") {
            switch epochType{
                case 0 {}

                case 1 {}
            }
            
        }

    }
}
