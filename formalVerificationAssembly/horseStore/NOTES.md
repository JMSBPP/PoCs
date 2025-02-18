## EVM Data Structures
- Make bitwise excersices in leetcode using the Dafny EVM specification and Yul, Huff
- Make stack excersices in leetcode using the Dafny EVM specification and Yul, Huff
- Investigate the program counter
- What data structure does the storage has- A Merkle Patricia Trie is used in Ethereum for contract interaction, but for contract storage, it behaves like a hash map. It works as a direct table when the data stored is a signed or unsigned integer up to 256 bits per slot. Booleans and enums map to 0 and 1, and integer structs and arrays with fixed lengths all fall under this direct table type of data structure.

However, for other types of structures, the data structure becomes a hash table, where the keys are calculated using the Keccak-256 hash function.
- what excercises to train this
### Memory
- What data structure does the memory has? - linear byte array
This means that data in memory is indexed by byte offsets instead of integer indexes. The maximum array size (or memory byte size is 256 bits)
- what excercises to train this ?
- What data structure does transient storage has?
- what excercises to train this
## Differential Testing
### Objective: 
Proof low-level code matches the high-level code

## Opcode Breakdown: Solidity vs Low-Level
-0x80 in 0x40 memory offset when deploying contract is the
free memory pointer (This is not necessary becuase the memory can be used as one pleases)
- Adding
```solidity
constructor payable {}
```
saves the gas accountat for the payable check opcodes, but it is secure, protects user againgst funds missent

## Dis-Assembly Op-codes:




