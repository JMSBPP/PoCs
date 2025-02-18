# Homework 5


## 1. Look at the example of init code in today's notes (gist)[\href{https://gist.github.com/extropyCoder/4243c0f90e6a6e97006a31f5b9265b94}]

   - When we do the CODECOPY operation, what are we overwriting ?
  

### **Answer:** 

As seen in the image (image1) the CODECOPY operation overwrites whatever is in the 0x00 index in memory with the contract bytecode from the 39th byte(image2), meaning ignores the first 38 bytes of the bytecode(which correspond to the initialization code).

It copies 182 bytes into memory from the index 0x00, this means that also overwrites the memory pointer written above at slot 0x40 (image3) and whatever is from slot 0x00 to slot 0x80. which corresponds to 5 chunks of 32 bytes.

$182 \mod 32 = 22$ bytes are written in slot 0xa0 padding to the left the unused 10 bytes with zeros.


## 2. Could the answer to Q1 allow an optimisation ?

### **Answer:**

Yes, given the fact that the bytes stored overwrites the free memory pointer at slot 0x40 set before the CODECOPY opcode, the optimization is not storing the free memory pointer, so optimization would be not including the additionof the freememory pointer.

1. 
**Remove:**
```solidity
PUSH1 0x80
PUSH1 0x40
MSTORE
```

Other optimization could be that the contract does not have payable functions, therefore doing checks over CALLVALUE is unnecessary.

2.

**Remove:**

```solidity
CALLVALUE
DUP1
ISZERO
```

Other optimization can be done prior to storing 0x11 in slot 0x00. Here is the comparison:
3. 
**Before:**
```solidity
[10] JUMPDEST
POP
PUSH1 0x11
PUSH1 0x00
DUP2
SWAP1
SSTORE
POP
```

**After:**
```solidity
PUSH1 0x17
PUSH1 0x00
SSTORE
```

Finally the DUP1 code can be removed for the purpose of storing the RUNTIME part of the BYTECODE.

Then: 

4.

**Before:**
```solidity
PUSH1 0xb6
DUP1
PUSH2 0x0027
PUSH1 0x00
CODECOPY
```

**After**


```solidity
PUSH1 0xb6
PUSH2 0x0027
PUSH1 0x00
CODECOPY
```



