# EVM Driven Algorithms and Data Structures Exercises
<div style="text-align: center;">
  <img src="images/evm.png" alt="Description" width="300"/>
</div>

## About

This repository is dedicated to exploring and solving LeetCode exercises focused on algorithms and data structures, with a unique emphasis on Ethereum Virtual Machine (EVM) concepts. The exercises are designed to deepen understanding of how EVM operates and how it can be leveraged in algorithmic problem-solving.

### Key Areas of Focus

- **Bitwise Exercises**: Solve LeetCode bitwise problems using the Dafny EVM specification and languages like Yul and Huff. These exercises aim to enhance understanding of low-level operations and EVM's bitwise capabilities.

- **Stack Exercises**: Tackle stack-related problems on LeetCode by applying the Dafny EVM specification and implementing solutions in Yul and Huff. This approach helps in grasping the stack-based nature of EVM and its implications in smart contract development.

- **Program Counter Investigation**: Delve into the workings of the program counter within the EVM. Understanding the program counter is crucial for optimizing smart contract execution and debugging.

- **EVM Storage Structures**: Explore the data structures used in EVM storage. Ethereum utilizes a Merkle Patricia Trie for contract interaction, but for contract storage, it behaves like a hash map. Specifically:
  - Direct Table: Used for signed or unsigned integers up to 256 bits per slot, booleans, enums, and fixed-length integer structs and arrays.
  - Hash Table: For other structures, keys are calculated using the Keccak-256 hash function, providing a deeper understanding of how complex data is managed in Ethereum.

## Getting Started

To get started with the exercises, clone the repository and explore the different directories corresponding to each focus area. Each directory contains detailed explanations and solutions to the problems tackled.

```bash
git clone https://github.com/JMSBPP/EVM_Driven_Algorithms_and_Data_Structures_Exercises.git
cd EVM_Driven_Algorithms_and_Data_Structures_Exercises
```
