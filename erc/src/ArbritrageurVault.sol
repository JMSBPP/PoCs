// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import {IArbritrageurVault} from "./interfaces/IArbritrageurVault.sol";
// This contract is to be integrated with EVC and it is to be EIP1155 to be gas efficient
// proxy

abstract contract ArbritrageurVault is IArbritrageurVault, IUniswapV2Callee {
    function uniswapV2Call(
        address sender, // caller of the swap
        uint amount0, // Amount 0 Out
        uint amount1, // Amount 1 Out
        bytes calldata data // External call to do the flash loan
    ) external {}
}
