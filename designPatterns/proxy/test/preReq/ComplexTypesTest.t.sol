//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {Deployers} from "@uniswap/v4-core/test/utils/Deployers.sol";
import {Constants} from "@uniswap/v4-core/test/utils/Constants.sol";
import {IHooks} from "v4-core/interfaces/IHooks.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";
import {ComplexTypes} from "../../src/preReq/ComplexTypes.sol";

contract ComplexTypesTest is Test, Deployers {
    ComplexTypes private complexTypes;

    function setUp() public {
        deployFreshManagerAndRouters();
        (currency0, currency1) = deployMintAndApprove2Currencies();
        ComplexTypes _complexTypes = ComplexTypes(
            address(
                uint160(
                    type(uint160).max |
                        clearAllHookPermissionsMask |
                        Hooks.BEFORE_ADD_LIQUIDITY_FLAG |
                        Hooks.AFTER_ADD_LIQUIDITY_FLAG |
                        Hooks.BEFORE_REMOVE_LIQUIDITY_FLAG |
                        Hooks.AFTER_REMOVE_LIQUIDITY_FLAG |
                        Hooks.BEFORE_SWAP_FLAG |
                        Hooks.AFTER_SWAP_FLAG |
                        Hooks.BEFORE_DONATE_FLAG |
                        Hooks.AFTER_DONATE_FLAG
                )
            )
        );
        deployCodeTo(
            "ComplexTypes",
            abi.encode(manager),
            address(_complexTypes)
        );
        (key, ) = initPoolAndAddLiquidity(
            currency0,
            currency1,
            IHooks(address(_complexTypes)),
            Constants.FEE_MEDIUM,
            SQRT_PRICE_1_2
        );
    }
}
