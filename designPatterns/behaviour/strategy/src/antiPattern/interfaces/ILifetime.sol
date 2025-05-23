// SPDX-License-Identifier: CC0-1.0
pragma solidity >=0.8.0 <0.9.0;

import "../../interfaces/IERC7818.sol";
interface ILifetime {
    function setBornParam(
        IERC7818.EPOCH_TYPE epochType,
        uint256 requestedBornParam
    ) external;
}
