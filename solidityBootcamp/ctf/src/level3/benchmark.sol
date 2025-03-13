// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Benchmark {
    constructor() payable {}

    //     ┌───────────────────── 9 bytes ─────────────────────┐┌──── 23 bytes of zeros ────┐
    // │ uint16 (2 bytes) | bool (1 byte) | bytes6 (6 bytes) │ 0x00 ... 0x00 (23 bytes)  │
    // └──────────────────────────────────────────────────────────┴───────────────────────────┘
    //uint16 a, bool b, bytes6 c
    function solution(
        bytes memory packed
    ) external pure returns (uint16 a, bool b, bytes6 c) {
        bytes32 _data2;
        assembly {
            mstore(0x80, packed)
            let data := mload(add(0x80, 0x40))
            _data2 := shr(184, data)
        }

        bytes memory data2 = abi.encode(_data2);

        (a, b, c) = abi.decode(data2, (uint16, bool, bytes6));
    }
}
