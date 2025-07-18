//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Storage Slot For Mappings
// To compute the storage slot of the value, we take the followings steps:

// Concatenate the key associated with the value and the mapping variable storage slot (base slot)
// Hash the concatenated result.
// Formula for the above steps

// bytes32 keyedValue =
// keccak256(abi.encodePacked(key, baseSlot));
import {IPoolManager} from "v4-core/interfaces/IPoolManager.sol";
import {IHooks} from "v4-core/interfaces/IHooks.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";
import {BaseHook} from "v4-periphery/src/utils/BaseHook.sol";
import {BalanceDelta, BalanceDeltaLibrary} from "v4-core/types/BalanceDelta.sol";

// NOTE: This Hook is designed to keep track of the balances
// of lp's

enum CallerType {
    NONE,
    LP,
    Swapper,
    Donator,
    Router,
    Hook,
    Manager,
    Other
}

contract ComplexTypes is BaseHook {
    // This stores the balance delta of the caller
    // BaseSlot = 1
    mapping(address => BalanceDelta) private deltaBalances;
    // This nested mapping stores the delta of the caller
    // distinguishing between an LP delta, swapper,
    // router, hook and manager
    // BaseSlot = 2
    mapping(address => mapping(CallerType => BalanceDelta))
        private callerDeltas;
    // BaseSlot = 3
    mapping(address => bytes hookData) private callerHookData;
    constructor(IPoolManager _manager) BaseHook(_manager) {}

    function getHookPermissions()
        public
        pure
        virtual
        override
        returns (Hooks.Permissions memory permissions)
    {
        return
            Hooks.Permissions({
                beforeInitialize: false,
                afterInitialize: false,
                beforeAddLiquidity: true,
                afterAddLiquidity: true,
                beforeRemoveLiquidity: true,
                afterRemoveLiquidity: true,
                beforeSwap: true,
                afterSwap: true,
                beforeDonate: true,
                afterDonate: true,
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            });
    }
}
