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

Notes:

    "0x0": "0x2ff2cc2500000000000000000000000000000000000000000000000000000000",
    // selector --> bytes4
    "0x20": "0x0000000100000000000000000000000000000000000000000000000000000000",
    "0x40": "0x0000000200000000000000000000000000000000000000000000000000000000",
    "0x60": "0x0000000300000000000000000000000000000000000000000000000000000000",
    "0x80": "0x0000000400000000000000000000000000000000000000000000000000000000",
    "0xa0": "0x0000000500000000000000000000000000000000000000000000000000000000",
    "0xc0": "0x0000000600000000000000000000000000000000000000000000000000000000",
    "0xe0": "0x0000000700000000000000000000000000000000000000000000000000000000",
    "0x100": "0x0000000800000000000000000000000000000000000000000000000000000000",
    "0x120": "0x0000000800000000000000000000000000000000000000000000000000000000",
    "0x140": "0x0000000a00000000000000000000000000000000000000000000000000000000",
    "0x160": "0x0000000b00000000000000000000000000000000000000000000000000000000",
    "0x180": "0x0000000c00000000000000000000000000000000000000000000000000000000"
