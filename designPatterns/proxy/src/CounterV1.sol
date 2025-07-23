// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";
import {TimelockControllerUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";
contract CounterV1 is UUPSUpgradeable, TimelockControllerUpgradeable {
    mapping(address participant => uint256 count) private _participantCounts;
    bytes32 upgradeProposalId;

    error InvalidCall__UpgradeTimeHasNotPassed();
    error InvalidCall__UpgradeAlreadyScheduled();
    modifier onlyAfterScheduledDate() {
        if (getOperationState(upgradeProposalId) != OperationState.Waiting)
            revert InvalidCall__UpgradeTimeHasNotPassed();
        _;
    }

    // modifier onlyForUnsetDoneUpgrades() {
    //     if (
    //         getOperationState(upgradeProposalId) != OperationState.Unset ||
    //         getOperationState(upgradeProposalId) != OperationState.Done
    //     ) revert InvalidCall__UpgradeAlreadyScheduled();
    //     _;
    // }

    function increment() public {
        _participantCounts[msg.sender]++;
    }

    function getCount() external view returns (uint256) {
        return _participantCounts[msg.sender];
    }

    function scheduleUpgrade(
        uint256 delay
    )
        external
        onlyRole(PROPOSER_ROLE)
        returns (bytes32 id)
    {
        id = _scheduleUpgrade(delay);
    }

    function _scheduleUpgrade(
        uint256 delay
    )
        internal
        onlyRole(PROPOSER_ROLE)
        returns (bytes32 id)
    {
        schedule(
            address(this),
            uint256(0x00),
            msg.data[:0],
            bytes32(0x00),
            bytes32(0x00),
            delay
        );
        upgradeProposalId = hashOperation(
            address(this),
            uint256(0x00),
            msg.data[:0],
            bytes32(0x00),
            bytes32(0x00)
        );
        id = upgradeProposalId;
    }

    function _authorizeUpgrade(
        address newImplementation
    )
        internal
        virtual
        override
        onlyRole(PROPOSER_ROLE)
        onlyAfterScheduledDate
    {}

    function initialize(address _admin) public virtual initializer {
        address[] memory proposers = new address[](1);
        proposers[0] = _admin;
        __TimelockController_init(
            uint256(1800),
            proposers,
            new address[](0),
            _admin
        );
    }

    function setProxyAsExcecutor(address _proxy) public {
        _grantRole(EXECUTOR_ROLE, _proxy);
    }
}
