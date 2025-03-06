//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Math} from "@math/Math.sol";
import {leftChamber} from "@chambers/leftChamber.sol";
import {rightChamber} from "@chambers/rightChamber.sol";
import {IChamber} from "@chambers/interfaces/IChamber.sol";
import {container} from "@shapes/container.sol";
contract Chambers is container {
    // bytes32 internal constant LEFTCHAMBERBYTECODE =
    //     bytes32(abi.encodePacked(type(leftChamber).creationCode));
    // bytes32 internal constant RIGHTCHAMBERBYTECODE =
    //     bytes32(abi.encodePacked(type(rightChamber).creationCode));

    // uint256 private constant SALT = 1;
    address internal _leftChamber;
    address internal _rightChamber;
    leftChamber private left;
    rightChamber private right;

    using Math for uint256;

    error NotReadyForDeployment();
    error NotReadyForCreatingChambers();
    function deployLeftChamber() internal {
        left = new leftChamber();
        _leftChamber = address(left);
    }
    function deployRightChamber() internal {
        right = new rightChamber();
        _rightChamber = address(right);
    }

    function deployChambers() internal {
        if (initializationState != InitializationState.readyForDeployment) {
            revert NotReadyForDeployment();
        }

        deployLeftChamber();
        deployRightChamber();

        initializationState = InitializationState.deployed;
    }

    function createChambers(uint256 width, uint256 height) internal {
        if (initializationState != InitializationState.deployed) {
            revert NotReadyForCreatingChambers();
        }
        (bool leftRes, ) = address(left).call(
            bytes(
                abi.encodeWithSignature(
                    "create(uint256,uint256)",
                    width.ceilDiv(uint256(2)),
                    height
                )
            )
        );
        assembly {
            if iszero(leftRes) {
                revert(0, 0)
            }
        }
        (bool rightRes, ) = address(right).call(
            bytes(
                abi.encodeWithSignature(
                    "create(uint256,uint256)",
                    width.ceilDiv(uint256(2)),
                    height
                )
            )
        );
        assembly {
            if iszero(rightRes) {
                revert(0, 0)
            }
        }
    }

    function getLeftChamberAddress() external view returns (address) {
        return _leftChamber;
    }

    function getRightChamberAddress() external view returns (address) {
        return _rightChamber;
    }

    // /// @notice Sets the address of the leftChamber contract by calculating the hash
    // /// @dev The address is calculated by using the create2 opcode
    // function setLeftChamber() private {
    //     bytes32 hash = keccak256(
    //         abi.encodePacked(
    //             bytes1(0xff),
    //             address(this),
    //             SALT,
    //             keccak256(abi.encodePacked(LEFTCHAMBERBYTECODE))
    //         )
    //     );

    //     _leftChamber = address(uint160(uint(hash)));
    // }

    // /// @notice Sets the address of the rightChamber contract by calculating the hash
    // /// @dev The address is calculated by using the create2 opcode
    // function setRightChamber() private {
    //     bytes32 hash = keccak256(
    //         abi.encodePacked(
    //             bytes1(0xff),
    //             address(this),
    //             SALT,
    //             keccak256(abi.encodePacked(RIGHTCHAMBERBYTECODE))
    //         )
    //     );

    //     _rightChamber = address(uint160(uint(hash)));
    // }
    // /// @notice Returns the address of the leftChamber contract that will be deployed
    // /// @dev The address is calculated by using the create2 opcode
    // /// @return __leftChamber The address of the leftChamber contract
    // function getLeftChamber() public view returns (address __leftChamber) {
    //     __leftChamber = _leftChamber;
    // }
    // /// @notice Returns the address of the rightChamber contract that will be deployed
    // /// @dev The address is calculated by using the create2 opcode
    // /// @return __rightChamber The address of the rightChamber contract
    // function getRightChamber() public view returns (address __rightChamber) {
    //     __rightChamber = _rightChamber;
    // }
    // /// @notice Deploys the leftChamber contract using the create2 opcode
    // /// @dev Uses assembly to perform the deployment to a deterministic address
    // /// @return addr The address of the deployed leftChamber contract
    // function deployLeftChamber() internal returns (address addr) {
    //     bytes memory bytecode = abi.encodePacked(LEFTCHAMBERBYTECODE);

    //     assembly {
    //         addr := create2(
    //             callvalue(),
    //             add(bytecode, 0x20),
    //             mload(bytecode),
    //             SALT
    //         )

    //         if iszero(extcodesize(addr)) {
    //             revert(0, 0)
    //         }
    //     }

    //     assert(addr == _leftChamber);
    // }

    // /// @notice Deploys the rightChamber contract using the create2 opcode
    // /// @dev Uses assembly to perform the deployment to a deterministic address
    // /// @return addr The address of the deployed rightChamber contract
    // function deployRightChamber() internal returns (address addr) {
    //     bytes memory bytecode = abi.encodePacked(RIGHTCHAMBERBYTECODE);

    //     assembly {
    //         addr := create2(
    //             callvalue(),
    //             add(bytecode, 0x20),
    //             mload(bytecode),
    //             SALT
    //         )

    //         if iszero(extcodesize(addr)) {
    //             revert(0, 0)
    //         }
    //     }

    //     assert(addr == _rightChamber);
    // }
}
