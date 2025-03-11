// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

library Sorting {
    function sort_array(bytes memory arr) external pure returns (bytes memory) {
        uint256 l = arr.length;
        for (uint i = 0; i < l; i++) {
            for (uint j = i + 1; j < l; j++) {
                if (arr[i] > arr[j]) {
                    bytes1 temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                }
            }
        }
        return arr;
    }
}

contract level2BenchMark {
    using Sorting for bytes;
    function solutionInefficient(
        uint256[10] calldata unsortedArray
    ) external returns (uint256[10] memory sortedArray) {
        bytes memory arr = abi.encodePacked(unsortedArray);
        bytes memory encodedSortedArray = arr.sort_array();
        sortedArray = abi.decode(encodedSortedArray, (uint256[10]));
    }
}
