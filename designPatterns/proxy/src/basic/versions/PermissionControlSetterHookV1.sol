// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "v4-periphery/src/utils/BaseHook.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
// @dev This Hooks is a Moch of a UUPS compliant hook that changes it's permissions
// Consider integrating with TimeLockController
contract PermissionControlSetterHookV1 is BaseHook {
    uint160 private hookPermissionsX160 =
        uint160((~uint160(0) << uint160(0x14)) | Hooks.BEFORE_INITIALIZE_FLAG);

    event PermissionsUpdated(
        uint160 prevPermissionsX160,
        uint160 newPermissionsX160
    );
    constructor(IPoolManager _poolManager) BaseHook(_poolManager) {}

    function getHookPermissions()
        public
        pure
        virtual
        override
        returns (Hooks.Permissions memory permissions)
    {
        return
            Hooks.Permissions({
                beforeInitialize: true,
                afterInitialize: false,
                beforeAddLiquidity: false,
                afterAddLiquidity: false,
                beforeRemoveLiquidity: false,
                afterRemoveLiquidity: false,
                beforeSwap: false,
                afterSwap: false,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            });
    }

    function _beforeInitialize(
        address,
        PoolKey calldata,
        uint160
    ) internal virtual override returns (bytes4) {
        emit PermissionsUpdated(hookPermissionsX160, hookPermissionsX160);
        return IHooks.beforeInitialize.selector;
    }

    function _authorizeUpgrade(address _newImplementation) internal override {
        // This will support future feature additions 
        // without having to have liquidity providers do migrations.

        // Requirements
        // - Admin upgradable
        // - Timelock system prevents rugging, 
        //    gives people at least 72 hours 
        //    to withdraw if they disagree with an upgrade by the admin.

Admin pauseable
    }
}
