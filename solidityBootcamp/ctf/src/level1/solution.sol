// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////
import {SafeMath} from "@math/SafeMath.sol";
import {Arrays} from "@arrays/Arrays.sol";
/*
  interface Isolution {
    function solution(uint256[2][3] calldata firstArray, uint256[2][3] calldata secondArray) external pure returns (uint256[2][3] memory finalArray);
  }
*/

contract Level1Template {
    using SafeMath for uint256;

    function solution(
        uint256[2][3] calldata x,
        uint256[2][3] calldata y
    ) external pure returns (uint256[2][3] memory finalArray) {
        // TODO: Implement your solution here
        for (uint256 row = 0; row < 3; row++) {
            for (uint256 col = 0; col < 2; col++) {
                (, finalArray[row][col]) = x[row][col].tryAdd(y[row][col]);
            }
        }
    }
}
