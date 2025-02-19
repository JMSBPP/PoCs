// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {bytes32ArrayExt} from "./bytes32ArrayExt.sol";
import {bytes32Ext} from "./bytes32Ext.sol";
library bytes32MatrixExt {
    using bytes32ArrayExt for bytes32[];
    using bytes32Ext for bytes32;
    // -------------------------------------

    //------------bytes32[][] EXT-------------------

    //--------------------------------------

    /**
     * @dev Removes the row at a given index from the given bytes32 matrix
     * @param inputMatrix bytes32 matrix to be processed
     * @param index Index of the row to be removed
     * @return newMatrix bytes32 matrix with the specified row removed
     */
    function removeFromBytes32Matrix(
        bytes32[][] memory inputMatrix,
        uint256 index
    ) public pure returns (bytes32[][] memory) {
        require(index < inputMatrix.length, "Index out of bounds");
        bytes32[][] memory newMatrix = new bytes32[][](inputMatrix.length - 1);
        for (uint256 i = 0; i < inputMatrix.length; i++) {
            if (i < index) {
                newMatrix[i] = inputMatrix[i];
            } else if (i > index) {
                newMatrix[i - 1] = inputMatrix[i];
            }
        }

        return newMatrix;
    }
    /**
     * @dev Removes duplicate rows from the given bytes32 matrix
     * @param inputMatrix bytes32 matrix to be processed
     * @return newMatrix bytes32 matrix with duplicate rows removed
     */
    function removeDuplicatesBytes32Matrix(
        bytes32[][] memory inputMatrix
    ) public pure returns (bytes32[][] memory) {
        uint256 length = inputMatrix.length;
        if (length < 2) {
            // If there are 0 or 1 rows, nothing to remove
            return inputMatrix;
        }

        // Temporary storage for unique rows
        bytes32[][] memory tempMatrix = new bytes32[][](length);
        uint256 uniqueCount = 0;

        for (uint256 i = 0; i < length; i++) {
            bool isDuplicate = false;
            // Compare the current row against rows already added to tempMatrix
            for (uint256 j = 0; j < uniqueCount; j++) {
                bytes32[] memory currentRow = inputMatrix[i];
                if (currentRow.EqualBytes32Array(tempMatrix[j])) {
                    isDuplicate = true;
                    break;
                }
            }
            // If not a duplicate, add to the tempMatrix
            if (!isDuplicate) {
                tempMatrix[uniqueCount] = inputMatrix[i];
                uniqueCount++;
            }
        }

        // Create a new matrix of the correct size for unique rows
        bytes32[][] memory uniqueMatrix = new bytes32[][](uniqueCount);
        for (uint256 k = 0; k < uniqueCount; k++) {
            uniqueMatrix[k] = tempMatrix[k];
        }

        return uniqueMatrix;
    }

    /**
     * @dev Uppercases the first 32 bytes of each string in a matrix of strings.
     * @param encodedStringMatrix The matrix of strings to be uppercased.
     * @return encodedStringCappedMatrix The matrix of uppercased strings.
     */
    function upperCapStringMatrix(
        bytes32[][] memory encodedStringMatrix
    ) external pure returns (bytes32[][] memory encodedStringCappedMatrix) {
        encodedStringCappedMatrix = new bytes32[][](encodedStringMatrix.length);
        for (uint256 row = 0; row < encodedStringMatrix.length; row++) {
            encodedStringCappedMatrix[row] = new bytes32[](
                encodedStringMatrix[row].length
            );
            for (
                uint256 column = 0;
                column < encodedStringMatrix[row].length;
                column++
            ) {
                bytes32 encodedString = encodedStringMatrix[row][column];
                encodedStringCappedMatrix[row][column] = encodedString
                    .upperCapEncodedString();
            }
        }
    }

    function onlySubsetsOf(
        bytes32[][] memory collectionOfSubsets,
        bytes32[] memory referencePowerSet
    ) external returns (bytes32[][] memory subsets) {
        uint256 totalSubsets = 0;
        for (
            uint256 subset = 0;
            subset < collectionOfSubsets.length;
            subset++
        ) {
            if (collectionOfSubsets[subset].isSubsetOf(referencePowerSet)) {
                totalSubsets++;
            }
        }
        subsets = new bytes32[][](totalSubsets);
        uint256 subsetCount = 0;
        for (
            uint256 subset = 0;
            subset < collectionOfSubsets.length;
            subset++
        ) {
            if (collectionOfSubsets[subset].isSubsetOf(referencePowerSet)) {
                subsets[subsetCount] = collectionOfSubsets[subset];
                subsetCount++;
            }
        }
    }
}
