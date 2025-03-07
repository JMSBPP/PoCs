// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
    interface Isolution {
        function solution() external pure returns (uint8);
    }
*/

contract Level0Template {
    constructor() payable {}

    function solution() external pure returns (uint8) {
        return 42;
        // assembly {
        //     mstore(0x00, 0x2a)
        //     return(0x00, 0x20)
        // }
    }
}
