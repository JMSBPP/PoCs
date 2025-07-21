// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {TimelockController} from "openzeppelin-contracts/contracts/governance/TimelockController.sol";

contract TimeControlledRuggBlocker is TimelockController {
    address public proxyContract;

    error UUPSProxyNotSet();

    event SuperDCAGaugeUpgradeScheduled(
        address indexed newImplementation,
        uint256 indexed delay
    );
    constructor(
        address _developerAddress
    )
        TimelockController(
            259_200, // 72 hours
            new address[](0),
            new address[](0),
            msg.sender
        )
    {
        // NOTE: The addresses inside porposers is the developerAddress
        // IDEA: This developer address can be then forced to comply with IGovernor
        // for further security
        _grantRole(PROPOSER_ROLE, _developerAddress);
        _grantRole(CANCELLER_ROLE, _developerAddress);

        // NOTE: The address on excecutors are empty and once the proxy contract address
        // is known is set to the proxy contract to be the excecutor
    }
    modifier onlyAfterProxyIsknown() {
        if (proxyContract == address(0)) {
            revert UUPSProxyNotSet();
        }
        _;
    }
    function setProxyContract(
        address _proxyContract
    ) public onlyRole(PROPOSER_ROLE) {
        // TODO: This is PoC
        // Further checks on the proxy contract actually
        // complies with UUPS Proxy
        proxyContract = _proxyContract;
        _grantRole(EXECUTOR_ROLE, proxyContract);
    }

    function _scheduleUpgrade(
        address newImplementation
    ) internal onlyRole(PROPOSER_ROLE) {
        uint256 minDelay = getMinDelay();
        schedule(
            newImplementation,
            uint256(0x00),
            msg.data[:0],
            bytes32(0x00),
            bytes32(0x00),
            minDelay
        );
        emit SuperDCAGaugeUpgradeScheduled(newImplementation, minDelay);
    }
}
