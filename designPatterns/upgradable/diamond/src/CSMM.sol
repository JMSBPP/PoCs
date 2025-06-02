//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "./interfaces/ICustomCurve.sol";
abstract contract CSMM is ICustomCurve {
    function modifyLiquidity(
        address sender,
        PoolKey memory poolKey,
        ModifyLiquidityParams memory params
    ) external returns (BalanceDelta callerDelta, BalanceDelta feesAccrued) {
        // TODO:
        // - L([pl, pu]) such that:
        //      - R_X (pl, pu) == R_Y (pl, pu)
        // We are providing a 1:1 reserve ratio
        // for all prices on the range (pl,pu)
        //However the price space on CSMM is
        // {1} since the pair is stable. Then
        // we just need to provide
        //  R_X = L/2 = R_Y/2
    }

    function swap(
        PoolKey memory key,
        SwapParams memory params,
        bytes calldata hookData
    ) external returns (BalanceDelta swapDelta) {}
}

abstract contract Leontief is ICustomCurve {
    function modifyLiquidity(
        address sender,
        PoolKey memory poolKey,
        ModifyLiquidityParams memory params
    ) external returns (BalanceDelta callerDelta, BalanceDelta feesAccrued) {}
    function swap(
        PoolKey memory key,
        SwapParams memory params,
        bytes calldata hookData
    ) external returns (BalanceDelta swapDelta) {}
}
