// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IPermissionControlSetterHookV1 {
    event PermissionsUpdated(
        uint160 prevPermissionsX160,
        uint160 newPermissionsX160
    );
}
