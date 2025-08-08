// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Initializable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import "v4-periphery/src/utils/BaseHook.sol";
import {BaseHookUpgradable} from "./base/BaseHookUpgradable.sol";
import {IRateProvider} from "balancer-v3-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/IRateProvider.sol";

abstract contract PriceOracleHookUpgradable is
    Initializable,
    BaseHookUpgradable
{
    /// @custom:storage-location erc7201:openzeppelin.storage.PriceOracleHook
    struct PriceOracleHookStorage {
        PoolKey poolKey;
        IRateProvider externalMarket;
        uint160 sqrtPriceX96;
    }

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.PriceOracleHook")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant PriceOracleHookStorageLocation =
        0x9b6a11e4e95282dad8d9c287b60226646f516d73e0c350e5c6dc3a706d6c4b00;

    function _getPriceOracleHookStorage()
        private
        pure
        returns (PriceOracleHookStorage storage $)
    {
        assembly {
            $.slot := PriceOracleHookStorageLocation
        }
    }
    function _beforeInitialize(
        address,
        PoolKey calldata,
        uint160 initialSqrtPriceX96
    ) internal virtual override returns (bytes4) {
        // TODO: Logic for the getExternalPrice hook
        // And creation of new poolKey with new price if needed
        uint256 externalPrice = externalMarket().getRate();
        // if (v3SqrtPriceX96 != initialSqrtPriceX96) {
        //     poolManager().initialize(poolKey(), v3SqrtPriceX96);
        // }
    }

    // TODO: Checks for beforeInitialize
    function initialize(
        PoolKey memory _poolKey, // This is the only
        // parametrized parameter
        IRateProvider _externalMarket,
        IPoolManager _poolManager,
        Hooks.Permissions calldata _permissions
    ) public initializer {
        __BaseHook_init(_poolManager, _permissions);
        PriceOracleHookStorage storage $ = _getPriceOracleHookStorage();
        $.poolKey = _poolKey;
        $.externalMarket = _externalMarket;
    }

    function poolKey() public view virtual returns (PoolKey memory _poolKey) {
        PriceOracleHookStorage memory $ = _getPriceOracleHookStorage();
        _poolKey = $.poolKey;
    }
    function externalMarket()
        public
        view
        virtual
        returns (IRateProvider _externalMarket)
    {
        PriceOracleHookStorage memory $ = _getPriceOracleHookStorage();
        _externalMarket = $.externalMarket;
    }
}
