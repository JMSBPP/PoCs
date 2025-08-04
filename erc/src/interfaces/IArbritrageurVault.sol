// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import {IUniswapV2Callee} from "uniswap-v2-core/interfaces/IUniswapV2Callee.sol";

interface IArbritrageurVault is IUniswapV2Callee {
    error InvalidCaller__CallerMustBeV2PairAddress();
}
