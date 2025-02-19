// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {bytes32Ext} from "./bytes32Ext.sol";

library bytes32ArrayExt {
    // -------------------------------------

    //------------bytes32[] EXT-------------------

    //--------------------------------------
    using bytes32Ext for bytes32;
    /**
     * @dev searches through a bytes32 array and returns if a given _string
     * is in the array
     * @param _encodedString string to be searched
     * @param _array array where the _encodedString will be searched
     */
    function searchBytes32(
        bytes32[] memory _array,
        bytes32 _encodedString
    ) public pure returns (bool isInArray) {
        isInArray = false;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_encodedString == _array[i]) {
                isInArray = true;
                break;
            }
        }
    }

    /**
     * @dev removes duplicates from a bytes32 array
     * @param inputArray array from which duplicates will be removed
     * @return a new array with the same elements as the inputArray, but with no duplicates
     */
    function removeDuplicatesBytes32Array(
        bytes32[] memory inputArray
    ) external pure returns (bytes32[] memory) {
        uint length = inputArray.length;
        if (length <= 1) {
            return inputArray;
        }

        bytes32[] memory tempArray = new bytes32[](length);
        uint uniqueCount = 0;

        for (uint i = 0; i < length; i++) {
            bool isDuplicate = false;
            for (uint j = 0; j < uniqueCount; j++) {
                if (inputArray[i] == tempArray[j]) {
                    isDuplicate = true;
                    break;
                }
            }
            if (!isDuplicate) {
                tempArray[uniqueCount] = inputArray[i];
                uniqueCount++;
            }
        }
        bytes32[] memory uniqueArray = new bytes32[](uniqueCount);
        for (uint i = 0; i < uniqueCount; i++) {
            uniqueArray[i] = tempArray[i];
        }

        return uniqueArray;
    }

    /**
     * @dev filters a bytes32 array so that it only contains elements that are composed
     *      of only the characters A-Z (0x41 to 0x5A)
     * @param inputArray the array to be filtered
     * @return a new array with the same elements as the inputArray, but with only
     *         the elements that are composed of only A-Z characters
     */
    // function filterOnlyAToZencoded(
    //     bytes32[] memory inputArray
    // ) external pure returns (bytes32[] memory) {
    //     bytes32[] memory tempArray = new bytes32[](inputArray.length);
    //     uint count = 0;

    //     for (uint i = 0; i < inputArray.length; i++) {
    //         bytes32 element = inputArray[i];
    //         bool isValid = true;

    //         for (uint j = 0; j < 32; j++) {
    //             bytes1 char = bytes1(element[j]);
    //             if (char != 0 && (char < 0x41 || char > 0x5A)) {
    //                 isValid = false;
    //                 break;
    //             }
    //         }

    //         if (isValid) {
    //             tempArray[count] = element;
    //             count++;
    //         }
    //     }
    //     bytes32[] memory encodedAToZOnlyArray = new bytes32[](count);
    //     for (uint k = 0; k < count; k++) {
    //         encodedAToZOnlyArray[k] = tempArray[k];
    //     }

    //     return encodedAToZOnlyArray;
    // }

    /**
     * @dev Compares two bytes32 arrays for equality.
     * @param a the first array
     * @param b the second array
     * @return true if both arrays have the same length and all elements are equal
     */
    function EqualBytes32Array(
        bytes32[] memory a,
        bytes32[] memory b
    ) external pure returns (bool) {
        if (a.length != b.length) {
            return false;
        }
        for (uint256 i = 0; i < a.length; i++) {
            if (a[i] != b[i]) {
                return false;
            }
        }
        return true;
    }

    /**
     * @dev Uppercases the first 32 bytes of each string in a bytes32 array.
     * @param encodedStringArray The array of strings to be uppercased.
     * @return encodedCappedStringArray The array of uppercased strings.
     */
    function upperCapEncodedStringArray(
        bytes32[] memory encodedStringArray
    ) external pure returns (bytes32[] memory encodedCappedStringArray) {
        encodedCappedStringArray = new bytes32[](encodedStringArray.length);
        for (uint256 i = 0; i < encodedStringArray.length; i++) {
            bytes32 _encodedString = encodedStringArray[i];
            encodedCappedStringArray[i] = _encodedString
                .upperCapEncodedString();
        }
    }

    /**
     * @dev Checks if the first array is a subset of the second array.
     * @param subset The subset to check.
     * @param referencePowerSet The power set to check against.
     * @return isSubset true if the subset is a subset of the power set, false otherwise.
     */
    function isSubsetOf(
        bytes32[] memory subset,
        bytes32[] memory referencePowerSet
    ) external pure returns (bool isSubset) {
        isSubset = false;
        for (uint256 index = 0; index < subset.length; index++) {
            bytes32 vertex = subset[index];
            if (searchBytes32(referencePowerSet, vertex)) {
                isSubset = true;
                break;
            }
        }
    }
}
