//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Storage {
    uint8 private valueToBeUpdated;

    function modifyValue(address logic, uint256 valueToUpdate) public {
        (bool ok, bytes memory res) = logic.delegatecall(
            abi.encodeWithSignature(
                "modifyStorageValue(uint256)",
                valueToUpdate
            )
        );

        if (ok) {
            valueToBeUpdated = abi.decode(res, (uint8));
        }

        // We should expect:
        // Storage.valueToBeUpdated = valueToUpdate + 1
    }

    function getValueToBeUpdated() public view returns (uint8 _value) {
        _value = valueToBeUpdated;
    }
}
contract Logic {
    uint256 private readValue;
    function setReadValue(uint256 value) public {
        readValue = value;
    }

    function modifyStorageValue(uint256 value) public {
        setReadValue(value);
        //Now logic.readValue = value
        readValue++;
        //Now logic.readValue = value + 1
    }
    function getReadValue() external view returns (uint256 _value) {
        _value = readValue;
    }
}
