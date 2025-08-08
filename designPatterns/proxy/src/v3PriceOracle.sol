// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IRateProvider} from "balancer-v3-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/IRateProvider.sol";
import {SqrtPriceLibrary} from "./libraries/SqrtPriceLibrary.sol";
import {IUniswapV3Pool} from "v3-core/interfaces/IUniswapV3Pool.sol";
import {OracleLibrary} from "v3-periphery/libraries/OracleLibrary.sol";
abstract contract v3PriceOracle is IRateProvider {
    using SqrtPriceLibrary for uint256;
    using SqrtPriceLibrary for uint160;
    using OracleLibrary for address;
    using OracleLibrary for address[];

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
        address[] memory tokens = new address[](2);
        tokens[0] = pool.token0();
        tokens[1] = pool.token1();
        int24[] memory tick = new int24[](1);
        tick[0] = _tick;
        return
            uint256(
                tokens.getChainedPrice(tick) < 0
                    ? -tokens.getChainedPrice(tick)
                    : tokens.getChainedPrice(tick)
            );
    }
}
