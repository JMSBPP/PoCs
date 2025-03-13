// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
}
*/

contract Level3Template {
    constructor() payable {}
    function solution(
        bytes memory packed
    ) external pure returns (uint16 a, bool b, bytes6 c) {
        // TODO: Write your solution here
        assembly ("memory-safe") {
            // skips the lenght of the packed bytes (preffix)
            let data := mload(add(0x80, 0x20))
            let data2 := shr(184, data)
            a := shr(240, data)
            //              _b := 0x01
            b := shr(48, shl(200, data2))
            c := shl(208, data2)
        }
    }
}
