# ⟠ Ethereum --- Complete Developer Cheat Sheet

> 🎯 **Goal:** Build a complete revision map of Ethereum for
> Blockchain/Solidity/Web3 interviews and day-to-day development.
>
> 📚 **Primary source:** Ethereum.org Developer Documentation ---
> foundational topics, Ethereum stack, smart contracts, EVM,
> transactions, gas, nodes, networks, consensus, APIs, storage,
> security, and development workflows.
>
> ⚠️ Ethereum evolves continuously. Use the official documentation for
> version-sensitive details and exact APIs.

------------------------------------------------------------------------

# 📚 Table of Contents

1.  [What is Ethereum?](#-1-what-is-ethereum)
2.  [Ethereum Mental Model](#-2-ethereum-mental-model)
3.  [Ether and ETH](#-3-ether-and-eth)
4.  [Ethereum State](#-4-ethereum-state)
5.  [Accounts](#-5-accounts)
6.  [EOA vs Contract Account](#-6-eoa-vs-contract-account)
7.  [Addresses and Keys](#-7-addresses-and-keys)
8.  [Transactions](#-8-transactions)
9.  [Transaction Fields](#-9-transaction-fields)
10. [Transaction Lifecycle](#-10-transaction-lifecycle)
11. [Blocks](#-11-blocks)
12. [EVM](#-12-evm)
13. [EVM Stack, Memory, Storage](#-13-evm-stack-memory-storage)
14. [Opcodes](#-14-opcodes)
15. [Gas](#-15-gas)
16. [EIP-1559 Fee Model](#-16-eip-1559-fee-model)
17. [Smart Contracts](#-17-smart-contracts)
18. [Smart Contract Lifecycle](#-18-smart-contract-lifecycle)
19. [Solidity](#-19-solidity)
20. [ABI and Bytecode](#-20-abi-and-bytecode)
21. [Contract Calls](#-21-contract-calls)
22. [Events and Logs](#-22-events-and-logs)
23. [Composability](#-23-composability)
24. [Oracles](#-24-oracles)
25. [Dapps](#-25-dapps)
26. [Ethereum Stack](#-26-ethereum-stack)
27. [Client Architecture](#-27-client-architecture)
28. [Nodes](#-28-nodes)
29. [Execution and Consensus
    Layers](#-29-execution-and-consensus-layers)
30. [Consensus and Proof of Stake](#-30-consensus-and-proof-of-stake)
31. [Validators](#-31-validators)
32. [Finality](#-32-finality)
33. [Networking](#-33-networking)
34. [Networks](#-34-networks)
35. [Mainnet vs Testnets](#-35-mainnet-vs-testnets)
36. [JSON-RPC](#-36-json-rpc)
37. [JavaScript APIs](#-37-javascript-apis)
38. [Backend APIs](#-38-backend-apis)
39. [Wallets and Authentication](#-39-wallets-and-authentication)
40. [Message Signing](#-40-message-signing)
41. [Storage](#-41-storage)
42. [Block Explorers](#-42-block-explorers)
43. [Development Environments](#-43-development-environments)
44. [Development Frameworks](#-44-development-frameworks)
45. [Testing](#-45-testing)
46. [Compiling](#-46-compiling)
47. [Deploying](#-47-deploying)
48. [Verifying](#-48-verifying)
49. [Upgrading](#-49-upgrading)
50. [Security](#-50-security)
51. [Formal Verification](#-51-formal-verification)
52. [Ethereum Data Model](#-52-ethereum-data-model)
53. [Merkle Patricia Trie](#-53-merkle-patricia-trie)
54. [Cryptography](#-54-cryptography)
55. [Tokens](#-55-tokens)
56. [ERC Standards](#-56-erc-standards)
57. [Layer 2](#-57-layer-2)
58. [Rollups Mental Model](#-58-rollups-mental-model)
59. [Developer Workflow](#-59-developer-workflow)
60. [Project Architecture](#-60-project-architecture)
61. [Common Commands](#-61-common-commands)
62. [Interview Questions](#-62-interview-questions)
63. [60-Second Revision](#-63-60-second-revision)
64. [Golden Rules](#-64-golden-rules)

------------------------------------------------------------------------

# ⟠ 1. What is Ethereum?

Ethereum is a decentralized blockchain network and programmable
platform.

Unlike a blockchain designed only for transferring value, Ethereum
provides a general-purpose execution environment where programs called
**smart contracts** can run.

### Simple definition

> **Ethereum = decentralized network + shared state + EVM + smart
> contracts + ETH + consensus.**

Ethereum documentation describes the network as a collection of nodes
communicating and maintaining a shared state. Smart contracts are
reusable programs published into EVM state and executed when requested.

------------------------------------------------------------------------

# 🧒 Explain Like I'm 10

Imagine a giant public computer:

``` text
          🌍 Ethereum Network
                  │
        ┌─────────┼─────────┐
        ▼         ▼         ▼
      Node      Node       Node
        │         │         │
        └─────────┼─────────┘
                  ▼
                 EVM
                  │
          ┌───────┼────────┐
          ▼       ▼        ▼
       Contract  Token    Game
```

Nobody owns the whole computer.

Thousands of computers agree on its state and execute the same rules.

------------------------------------------------------------------------

# 🧠 2. Ethereum Mental Model

``` text
Ethereum
   │
   ├── Accounts
   │
   ├── Transactions
   │
   ├── Blocks
   │
   ├── EVM
   │
   ├── Smart Contracts
   │
   ├── ETH + Gas
   │
   ├── Nodes
   │
   ├── Consensus
   │
   └── Networks
```

Application layer:

``` text
Dapp
 │
 ├── Frontend
 ├── Wallet
 ├── RPC/API
 └── Smart Contracts
```

------------------------------------------------------------------------

# 💎 3. Ether and ETH

**Ether (ETH)** is Ethereum's native asset.

ETH is used for:

-   Paying transaction fees
-   Paying for computation
-   Staking
-   Transferring value
-   Interacting with smart contracts

### Units

``` text
1 ETH = 10^18 wei
1 gwei = 10^9 wei
1 gwei = 10^-9 ETH
```

``` text
ETH
 │
 ├── Ether
 ├── Gwei
 └── Wei
```

### Remember

> **ETH is the asset. Gas measures computation.**

------------------------------------------------------------------------

# 🌐 4. Ethereum State

Ethereum can be understood as a **state machine**.

The state contains information such as:

``` text
Accounts
Balances
Contract code
Contract storage
```

A transaction causes a state transition:

``` text
Old State
   +
Valid Transactions
   ↓
EVM Execution
   ↓
New State
```

Conceptually:

``` text
Y(S, T) = S'
```

where:

-   `S` = old valid state
-   `T` = valid transactions
-   `S'` = resulting state

------------------------------------------------------------------------

# 👤 5. Accounts

An Ethereum account is an entity that can hold ETH and interact with the
network.

Two major account categories:

``` text
Account
 │
 ├── EOA
 │
 └── Contract Account
```

------------------------------------------------------------------------

# 👤 6. EOA vs Contract Account

  Feature                  EOA           Contract Account
  ------------------------ ------------- ------------------
  Controlled by            Private key   Contract code
  Has address              ✅            ✅
  Can hold ETH             ✅            ✅
  Has code                 ❌            ✅
  Initiates transactions   ✅            ❌ directly
  Runs code                ❌            ✅ when called

### EOA

Externally Owned Account.

Example:

``` text
User
 ↓
Private Key
 ↓
EOA
 ↓
Transaction
```

### Contract Account

``` text
Smart Contract
 ↓
Code + State
 ↓
Contract Address
```

------------------------------------------------------------------------

# 🔑 7. Addresses and Keys

An Ethereum wallet normally involves:

``` text
Private Key
     ↓
Public Key
     ↓
Address
```

### Private key

Used to sign transactions/messages.

### Public key

Derived from the private key.

### Address

Used to identify the account/contract on Ethereum.

> 🔐 **Private key = secret. Address = public.**

Never share:

``` text
Private key
Seed phrase
Wallet recovery phrase
```

------------------------------------------------------------------------

# 🧾 8. Transactions

A transaction is a cryptographically signed instruction from an account
that can change Ethereum state.

Examples:

``` text
Send ETH
Deploy contract
Call contract
Transfer token
```

### Transaction flow

``` text
User
 ↓
Wallet
 ↓
Sign
 ↓
RPC / Node
 ↓
Transaction Pool
 ↓
Validator
 ↓
Block
 ↓
State Change
```

------------------------------------------------------------------------

# 📋 9. Transaction Fields

Common transaction information includes:

``` text
from
to
nonce
value
input data
gasLimit
maxFeePerGas
maxPriorityFeePerGas
signature
```

### `from`

Sender address.

### `to`

Recipient address.

For contract creation, the transaction has no normal `to` recipient.

### `nonce`

Sequential transaction counter for the sender.

### `value`

ETH transferred.

``` text
value → wei
```

### `data`

Input/calldata for contract interaction or contract creation.

### `gasLimit`

Maximum gas units allowed.

### `maxFeePerGas`

Maximum total fee per gas unit the sender is willing to pay.

### `maxPriorityFeePerGas`

Maximum validator tip per gas unit.

------------------------------------------------------------------------

# 🔄 10. Transaction Lifecycle

``` text
1. Create transaction
        ↓
2. Sign transaction
        ↓
3. Broadcast
        ↓
4. Transaction pool
        ↓
5. Validator includes it
        ↓
6. EVM executes
        ↓
7. Block is included
        ↓
8. State changes
        ↓
9. Block becomes justified/finalized
```

### Transaction hash

A transaction gets a cryptographic identifier:

``` text
0x...
```

Use it to inspect the transaction in a block explorer.

------------------------------------------------------------------------

# 🧱 11. Blocks

A block is a batch of transactions plus blockchain/protocol information.

Conceptually:

``` text
Block
 │
 ├── Block metadata
 ├── Transactions
 ├── State-related commitments
 └── Consensus information
```

### Why blocks?

Instead of agreeing on every transaction independently:

``` text
Transactions
 ↓
Block
 ↓
Network agreement
```

------------------------------------------------------------------------

# ⚙️ 12. EVM

EVM = **Ethereum Virtual Machine**

It is the execution environment for Ethereum smart contracts.

Ethereum's EVM documentation describes it as a decentralized virtual
environment that executes code consistently across Ethereum nodes.

------------------------------------------------------------------------

# 🧠 EVM as a State Machine

``` text
Input
  ↓
EVM
  ↓
Deterministic Execution
  ↓
Output + State Changes
```

If every honest node executes the same valid transaction under the same
state:

``` text
Same Input
    ↓
Same Rules
    ↓
Same Result
```

This deterministic execution is essential for consensus.

------------------------------------------------------------------------

# 🧮 13. EVM Stack, Memory, Storage

The EVM is a stack machine.

### Stack

-   Temporary execution structure
-   256-bit words
-   Maximum depth of 1024 items

### Memory

``` text
Temporary
Transaction execution
Not persistent
```

### Storage

``` text
Persistent
Contract-specific
Part of Ethereum state
```

### Transient storage

Modern EVM also has transient storage accessed through:

``` text
TSTORE
TLOAD
```

It lasts across internal calls within a transaction and is cleared at
the end of that transaction.

------------------------------------------------------------------------

# 🧠 Memory vs Storage vs Transient Storage

  -----------------------------------------------------------------------
  Feature           Memory            Storage           Transient Storage
  ----------------- ----------------- ----------------- -----------------
  Persistent?       ❌                ✅                ❌

  Scope             Execution         Contract state    Transaction

  Expensive?        Relatively        Usually expensive Designed for
                                                        temporary state

  Example           Temporary arrays  Balances          Temporary
                                                        cross-call data
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 🔢 14. Opcodes

Solidity is compiled into bytecode.

Bytecode is executed using EVM opcodes.

Examples:

``` text
ADD
SUB
MUL
DIV
AND
OR
XOR
SLOAD
SSTORE
CALL
RETURN
REVERT
LOG
```

Concept:

``` text
Solidity
   ↓
Compiler
   ↓
Bytecode
   ↓
Opcodes
   ↓
EVM
```

------------------------------------------------------------------------

# ⛽ 15. Gas

Gas measures computational work.

Every operation has a gas cost.

Why gas exists:

``` text
Prevent spam
Prevent infinite computation
Allocate computational resources
Price execution
```

### Basic relationship

``` text
Transaction Fee
≈
Gas Used × Effective Gas Price
```

Gas is paid in ETH.

------------------------------------------------------------------------

# 💰 16. EIP-1559 Fee Model

Modern Ethereum transactions commonly use:

``` text
Base Fee
+
Priority Fee
```

### Base fee

Protocol-determined component.

The base fee is burned.

### Priority fee

Tip offered to the validator.

### Concept

``` text
Total gas price
      │
      ├── Base Fee → Burned
      │
      └── Priority Fee → Validator
```

A simplified formula:

``` text
Effective Gas Price
=
Base Fee
+
Priority Fee
```

subject to the transaction's maximum fee constraints.

------------------------------------------------------------------------

# 🔥 Example

Suppose:

``` text
Gas Used = 21,000
Base Fee = 20 gwei
Priority Fee = 2 gwei
```

Then:

``` text
Effective price ≈ 22 gwei
```

and:

``` text
Fee ≈ 21,000 × 22 gwei
```

------------------------------------------------------------------------

# 🧠 17. Smart Contracts

A smart contract is a program deployed to the Ethereum blockchain.

It contains:

``` text
Code
+
State
```

Example:

``` solidity
contract Counter {

    uint256 public count;

    function increment() public {
        count++;
    }
}
```

------------------------------------------------------------------------

# 🔨 18. Smart Contract Lifecycle

``` text
Write
 ↓
Compile
 ↓
Bytecode
 ↓
Deploy Transaction
 ↓
Contract Address
 ↓
Interact
```

------------------------------------------------------------------------

# 📦 Contract Deployment

Deployment is a transaction containing compiled contract creation code
without specifying a normal recipient.

``` text
Solidity
 ↓
Compiler
 ↓
Bytecode
 ↓
Deployment Transaction
 ↓
EVM
 ↓
Contract Account
 ↓
Contract Address
```

Deployment requires ETH for gas.

------------------------------------------------------------------------

# 🧑‍💻 19. Solidity

Solidity is a programming language used to write Ethereum smart
contracts.

Other smart-contract languages exist, including:

``` text
Solidity
Vyper
```

Solidity code must be compiled before EVM execution.

------------------------------------------------------------------------

# 📝 Basic Solidity

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloEthereum {

    string public message;

    constructor(string memory _message) {
        message = _message;
    }

    function setMessage(string memory _message) public {
        message = _message;
    }
}
```

------------------------------------------------------------------------

# 📦 20. ABI and Bytecode

## ABI

Application Binary Interface.

Describes how external applications interact with contract
functions/events.

``` text
Frontend
 ↓
ABI
 ↓
Contract
```

## Bytecode

Machine-level code executed by the EVM.

``` text
Solidity
 ↓
Compiler
 ↓
Bytecode
 ↓
EVM
```

------------------------------------------------------------------------

# 🔌 21. Contract Calls

Two broad categories:

``` text
Read
Write
```

### Read

Functions that don't change state can often be called through `eth_call`
without paying a transaction gas fee from an EOA.

``` text
view
pure
```

### Write

State-changing interaction:

``` text
Wallet
 ↓
Sign
 ↓
Transaction
 ↓
Gas
 ↓
Contract
```

------------------------------------------------------------------------

# 📡 22. Events and Logs

Smart contracts can emit events.

``` solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint256 amount
);
```

Emit:

``` solidity
emit Transfer(msg.sender, recipient, amount);
```

Events create logs that applications can monitor.

``` text
Contract
   ↓
Event
   ↓
Log
   ↓
RPC / Indexer
   ↓
Frontend
```

------------------------------------------------------------------------

# 🧩 23. Composability

Ethereum smart contracts are public and can interact with other smart
contracts.

Example:

``` text
Your Dapp
   ↓
Token Contract
   ↓
DEX Contract
   ↓
Oracle Contract
```

This is called **composability**.

### Remember

> **Smart contracts behave like public APIs on-chain.**

------------------------------------------------------------------------

# 🌐 24. Oracles

Smart contracts cannot directly retrieve arbitrary real-world
information.

Example:

``` text
Smart Contract
      ❌
      ↓
Internet weather API
```

Instead:

``` text
Off-chain Data
      ↓
Oracle
      ↓
Blockchain
      ↓
Smart Contract
```

Oracles provide external data to blockchain applications.

------------------------------------------------------------------------

# 🧑‍💻 25. Dapps

Dapp = decentralized application.

Typical architecture:

``` text
                DAPP
                 │
       ┌─────────┴─────────┐
       ▼                   ▼
   Frontend             Backend
       │
       ▼
    Wallet
       │
       ▼
  Ethereum RPC
       │
       ▼
 Smart Contracts
```

A dapp can include:

``` text
React
Next.js
JavaScript
TypeScript
Wallet
RPC
Smart Contracts
Decentralized Storage
Indexing
```

------------------------------------------------------------------------

# 🏗️ 26. Ethereum Stack

A useful mental model:

``` text
Application
     │
     ▼
Dapps / Wallets / Interfaces
     │
     ▼
Smart Contracts
     │
     ▼
EVM
     │
     ▼
Ethereum Protocol
     │
     ▼
Execution + Consensus Clients
     │
     ▼
Network
```

The exact stack varies by project.

------------------------------------------------------------------------

# 🖥️ 27. Client Architecture

After Ethereum's transition to Proof of Stake, a full Ethereum node uses
two clients:

``` text
              Ethereum Node
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
 Execution Client        Consensus Client
          │                   │
          ▼                   ▼
   EVM / transactions      Consensus
```

### Execution layer

Handles:

``` text
Transactions
EVM execution
State
Execution payloads
```

### Consensus layer

Handles:

``` text
Proof of Stake
Validators
Attestations
Fork choice
Finality
```

------------------------------------------------------------------------

# 🖥️ 28. Nodes

A node is a computer running Ethereum client software.

Nodes help:

``` text
Verify transactions
Verify blocks
Maintain state
Participate in network
Provide RPC access
```

------------------------------------------------------------------------

# 🧰 Node Types / Concepts

Common concepts include:

``` text
Full node
Archive node
Light client
Bootnode
Node as a service
```

### Full node

Maintains enough information to independently verify the chain.

### Archive node

Maintains historical state information useful for deep historical
queries.

### Light client

Uses less local data and relies on proofs/network information.

------------------------------------------------------------------------

# ⚖️ 29. Execution and Consensus Layers

Ethereum is separated into two major client layers.

``` text
                 Ethereum
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
     Execution Layer      Consensus Layer
          │                   │
          ▼                   ▼
         EVM                  PoS
          │                   │
      Transactions          Validators
      Smart Contracts       Attestations
      State                 Finality
```

------------------------------------------------------------------------

# 🛡️ 30. Consensus and Proof of Stake

Ethereum uses a Proof-of-Stake-based consensus mechanism.

Ethereum documentation describes **Gasper** as combining:

``` text
Casper FFG
+
GHOST fork-choice
```

The system uses economic incentives and penalties to encourage honest
validator behavior.

------------------------------------------------------------------------

# 🧑‍⚖️ 31. Validators

Validators participate in Proof of Stake.

They are involved in:

``` text
Block proposals
Attestations
Consensus
Fork choice
Finality
```

Conceptually:

``` text
Validator
    │
    ├── Propose
    ├── Attest
    └── Participate in consensus
```

------------------------------------------------------------------------

# ✅ 32. Finality

A block can progress through stages of increasing confidence.

Simplified:

``` text
Proposed
   ↓
Included
   ↓
Justified
   ↓
Finalized
```

A finalized block is extremely difficult to reverse without a severe
network-level attack.

------------------------------------------------------------------------

# 🌐 33. Networking

Ethereum is a distributed peer-to-peer network.

Concept:

``` text
Node ←→ Node ←→ Node
 │       │       │
 └───────┼───────┘
         ▼
   Shared Network
```

Nodes communicate:

``` text
Transactions
Blocks
Consensus information
Network metadata
```

------------------------------------------------------------------------

# 🌍 34. Networks

Ethereum has multiple networks.

``` text
Ethereum Mainnet
       │
       ├── Test Networks
       │
       └── Development Networks
```

Developers use test/development environments before mainnet.

------------------------------------------------------------------------

# 🧪 35. Mainnet vs Testnets

  Feature       Mainnet   Testnet
  ------------- --------- ------------------
  Real ETH      ✅        Usually test ETH
  Real value    ✅        ❌
  Production    ✅        ❌
  Development   Limited   ✅
  Risk          High      Lower

------------------------------------------------------------------------

# 🧪 Development Networks

Used for:

``` text
Local development
Testing
Debugging
Integration testing
```

Examples:

``` text
Hardhat
Anvil
Ganache
```

------------------------------------------------------------------------

# 🔌 36. JSON-RPC

JSON-RPC is a standard way for applications to communicate with Ethereum
nodes.

Concept:

``` text
Frontend / Backend
        │
        ▼
     JSON-RPC
        │
        ▼
       Node
        │
        ▼
    Ethereum
```

Common RPC methods include:

``` text
eth_call
eth_sendRawTransaction
eth_getBalance
eth_getBlockByNumber
eth_getTransactionByHash
eth_getTransactionReceipt
```

------------------------------------------------------------------------

# 📡 `eth_call`

Used for executing a contract call without submitting a state-changing
transaction.

Common use:

``` text
Read contract state
```

------------------------------------------------------------------------

# 💸 `eth_sendRawTransaction`

Used to submit a signed transaction to a node.

------------------------------------------------------------------------

# 💰 `eth_getBalance`

Gets an account's ETH balance.

------------------------------------------------------------------------

# 🔎 37. JavaScript APIs

Applications commonly use Ethereum client libraries.

Examples:

``` text
ethers.js
viem
web3.js
```

Concept:

``` text
JavaScript / TypeScript
        ↓
Ethereum Library
        ↓
RPC
        ↓
Ethereum
```

------------------------------------------------------------------------

# 🖥️ 38. Backend APIs

Backends can interact with Ethereum using:

``` text
JSON-RPC
Ethereum libraries
Node providers
Indexing services
```

Use cases:

``` text
Read blockchain
Monitor events
Submit transactions
Build APIs
Index application data
```

------------------------------------------------------------------------

# 🔐 39. Wallets and Authentication

Ethereum wallets manage keys and help users interact with dapps.

Typical flow:

``` text
Dapp
 ↓
Connect Wallet
 ↓
User approves
 ↓
Wallet signs
 ↓
RPC
 ↓
Ethereum
```

Wallets may support:

``` text
Account management
Transaction signing
Message signing
Network switching
Dapp connection
```

------------------------------------------------------------------------

# ✍️ 40. Message Signing

Users can sign messages without necessarily submitting a blockchain
transaction.

Concept:

``` text
Message
   ↓
Wallet
   ↓
Private Key Signature
   ↓
Backend / Dapp
   ↓
Verify signer
```

Useful for:

``` text
Authentication
Off-chain approvals
SIWE-style authentication
Proof of wallet ownership
```

------------------------------------------------------------------------

# 💾 41. Storage

Ethereum storage can be divided conceptually into:

``` text
On-chain
Off-chain
Decentralized off-chain
```

### On-chain

Good for:

``` text
Critical state
Balances
Ownership
Contract configuration
```

But blockchain storage is expensive.

### Off-chain

Useful for:

``` text
Large files
Images
Metadata
Documents
```

Common decentralized storage technologies include:

``` text
IPFS
Arweave
```

------------------------------------------------------------------------

# 🔎 42. Block Explorers

A block explorer provides a human-readable view of blockchain data.

Examples of information:

``` text
Blocks
Transactions
Addresses
Contracts
Tokens
Events
Gas
```

Concept:

``` text
Blockchain
    ↓
Indexer / Explorer
    ↓
Human-readable UI
```

------------------------------------------------------------------------

# 🛠️ 43. Development Environments

Common Ethereum development environments/tools:

``` text
Remix
Hardhat
Foundry
Anvil
```

### Remix

Browser-based IDE.

### Hardhat

JavaScript/TypeScript-oriented development environment.

### Foundry

Rust-based Ethereum development toolkit with strong Solidity tooling.

### Anvil

Local Ethereum node commonly used with Foundry.

------------------------------------------------------------------------

# 🧪 44. Testing

Smart-contract testing should cover:

``` text
Happy paths
Failure paths
Access control
Events
State transitions
Edge cases
Security assumptions
Gas-sensitive behavior
Integration
```

Testing levels:

``` text
Unit
 ↓
Integration
 ↓
Fork
 ↓
Fuzz
 ↓
Security
```

------------------------------------------------------------------------

# ⚙️ 45. Compiling

Compilation flow:

``` text
Solidity
   ↓
Solidity Compiler
   ↓
Bytecode
   +
ABI
   ↓
Deployment / Interaction
```

Compiler checks:

``` text
Syntax
Types
Semantics
```

The compiler converts Solidity into EVM-compatible bytecode.

------------------------------------------------------------------------

# 🚀 46. Deploying

Requirements:

``` text
Compiled bytecode
+
ETH for gas
+
Wallet/account
+
Network
```

Flow:

``` text
Contract
 ↓
Compile
 ↓
Bytecode
 ↓
Deployment transaction
 ↓
Validator
 ↓
EVM
 ↓
Contract address
```

------------------------------------------------------------------------

# 🔍 47. Verifying

Contract verification publishes source-code/build information so users
can inspect the deployed contract and compare it with its on-chain
bytecode.

Typical requirements:

``` text
Correct source
Correct compiler
Correct optimizer settings
Correct constructor arguments
Correct network
```

------------------------------------------------------------------------

# ♻️ 48. Upgrading

Smart contracts are normally immutable after deployment.

If upgradeability is needed, developers use architectural patterns such
as:

``` text
Proxy
+
Implementation
```

Concept:

``` text
User
 ↓
Proxy
 ↓
Implementation
```

Common upgrade patterns:

``` text
Transparent Proxy
UUPS
Beacon
Diamond
```

> ⚠️ Upgradeability adds complexity and governance/security
> considerations.

------------------------------------------------------------------------

# 🛡️ 49. Security

Smart-contract security is critical because deployed contracts can hold
valuable assets and interactions are generally irreversible.

Major risks include:

``` text
Reentrancy
Access-control bugs
Oracle manipulation
Flash-loan-assisted attacks
Integer/accounting bugs
Signature replay
Unsafe external calls
Denial of service
Front-running / MEV
Logic errors
```

------------------------------------------------------------------------

# 🔐 Security Checklist

``` text
☐ Validate inputs
☐ Check access control
☐ Follow checks-effects-interactions
☐ Protect external calls
☐ Use safe arithmetic
☐ Validate token transfers
☐ Handle ETH correctly
☐ Test failure paths
☐ Review oracle assumptions
☐ Avoid unnecessary trust
☐ Test edge cases
☐ Consider upgrade/admin risks
```

------------------------------------------------------------------------

# 🧮 50. Formal Verification

Formal verification uses mathematical methods to prove properties of
software.

Instead of only asking:

``` text
"Did my tests pass?"
```

you can ask:

``` text
"Can I prove this property always holds under defined assumptions?"
```

Useful for high-assurance smart contracts.

------------------------------------------------------------------------

# 📐 51. Ethereum Data Model

Important pieces:

``` text
State
Accounts
Contract Storage
Transactions
Blocks
Receipts
Logs
```

Relationship:

``` text
Transaction
    ↓
EVM execution
    ↓
State transition
    ↓
Receipt / logs
    ↓
Block
```

------------------------------------------------------------------------

# 🌳 52. Merkle Patricia Trie

Ethereum uses trie-based data structures to organize and
cryptographically commit state.

The Ethereum EVM documentation describes the state as a modified Merkle
Patricia Trie, with accounts linked by hashes and reducible to a root
hash.

Concept:

``` text
                    Root
                   /    \
                 Hash   Hash
                /         \
             Data         Data
```

Benefits:

``` text
Integrity
Efficient proofs
Compact commitments
State verification
```

------------------------------------------------------------------------

# 🔐 53. Cryptography

Ethereum uses cryptographic primitives for:

``` text
Hashing
Signatures
Address derivation
Data integrity
Authentication
```

Important concepts:

``` text
Keccak-256
ECDSA
secp256k1
Digital signatures
```

------------------------------------------------------------------------

# 🪙 54. Tokens

Tokens are generally implemented through smart contracts.

Common categories:

``` text
Fungible
Non-fungible
Multi-token
```

------------------------------------------------------------------------

# 🪙 ERC-20

Fungible token standard.

Typical functions:

``` solidity
totalSupply()
balanceOf()
transfer()
allowance()
approve()
transferFrom()
```

Typical events:

``` solidity
Transfer
Approval
```

------------------------------------------------------------------------

# 🖼️ ERC-721

NFT standard.

Typical concepts:

``` text
tokenId
owner
transfer
approval
metadata
```

------------------------------------------------------------------------

# 🎨 ERC-1155

Multi-token standard supporting multiple token types within one
contract.

Useful for:

``` text
Gaming
Collections
Fungible + NFT-style assets
Batch operations
```

------------------------------------------------------------------------

# 📚 55. ERC Standards

ERC = Ethereum Request for Comments.

Standards help applications and contracts interoperate.

Examples:

``` text
ERC-20
ERC-721
ERC-1155
ERC-4626
```

------------------------------------------------------------------------

# ⚡ 56. Layer 2

Layer 2 networks execute transactions with Ethereum as a base-layer
security/settlement environment.

Concept:

``` text
Ethereum Layer 1
        │
        ▼
      Layer 2
        │
        ▼
Higher throughput / lower cost
```

Common L2 designs include rollups.

------------------------------------------------------------------------

# 📦 57. Rollups Mental Model

``` text
Users
  ↓
Layer 2
  ↓
Execute many transactions
  ↓
Batch / compress data
  ↓
Ethereum
  ↓
Settlement / security
```

Two major rollup categories:

``` text
Optimistic Rollups
ZK Rollups
```

------------------------------------------------------------------------

# 🧠 Optimistic Rollups

General idea:

``` text
Assume valid
     ↓
Post data/commitment
     ↓
Challenge incorrect results
```

------------------------------------------------------------------------

# 🧠 ZK Rollups

General idea:

``` text
Execute many transactions
        ↓
Generate proof
        ↓
Ethereum verifies proof
```

------------------------------------------------------------------------

# 🏗️ 58. Ethereum Developer Workflow

``` text
IDE
 ↓
Write Solidity
 ↓
Compile
 ↓
Unit Test
 ↓
Deploy Local
 ↓
Integration Test
 ↓
Fork Test
 ↓
Deploy Testnet
 ↓
Verify
 ↓
Frontend Integration
 ↓
Security Review
 ↓
Mainnet
```

------------------------------------------------------------------------

# 🧑‍💻 59. Professional Dapp Workflow

## Step 1 --- Design

``` text
Requirements
 ↓
Architecture
 ↓
Contract interfaces
 ↓
Storage model
```

## Step 2 --- Smart Contract

``` text
Solidity
 ↓
OpenZeppelin / libraries
 ↓
Tests
```

## Step 3 --- Tooling

``` text
Hardhat / Foundry
 ↓
Compile
 ↓
Test
 ↓
Deploy
```

## Step 4 --- Frontend

``` text
React / Next.js
 ↓
Wallet
 ↓
ethers / viem
 ↓
RPC
```

## Step 5 --- Production

``` text
Testnet
 ↓
Audit / review
 ↓
Verify
 ↓
Mainnet
```

------------------------------------------------------------------------

# 🏗️ 60. Project Architecture

A modern Ethereum project may look like:

``` text
my-dapp/
│
├── contracts/
│   ├── Token.sol
│   ├── Staking.sol
│   └── Marketplace.sol
│
├── test/
│
├── scripts/
│
├── ignition/
│   └── modules/
│
├── frontend/
│   ├── components/
│   ├── pages/
│   └── services/
│
├── deployments/
│
├── artifacts/
│
├── package.json
└── README.md
```

------------------------------------------------------------------------

# 🔌 Frontend Architecture

``` text
React
  │
  ▼
Wallet
  │
  ▼
Provider
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

------------------------------------------------------------------------

# 🧠 Read vs Write Dapp Flow

## Read

``` text
Frontend
 ↓
Provider / RPC
 ↓
eth_call
 ↓
Contract
 ↓
Result
```

## Write

``` text
Frontend
 ↓
Wallet
 ↓
Sign transaction
 ↓
RPC
 ↓
Validator
 ↓
Block
 ↓
Contract
 ↓
State change
```

------------------------------------------------------------------------

# 🧪 61. Common Commands

## Hardhat

``` bash
npx hardhat --version
npx hardhat compile
npx hardhat test
npx hardhat --help
```

## Foundry

``` bash
forge build
forge test
forge script
cast call
cast send
anvil
```

## Node/npm

``` bash
node --version
npm --version
npm install
npm run dev
```

> Exact commands vary by project and tool version.

------------------------------------------------------------------------

# 🧠 62. Interview Questions

## Q1. What is Ethereum?

> Ethereum is a decentralized programmable blockchain platform whose
> shared state is updated through transactions executed by the EVM and
> agreed upon through Proof-of-Stake consensus.

------------------------------------------------------------------------

## Q2. What is ETH?

> ETH is Ethereum's native asset, used for value transfer, transaction
> fees, and staking.

------------------------------------------------------------------------

## Q3. What is the EVM?

> The EVM is Ethereum's decentralized execution environment for smart
> contracts.

------------------------------------------------------------------------

## Q4. What is a smart contract?

> A smart contract is a program and associated state deployed at an
> Ethereum address and executed by the EVM.

------------------------------------------------------------------------

## Q5. EOA vs contract account?

> An EOA is controlled by a private key, while a contract account is
> controlled by code.

------------------------------------------------------------------------

## Q6. What is gas?

> Gas measures computational work required by EVM execution and is paid
> for in ETH.

------------------------------------------------------------------------

## Q7. Why does Ethereum need gas?

> To price computation and prevent abuse such as spam and unbounded
> execution.

------------------------------------------------------------------------

## Q8. What is `msg.sender`?

> The immediate caller of the current contract function.

------------------------------------------------------------------------

## Q9. What is `msg.value`?

> The amount of ETH sent with the current message call, denominated in
> wei.

------------------------------------------------------------------------

## Q10. What is `calldata`?

> Transaction input data supplied to a contract call.

------------------------------------------------------------------------

## Q11. What is an ABI?

> ABI defines how external applications encode calls to and decode
> responses/events from a smart contract.

------------------------------------------------------------------------

## Q12. What is bytecode?

> EVM-executable machine code produced by compiling a smart contract.

------------------------------------------------------------------------

## Q13. What is JSON-RPC?

> A protocol/interface through which applications communicate with
> Ethereum nodes.

------------------------------------------------------------------------

## Q14. What is an oracle?

> A mechanism that supplies external/off-chain information to smart
> contracts.

------------------------------------------------------------------------

## Q15. Why can't smart contracts directly access the internet?

> Deterministic blockchain execution cannot safely depend on arbitrary
> external data sources, so oracle mechanisms are used to bring external
> information on-chain.

------------------------------------------------------------------------

## Q16. What is Proof of Stake?

> Ethereum's consensus mechanism uses staked ETH, validators, rewards
> and penalties, and fork-choice/finality rules to maintain agreement on
> the chain.

------------------------------------------------------------------------

## Q17. What are the execution and consensus layers?

> The execution layer handles transactions/EVM/state execution; the
> consensus layer handles Proof-of-Stake consensus, validator duties,
> fork choice, and finality.

------------------------------------------------------------------------

## Q18. What is finality?

> A finalized block has strong economic/protocol guarantees against
> being reverted except under severe network-level conditions.

------------------------------------------------------------------------

## Q19. What is a block?

> A block batches transactions and protocol information into a unit
> accepted by the network.

------------------------------------------------------------------------

## Q20. What is composability?

> The ability of smart contracts and applications to interact with and
> build on other smart contracts.

------------------------------------------------------------------------

# 🧠 63. 60-Second Revision

  Topic              One-Line Summary
  ------------------ ------------------------------------------------
  ⟠ Ethereum         Programmable decentralized blockchain platform
  💎 ETH             Native Ethereum asset
  👤 Account         Entity holding state/balance
  👤 EOA             Account controlled by private key
  📜 Contract        Account containing executable code
  🧾 Transaction     Signed instruction that can change state
  🧱 Block           Batch of transactions/protocol data
  ⚙️ EVM             Ethereum execution environment
  ⛽ Gas             Unit measuring computational work
  🔐 ABI             Contract interaction interface
  📦 Bytecode        EVM-executable contract code
  📡 JSON-RPC        Node communication interface
  🖥️ Node            Software/computer participating in Ethereum
  ⚖️ Consensus       Agreement on blockchain state
  🛡️ PoS             Ethereum's consensus foundation
  🧑‍⚖️ Validator       Participant in PoS
  ✅ Finality        Strong confirmation of chain state
  📢 Event           Contract-emitted log for applications
  🌐 Oracle          Brings external data on-chain
  🧩 Composability   Contracts building/interacting with contracts
  💰 ERC-20          Fungible token standard
  🖼️ ERC-721         NFT standard
  🎨 ERC-1155        Multi-token standard
  ⚡ L2              Scaling layer built around Ethereum
  📦 Rollup          L2 technique that batches transactions

------------------------------------------------------------------------

# 🗺️ 64. Complete Ethereum Concept Flow

``` text
                         ETHEREUM
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
          Accounts      Transactions      Blocks
             │              │              │
             └──────────────┼──────────────┘
                            ▼
                           EVM
                            │
                ┌───────────┼───────────┐
                ▼           ▼           ▼
            Contracts      Gas        State
                │                       │
                ▼                       ▼
             Dapps                  Trie/State
                │
        ┌───────┼────────┐
        ▼       ▼        ▼
     Wallet    RPC    Frontend
        │       │        │
        └───────┼────────┘
                ▼
             Ethereum
                │
       ┌────────┴────────┐
       ▼                 ▼
 Execution Layer    Consensus Layer
       │                 │
       ▼                 ▼
      EVM                PoS
                         │
                         ▼
                     Validators
                         │
                         ▼
                       Finality
```

------------------------------------------------------------------------

# 🔥 65. Most Important Developer Concepts

If you are preparing for a **Solidity/Blockchain Developer interview**,
prioritize these:

## Level 1 --- MUST KNOW

``` text
Ethereum
ETH
Accounts
EOA
Contract Account
Transactions
Blocks
Gas
EVM
Smart Contracts
Solidity
ABI
Bytecode
RPC
Wallets
Events
```

## Level 2 --- STRONG KNOWLEDGE

``` text
Execution Layer
Consensus Layer
Proof of Stake
Validators
Finality
Nodes
JSON-RPC
Composability
Oracles
Storage
Merkle Patricia Trie
Contract Deployment
Verification
Testing
Security
```

## Level 3 --- ADVANCED

``` text
EVM Opcodes
EVM memory model
Transient storage
Client architecture
Fork choice
Formal verification
Layer 2
Rollups
MEV
Advanced gas optimization
Protocol-level Ethereum architecture
```

------------------------------------------------------------------------

# 🧠 66. Golden Rules

-   ⟠ **Ethereum is a programmable blockchain, not just a
    cryptocurrency.**
-   💎 **ETH is Ethereum's native asset.**
-   👤 **EOAs are controlled by private keys.**
-   📜 **Contract accounts are controlled by code.**
-   🧾 **Transactions are signed instructions that can change Ethereum
    state.**
-   ⚙️ **The EVM executes smart-contract code deterministically.**
-   ⛽ **Gas measures computational work.**
-   🔥 **Modern Ethereum uses a base-fee + priority-fee model; the base
    fee is burned.**
-   🧱 **Blocks batch transactions and protocol information.**
-   🖥️ **Nodes run Ethereum clients and verify/participate in the
    network.**
-   ⚙️ **Execution clients execute transactions and maintain execution
    state.**
-   🛡️ **Consensus clients participate in Proof-of-Stake consensus.**
-   🧑‍⚖️ **Validators participate in block proposals, attestations and
    consensus.**
-   ✅ **Finality gives strong guarantees that finalized state will not
    normally revert.**
-   📡 **JSON-RPC is a key interface between applications and nodes.**
-   🔐 **Private keys must remain secret.**
-   📦 **ABI describes contract interaction; bytecode is executed by the
    EVM.**
-   🧩 **Smart-contract composability is one of Ethereum's major
    strengths.**
-   🌐 **Oracles connect smart contracts with external information.**
-   🛡️ **Smart-contract security must be designed before deployment.**
-   ⚡ **Layer 2 networks scale Ethereum by moving much execution away
    from L1 while using Ethereum for settlement/security depending on
    the design.**

------------------------------------------------------------------------

# 🎯 67. Ultimate Ethereum Developer Memory Line

> **ACCOUNT → SIGN → TRANSACTION → GAS → EVM → STATE CHANGE → BLOCK →
> CONSENSUS → FINALITY**

For Dapp development:

> **FRONTEND → WALLET → RPC → SMART CONTRACT → EVM → ETHEREUM**

For smart-contract development:

> **SOLIDITY → COMPILE → ABI + BYTECODE → DEPLOY → ADDRESS → INTERACT →
> VERIFY**

For production:

> **DESIGN → CODE → TEST → SECURITY REVIEW → DEPLOY TESTNET → VERIFY →
> MAINNET → MONITOR**

------------------------------------------------------------------------

# 📚 Official Ethereum Developer Documentation

Primary documentation:

https://ethereum.org/developers/docs/

Developer portal:

https://ethereum.org/developers/

The Ethereum developer documentation covers foundational concepts, the
Ethereum stack, smart contracts, EVM, accounts, transactions, blocks,
gas, nodes/clients, networks, consensus, APIs, storage, development
environments, security, and related topics.

------------------------------------------------------------------------

# 🔗 Source Map

The cheat sheet is organized primarily around the official Ethereum.org
developer documentation:

-   Ethereum Developer Documentation
-   Technical Introduction to Ethereum
-   Accounts
-   Transactions
-   Blocks
-   EVM
-   Gas and Fees
-   Nodes and Clients
-   Networks
-   Consensus Mechanisms
-   Ethereum Stack
-   Smart Contracts
-   Compiling
-   Deploying
-   Testing
-   Verifying
-   Upgrading
-   Security
-   APIs
-   Authentication
-   Storage
-   Data and Analytics

> 📌 **Revision strategy:** Learn the Level 1 concepts first, then
> connect them using the flow diagrams. For interviews, be able to
> explain every arrow in
> `ACCOUNT → TRANSACTION → EVM → STATE → BLOCK → CONSENSUS → FINALITY`.
