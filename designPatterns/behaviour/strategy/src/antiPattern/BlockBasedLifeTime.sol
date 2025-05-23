// SPDX-License-Identifier: CC0-1.0
pragma solidity >=0.8.0 <0.9.0;

import "./LifeTime.sol";

contract BlockBasedLifetime is Lifetime {
    modifier onlyValidBlockBornParam(uint256 requestedBornParam) {
        blockBased__validateBornParam(requestedBornParam);
        _;
    }

    function blockBased__validateEpochType(
        IERC7818.EPOCH_TYPE epochType
    ) private pure {
        if (epochType != IERC7818.EPOCH_TYPE.BLOCKS_BASED)
            revert BlockBasedLifetime__InvalidEpochType();
    }

    function blockBased__validateBornParam(
        uint256 requestedBornParam
    ) private view onlyValidBornParam(requestedBornParam) {
        if (requestedBornParam < uint256(block.number))
            revert BlockBasedLifetime__InvalidBornParam();
    }

    function setBornParam(
        IERC7818.EPOCH_TYPE epochType,
        uint256 requestedBornParam
    ) external override onlyValidBlockBornParam(requestedBornParam) {
        blockBased__validateEpochType(epochType);
        bornParam = requestedBornParam;
    }
}
