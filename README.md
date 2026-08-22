# Blockchain Journey

Hi, I'm **Maithili**. This repository documents my hands-on journey through blockchain fundamentals, Ethereum, Solidity, and smart-contract development.

It contains revision notes, small Solidity examples, Hardhat exercises, JavaScript scripts, and mini-projects. The work is organized as a 30-day learning series and is still evolving.

## What is here

- 30 learning notes, from blockchain fundamentals through Solidity security
- Solidity examples covering variables, functions, data types, arrays, structs, mappings, enums, data locations, errors, events, modifiers, inheritance, interfaces, abstract contracts, libraries, fallback and receive functions, Ether handling, and security
- A Hardhat project configured for Solidity `0.8.20`
- A tested `PiggyBank` contract
- JavaScript and frontend experiments in `javascript/` and `mini-projects/`

## Repository structure

```text
blockchain-journey/
├── contracts/          Solidity learning examples
├── notes/              Day 1 through Day 30 revision notes
├── test/               Hardhat tests
├── javascript/         JavaScript exercises
├── mini-projects/      password-Hasher, variable, and wallet-UI
├── diagrams/           Learning diagrams
├── images/             Supporting images
├── hardhat.config.js   Hardhat configuration
└── package.json        Node.js dependencies and scripts
```

## Learning progress

| Days  | Topics                                                                                                   | Status   |
| ----- | -------------------------------------------------------------------------------------------------------- | -------- |
| 1-5   | Blockchain, security, cryptography, consensus, Ethereum, and the EVM                                     | Complete |
| 6-13  | Solidity fundamentals, variables, functions, data types, visibility, constructors, operators, and arrays | Complete |
| 14-20 | Structs, loops, mappings, enums, data locations, error handling, and events                              | Complete |
| 21-26 | Modifiers, inheritance, constructors with inheritance, interfaces, abstract contracts, and libraries     | Complete |
| 27-30 | Fallback and receive functions, payable functions, Ether transfers, and security fundamentals            | Complete |

See the full notes in [`notes/`](notes/).

## Running the project

Install dependencies:

```bash
npm install
```

Compile the contracts:

```bash
npx hardhat compile
```

Run the Hardhat test suite:

```bash
npx hardhat test
```

The project uses Hardhat's local network by default. Contract artifacts are generated in `artifacts/` and the compiler cache is stored in `cache/`.

## Current focus

The current codebase focuses on Solidity fundamentals, Ether transfers, contract security, and learning how to test contracts with Hardhat and ethers.js. Advanced application development, deployment, and larger DApps remain future areas of the journey.

## Connect

- [GitHub](https://github.com/Maithali)
- [LinkedIn](https://www.linkedin.com/in/maithali-gharde-77aa29191)
