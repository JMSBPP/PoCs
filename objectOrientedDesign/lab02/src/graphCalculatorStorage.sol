// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {graphTypes} from "./graphTypes.sol";
contract GraphCalculatorStorage is graphTypes {
    // NOTE: This mapping uses a string as a key, but this string is not the actual key
    // used in the mapping. Instead, the key is the keccak256 hash of the string.
    // This is done to ensure that the mapping is not vulnerable to reentrancy attacks.
    // See https://consensys.github.io/smart-contract-best-practices/reentrancy/
    mapping(bytes32 => Graph) private variables;
    bytes32[] private availableKeys;
}
