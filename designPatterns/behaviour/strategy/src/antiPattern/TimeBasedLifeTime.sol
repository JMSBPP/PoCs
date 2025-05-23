// SPDX-License-Identifier: CC0-1.0
pragma solidity >=0.8.0 <0.9.0;

import "./LifeTime.sol";

contract TimeBasedLifetime is Lifetime {
    modifier onlyValidTimeBornParam(uint256 requestedBornParam) {
        timeBased__validateBornParam(requestedBornParam);
        _;
    }

    function timeBased__validateBornParam(
        uint256 requestedBornParam
    ) private view onlyValidBornParam(requestedBornParam) {
        if (requestedBornParam < uint256(block.timestamp))
            revert TimeBasedLifetime__InvalidBornParam();
    }

    function timeBased__validateEpochType(
        IERC7818.EPOCH_TYPE epochType
    ) private pure {
        if (epochType != IERC7818.EPOCH_TYPE.TIME_BASED)
            revert BlockBasedLifetime__InvalidEpochType();
    }

    function setBornParam(
        IERC7818.EPOCH_TYPE epochType,
        uint256 requestedBornParam
    ) external override onlyValidTimeBornParam(requestedBornParam) {
        timeBased__validateEpochType(epochType);
        bornParam = requestedBornParam;
    }
}
