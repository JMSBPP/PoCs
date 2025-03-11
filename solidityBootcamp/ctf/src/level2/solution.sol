// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/////////////////// ☆☆ extropyio ☆☆ /////////////////////
//     -漫~*'¨¯¨'*·舞~ solidity ctf ~舞·*'¨¯¨'*~漫-     //
/////////////////////////////////////////////////////////

/* 
  interface Isolution2 {
    function solution(uint256[10] calldata unsortedArray) external returns (uint256[10] memory sortedArray);
  }
*/

contract Level2Template {
    function solution(
        uint256[10] calldata unsortedArray
    ) external returns (uint256[10] memory sortedArray) {
        //lets fi5rt store the whole array in memory
        //then we can allocate half hasl in stack and half in memory in order to emasure
        //performance
        assembly ("memory-safe") {
            let fptr := mload(0x40)
            //skips the selector
            //the data to be copied is 32 bytes each word times 10 - 4 bytes of the selector
            //this is 320bytes=--> 0x0140
            calldatacopy(fptr, 0x04, 0x0140)
            //updating the free memory pointer
            mstore(0x40, add(fptr, 0x0140))
            // now we need to ort the array
            //to compare two elements we can use the space in memory
            //0x00 and 0x20,
            //then I have
            //[0x00:x_i , 0x20: x_j ] as scratch space to do comparison
            //operations x_j <>= x_j and [0x80: x_1, ...0x80+(0x20*10): x_10] holds the
            //unsorted array
            // =======ALGORITHMS==========
            // ======= BUBBLE SORT =========
            let length := 10
            let swapFlag := 1

            for {
                let pass := 0
            } lt(pass, sub(length, 1)) {
                pass := add(pass, 1)
            } {
                swapFlag := 0
                for {
                    let i := 0
                } lt(i, sub(sub(length, 1), pass)) {
                    i := add(i, 1)
                } {
                    let x_i := add(fptr, mul(i, 0x20))
                    let x_j := add(x_i, 0x20)
                    let val_i := mload(x_i)
                    let val_j := mload(x_j)

                    if gt(val_i, val_j) {
                        mstore(x_i, val_j)
                        mstore(x_j, val_i)
                        swapFlag := 1
                    }
                }
                //if no swaps are reuired we exit because the array us already sorted
                if iszero(swapFlag) {
                    break
                }
            }

            sortedArray := fptr // Assign sorted data to return variable
        }
    }
}
