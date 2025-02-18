// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

contract practice {
    //How does the EVM encode and decode an array of bytes?
    //Consider the following example:
    //ordered inputs: (address,uint256,uint256)
    //encoding: [20bytes, 32bytes, 32bytes]
    //total length: 84 bytes
    function receiveData(
        address k1,
        uint256 k2,
        uint256 value
    ) public pure returns (bytes memory) {
        return abi.encode(k1, k2, value);
    }

    //1. Retreive the 32 byte of k2
    //1.1 0x0000address00000k2000000k1
    //1.2 we need to take off the last 32 bytes
    //1.2 take off the first 32 bytes
    function retreiveK2(bytes calldata data) public pure returns (bytes32) {
        return bytes32(data[32:64]);
    }

    function retreiveK1(bytes calldata data) public pure returns (bytes32) {
        return bytes32(data[4:32]);
    }

    function retreiveValue(bytes calldata data) public pure returns (bytes32) {
        return bytes32(data[64:96]);
    }

    function dataPlusSelector(
        address k1,
        uint256 k2,
        uint256 value
    ) public pure returns (bytes memory data) {
        data = abi.encodeWithSelector(
            bytes4(keccak256("_ownedTokens(address,uint256,uint256)")),
            k1,
            k2,
            value
        );
    }
    function getK2Slot(bytes calldata data) public pure returns (uint256 slot) {
        bytes32 k1 = retreiveK1(data);
        bytes32 _slot = bytes32(uint256(0));
        bytes memory _concat = abi.encodePacked(k1, _slot);
        slot = uint256(keccak256(_concat));
    }

    function getValueSlot(
        bytes calldata data
    ) public pure returns (uint256 slot) {
        bytes32 k2 = retreiveK2(data);
        bytes32 k2Slot = bytes32(getK2Slot(data));
        bytes memory _concat = abi.encodePacked(k2, k2Slot);
        slot = uint256(keccak256(_concat));
    }
}
