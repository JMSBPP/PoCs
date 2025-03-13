// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/*
interface Isolution5 {
    function solution(int256 a, int256 b) external pure returns (int256);
}
*/

contract Level5Template {
    // Give an overflow-free method for computing the average, rounding up, of 2 signed integers, (a + b) / 2
    // Your function will take 2 values (a,b) and return the average of these values
    // Keep in mind that you will be rounding the average up (ceil) NOT rounding down (floor)
    // Floor -> rounding towards zero
    // Ceil -> rounding away from zero
    constructor() payable {}

    function solution(int256 a, int256 b) external pure returns (int256) {
        int256 res;
        assembly {
            // Compute average without overflow: avg = (a & b) + ((a ^ b) >> 1)
            let a_xor_b := xor(a, b)
            let a_and_b := and(a, b)
            let avg := add(a_and_b, sar(1, a_xor_b))

            // Check if sum is odd (a_xor_b's LSB is 1)
            if and(a_xor_b, 1) {
                // Determine if sum is positive or negative
                let sum_sign
                switch slt(avg, 0)
                case 0 {
                    // avg >= 0 → sum is positive
                    sum_sign := 1
                }
                default {
                    // avg < 0 → sum is negative
                    sum_sign := 0
                }

                // Adjust based on sum's sign
                switch sum_sign
                case 1 {
                    // Positive sum → add 1 to round up
                    avg := add(avg, 1)
                }
                case 0 {
                    // Negative sum → subtract 1 to round down (away from zero)
                    avg := sub(avg, 1)
                }
            }
            res := avg
        }
        return res;
    }
}
