// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";
import {TimelockControllerUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";
/// @custom:oz-upgrades-from CounterV1
contract CounterV1 is UUPSUpgradeable, TimelockControllerUpgradeable {
    mapping(address participant => uint256 count) private _participantCounts;

    constructor() {
        _disableInitializers();
    }
    function increment(address _participant) public {
        _participantCounts[_participant]++;
    }

    function getCount(address _participant) external view returns (uint256) {
        return _participantCounts[_participant];
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal virtual override onlyRole(PROPOSER_ROLE) {
        schedule(
            newImplementation,
            uint256(0x00),
            msg.data[:0],
            bytes32(0x00),
            bytes32(0x00),
            getMinDelay()
        );
    }

    function initialize(
        address _admin,
        address _proxy
    ) public virtual initializer {
        address[] memory proposers = new address[](1);
        address[] memory executors = new address[](1);
        proposers[0] = _admin;
        executors[0] = _proxy;
        __TimelockController_init(uint256(1800), proposers, executors, _admin);
    }
}
