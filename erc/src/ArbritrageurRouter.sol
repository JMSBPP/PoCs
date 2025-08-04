// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import {FlashBorrower} from "./minimal/FlashBorrower.sol";
import {IUniswapV2Callee} from "uniswap-v2-core/interfaces/IUniswapV2Callee.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Pair} from "uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import {UniswapV2Library} from "uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import {ContextUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol";
import {Initializable} from "openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import {IArbritrageurVault} from "./interfaces/IArbritrageurVault.sol";
struct Pools {
    IUniswapV2Pair v2Pair;
}

contract ArbritrageurRouter is Initializable, ContextUpgradeable {
    using UniswapV2Library for address;
    /// @custom:storage-location erc7201:openzeppelin.storage.ArbritrageurRouter
    struct ArbritrageurRouterStorage {
        IUniswapV2Pair v2Pair;
        IArbritrageurVaults[] vaults;
    }
    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.ArbritrageurRouter")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant ArbritrageurRouterStorageLocation =
        0x2b974cc898df09e5aa2f5b36bc98f38d460a97c9749e7016973e73490f296a00;
    function _getArbritrageurRouterStorage()
        private
        pure
        returns (ArbritrageurRouterStorage storage $)
    {
        assembly {
            $.slot := ArbritrageurRouterStorageLocation
        }
    }

    function v2Pair() public view returns (IUniswapV2Pair) {
        return _getArbritrageurRouterStorage().v2Pair;
    }

    error PoolHasNotBeenCreated();
    error TraderMustHaveBoughtOneOfTheTokens();

    function initialize(
        address v2Factory,
        address tokenA,
        address tokenB
    ) public initializer {
        address pair = v2Factory.pairFor(tokenA, tokenB);
        ArbritrageurRouterStorage storage $ = _getArbritrageurRouterStorage();
        $.v2Pair = IUniswapV2Pair(pair);
    }

    function uniswapV2Call(
        address sender, // caller of the swap
        uint amount0, // Amount 0 Out
        uint amount1, // Amount 1 Out
        bytes calldata data // External call to do the flash loan
    ) external {
        // NOTE: The trader already has the amount_i_Out of the token they bought,
        // we need to identify which token is it ?
        address[] memory path = new address[](2);
        {
            address token0 = v2Pair.token0();
            address token1 = v2Pair.token1();
            // NOTE: that the caller of this function MUST be the
            // UniswapV2Pair contract
            if (!(_msgSender() == address(v2Factory).pairFor(token0, token1)))
                revert InvalidCaller__CallerMustBeV2PairAddress();

            if (amount0 == 0 || amount1 == 0)
                revert TraderMustHaveBoughtOneOfTheTokens();
            //NOTE: If amount0==0 then the trader has bought token1
            // therefore we wants to buy
        }
    }
}
