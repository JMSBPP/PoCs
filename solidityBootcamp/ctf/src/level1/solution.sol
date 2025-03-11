// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////
// import {SafeMath} from "@math/SafeMath.sol";
// import {Arrays} from "@arrays/Arrays.sol";
// import {HuffDeployer} from "@huff/HuffDeployer.sol";
// interface Isolution {
//     function solution(
//         uint256[2][3] calldata firstArray,
//         uint256[2][3] calldata secondArray
//     ) external pure returns (uint256[2][3] memory finalArray);
// }

contract Level1Template {
    // using SafeMath for uint256;

    constructor() payable {}
    function solution(
        uint256[2][3] calldata x,
        uint256[2][3] calldata y
    ) external pure returns (uint256[2][3] memory finalArray) {
        // TODO: Implement your solution here
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0x04, 0x0180)
            let ptrMatrix1 := ptr
            let ptrMatrix2 := add(ptr, 0xc0)
            //update pointer
            let resultPtr := add(ptr, 0x0180)
            mstore(0x40, add(resultPtr, 0xc0)) // Reserve space for result

            // Process each element (6 elements total: 3 rows × 2 columns)
            for {
                let i := 0
            } lt(i, 0xc0) {
                // 6 elements * 32 bytes = 0xc0
                i := add(i, 0x20)
            } {
                let valueMatrix1 := mload(add(ptrMatrix1, i))
                let valueMatrix2 := mload(add(ptrMatrix2, i))
                mstore(add(resultPtr, i), add(valueMatrix1, valueMatrix2))
            }

            // Return the result
            return(resultPtr, 0xc0)
        }
        // for (uint256 row = 0; row < 3; row++) {
        //     for (uint256 col = 0; col < 2; col++) {
        //         (, finalArray[row][col]) = x[row][col].tryAdd(y[row][col]);
        //     }
        // }
    }

    // function solutionHuff(
    //     uint256[2][3] calldata x,
    //     uint256[2][3] calldata y
    // ) public returns (uint256[2][3] memory finalArray) {
    //     address _level1Huff = HuffDeployer.deploy("src/level1/solution");
    //     Isolution level1Huff = Isolution(_level1Huff);
    //     finalArray = level1Huff.solution(x, y);
    // }
}
