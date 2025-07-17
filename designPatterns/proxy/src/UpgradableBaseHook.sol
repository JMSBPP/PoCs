//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Initializable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import {BaseHook} from "v4-periphery/src/utils/BaseHook.sol";
import {IPoolManager} from "@uniswap/v4-core/src/interfaces/IPoolManager.sol";
import {Hooks} from "v4-core/libraries/Hooks.sol";

// TODO: Our goal is to create a template for any hook
// inheriting this to be compatible with proxies

// @dev This is a base contract to aid in writing upgradeable contracts,
// that will be deployed behind a proxy.
abstract contract UpgradableBaseHook is BaseHook, Initializable {
    bool public initializerRan;
    bool public onlyInitializingRan;

    constructor(IPoolManager _manager) BaseHook(_manager) initializer {
        initialize();
        initializeOnlyInitializing();
    }
    function initialize() public initializer {
        initializerRan = true;
    }

    function initializeOnlyInitializing() public onlyInitializing {
        onlyInitializingRan = true;
    }
}
