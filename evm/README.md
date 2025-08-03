# Ethereum Virtual Machine (EVM) Study Guide  
**Connecting the EVM with Computer Architecture, Operating Systems, and Solidity**  
*Inspired by "Computer Architecture: A Quantitative Approach" and OS Principles*

---

The EVM is a stack-based, 16-bit word-oriented virtual machine.
---

## 🔗 **Key Connections**

| EVM Concept                | Computer Architecture                  | Operating System                          |
| -------------------------- | -------------------------------------- | ----------------------------------------- |
| Stack-based VM             | Stack machines (e.g., JVM, Forth)      | Process execution model                   |
| Gas metering               | Performance cost (CPI, cycles)         | Resource quotas (CPU time, memory limits) |
| Storage (Persistent State) | Non-volatile memory (disk)             | File system / persistent storage          |
| Memory (Temporary)         | RAM                                    | Heap allocation                           |
| Execution Environment      | ISA (Instruction Set Architecture)     | Process isolation / sandboxing            |
| Contract Calls             | Function calls / procedure linkage     | Inter-process communication (IPC)         |
| Opcodes                    | Machine instructions                   | System calls                              |
| Reverts / Exceptions       | Exception handling (traps, interrupts) | Signal handling / process termination     |

---

## Read & Write
### Stack

### Memory

### Storage

### Transient Storage

### Calldata

### Code

### ReturnData

## Write (only)

### Logs

## Read (only)

### Transaction Data (& BlobHash)

### Chain Data

### Gas Data

### PC

### Other ...