// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

//decode
// abi.encodePacked(a, b, c).

// a -> uint16, b  -> bool and c -> bytes6

contract benchmark {
    function solution(
        bytes memory packed
    ) external pure returns (uint16 a, bool b, bytes6 c) {
        //The first thing is check the length of the bytes
        //types shorter than
        //32 bytes are concatenated directly, without padding
        //or sign extension
        //16= 2 bytes +1 bytes + 6 bytes = 9 bytes < 32 bytes
        //0x2bytes1bytes6bytes0000000...00000000
        //                           23 bytes
    }
}
