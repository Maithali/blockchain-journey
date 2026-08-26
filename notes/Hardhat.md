# ⚒️ Hardhat — Complete Revision & Cheat Sheet

> 🎯 **Goal:** Master Hardhat from beginner setup to advanced development, testing, deployment, debugging, configuration, Ignition, plugins, networks, verification, and interview-level concepts.

> 📌 **Current focus:** Hardhat 3. Hardhat is an Ethereum development environment for building, testing, debugging, deploying, and verifying smart contracts. Hardhat 3 includes a Rust-powered Ethereum Development Runtime (EDR), Solidity testing, TypeScript support, Hardhat Ignition, and an extensible plugin ecosystem. :contentReference[oaicite:0]{index=0}

---

# 📚 Table of Contents

1. [What is Hardhat?](#-1-what-is-hardhat)
2. [Hardhat Architecture](#-2-hardhat-architecture)
3. [Installation](#-3-installation)
4. [Creating a Project](#-4-creating-a-project)
5. [Project Structure](#-5-hardhat-project-structure)
6. [Guides](#-6-guides)
7. [Solidity Contracts](#-7-solidity-contracts)
8. [Compilation](#-8-compilation)
9. [Testing](#-9-testing)
10. [Solidity Tests](#-10-solidity-tests)
11. [TypeScript Tests](#-11-typescript-tests)
12. [Deployments](#-12-deployments)
13. [Hardhat Ignition](#-13-hardhat-ignition)
14. [Networks](#-14-networks)
15. [Configuration](#-15-configuration)
16. [Configuration Variables & Secrets](#-16-configuration-variables--secrets)
17. [Accounts & Private Keys](#-17-accounts--private-keys)
18. [Debugging](#-18-debugging)
19. [console.log](#-19-consolelog)
20. [Gas & Gas Reporting](#-20-gas--gas-reporting)
21. [Contract Verification](#-21-contract-verification)
22. [Advanced](#-22-advanced)
23. [Hardhat Network & EDR](#-23-hardhat-network--edr)
24. [Forking](#-24-forking)
25. [Snapshots & Time Manipulation](#-25-snapshots--time-manipulation)
26. [Multi-Chain Development](#-26-multi-chain-development)
27. [Custom Tasks](#-27-custom-tasks)
28. [Plugins](#-28-plugins)
29. [Supporter Guides](#-29-supporter-guides)
30. [Reference](#-30-reference)
31. [Common Commands](#-31-common-commands)
32. [Common Errors](#-32-common-hardhat-errors)
33. [Hardhat + React Frontend](#-33-hardhat--react-frontend)
34. [Hardhat + Ethers](#-34-hardhat--ethers)
35. [Hardhat + Viem](#-35-hardhat--viem)
36. [Production Workflow](#-36-production-workflow)
37. [Interview Questions](#-37-hardhat-interview-questions)
38. [60-Second Revision](#-38-60-second-revision)
39. [Golden Rules](#-39-golden-rules)

---

# ⚒️ 1. What is Hardhat?

## Definition

**Hardhat** is a development environment for Ethereum and Solidity applications.

It helps developers:

```text
Write Solidity
     ↓
Compile
     ↓
Test
     ↓
Debug
     ↓
Deploy
     ↓
Verify
     ↓
Connect Frontend
```

Hardhat provides tooling for the complete smart-contract development lifecycle. :contentReference[oaicite:1]{index=1}

---

# 🧒 Explain Like I'm 10

Imagine you are building a car.

You need:

```text
Factory       → Build
Testing Lab  → Test
Repair Shop  → Debug
Transport     → Deploy
Inspection    → Verify
```

Hardhat is like the complete workshop for your smart contracts.

---

# 🧠 2. Hardhat Architecture

```text
                     HARDHAT
                        │
       ┌────────────────┼────────────────┐
       ▼                ▼                ▼
   Compiler          Testing          Network
       │                │                │
       ▼                ▼                ▼
    Solidity       TypeScript       Local EVM
    Compiler       Solidity Tests    Simulation
                        │
                        ▼
                   Debugging
                        │
       ┌────────────────┼────────────────┐
       ▼                ▼                ▼
   Deployment       Verification      Plugins
       │                │                │
       ▼                ▼                ▼
   Ignition         Explorers        Extensions
```

---

# 🔥 3. Why Hardhat?

## Main Benefits

- ⚒️ Development environment
- 🧪 Testing
- 🐛 Debugging
- 🏗️ Deployment
- 🌐 Network management
- 🔐 Configuration
- 📦 Plugin ecosystem
- 📝 TypeScript support
- ⛓️ Local Ethereum execution
- 🚀 Hardhat Ignition
- 🔍 Contract verification

Hardhat emphasizes extensibility and allows developers to customize tasks and integrate other tools. :contentReference[oaicite:2]{index=2}

---

# 📦 4. Installation

Check Node.js:

```bash
node --version
```

Check npm:

```bash
npm --version
```

Create a project:

```bash
mkdir my-hardhat-project
cd my-hardhat-project
```

Initialize npm:

```bash
npm init -y
```

Install Hardhat:

```bash
npm install --save-dev hardhat
```

Check:

```bash
npx hardhat --version
```

---

# 🏗️ 5. Creating a Hardhat Project

For a new Hardhat project:

```bash
npx hardhat --init
```

Follow the project setup prompts.

Typical project choices may include:

```text
TypeScript
Solidity
Testing
```

---

# 📁 6. Hardhat Project Structure

A typical project looks like:

```text
my-hardhat-project/
│
├── contracts/
│   └── Counter.sol
│
├── test/
│   ├── Counter.ts
│   └── Counter.t.sol
│
├── ignition/
│   └── modules/
│       └── Counter.ts
│
├── scripts/
│
├── artifacts/
│
├── cache/
│
├── node_modules/
│
├── package.json
├── hardhat.config.ts
└── README.md
```

---

# 📂 7. Important Folders

## `contracts/`

Contains Solidity contracts:

```text
contracts/
    ├── MyToken.sol
    ├── Voting.sol
    └── Staking.sol
```

---

## `test/`

Contains automated tests.

Examples:

```text
test/
    ├── MyToken.ts
    └── MyToken.t.sol
```

---

## `ignition/`

Contains Hardhat Ignition deployment modules.

```text
ignition/
    └── modules/
        └── MyToken.ts
```

---

## `artifacts/`

Contains generated compilation artifacts.

Typically includes:

```text
ABI
Bytecode
Metadata
```

---

## `cache/`

Stores compiler/build-related cache data.

---

# 🧠 8. Hardhat Development Lifecycle

```text
                Solidity Code
                     │
                     ▼
                 Compile
                     │
                     ▼
                 Artifacts
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
        Tests                 Deploy
          │                     │
          ▼                     ▼
       Debug                Network
                                │
                                ▼
                            Verify
                                │
                                ▼
                             Frontend
```

---

# 📘 9. Guides

The practical Hardhat workflow can be remembered as:

```text
SETUP
  ↓
WRITE
  ↓
COMPILE
  ↓
TEST
  ↓
DEBUG
  ↓
DEPLOY
  ↓
VERIFY
  ↓
INTEGRATE
```

---

# ✍️ 10. Writing a Solidity Contract

Example:

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Counter {

    uint256 public count;

    function increment() public {
        count++;
    }

    function decrement() public {
        count--;
    }
}
```

Save as:

```text
contracts/Counter.sol
```

---

# ⚙️ 11. Compilation

Compile:

```bash
npx hardhat compile
```

If successful:

```text
Compiled successfully
```

Artifacts are generated.

---

# 📦 12. What Is an Artifact?

An artifact contains information generated by the compiler.

Important pieces:

```text
ABI
Bytecode
Metadata
```

---

# 🧠 ABI

ABI means:

> Application Binary Interface

It describes how applications interact with the contract.

For example:

```text
increment()
count()
decrement()
```

Frontend libraries use the ABI to construct contract calls.

---

# ⚙️ 13. Compiler Configuration

A Hardhat configuration can specify Solidity versions and compiler settings.

Example:

```typescript
import { defineConfig } from "hardhat/config";

export default defineConfig({
  solidity: {
    version: "0.8.20",
  },
});
```

---

# 🧪 14. Testing

Testing is one of Hardhat's most important features.

You should test:

```text
Normal behavior
Failure behavior
Access control
Events
State changes
Edge cases
Security assumptions
```

Hardhat 3 supports both Solidity and TypeScript testing approaches. :contentReference[oaicite:3]{index=3}

---

# 🧪 15. Why Test Smart Contracts?

Smart contracts are:

```text
Immutable after deployment
+
Financially sensitive
+
Public
+
Attacked by adversaries
```

A bug can be extremely expensive.

Therefore:

```text
Write
 ↓
Test
 ↓
Find bug
 ↓
Fix
 ↓
Retest
 ↓
Deploy
```

---

# 🧪 16. TypeScript Tests

A test commonly follows:

```text
Arrange
 ↓
Act
 ↓
Assert
```

Example concept:

```typescript
it("should increment", async () => {

  // Arrange
  const counter = ...;

  // Act
  await counter.increment();

  // Assert
  // expect count to be 1
});
```

---

# 🧪 17. Solidity Tests

Hardhat 3 provides first-class Solidity testing.

Conceptually:

```text
test/
    Counter.t.sol
```

Solidity tests are useful when you want:

```text
Fast execution
Direct contract-level testing
Familiar Solidity syntax
```

Hardhat 3 also supports combining Solidity and TypeScript tests depending on the use case. :contentReference[oaicite:4]{index=4}

---

# 🧪 18. Testing Strategy

```text
Unit Tests
    ↓
Integration Tests
    ↓
Security Tests
    ↓
Fork Tests
    ↓
Deployment Tests
```

---

# 🧪 19. Unit Test

Test one function:

```text
transfer()
```

---

# 🔗 20. Integration Test

Test multiple contracts:

```text
Token
  ↓
Staking
  ↓
Rewards
```

---

# 🔐 21. Security Test

Test:

```text
Unauthorized access
Reentrancy
Bad input
Overflow
Allowance issues
Zero address
```

---

# 🧪 22. Fuzz Testing

Fuzzing means testing many automatically generated inputs.

Instead of:

```text
amount = 100
```

the test can explore many values:

```text
0
1
2
100
999999
MAX_UINT
...
```

This helps discover edge cases.

---

# 🚀 23. Deployment

Deployment means:

```text
Local Contract
      ↓
Blockchain Network
```

Possible environments:

```text
Local
 ↓
Testnet
 ↓
Mainnet
```

---

# 🌐 24. Network Types

## Local

Used for development.

```text
Hardhat local network
```

---

## Testnet

Used for testing real blockchain deployment.

Examples can include:

```text
Sepolia
```

---

## Mainnet

Real assets and real transactions.

```text
Ethereum Mainnet
```

---

# 🏗️ 25. Hardhat Ignition

Hardhat Ignition is Hardhat's deployment system.

Instead of manually writing every deployment step, you describe the desired deployment in a module.

Hardhat then manages the deployment process. :contentReference[oaicite:5]{index=5}

---

# 📦 26. Ignition Module

Example:

```typescript
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CounterModule = buildModule("CounterModule", (m) => {
  const counter = m.contract("Counter");

  return {
    counter,
  };
});

export default CounterModule;
```

---

# 🚀 27. Ignition Deployment

A common workflow is:

```bash
npx hardhat ignition deploy ignition/modules/Counter.ts
```

For a specific network:

```bash
npx hardhat ignition deploy ignition/modules/Counter.ts --network sepolia
```

Always check the current Hardhat version's CLI/reference for exact command options.

---

# 🧠 28. Why Use Ignition?

It helps with:

```text
Deployment definitions
Dependencies
Deployment state
Reproducibility
Complex deployments
```

For larger projects:

```text
Contract A
   ↓
Contract B
   ↓
Contract C
```

deployment dependencies become easier to express.

---

# 🌐 29. Networks

A network configuration normally contains information such as:

```text
Network name
RPC URL
Chain ID
Accounts
```

Conceptual example:

```typescript
networks: {
  sepolia: {
    type: "http",
    url: "...",
    accounts: ["..."],
  },
}
```

---

# 🔐 30. NEVER Hardcode Private Keys

❌ Don't do:

```typescript
accounts: ["my-real-private-key"];
```

Use configuration variables or environment/secrets mechanisms instead.

---

# 🔑 31. RPC URL

RPC means:

> Remote Procedure Call

Your application communicates with a blockchain node through an RPC endpoint.

Conceptually:

```text
Hardhat
   │
   │ RPC
   ▼
Ethereum Node
   │
   ▼
Blockchain
```

---

# 🔢 32. Chain ID

A chain ID identifies the blockchain network.

Example concept:

```text
Mainnet → one chain ID
Sepolia  → another chain ID
```

It helps prevent transactions intended for one network from being replayed or mistakenly used on another network.

---

# 🔐 33. Configuration Variables & Secrets

Sensitive values can include:

```text
RPC URLs
Private keys
API keys
Explorer API keys
```

Do not commit secrets to GitHub.

Use:

```text
configuration variables
environment variables
secret management
```

Hardhat's current documentation also supports configuration variables and defaults in configuration. :contentReference[oaicite:6]{index=6}

---

# 📝 34. `.gitignore`

Typical entries:

```text
node_modules/
artifacts/
cache/
.env
```

Never commit:

```text
private keys
seed phrases
real credentials
```

---

# 🐛 35. Debugging

Hardhat is designed with strong Solidity debugging support.

Useful debugging information includes:

```text
Revert reason
Stack trace
Transaction failure
Contract call location
```

Hardhat's documentation highlights Solidity stack traces and explicit errors as major debugging features. :contentReference[oaicite:7]{index=7}

---

# 🧾 36. `console.log`

For local development, Solidity debugging can use:

```solidity
import "hardhat/console.sol";
```

Then:

```solidity
console.log("Count:", count);
```

Use this for:

```text
Debugging
State inspection
Tracing development logic
```

Do not treat debugging logs as production application logging.

---

# 🧠 37. Debugging Workflow

When a transaction fails:

```text
Read Error
    ↓
Read Revert Reason
    ↓
Read Stack Trace
    ↓
Find Contract Line
    ↓
Check Input
    ↓
Check State
    ↓
Fix
    ↓
Run Tests Again
```

---

# ⛽ 38. Gas

Every Ethereum operation consumes gas.

Examples:

```text
SSTORE
SLOAD
CALL
LOG
Contract deployment
```

---

# 💡 39. Gas Optimization

General principles:

```text
Avoid unnecessary storage writes
Use calldata where appropriate
Avoid unnecessary loops
Pack storage variables carefully
Use efficient data structures
Cache repeated reads when useful
```

But:

> **Do not sacrifice correctness or security just to save a small amount of gas.**

---

# 📊 40. Gas Testing

Gas-related tests can help identify:

```text
Expensive functions
Storage-heavy operations
Unexpected regressions
```

A useful development workflow is:

```text
Implement
 ↓
Test
 ↓
Measure
 ↓
Optimize
 ↓
Retest
```

---

# 🔍 41. Contract Verification

Verification publishes source-code information to a block explorer so users can inspect the deployed contract and compare it with the deployed bytecode.

Conceptually:

```text
Solidity Source
      │
      ▼
Compiler
      │
      ▼
Bytecode
      │
      ▼
Blockchain
```

Verification helps connect:

```text
Deployed Bytecode
        +
Published Source
```

---

# 🌐 42. Typical Verification Workflow

```text
Deploy
  ↓
Get Contract Address
  ↓
Compile with Same Settings
  ↓
Submit Verification
  ↓
Explorer Checks Bytecode
  ↓
Verified Contract
```

---

# ⚠️ 43. Verification Common Problems

Verification can fail because of:

```text
Wrong compiler version
Wrong optimizer settings
Wrong constructor arguments
Wrong contract path
Wrong network
Wrong deployed address
Different source code
```

---

# 🚀 44. Advanced

Advanced Hardhat knowledge includes:

```text
Hardhat Network
EDR
Forking
Snapshots
Time manipulation
Fuzzing
Custom tasks
Plugins
Multi-chain testing
Advanced deployment
Debugging
Performance optimization
```

Hardhat 3's runtime is powered by EDR, implemented in Rust, and Hardhat supports advanced testing and multi-chain simulation workflows. :contentReference[oaicite:8]{index=8}

---

# ⚡ 45. Hardhat Network

Hardhat provides a local Ethereum development environment.

Conceptually:

```text
Your Computer
     │
     ▼
Hardhat Network
     │
     ├── Accounts
     ├── ETH
     ├── Contracts
     ├── Transactions
     └── Blocks
```

This allows rapid development without spending real ETH.

---

# 🧠 46. EDR

EDR means:

> Ethereum Development Runtime

Hardhat 3 uses a Rust-powered runtime for Ethereum execution and testing. :contentReference[oaicite:9]{index=9}

Conceptually:

```text
Hardhat
   │
   ▼
EDR
   │
   ▼
Ethereum Execution Simulation
```

---

# 🍴 47. Mainnet Forking

Forking creates a local development environment based on the state of another network.

Conceptually:

```text
Ethereum Network
       │
       │ Fork
       ▼
Local Hardhat Environment
```

You can then test against realistic blockchain state without modifying the real network.

---

# 🧪 48. Why Fork?

Useful for testing:

```text
DeFi protocols
Existing contracts
Real token balances
Oracle interactions
Liquidity
Complex integrations
```

Example:

```text
Real Network State
       ↓
Local Fork
       ↓
Test Your Contract
```

---

# 📸 49. Snapshots

Snapshots allow a test/development state to be saved and restored.

Concept:

```text
Initial State
     │
     ▼
Snapshot
     │
     ▼
Perform Operations
     │
     ▼
Restore
     │
     ▼
Initial State
```

Useful for:

```text
Fast tests
Repeated scenarios
Complex setup
```

---

# ⏰ 50. Time Manipulation

Blockchain applications often depend on:

```solidity
block.timestamp
```

Examples:

```text
Staking
Vesting
Auctions
Voting
Deadlines
Lock periods
```

Testing may require advancing simulated blockchain time.

---

# 🔗 51. Multi-Chain Development

Modern Web3 applications may target:

```text
Ethereum
Base
Optimism
Arbitrum
Polygon
zkSync
```

The exact supported simulation features depend on the current Hardhat release and network configuration.

Hardhat 3 currently highlights support for multi-chain workflows including Optimism's OP Stack and Base simulation. :contentReference[oaicite:10]{index=10}

---

# 🛠️ 52. Custom Tasks

Hardhat is extensible.

You can create custom development commands for repetitive workflows.

Concept:

```text
npx hardhat myTask
```

Example use cases:

```text
Show accounts
Read contract state
Deploy contract
Mint tokens
Check balances
Export data
```

---

# 🧩 53. Plugins

Hardhat has a plugin ecosystem.

Plugins can add:

```text
Testing tools
Ethereum libraries
Deployment functionality
Verification
Coverage
Gas reporting
Type generation
Custom integrations
```

Hardhat is intentionally designed to be extensible through plugins. :contentReference[oaicite:11]{index=11}

---

# 📦 54. Plugin Mental Model

```text
                 HARDHAT
                    │
       ┌────────────┼────────────┐
       ▼            ▼            ▼
     Core         Plugin       Plugin
       │            │            │
       ▼            ▼            ▼
  Compiler      Testing       Deployment
```

---

# 🧰 55. Common Hardhat Ecosystem Tools

Depending on project requirements, you may encounter:

```text
Hardhat Toolbox
Hardhat Ignition
Hardhat Network
Ethers integration
Viem integration
TypeScript tooling
Verification tooling
Gas-reporting plugins
Coverage tooling
```

> 📌 Always check plugin compatibility with your Hardhat major version before installing packages.

---

# ⚠️ 56. Hardhat 2 vs Hardhat 3

This is extremely important.

Older tutorials may use:

```text
Hardhat 2
```

while current documentation focuses on:

```text
Hardhat 3
```

Therefore, commands and package APIs can differ.

### Rule:

```text
Tutorial Version
       ↓
Check package versions
       ↓
Check current documentation
       ↓
Then copy code
```

Do not blindly mix:

```text
Hardhat 2 packages
+
Hardhat 3 packages
```

---

# 🧨 57. Why Dependency Conflicts Happen

You may see:

```text
ERESOLVE
HH606
HH8
HH404
HH117
```

Often the root cause is:

```text
Hardhat version
       +
Plugin version
       +
Ethers version
       +
TypeScript version
```

are incompatible.

---

# 🛠️ 58. Dependency Debugging

Check:

```bash
npm list hardhat
```

Check Ethers:

```bash
npm list ethers
```

Check Nomic Foundation packages:

```bash
npm list @nomicfoundation/*
```

Check outdated packages:

```bash
npm outdated
```

---

# 🧹 59. Clean Installation

When a project has corrupted/incompatible dependencies:

```bash
rm -rf node_modules
rm package-lock.json
npm install
```

On Windows PowerShell:

```powershell
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm install
```

> ⚠️ Do this carefully in an existing project because changing dependency resolution can change package versions.

---

# 🔧 60. Reference

The Hardhat reference section is where you should look for exact technical details such as:

```text
Configuration
CLI commands
Network configuration
Compiler settings
Runtime APIs
Plugin APIs
Testing options
Advanced network features
```

For interview preparation:

```text
Guides
 ↓
Understand workflow

Reference
 ↓
Understand exact API/configuration
```

---

# 📋 61. Reference — Configuration

Typical configuration areas include:

```text
Solidity compiler
Networks
Plugins
Configuration variables
Paths
Testing
Verification
```

Conceptual:

```typescript
export default defineConfig({
  solidity: {
    version: "0.8.20",
  },

  networks: {
    // network configuration
  },
});
```

---

# 📋 62. Reference — CLI

The CLI is used to run Hardhat operations.

Examples:

```bash
npx hardhat compile
```

```bash
npx hardhat test
```

```bash
npx hardhat --help
```

```bash
npx hardhat --version
```

For exact commands and flags:

```bash
npx hardhat --help
```

and consult the version-specific reference documentation.

---

# 🧪 63. Reference — Testing

Testing concepts:

```text
Test files
Test discovery
Assertions
Fixtures
Fuzzing
Gas
Snapshots
Network manipulation
```

---

# 🌐 64. Reference — Network

Know these concepts:

```text
Local network
HTTP network
RPC URL
Chain ID
Accounts
Forking
Network state
```

---

# 🧩 65. Reference — Plugins

When installing a plugin, verify:

```text
Plugin name
Hardhat version compatibility
Peer dependencies
Installation command
Configuration
Usage
```

This prevents the common:

```text
ERESOLVE
```

dependency problem.

---

# 💎 66. Supporter Guides

Some documentation sections are intended for deeper or specialized workflows.

Treat supporter/advanced material as:

```text
Core knowledge
      ↓
Guides
      ↓
Advanced guides
      ↓
Specialized workflows
```

The key rule is:

> Do not try to memorize every specialized feature. Learn the architecture and know where to look up the exact API.

---

# 🧠 67. What You Actually Need to Memorize

### MUST KNOW

```text
Hardhat purpose
Project structure
Compile
Test
Deploy
Network
Configuration
Ignition
Debugging
Plugins
Artifacts
ABI
Bytecode
RPC
```

### SHOULD KNOW

```text
Forking
Snapshots
Fuzzing
Custom tasks
Gas analysis
Verification
Multi-chain testing
```

### LOOK UP WHEN NEEDED

```text
Rare configuration fields
Advanced plugin APIs
Special compiler settings
Uncommon network features
Specialized deployment behavior
```

---

# ⚛️ 68. Hardhat + Ethers Architecture

```text
Frontend / Script
       │
       ▼
    Ethers
       │
       ▼
   Provider
       │
       ▼
      RPC
       │
       ▼
 Ethereum Network
```

Hardhat provides the development environment while Ethers can provide the JavaScript/TypeScript Ethereum interaction layer when that integration is selected.

---

# 🔌 69. Provider vs Signer

## Provider

Used to:

```text
Read blockchain
Read blocks
Read balances
Read contract state
```

Concept:

```text
Provider
   ↓
Read
```

---

## Signer

Used to:

```text
Send transactions
Sign messages
Modify blockchain state
```

Concept:

```text
Signer
   ↓
Sign
   ↓
Transaction
```

---

# 🧠 70. Read vs Write

```text
VIEW FUNCTION
     ↓
Provider
     ↓
Read
```

```text
STATE-CHANGING FUNCTION
     ↓
Signer
     ↓
Transaction
```

---

# ⚛️ 71. Hardhat + Viem

Viem is another Ethereum TypeScript interaction library.

Conceptually:

```text
Hardhat
   │
   ▼
Viem
   │
   ├── Public Client
   └── Wallet Client
```

The exact integration depends on the Hardhat configuration and plugins used.

---

# 🌐 72. Hardhat + React Frontend

A typical architecture:

```text
                 React
                   │
                   ▼
              Ethers/Viem
                   │
                   ▼
              MetaMask
                   │
                   ▼
                  RPC
                   │
                   ▼
             Ethereum
                   │
                   ▼
            Smart Contract
```

---

# 📦 73. ABI in Frontend

After compilation:

```text
Contract
    ↓
Compiler
    ↓
Artifact
    ↓
ABI
    ↓
Frontend
```

Frontend needs:

```text
Contract Address
+
ABI
+
Provider/Wallet
```

---

# 🔗 74. Contract Integration

Conceptual:

```typescript
const contract = new Contract(contractAddress, abi, signer);
```

Then:

```typescript
await contract.transfer(recipient, amount);
```

---

# 🏗️ 75. Complete DApp Architecture

```text
                     USER
                      │
                      ▼
                React Frontend
                      │
                      ▼
               Ethers / Viem
                      │
                      ▼
                   Wallet
                      │
                      ▼
                    RPC
                      │
                      ▼
                Blockchain
                      │
                      ▼
              Solidity Contract
                      ▲
                      │
                  Hardhat
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
     Compile        Test          Deploy
        │             │             │
        ▼             ▼             ▼
    Artifact       Results       Ignition
```

---

# 🧪 76. Professional Testing Pipeline

```text
Developer writes contract
          │
          ▼
       Compile
          │
          ▼
      Unit Tests
          │
          ▼
   Integration Tests
          │
          ▼
     Fuzz Testing
          │
          ▼
   Security Review
          │
          ▼
    Fork Testing
          │
          ▼
     Testnet Deploy
          │
          ▼
      Verification
          │
          ▼
      Mainnet Deploy
```

---

# 🚀 77. Production Deployment Workflow

```text
                    CODE
                     │
                     ▼
                  COMPILE
                     │
                     ▼
                   TEST
                     │
                     ▼
              SECURITY REVIEW
                     │
                     ▼
              TESTNET DEPLOY
                     │
                     ▼
                VERIFY
                     │
                     ▼
              FRONTEND TEST
                     │
                     ▼
             DEPLOYMENT REVIEW
                     │
                     ▼
              MAINNET DEPLOY
                     │
                     ▼
                MONITOR
```

---

# 🔐 78. Deployment Security Checklist

Before mainnet:

```text
☐ Private key protected
☐ RPC URL protected where appropriate
☐ Correct chain selected
☐ Correct contract compiled
☐ Tests passing
☐ Access control tested
☐ Constructor parameters verified
☐ Deployment address recorded
☐ Contract verified
☐ Admin/owner address checked
☐ Upgradeability understood if used
☐ Emergency controls reviewed
☐ Frontend points to correct address
```

---

# 🧪 79. Smart Contract Test Checklist

```text
☐ Deployment succeeds
☐ Initial state correct
☐ Happy path works
☐ Invalid input rejected
☐ Unauthorized caller rejected
☐ Events emitted
☐ State updated correctly
☐ ETH handling tested
☐ Token transfers tested
☐ Reverts tested
☐ Edge cases tested
☐ Zero address tested
☐ Large values tested
☐ Boundary values tested
```

---

# 🐛 80. Common Hardhat Errors

## HH606

Often related to incompatible Solidity compiler versions/pragmas.

Check:

```text
pragma solidity
```

and:

```text
Hardhat compiler configuration
```

---

# ❌ 81. HH8

Often indicates invalid Hardhat configuration, commonly around accounts or network settings.

Check:

```text
private key
network config
environment variables
```

---

# ❌ 82. HH404

Often means an imported module/file cannot be found.

Check:

```text
npm package
import path
node_modules
```

Example:

```bash
npm install @openzeppelin/contracts
```

---

# ❌ 83. HH117

Often related to missing or empty network configuration values.

Check:

```text
RPC URL
environment variables
network configuration
```

---

# ❌ 84. ERESOLVE

Usually an npm dependency-resolution conflict.

Check:

```text
Hardhat version
Plugin version
Ethers version
Peer dependencies
Node version
```

---

# ❌ 85. "Invalid JSON-RPC response"

Usually means your RPC endpoint is:

```text
Incorrect
Unavailable
Malformed
Empty
```

Check:

```text
RPC URL
API key
network
provider status
```

---

# ❌ 86. "Network Does Not Exist"

Check:

```text
network name in config
```

against:

```bash
npx hardhat --help
```

and your current Hardhat documentation/configuration.

---

# 🧠 87. Troubleshooting Framework

Whenever you get an error:

```text
1. Read the first meaningful error
2. Identify Hardhat error code
3. Check Hardhat version
4. Check package versions
5. Check config
6. Check Solidity pragma
7. Check RPC
8. Check private-key/account config
9. Re-run compile
10. Re-run tests
```

---

# 📦 88. NPM Commands Cheat Sheet

Install dependency:

```bash
npm install package-name
```

Install development dependency:

```bash
npm install --save-dev package-name
```

Remove package:

```bash
npm uninstall package-name
```

List packages:

```bash
npm list
```

Check Hardhat:

```bash
npm list hardhat
```

Check outdated packages:

```bash
npm outdated
```

---

# ⚒️ 89. Hardhat Command Cheat Sheet

Check version:

```bash
npx hardhat --version
```

Help:

```bash
npx hardhat --help
```

Compile:

```bash
npx hardhat compile
```

Test:

```bash
npx hardhat test
```

Run a specific network:

```bash
npx hardhat <command> --network sepolia
```

Clean/build-related artifacts as supported by your installed Hardhat version:

```bash
npx hardhat clean
```

---

# 🏗️ 90. Ignition Cheat Sheet

Create:

```text
ignition/modules/MyToken.ts
```

Example:

```typescript
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MyTokenModule = buildModule("MyTokenModule", (m) => {
  const token = m.contract("MyToken");

  return {
    token,
  };
});

export default MyTokenModule;
```

Deploy:

```bash
npx hardhat ignition deploy ignition/modules/MyToken.ts
```

Network:

```bash
npx hardhat ignition deploy ignition/modules/MyToken.ts --network sepolia
```

---

# 🧠 91. Ignition Mental Model

```text
Module
  │
  ▼
Deployment Definition
  │
  ▼
Contract Dependencies
  │
  ▼
Ignition
  │
  ▼
Deployment
```

---

# 🧩 92. Plugin Installation Mental Model

Before installing:

```text
Which plugin?
      ↓
Which Hardhat version?
      ↓
Which peer dependencies?
      ↓
Which ethers/viem version?
      ↓
Install
      ↓
Configure
      ↓
Test
```

---

# ⚠️ 93. Never Randomly Install Packages

Bad approach:

```bash
npm install
packageA
packageB
packageC
packageD
```

without checking compatibility.

Better:

```text
Hardhat version
       ↓
Official plugin docs
       ↓
Compatible version
       ↓
Install
```

---

# 🧠 94. Hardhat vs Remix

| Feature               | Hardhat          | Remix       |
| --------------------- | ---------------- | ----------- |
| Local development     | ⭐⭐⭐⭐⭐       | ⭐⭐⭐      |
| IDE                   | CLI/editor based | Browser IDE |
| Testing               | ⭐⭐⭐⭐⭐       | ⭐⭐⭐      |
| Automation            | ⭐⭐⭐⭐⭐       | ⭐⭐        |
| Deployment scripting  | ⭐⭐⭐⭐⭐       | ⭐⭐⭐      |
| Git workflow          | ⭐⭐⭐⭐⭐       | ⭐⭐⭐      |
| Large projects        | ⭐⭐⭐⭐⭐       | ⭐⭐        |
| Beginner friendliness | ⭐⭐⭐           | ⭐⭐⭐⭐⭐  |
| Frontend integration  | ⭐⭐⭐⭐⭐       | ⭐⭐⭐      |
| CI/CD                 | ⭐⭐⭐⭐⭐       | ⭐⭐        |

---

# 🧠 95. Hardhat vs Foundry

| Feature                      | Hardhat          | Foundry         |
| ---------------------------- | ---------------- | --------------- |
| Language ecosystem           | JS/TS + Solidity | Rust + Solidity |
| Solidity testing             | ✅               | ✅              |
| TypeScript integration       | ⭐⭐⭐⭐⭐       | ⭐⭐⭐          |
| EVM tooling                  | ⭐⭐⭐⭐⭐       | ⭐⭐⭐⭐⭐      |
| Fast Solidity tests          | ⭐⭐⭐⭐         | ⭐⭐⭐⭐⭐      |
| Deployment                   | Ignition         | Forge scripts   |
| JavaScript ecosystem         | ⭐⭐⭐⭐⭐       | ⭐⭐⭐          |
| Fuzzing                      | ✅               | ⭐⭐⭐⭐⭐      |
| Beginner Web3 JS integration | ⭐⭐⭐⭐⭐       | ⭐⭐⭐          |

---

# 🎯 96. Hardhat Interview Questions

## Q1. What is Hardhat?

> Hardhat is an Ethereum development environment used to compile, test, debug, deploy, and verify smart contracts.

---

## Q2. Why use Hardhat?

> It provides an integrated development workflow with compilation, testing, local execution, debugging, deployment tooling, network configuration, and extensibility through plugins.

---

## Q3. What is Hardhat Ignition?

> Hardhat Ignition is Hardhat's declarative deployment system used to define and execute contract deployments and their dependencies.

---

## Q4. What is an artifact?

> An artifact is compiler-generated information about a contract, including ABI, bytecode, and metadata.

---

## Q5. What is ABI?

> ABI describes the interface through which external applications interact with a contract.

---

## Q6. What is Hardhat Network?

> It is a local Ethereum development environment used for executing and testing smart contracts locally.

---

## Q7. What is EDR?

> EDR, or Ethereum Development Runtime, is Hardhat's Ethereum execution runtime. Hardhat 3 uses a Rust-powered implementation. :contentReference[oaicite:12]{index=12}

---

## Q8. How do you compile?

```bash
npx hardhat compile
```

---

## Q9. How do you test?

```bash
npx hardhat test
```

---

## Q10. How do you deploy?

With Ignition:

```bash
npx hardhat ignition deploy ignition/modules/MyContract.ts
```

---

## Q11. What is a network configuration?

It defines how Hardhat connects to a blockchain environment, including items such as RPC configuration, chain information, and accounts.

---

## Q12. Why shouldn't private keys be committed?

Because anyone obtaining the key can potentially control the associated blockchain account.

---

## Q13. What is forking?

> Forking creates a local environment using the state of another blockchain network for testing.

---

## Q14. Why use snapshots?

> To save and restore blockchain state efficiently during development and testing.

---

## Q15. What is a plugin?

> A plugin extends Hardhat's capabilities with additional functionality or integrations.

---

## Q16. Hardhat 2 vs Hardhat 3?

> They are different major versions with potentially different APIs, packages, configuration patterns, and plugin compatibility. Always follow documentation matching the version installed.

---

# ⚡ 97. One-Minute Hardhat Revision

```text
HARDHAT
   │
   ├── contracts/
   │       └── Solidity
   │
   ├── test/
   │       └── Tests
   │
   ├── ignition/
   │       └── Deployment
   │
   ├── artifacts/
   │       └── ABI + Bytecode
   │
   └── hardhat.config.ts
           │
           ├── Solidity
           ├── Networks
           ├── Plugins
           └── Configuration
```

Workflow:

```text
WRITE
  ↓
COMPILE
  ↓
TEST
  ↓
DEBUG
  ↓
IGNITION
  ↓
DEPLOY
  ↓
VERIFY
  ↓
FRONTEND
```

---

# ⚡ 98. 30-Second Command Revision

```bash
# Version
npx hardhat --version

# Help
npx hardhat --help

# Compile
npx hardhat compile

# Test
npx hardhat test

# Deploy
npx hardhat ignition deploy ignition/modules/MyToken.ts

# Deploy to network
npx hardhat ignition deploy ignition/modules/MyToken.ts --network sepolia

# Check dependencies
npm list

# Check Hardhat
npm list hardhat

# Check outdated packages
npm outdated
```

---

# 🧠 99. Hardhat Mental Map

```text
                       HARDHAT
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
     DEVELOP           TEST             DEPLOY
        │                 │                 │
        ▼                 ▼                 ▼
   Solidity          TS/Solidity       Ignition
        │                 │                 │
        └─────────────────┼─────────────────┘
                          ▼
                       DEBUG
                          │
                          ▼
                       NETWORK
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
           Local       Testnet      Mainnet
                          │
                          ▼
                      VERIFY
                          │
                          ▼
                      FRONTEND
```

---

# 🏆 100. Golden Rules

- ⚒️ **Hardhat = Ethereum development environment.**
- 📝 **Contracts live in `contracts/`.**
- 🧪 **Tests live in `test/`.**
- 🏗️ **Ignition modules define deployments.**
- 📦 **Artifacts contain ABI and bytecode information.**
- ⚙️ **`hardhat.config.ts` controls project configuration.**
- 🧪 **Always test before deployment.**
- 🐛 **Use stack traces and debugging tools to investigate failures.**
- 🔐 **Never expose private keys or seed phrases.**
- 🌐 **Separate local, testnet, and mainnet configuration.**
- 🔑 **Protect RPC/API credentials where necessary.**
- 🧩 **Check plugin compatibility before installation.**
- ⚠️ **Do not blindly mix Hardhat 2 and Hardhat 3 tutorials/packages.**
- 🚀 **Use Ignition for structured deployments.**
- 🔍 **Verify deployed contracts when appropriate.**
- 🍴 **Use forking for realistic local integration testing.**
- 📸 **Use snapshots to speed up repeated test scenarios.**
- 🧪 **Use fuzzing to explore unexpected inputs.**
- ⛽ **Measure gas before optimizing.**
- 🛡️ **Security and correctness are more important than premature optimization.**

---

# 🎯 101. Ultimate Hardhat Interview Memory Line

> **Hardhat = CODE → COMPILE → TEST → DEBUG → NETWORK → IGNITION → DEPLOY → VERIFY → INTEGRATE**

And remember:

```text
                HARDHAT
                   │
        ┌──────────┼──────────┐
        ▼          ▼          ▼
      BUILD       TEST      DEPLOY
        │          │          │
     Solidity   TS/Solidity  Ignition
        │          │          │
        └──────────┼──────────┘
                   ▼
                DEBUG
                   │
                   ▼
                NETWORK
                   │
                   ▼
                VERIFY
                   │
                   ▼
               FRONTEND
```

> 🚀 **If you can explain this entire flow, create a Hardhat project, write a Solidity contract, compile it, test it, debug it, deploy it with Ignition, configure a testnet, and connect the deployed contract to a React frontend, you have the core Hardhat knowledge expected of a Solidity/Blockchain developer.**

---

# 📚 102. Official Documentation

For current Hardhat 3 documentation, use the official Hardhat documentation because commands, configuration, plugins, and APIs can change between major versions. Hardhat's current site identifies Hardhat 3 as the current major release and provides the latest guides and references. :contentReference[oaicite:13]{index=13}

Official Hardhat:

https://hardhat.org/

Hardhat 3 documentation:

https://hardhat.org/docs

Legacy Hardhat 2 documentation:

https://v2.hardhat.org/

> ⚠️ **Interview tip:** If an interviewer asks about Hardhat, mention the version you have actually used. This avoids confusion when your code or configuration differs from an older Hardhat tutorial.
