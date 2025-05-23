// SPDX-License-Identifier: CC0-1.0
pragma solidity >=0.8.0 <0.9.0;

import "./interfaces/ILifetime.sol";
import "./base/Errors.sol";
abstract contract Lifetime is ILifetime {
    uint256 internal bornParam;
    uint256 internal deathParam;

    modifier onlyValidBornParam(uint256 requestedBornParam) {
        general__validateBornParam(requestedBornParam);
        _;
    }
    function general__validateBornParam(
        uint256 requestedBornParam
    ) private view {
        if (
            requestedBornParam == 0 ||
            (requestedBornParam > deathParam && deathParam != 0)
        ) revert Lifetime__InvalidBornParam();
    }
    function setBornParam(
        IERC7818.EPOCH_TYPE epochType,
        uint256 requestedBornParam
    ) external virtual onlyValidBornParam(requestedBornParam) {
        bornParam = requestedBornParam;
    }

    function getBornParam() external view returns (uint256 _bornParam) {
        _bornParam = bornParam;
    }
}
