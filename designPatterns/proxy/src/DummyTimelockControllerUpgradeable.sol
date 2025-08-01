// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {TimelockControllerUpgradeable, Initializable} from "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";
import {UUPSUpgradeable, ERC1967Utils} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";

abstract contract DummyTimelockControllerUpgradeable is
    TimelockControllerUpgradeable,
    UUPSUpgradeable
{
    /// @custom:storage-location erc7201:openzeppelin.storage.UpgradeControl
    struct UpgradeControlStorage {
        bytes32 upgradeId;
        uint256 nonce;
    }

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.UpgradeControl")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant UpgradeControlStorageLocation =
        0x3ba623ae4c8b7e2f540ff4f5e4ad21b8522a86456b1a78334d79760b6f8e3500;

    function _getUpgradeControlStorage()
        private
        pure
        returns (UpgradeControlStorage storage $)
    {
        assembly {
            $.slot := UpgradeControlStorageLocation
        }
    }

    function upgradeId() public view returns (bytes32) {
        UpgradeControlStorage storage $ = _getUpgradeControlStorage();
        return $.upgradeId;
    }

    function initialize(address executor) public initializer {
        address[] memory proposers = new address[](1);
        proposers[0] = _msgSender();
        address[] memory executors = new address[](1);
        // NOTE: The idea is to test what happens when switching between

        // address(this) -> proxy
        // ERC1967Utils.getImplementation() -> implementation
        executors[0] = executor;
        __TimelockController_init(
            uint256(25_200),
            proposers,
            executors,
            address(0x00)
        );
    }
    function scheduleUpgrade(
        uint256 delay,
        address newImplementation
    ) public onlyRole(PROPOSER_ROLE) {
        UpgradeControlStorage storage $ = _getUpgradeControlStorage();
        bytes32 salt = keccak256(
            abi.encodePacked(newImplementation, $.nonce, block.timestamp)
        );
        _scheduleUpgrade(delay, newImplementation, salt);
    }

    // /**
    //  * @dev Execute an operation's call.
    //  */
    // function _execute(address target, uint256 value, bytes calldata data) internal virtual {
    //     (bool success, bytes memory returndata)
    //  = target.call{value: value}(data);
    //     Address.verifyCallResult(success, returndata);
    // }

    function _scheduleUpgrade(
        uint256 delay,
        address newImplementation,
        bytes32 salt
    ) private {
        //TODO: Here msg.data needs to be the call to
        // ERC1967Utils.upgradeToAndCall with the new
        // newImplementation as argument
        schedule(
            address(this), // Proxy.call() -> Proxy.delegateCall() - > Imp.call()
            msg.value,
            _msgData(),
            upgradeId(),
            salt,
            delay
        );
    }

    // function upgradeToAndCall(
    //    address newImplementation,
    //    bytes memory data)
    // public payable virtual onlyProxy {
    //     _authorizeUpgrade(newImplementation);
    //     _upgradeToAndCallUUPS(newImplementation, data);
    // }
}
