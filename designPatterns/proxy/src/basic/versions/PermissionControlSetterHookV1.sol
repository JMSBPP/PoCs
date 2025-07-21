// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "v4-periphery/src/utils/BaseHook.sol";
import {IPermissionControlSetterHookV1} from "./interfaces/IPermissionControlSetterHookV1.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
// @dev This Hooks is a Moch of a UUPS compliant hook that changes it's permissions
import {TimeControlledRuggBlocker} from "../TimeControlledRuggBlocker.sol";

contract PermissionControlSetterHookV1 is
    BaseHook,
    UUPSUpgradeable,
    TimeControlledRuggBlocker,
    IPermissionControlSetterHookV1
{
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");

    uint160 private hookPermissionsX160 =
        uint160((~uint160(0) << uint160(0x14)) | Hooks.BEFORE_INITIALIZE_FLAG);
    // // @dev Inherited from SuperDCAGauge
    address public developerAddress;
    constructor(
        IPoolManager _poolManager,
        address _developerAddress
    ) BaseHook(_poolManager) TimeControlledRuggBlocker(_developerAddress) {
        developerAddress = _developerAddress;
        _grantRole(MANAGER_ROLE, _developerAddress);
    }

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

    function _authorizeUpgrade(
        address _newImplementation
    ) internal override onlyRole(MANAGER_ROLE) {
        // TODO: This is a placeHodler for admin checking
        // in practice we might want a better check
        // This will support future feature additions
        // without having to have liquidity providers do migrations.
        // Requirements
        // - Admin upgradable --> AccessControl
        // - Timelock system prevents rugging ---> TimeLockController is AccessConntrol,
        //    gives people at least 72 hours
        //    to withdraw if they disagree with an upgrade by the admin.
        // Admin pauseable
        // bytes32 id = _calculateUpgradeImplementationId(newImplementation);
        _scheduleUpgrade(_newImplementation);
    }
}
