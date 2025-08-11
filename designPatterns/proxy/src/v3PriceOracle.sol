// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IRateProvider} from "balancer-v3-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/IRateProvider.sol";
import {IUniswapV3Pool} from "v3-core/interfaces/IUniswapV3Pool.sol";
import {OracleLibrary} from "v3-periphery/libraries/OracleLibrary.sol";
import {TickMath} from "v3-core/libraries/TickMath.sol";
contract v3PriceOracle is IRateProvider {
    using OracleLibrary for address;
    using OracleLibrary for address[];
    using TickMath for int24;

    IUniswapV3Pool public immutable pool;
    constructor(address _pool) {
        pool = IUniswapV3Pool(_pool);
    }
    // struct Slot0 {
    //     // the current price
    //     uint160 sqrtPriceX96;
    //     // the current tick
    //     int24 tick;
    //     // the most-recently updated index of the observations array
    //     uint16 observationIndex;
    //     // the current maximum number of observations that are being stored
    //     uint16 observationCardinality;
    //     // the next maximum number of observations to store, triggered in observations.write
    //     uint16 observationCardinalityNext;
    //     // the current protocol fee as a percentage of the swap fee taken on withdrawal
    //     // represented as an integer denominator (1/x)%
    //     uint8 feeProtocol;
    //     // whether the pool is locked
    //     bool unlocked;
    // }
    // /// @inheritdoc IUniswapV3PoolState
    // Slot0 public override slot0;

    function getRate() external view returns (uint256) {
        (int24 _tick, ) = address(pool).getBlockStartingTickAndLiquidity();
        return uint256(_tick.getSqrtRatioAtTick());
        
    }
}
