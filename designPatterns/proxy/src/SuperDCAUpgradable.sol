// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {BaseHookUpgradable, IPoolManager, Hooks} from "./BaseHookUpgradable.sol";
import {TimelockControllerUpgradeable, Initializable} from "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import {EnumerableSet} from "openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";

abstract contract SuperDCAUpgradable is
    Initializable,
    BaseHookUpgradable,
    TimelockControllerUpgradeable,
    UUPSUpgradeable
{
    using EnumerableSet for EnumerableSet.AddressSet;

    // Constants
    uint24 public constant INTERNAL_POOL_FEE = 500; // 0.05%
    uint24 public constant EXTERNAL_POOL_FEE = 5000; // 0.50%
    bytes32 public constant MANAGER_ROLE = keccak256("MANAGER_ROLE");
    /**
     * @notice Information about a token's staking and rewards
     * @param stakedAmount Total amount of SuperDCATokens staked for this token
     * @param lastRewardIndex The reward index when rewards were last claimed
     */
    struct TokenRewardInfo {
        uint256 stakedAmount;
        uint256 lastRewardIndex;
    }

    // Events
    event Staked(address indexed token, address indexed user, uint256 amount);
    event Unstaked(address indexed token, address indexed user, uint256 amount);
    event RewardIndexUpdated(uint256 newIndex);
    event InternalAddressUpdated(address indexed user, bool isInternal);
    event FeeUpdated(bool indexed isInternal, uint24 oldFee, uint24 newFee);

    // Errors
    error NotDynamicFee();
    error InsufficientBalance();
    error ZeroAmount();
    error InvalidPoolFee();
    error PoolMustIncludeSuperDCAToken();

    // UpgradeTimeLock
    /// @custom:storage-location erc7201:openzeppelin.storage.UpgradeTimeController
    struct UpgradeTimeControllerStorage {
        bytes32 upgradeId;
    }

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.UpgradeTimeController")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant UpgradeTimeControllerStorageLocation =
        0x84f7109bd2cfa04c6033251f2021a16fa025054b4977e7cd36146ce6aa7e2100;

    function _getUpgradeTimeControllerStorage()
        private
        pure
        returns (UpgradeTimeControllerStorage storage $)
    {
        assembly {
            $.slot := UpgradeTimeControllerStorageLocation
        }
    }

    function upgradeId() public view virtual returns (bytes32) {
        UpgradeTimeControllerStorage
            storage $ = _getUpgradeTimeControllerStorage();
        return $.upgradeId;
    }

    // TODO: This function needs to be guarded or private
    function _setUpgradeId(bytes32 newUpgradeId) private {
        UpgradeTimeControllerStorage
            storage $ = _getUpgradeTimeControllerStorage();
        $.upgradeId = newUpgradeId;
    }

    // State
    /// @custom:storage-location erc7201:openzeppelin.storage.SuperDCAState
    struct SuperDCAStateStorage {
        address superDCAToken;
        address developerAddress;
        uint24 internalFee;
        uint24 externalFee;
        uint256 mintRate;
        uint256 lastMinted;
        mapping(address => bool) isInternalAddress;
    }
    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.SuperDCAState")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant SuperDCAStateStorageLocation =
        0xd347c705d3a032d396379973920a5763515402f60323df74d70a36056ae75a00;

    function _getSuperDCAStateStorage()
        private
        pure
        returns (SuperDCAStateStorage storage $)
    {
        assembly {
            $.slot := SuperDCAStateStorageLocation
        }
    }

    // Reward tracking
    /// @custom:storage-location erc7201:openzeppelin.storage.RewardTracking
    struct RewardTrackingStorage {
        uint256 totalStakedAmount;
        uint256 rewardIndex;
        mapping(address token => TokenRewardInfo info) tokenRewardInfos;
        mapping(address user => EnumerableSet.AddressSet stakedTokens) userStakedTokens;
        mapping(address user => mapping(address token => uint256 amount)) userStakes;
    }

    // keccak256(abi.encode(uint256(keccak256("openzeppelin.storage.RewardTracking")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant RewardTrackingStorageLocation =
        0xe3b9b8135e189d47c2b4296790cd3f2a9eceea88c74dae0114c5948cc0bb5e00;

    function _getRewardTrackingStorage()
        private
        pure
        returns (RewardTrackingStorage storage $)
    {
        assembly {
            $.slot := RewardTrackingStorageLocation
        }
    }

    function initialize(
        IPoolManager _poolManager,
        address _superDCAToken,
        address _developerAddress,
        uint256 _mintRate
    ) public virtual initializer {
        __BaseHook_init(_poolManager);
        __TimelockController_init(
            //72 hours *60 minutes *60 seconds = 259_200
            uint256(259_200),
            new address[](0),
            new address[](0),
            _msgSender()
        );
        __SuperDCA_init(_superDCAToken, _developerAddress, _mintRate);
        __UUPSUpgradeable_init();
    }

    function __SuperDCA_init(
        address _superDCAToken,
        address _developerAddress,
        uint256 _mintRate
    ) internal onlyInitializing {
        __SuperDCA_init_unchained(_superDCAToken, _developerAddress, _mintRate);
    }

    function __SuperDCA_init_unchained(
        address _superDCAToken,
        address _developerAddress,
        uint256 _mintRate
    ) internal onlyInitializing {
        SuperDCAStateStorage storage $ = _getSuperDCAStateStorage();
        _grantRole(MANAGER_ROLE, _developerAddress);
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        $.superDCAToken = _superDCAToken;
        $.developerAddress = _developerAddress;
        $.internalFee = INTERNAL_POOL_FEE;
        $.externalFee = EXTERNAL_POOL_FEE;
        $.mintRate = _mintRate;
        $.lastMinted = block.timestamp;
    }

    function scheduleUpgrade(
        uint256 delay
    ) external onlyRole(MANAGER_ROLE) returns (bytes32 _upgradeId) {
        return _scheduleUpgrade(delay);
    }

    function _scheduleUpgrade(
        uint256 delay
    ) internal returns (bytes32 _upgradeId) {}

    /**
     * @notice Returns the hook permissions.
     * Only beforeAddLiquidity and beforeRemoveLiquidity are enabled.
     */
    function getHookPermissions()
        public
        pure
        override
        returns (Hooks.Permissions memory)
    {
        return
            Hooks.Permissions({
                beforeInitialize: true,
                afterInitialize: true,
                beforeAddLiquidity: true,
                afterAddLiquidity: false,
                beforeRemoveLiquidity: true,
                afterRemoveLiquidity: false,
                beforeSwap: true,
                afterSwap: false,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            });
    }
}
