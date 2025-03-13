## Level 0 - Return 42 (tutorial)

This level is really simple. Use the interface below to write a smart contract. Your contract should contain a function called solution that returns a uint8. In this case the function body logic is very simply as the answer is always 42.

Interface:
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

interface Isolution {
    function solution() external pure returns (uint8);
}
```
Solution:
To solve we need write the function to return the correct answer. In this case we would just need to write return 42

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract Level_0 {

  function solution() external pure returns (uint8){
      return 42;
    }
}
```

## Level 1 - Matrix Addition


Write a function that adds two matrices returns the result. To keep things simple the array sizes will be fixed sizes of 2x3 (uint256[2][3]). Take a look at Wikipedia if you need help understanding matrix addition. Your solution should implement the following interface:


```solidity
interface Isolution1 {
    function solution(
        uint256[2][3] calldata x, 
        uint256[2][3] calldata y
    ) external pure returns (
        uint256[2][3] memory
    );
}
```

## Level 2 - Sorting an Array

Write a function that sorts an array in ascending order and returns the result. The array will be a fixed of 10 but the contents random. Your solution should implement the following interface:
```solidity

interface Isolution2 {
  function solution(uint256[10] calldata unsortedArray) external returns (uint256[10] memory sortedArray);
}

```
# Level 3 - abi.encodePacked
Using the Isolution3 interface write a function that unpacks our data that was packed using abi.encodePacked(a, b, c). Where a is type uint16, b is type bool and c is type bytes6.

```solidity
interface Isolution3 {
    function solution(bytes memory packed) external returns (uint16 a, bool b, bytes6 c);
	}
```

