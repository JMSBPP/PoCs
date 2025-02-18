# Formal-Verification-EVM-Opcodes


This repository contains implementations of projects designed to:


1- Understand the inner workings of the Solidity compiler and EVM opcodes. 

2- Develop smart contracts using Assembly and Yul for optimized and granular control.

3- Apply formal verification techniques to guarantee contract invariants using tools like Certora and Halmos.

It is the result of the A 11 hours long course, completely for free! 

Check it out:
[Cyfrin Updraft](https://updraft.cyfrin.io/courses/formal-verification) 

# Getting Started

## Requirements

-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  
    -   You'll know you've done it right if you can run `git --version`
-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.2.0`
-   [Solidity Compiler](https://docs.soliditylang.org/en/latest/installing-solidity.html)
    -   You'll know you've done it right if you can run `solc --verison` and get an output like:
    -   `solc, the solidity compiler commandline interface Version: 0.8.15+commit.e14f2714.Darwin.appleclan`
-   [Halmos (which means you need python)](https://github.com/a16z/halmos)
    -   You'll know you've done it right if you can run `halmos --version` and get an output like: `Halmos 0.1.9`


## Quickstart

1. Clone the repo & install dependencies

```
git clone https://github.com/JMSBPP/Formal-Verification-EVM-Opcodes.git
cd Formal-Verification-EVM-Opcodes
cd <projectName>
```

2. Run tests

```
forge test
```

