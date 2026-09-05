# ⚗️ ALCHEMY --- COMPLETE REVISION NOTES

> A practical, interview-ready revision guide for building onchain
> applications with Alchemy.

**Source basis:** Official Alchemy documentation ---
https://www.alchemy.com/docs

------------------------------------------------------------------------

## Table of Contents

1.  What is Alchemy?
2.  Alchemy Mental Model
3.  Product Map
4.  Account, Apps and API Keys
5.  Chains and Networks
6.  JSON-RPC
7.  Ethereum Chain API
8.  Important RPC Methods
9.  Viem + Alchemy
10. Ethers.js + Alchemy
11. Data APIs
12. Portfolio API
13. Transfers API
14. Token API
15. NFT API
16. Prices API
17. Webhooks
18. WebSockets
19. Simulation API
20. Debug API
21. Trace API
22. Wallet APIs
23. Account Abstraction
24. Bundler API
25. Gas Manager
26. Transaction APIs
27. Smart Wallet Architecture
28. Alchemy + React
29. Alchemy + Next.js
30. Alchemy + RainbowKit
31. Alchemy + Wagmi + Viem
32. Alchemy + Solidity
33. Environment Variables
34. Frontend vs Backend
35. Polling vs Webhooks vs WebSockets
36. Production Architecture
37. Error Handling
38. Security
39. Common Mistakes
40. Debugging Checklist
41. Interview Questions
42. Coding Practice
43. Project Ideas
44. 30-Day Learning Plan
45. Final Cheat Sheet
46. 10x Mental Model
47. Mastery Checklist

------------------------------------------------------------------------

# 1. What is Alchemy?

Alchemy is blockchain infrastructure that lets applications interact
with supported blockchains through APIs and infrastructure services.

The current Alchemy documentation groups its offerings into major areas
including:

``` text
Chain APIs
Data APIs
Wallets
Build with AI
Tools & Resources
```

Simple definition:

> **Alchemy is an infrastructure/provider layer between your application
> and blockchain networks.**

Instead of maintaining your own blockchain nodes, your application can
use Alchemy endpoints and APIs.

------------------------------------------------------------------------

# 2. Alchemy Mental Model

``` text
                 YOUR APPLICATION
                       │
              ┌────────▼────────┐
              │     ALCHEMY     │
              └────────┬────────┘
                       │
       ┌───────────────┼────────────────┐
       │               │                │
       ▼               ▼                ▼
   Chain APIs       Data APIs        Wallet APIs
       │               │                │
       ▼               ▼                ▼
    JSON-RPC       Indexed Data     Smart Wallets
       │               │                │
       └───────────────┼────────────────┘
                       ▼
                Blockchain Networks
```

The key distinction:

``` text
Chain API
= low-level blockchain access

Data API
= indexed / structured data

Wallet API
= smart-wallet / account-abstraction infrastructure
```

------------------------------------------------------------------------

# 3. Product Map

## Chain APIs

Low-level access to standard JSON-RPC methods.

Use them for:

-   Reading blockchain state
-   Sending transactions
-   Querying blocks
-   Querying logs
-   Accessing chain information

Companion infrastructure includes:

-   WebSockets
-   Trace API
-   Debug API
-   Other chain-specific interfaces

## Data APIs

Structured and indexed blockchain data.

Current documentation highlights:

-   Portfolio API
-   Transfers API
-   Prices API
-   NFT API
-   Webhooks
-   Simulation API

## Wallet APIs

Smart-wallet and account-abstraction infrastructure:

-   Smart Wallets
-   Bundler API
-   Gas Manager
-   Transaction APIs

## Build with AI

The current docs also provide:

-   Agent Skills
-   MCP Server
-   Alchemy CLI
-   AI-oriented developer tooling

------------------------------------------------------------------------

# 4. Account, Apps and API Keys

Basic workflow:

``` text
Create Alchemy account
        ↓
Create/configure application
        ↓
Choose chain/network
        ↓
Get API key / endpoint
        ↓
Make API requests
```

An API key identifies your application when using Alchemy services.

Benefits of a dedicated API key can include:

-   Usage monitoring
-   Higher request throughput depending on plan
-   Increased concurrency depending on plan
-   Access to supported data APIs
-   Individualized usage metrics

Never confuse:

``` text
Alchemy API key
```

with:

``` text
wallet private key
```

An API key does not authorize a user transaction by itself.

------------------------------------------------------------------------

# 5. Chains and Networks

Alchemy supports many blockchain networks.

**Important:** exact chain coverage and feature availability can change.
Always verify the current Alchemy chain-support documentation before
building around a specific chain/API.

For Ethereum development, Alchemy's FAQ currently recommends:

``` text
Sepolia
```

as the testnet choice for getting started.

------------------------------------------------------------------------

# 6. JSON-RPC

Ethereum uses the JSON-RPC API standard.

JSON-RPC is a lightweight remote procedure call protocol.

Conceptually:

``` text
Application
    ↓
JSON-RPC request
    ↓
Alchemy endpoint
    ↓
Ethereum node
    ↓
Blockchain
```

Example request:

``` json
{
  "jsonrpc": "2.0",
  "method": "eth_blockNumber",
  "params": [],
  "id": 1
}
```

Example response:

``` json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x..."
}
```

Libraries such as Viem and Ethers abstract much of this low-level
protocol.

------------------------------------------------------------------------

# 7. Ethereum Chain API

Alchemy's Ethereum API provides standard Ethereum JSON-RPC methods.

Common methods include:

``` text
eth_blockNumber
eth_chainId
eth_getBalance
eth_getBlockByNumber
eth_getTransactionByHash
eth_getTransactionReceipt
eth_getTransactionCount
eth_call
eth_estimateGas
eth_gasPrice
eth_feeHistory
eth_getLogs
eth_sendRawTransaction
eth_getCode
```

------------------------------------------------------------------------

# 8. Important RPC Methods

## `eth_blockNumber`

Returns the latest block number.

``` text
eth_blockNumber
```

Useful for:

-   Current chain height
-   Synchronization
-   Monitoring

## `eth_chainId`

Returns the chain ID.

``` text
eth_chainId
```

Useful for network validation.

## `eth_getBalance`

Gets an account's native ETH balance.

Conceptually:

``` text
address
   ↓
eth_getBalance
   ↓
balance in wei
```

## `eth_getBlockByNumber`

Gets block information.

Useful for:

-   Explorers
-   Analytics
-   Monitoring

## `eth_getTransactionByHash`

Retrieves transaction information using a transaction hash.

## `eth_getTransactionReceipt`

Retrieves a transaction receipt.

A receipt can provide information such as:

-   Status
-   Block
-   Gas used
-   Logs

## `eth_call`

Performs a message call without submitting a state-changing transaction.

Commonly used for smart-contract reads.

## `eth_estimateGas`

Estimates gas required for a transaction.

## `eth_getLogs`

Queries contract/event logs.

## `eth_sendRawTransaction`

Broadcasts a signed raw transaction.

Remember:

``` text
sign
+
broadcast
```

are different operations.

------------------------------------------------------------------------

# 9. Viem + Alchemy

Alchemy works naturally with Viem.

``` tsx
import { createPublicClient, http } from 'viem'
import { mainnet } from 'viem/chains'

const client = createPublicClient({
  chain: mainnet,
  transport: http(
    'https://eth-mainnet.g.alchemy.com/v2/YOUR_ALCHEMY_API_KEY'
  ),
})

const blockNumber = await client.getBlockNumber()

console.log(blockNumber)
```

Get balance:

``` tsx
const balance = await client.getBalance({
  address: '0xab5801a7d398351b8be11c439e05c5b3259aec9b',
})

console.log(balance)
```

Read a block:

``` tsx
const block = await client.getBlock({
  blockNumber,
})
```

Get a transaction:

``` tsx
const tx = await client.getTransaction({
  hash: '0xYOUR_TX_HASH',
})
```

Get a receipt:

``` tsx
const receipt = await client.getTransactionReceipt({
  hash: '0xYOUR_TX_HASH',
})
```

Mental model:

``` text
Viem
 ↓
HTTP transport
 ↓
Alchemy
 ↓
Ethereum
```

------------------------------------------------------------------------

# 10. Ethers.js + Alchemy

Ethers.js can also connect to Alchemy through an RPC provider.

Architecture:

``` text
Ethers Provider
      ↓
Alchemy RPC
      ↓
Ethereum
```

The exact constructor/API depends on the Ethers major version installed.

Always check the documentation for your installed version.

------------------------------------------------------------------------

# 11. Data APIs

Data APIs provide higher-level indexed data that can be difficult to
construct efficiently from raw RPC calls alone.

Current categories include:

``` text
Portfolio
Transfers
Prices
NFT
Webhooks
Simulation
```

Think:

``` text
Raw RPC
   ↓
Low-level blockchain access

Data API
   ↓
Indexed / structured application data
```

------------------------------------------------------------------------

# 12. Portfolio API

Portfolio APIs are designed to provide a consolidated view of wallet
assets.

Conceptually:

``` text
Wallet
 ├── Native assets
 ├── Tokens
 └── NFTs
```

Use cases:

-   Wallet dashboards
-   Portfolio trackers
-   Asset overview
-   User account pages

------------------------------------------------------------------------

# 13. Transfers API

The Transfers API provides historical transfer/activity information for
addresses.

Useful for:

-   Wallet history
-   Explorer interfaces
-   Analytics
-   Activity feeds

Instead of manually scanning blocks and logs:

``` text
Address
  ↓
Transfers API
  ↓
Historical activity
```

------------------------------------------------------------------------

# 14. Token API

The Token API provides token-related information.

Important endpoints include:

``` text
alchemy_getTokenAllowance
alchemy_getTokenBalances
alchemy_getTokenMetadata
```

Token metadata can include:

``` text
name
symbol
decimals
logo
```

Conceptually:

``` text
Wallet
   ↓
Token API
   ↓
ERC-20 balances
```

------------------------------------------------------------------------

# 15. NFT API

Alchemy's NFT API provides indexed NFT functionality.

## Ownership endpoints

``` text
getNFTsForOwner
getOwnersForNFT
getOwnersForContract
getContractsForOwner
```

## Metadata endpoints

``` text
getNFTsForContract
getNFTMetadata
getNFTMetadataBatch
getContractMetadata
getContractMetadataBatch
refreshNftMetadata
```

## Spam endpoints

``` text
isSpamContract
reportSpam
```

## Sales endpoint

``` text
getFloorPrice
```

Exact chain/endpoint support should be checked in the current
documentation.

------------------------------------------------------------------------

# 16. Prices API

Prices API provides token price information.

Example application:

``` text
Wallet
  ↓
Token balances
  ↓
Token prices
  ↓
Portfolio valuation
```

Use cases:

-   Portfolio dashboards
-   Token dashboards
-   DeFi interfaces
-   Market analytics

------------------------------------------------------------------------

# 17. Webhooks

Alchemy Webhooks let Alchemy send HTTP POST requests to your server when
configured onchain activity occurs.

This is useful when you do not want to continuously poll the blockchain.

Flow:

``` text
Blockchain event
      ↓
Alchemy detects event
      ↓
Alchemy HTTP POST
      ↓
Your backend
      ↓
Database / notification / business logic
```

Current webhook categories include:

``` text
Custom
Address Activity
NFT Activity
```

Address Activity can track:

``` text
ETH
ERC-20
ERC-721
ERC-1155
```

## Webhook security

Use the security mechanisms documented by Alchemy, including signature
validation where applicable.

------------------------------------------------------------------------

# 18. WebSockets

WebSockets provide persistent connections for real-time subscriptions.

Useful subscriptions include:

``` text
pending transactions
logs
new blocks
```

Compare:

``` text
HTTP:
request → response

WebSocket:
persistent connection → event stream
```

Use WebSockets for live application experiences.

------------------------------------------------------------------------

# 19. Simulation API

Simulation lets developers preview the effects of transactions before
sending them.

Conceptual flow:

``` text
Transaction
     ↓
Simulation
     ↓
Expected effects
     ↓
User confirmation
     ↓
Real transaction
```

Useful for:

-   Transaction previews
-   DeFi UX
-   Detecting likely failures
-   Showing expected state changes

Simulation does not replace smart-contract auditing.

------------------------------------------------------------------------

# 20. Debug API

The Debug API provides non-standard RPC methods for deeper transaction
inspection and debugging.

Useful when:

``` text
Transaction failed
      ↓
Need deeper execution information
      ↓
Debug transaction
```

This is different from ordinary application error handling.

------------------------------------------------------------------------

# 21. Trace API

Trace APIs provide deeper information about transaction processing and
onchain activity.

Useful for:

-   Transaction debugging
-   Execution analysis
-   Complex contract interactions
-   Advanced analytics

Mental model:

``` text
Transaction
   ↓
Trace
   ↓
Deeper execution information
```

------------------------------------------------------------------------

# 22. Wallet APIs

Alchemy's Wallets section focuses on smart-wallet infrastructure.

Current documentation includes:

``` text
Smart Wallets
Bundler API
Gas Manager
Transaction APIs
```

These are particularly relevant to account abstraction.

------------------------------------------------------------------------

# 23. Account Abstraction

Traditional EOA flow:

``` text
EOA
 ↓
Sign transaction
 ↓
Pay gas
 ↓
Execute
```

Smart-account flow:

``` text
User
 ↓
Smart Account
 ↓
User Operation
 ↓
Bundler
 ↓
Account-abstraction infrastructure
 ↓
Blockchain
```

Potential benefits:

-   Gas sponsorship
-   Better onboarding
-   Batched actions
-   Programmable authorization
-   Improved UX

------------------------------------------------------------------------

# 24. Bundler API

A bundler handles user operations in account-abstraction workflows.

Conceptually:

``` text
User
  ↓
UserOperation
  ↓
Bundler
  ↓
EntryPoint / AA infrastructure
  ↓
Smart Account
  ↓
Blockchain
```

Use a bundler for smart-account workflows.

------------------------------------------------------------------------

# 25. Gas Manager

Gas Manager infrastructure enables applications to sponsor gas for
users.

Traditional:

``` text
User pays gas
```

Sponsored:

``` text
DApp / sponsor
      ↓
pays gas
      ↓
User transaction
```

This can enable:

``` text
User starts using the dApp
without first acquiring ETH for gas
```

Exact sponsorship behavior depends on product configuration and chain
support.

------------------------------------------------------------------------

# 26. Transaction APIs

Transaction APIs provide infrastructure for sending transactions with
smart accounts.

Conceptually:

``` text
Smart Account
      ↓
Transaction API
      ↓
Bundler / AA infrastructure
      ↓
Blockchain
```

This is distinct from broadcasting a normal signed EOA transaction with
`eth_sendRawTransaction`.

------------------------------------------------------------------------

# 27. Smart Wallet Architecture

Simplified architecture:

``` text
             USER
               │
               ▼
        ┌──────────────┐
        │  Your DApp   │
        └──────┬───────┘
               │
               ▼
         Smart Account
               │
               ▼
         User Operation
               │
               ▼
            Bundler
               │
               ▼
        Account Abstraction
               │
               ▼
          Blockchain
```

With gas sponsorship:

``` text
                  ┌─────────────┐
                  │ Gas Manager │
                  └──────┬──────┘
                         │
                         ▼
User → DApp → Smart Account → Bundler → Blockchain
```

------------------------------------------------------------------------

# 28. Alchemy + React

A common architecture:

``` text
React
 ↓
RainbowKit
 ↓
Wagmi
 ↓
Viem
 ↓
Alchemy
 ↓
Blockchain
```

Example:

``` tsx
const publicClient = createPublicClient({
  chain: sepolia,
  transport: http(
    'https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY'
  ),
})
```

Use the client for blockchain reads and other supported EVM operations.

------------------------------------------------------------------------

# 29. Alchemy + Next.js

Next.js applications can use Alchemy on either server or client
depending on the architecture.

A useful separation is:

``` text
Frontend
   ↓
Wallet
   ↓
Wagmi / Viem

Backend
   ↓
Alchemy
   ↓
RPC / Data APIs / Webhooks
```

Keep server-only secrets on the server.

------------------------------------------------------------------------

# 30. Alchemy + RainbowKit

A modern React dApp can use:

``` text
React
   ↓
RainbowKit
   ↓
Wagmi
   ↓
Viem
   ↓
Alchemy
   ↓
EVM blockchain
```

Responsibilities:

``` text
RainbowKit → wallet connection UI

Wagmi → React Web3 state/hooks

Viem → EVM interaction

Alchemy → RPC + indexed infrastructure
```

------------------------------------------------------------------------

# 31. Alchemy + Wagmi + Viem

Public client:

``` tsx
import { createPublicClient, http } from 'viem'
import { mainnet } from 'viem/chains'

const client = createPublicClient({
  chain: mainnet,
  transport: http(ALCHEMY_RPC_URL),
})
```

Conceptual contract read:

``` text
useReadContract
      ↓
Viem
      ↓
Alchemy
      ↓
eth_call
      ↓
Smart Contract
```

Conceptual contract write:

``` text
useWriteContract
      ↓
Wallet
      ↓
Signature
      ↓
Alchemy / RPC
      ↓
Blockchain
```

------------------------------------------------------------------------

# 32. Alchemy + Solidity

Alchemy does not replace Solidity.

Responsibilities:

``` text
Solidity
= onchain business logic

Alchemy
= blockchain infrastructure/API access

Viem/Wagmi
= application interaction

React
= UI
```

Complete stack:

``` text
React
 ↓
RainbowKit
 ↓
Wagmi
 ↓
Viem
 ↓
Alchemy
 ↓
Ethereum
 ↓
Solidity Contract
```

------------------------------------------------------------------------

# 33. Environment Variables

Example:

``` env
VITE_ALCHEMY_API_KEY=your_key
```

Then:

``` tsx
const apiKey = import.meta.env.VITE_ALCHEMY_API_KEY
```

For server-side code:

``` env
ALCHEMY_API_KEY=your_key
```

Important:

> A frontend environment variable is not automatically secret. If it is
> included in browser code, users can generally inspect it.

Never put these in frontend code:

``` text
private keys
database passwords
server credentials
signing secrets
```

------------------------------------------------------------------------

# 34. Frontend vs Backend

## Frontend

Good for:

``` text
Wallet connection
User interactions
Read-only blockchain data
Transaction requests
UI state
```

## Backend

Good for:

``` text
Webhooks
Database updates
Server-side indexing
Authentication
Notifications
Background jobs
Private application logic
API orchestration
```

Architecture:

``` text
              FRONTEND
                 │
        ┌────────┴────────┐
        │                 │
    RainbowKit         Viem/Wagmi
        │                 │
        ▼                 ▼
      Wallet           Alchemy
                          │
                          ▼
                     Blockchain

              BACKEND
                 │
             Alchemy
                 │
       ┌─────────┼─────────┐
       ▼         ▼         ▼
   Webhooks   Data APIs   RPC
       │
       ▼
    Database
```

------------------------------------------------------------------------

# 35. Polling vs Webhooks vs WebSockets

## Polling

``` text
Every N seconds:
"Did something happen?"
```

Pros:

-   Simple
-   Easy to implement

Cons:

-   Repeated requests
-   Latency
-   Potentially wasteful

## Webhooks

``` text
Event happens
    ↓
Alchemy
    ↓
Your server
```

Pros:

-   Event-driven
-   No constant polling
-   Excellent for backend processing

## WebSockets

``` text
Persistent connection
       ↓
Live event stream
```

Pros:

-   Real-time
-   Good for live dashboards
-   Event subscriptions

Rule of thumb:

``` text
Periodic/simple data
→ polling

Backend event processing
→ webhooks

Live subscriptions
→ WebSockets
```

------------------------------------------------------------------------

# 36. Production Architecture

``` text
                         USERS
                           │
                           ▼
                    ┌────────────┐
                    │   React    │
                    └─────┬──────┘
                          │
                   RainbowKit
                          │
                       Wagmi
                          │
                        Viem
                          │
              ┌───────────┴───────────┐
              │                       │
           Wallet                  Alchemy
                                      │
                         ┌────────────┼─────────────┐
                         │            │             │
                       RPC         Data APIs      Webhooks
                         │            │             │
                         └────────────┼─────────────┘
                                      │
                                 Blockchain
                                      │
                              Smart Contracts

Backend
   ↑
Webhooks
   ↓
Database
   ↓
Notifications / Analytics
```

------------------------------------------------------------------------

# 37. Error Handling

## Wrong network

``` text
Wallet → Mainnet
Contract → Sepolia
```

Solution:

``` text
Detect chain
→ Ask user to switch
```

## Invalid RPC

Check:

``` text
API key
RPC URL
Network
Environment variable
```

## Rate limiting

Symptoms:

``` text
Intermittent failures
Slow requests
Too many requests
```

Potential solutions:

-   Use appropriate infrastructure
-   Cache where appropriate
-   Reduce unnecessary requests
-   Batch where supported
-   Implement sensible retries

## Transaction reverted

Investigate:

``` text
Contract logic
Arguments
Permissions
Balance
Allowance
Current state
Gas
```

## Transaction pending

Check:

``` text
Transaction hash
Network
Receipt
Provider/node status
```

------------------------------------------------------------------------

# 38. Security

## Protect secrets

Do not commit secrets to Git.

Use appropriate environment/configuration management.

## Never expose private keys

Alchemy API credentials are not a substitute for wallet security.

## Validate webhooks

Verify webhook authentication/signatures according to the current
Alchemy documentation.

## Validate chains

Always know:

``` text
chain ID
network
contract deployment
```

## Verify contract addresses

Do not assume the same contract address exists on every chain.

Maintain explicit:

``` text
chain ID
contract address
ABI
```

## User signatures

Clearly explain what users are signing.

## Frontend is untrusted

Important authorization should be enforced by the smart contract and
trusted backend systems where appropriate.

------------------------------------------------------------------------

# 39. Common Mistakes

## Mistake 1

Thinking:

``` text
Alchemy = Ethereum
```

Correct:

``` text
Alchemy = infrastructure/provider
Ethereum = blockchain network
```

## Mistake 2

Confusing RPC with Data APIs.

``` text
RPC
= low-level blockchain access

Data API
= indexed/structured data
```

## Mistake 3

Thinking an API key signs transactions.

It does not.

## Mistake 4

Hard-coding private keys.

Never do this.

## Mistake 5

Using the wrong chain.

Check:

``` text
chain ID
RPC
contract address
wallet network
```

## Mistake 6

Polling everything.

Use Webhooks or WebSockets where appropriate.

## Mistake 7

Assuming every API supports every chain.

Always check current feature/chain support.

## Mistake 8

Treating indexed data as identical to raw RPC.

They solve different problems.

------------------------------------------------------------------------

# 40. Debugging Checklist

## RPC

``` text
API key correct?
      ↓
Endpoint correct?
      ↓
Network correct?
      ↓
Chain supported?
      ↓
Request valid?
      ↓
Rate limit?
      ↓
Provider status?
```

## Contract

``` text
Correct chain?
      ↓
Correct address?
      ↓
Correct ABI?
      ↓
Correct function?
      ↓
Correct arguments?
      ↓
Correct account?
      ↓
Enough ETH?
      ↓
Allowance?
      ↓
Simulation successful?
      ↓
Transaction sent?
      ↓
Receipt successful?
```

## Webhooks

``` text
Webhook active?
      ↓
Correct URL?
      ↓
Server reachable?
      ↓
Signature validated?
      ↓
Payload parsed?
      ↓
Duplicate handling?
      ↓
Database update successful?
```

------------------------------------------------------------------------

# 41. Interview Questions

## Q1. What is Alchemy?

**Answer:** Alchemy is blockchain infrastructure that provides APIs and
services for interacting with supported blockchains, including low-level
RPC, indexed data, webhooks, and smart-wallet/account-abstraction
infrastructure.

## Q2. What is an Alchemy API key?

**Answer:** It identifies your application when using Alchemy services
and enables access/usage tracking according to the configured service
and plan.

## Q3. What is JSON-RPC?

**Answer:** JSON-RPC is a lightweight remote procedure call protocol
used by Ethereum clients for blockchain interaction.

## Q4. RPC vs Data API?

**Answer:**

``` text
RPC
→ low-level blockchain access

Data API
→ indexed, structured application data
```

## Q5. Why use Alchemy instead of operating your own node?

**Answer:** Alchemy provides managed blockchain infrastructure so
developers can focus on building applications instead of maintaining
node infrastructure.

## Q6. What is `eth_call`?

**Answer:** It executes a message call without submitting a
state-changing transaction.

## Q7. What is `eth_getLogs`?

**Answer:** It queries event logs emitted by smart contracts.

## Q8. What is a transaction receipt?

**Answer:** A receipt contains information about a mined transaction,
including status, block information, gas usage, and logs.

## Q9. What is a webhook?

**Answer:** A webhook lets Alchemy send an HTTP request to your server
when configured onchain activity occurs.

## Q10. Webhook vs WebSocket?

**Answer:**

``` text
Webhook
→ HTTP event delivery to a server

WebSocket
→ persistent real-time subscription
```

## Q11. What is the NFT API?

**Answer:** Alchemy's NFT API provides indexed NFT ownership, metadata,
collection, spam, sales, and related capabilities.

## Q12. What is the Token API?

**Answer:** It provides token balances, metadata, allowances, and
related token information through supported endpoints.

## Q13. What is the Transfers API?

**Answer:** It provides historical transfer/activity data for addresses.

## Q14. What is the Portfolio API?

**Answer:** It provides a consolidated view of wallet assets across
supported tokens and NFTs.

## Q15. What is Simulation?

**Answer:** Simulation previews transaction effects before a transaction
is actually sent.

## Q16. What is the Bundler API?

**Answer:** It supports account-abstraction workflows by handling user
operations for smart accounts.

## Q17. What is Gas Manager?

**Answer:** It supports gas sponsorship so applications can pay gas for
users in supported smart-account workflows.

## Q18. Does an Alchemy API key sign a transaction?

**Answer:** No. Signing normally requires a wallet/private key. The
provider can broadcast the signed transaction.

## Q19. Does Alchemy replace Solidity?

**Answer:** No. Solidity defines smart-contract logic; Alchemy provides
blockchain infrastructure and APIs.

## Q20. How does Alchemy fit into a React dApp?

**Answer:**

``` text
React
 ↓
RainbowKit
 ↓
Wagmi
 ↓
Viem
 ↓
Alchemy
 ↓
Blockchain
```

## Q21. What is account abstraction?

**Answer:** Account abstraction enables programmable smart-account
behavior and user experiences such as batching and sponsored gas.

## Q22. What is a smart wallet?

**Answer:** A wallet represented by a smart-contract account with
programmable behavior.

## Q23. What is EIP-1193?

**Answer:** A standard Ethereum provider interface used for
communication between dApps and compatible wallets.

## Q24. What is EIP-6963?

**Answer:** A wallet discovery standard that improves interoperability
between browser wallets and dApps.

## Q25. How would you build a wallet dashboard?

**Answer:**

``` text
Connect wallet
      ↓
Get address
      ↓
Portfolio / Token / NFT APIs
      ↓
Fetch assets
      ↓
Fetch prices if needed
      ↓
Render dashboard
      ↓
Use Webhooks for backend updates
```

------------------------------------------------------------------------

# 42. Coding Practice

## Beginner

### 1. Latest Block App

Build:

``` text
Latest Block:
12345678
```

Use:

``` text
Viem
Alchemy
```

### 2. Wallet Balance Checker

Input:

``` text
0x...
```

Output:

``` text
ETH balance
```

### 3. Transaction Lookup

Input:

``` text
Transaction hash
```

Output:

``` text
From
To
Value
Block
Status
Gas used
```

### 4. Chain Checker

Display:

``` text
Chain ID
Network
Latest Block
```

------------------------------------------------------------------------

# Intermediate

## 5. ERC-20 Dashboard

Display:

``` text
Wallet
Token
Balance
Symbol
Decimals
```

Use Token API where appropriate.

## 6. NFT Gallery

Display:

``` text
NFT image
Name
Collection
Token ID
Owner
Metadata
```

Use NFT API.

## 7. Transaction History

``` text
Wallet
 ↓
Transfers API
 ↓
Activity table
```

## 8. Portfolio Dashboard

Display:

``` text
Native assets
ERC-20 tokens
NFTs
Prices
Estimated value
```

------------------------------------------------------------------------

# Advanced

## 9. Real-Time Wallet Monitor

``` text
Wallet
 ↓
Alchemy Address Activity Webhook
 ↓
Backend
 ↓
Database
 ↓
React dashboard
```

## 10. Smart Wallet DApp

``` text
Connect
 ↓
Smart account
 ↓
User operation
 ↓
Bundler
 ↓
Gas sponsorship
 ↓
Blockchain
```

## 11. Transaction Simulator

``` text
Transaction form
       ↓
Simulation
       ↓
Show expected effects
       ↓
User confirms
       ↓
Send transaction
```

------------------------------------------------------------------------

# 43. Project Ideas

Build in this order:

``` text
1. Block Explorer Lite
       ↓
2. Wallet Balance Checker
       ↓
3. Transaction Explorer
       ↓
4. ERC-20 Dashboard
       ↓
5. NFT Gallery
       ↓
6. Wallet Portfolio
       ↓
7. Transfer History
       ↓
8. Real-Time Webhook Dashboard
       ↓
9. Transaction Simulator
       ↓
10. Smart Wallet / Gasless DApp
```

A strong blockchain portfolio stack:

``` text
Solidity
+
React
+
TypeScript
+
RainbowKit
+
Wagmi
+
Viem
+
Alchemy
+
OpenZeppelin
+
Hardhat / Foundry
+
Sepolia
```

------------------------------------------------------------------------

# 44. 30-Day Learning Plan

## Week 1 --- Fundamentals

### Day 1

Learn:

-   What Alchemy is
-   Nodes
-   RPC
-   API keys
-   Networks

### Day 2

Learn:

-   JSON-RPC
-   `eth_blockNumber`
-   `eth_chainId`
-   `eth_getBalance`

### Day 3

Learn:

-   Transactions
-   Receipts
-   Logs
-   `eth_call`

### Day 4

Build:

``` text
Block Explorer Lite
```

### Day 5

Learn:

``` text
Viem + Alchemy
```

### Day 6

Learn:

``` text
Ethers + Alchemy
```

### Day 7

Build:

``` text
Wallet Balance App
```

## Week 2 --- Data APIs

### Day 8

Token API.

### Day 9

NFT API.

### Day 10

Transfers API.

### Day 11

Portfolio API.

### Day 12

Prices API.

### Day 13

Build NFT gallery.

### Day 14

Build portfolio dashboard.

## Week 3 --- Real-Time and Advanced

### Day 15

Webhooks.

### Day 16

Webhook security.

### Day 17

WebSockets.

### Day 18

Simulation.

### Day 19

Debug API.

### Day 20

Trace API.

### Day 21

Build real-time wallet monitor.

## Week 4 --- Account Abstraction

### Day 22

Smart accounts.

### Day 23

User operations.

### Day 24

Bundlers.

### Day 25

Gas sponsorship.

### Day 26

Smart-wallet transaction APIs.

### Day 27

Build a gas-sponsored flow.

### Day 28

Testing and security.

### Day 29

Deploy to Sepolia.

### Day 30

Polish:

``` text
GitHub
README
Architecture diagram
Live demo
Tests
Screenshots
Deployment
```

------------------------------------------------------------------------

# 45. Final Cheat Sheet

## Alchemy

``` text
Alchemy
= Blockchain Infrastructure
```

## Main categories

``` text
Chain APIs
Data APIs
Wallet APIs
AI / developer tooling
```

## Chain APIs

``` text
JSON-RPC
WebSockets
Debug
Trace
```

## Data APIs

``` text
Portfolio
Transfers
Prices
NFT
Webhooks
Simulation
```

## Wallet APIs

``` text
Smart Wallets
Bundler
Gas Manager
Transaction APIs
```

## Common RPC

``` text
eth_blockNumber
eth_chainId
eth_getBalance
eth_getBlockByNumber
eth_getTransactionByHash
eth_getTransactionReceipt
eth_call
eth_estimateGas
eth_getLogs
eth_sendRawTransaction
```

## Architecture

``` text
React
 ↓
RainbowKit
 ↓
Wagmi
 ↓
Viem
 ↓
Alchemy
 ↓
Blockchain
```

## Data architecture

``` text
Blockchain
    ↓
Alchemy indexing
    ↓
Data APIs
    ↓
Your application
```

## Real-time

``` text
Webhook
→ HTTP event delivery

WebSocket
→ live subscription
```

## Account abstraction

``` text
User
 ↓
Smart Account
 ↓
UserOperation
 ↓
Bundler
 ↓
Blockchain
```

------------------------------------------------------------------------

# 46. 10x Mental Model

Memorize this:

``` text
                           ALCHEMY
                              │
         ┌────────────────────┼────────────────────┐
         │                    │                    │
         ▼                    ▼                    ▼
     CHAIN APIs            DATA APIs           WALLET APIs
         │                    │                    │
         ▼                    ▼                    ▼
      JSON-RPC             Indexed data       Smart accounts
      WebSockets           Portfolio          Bundler
      Debug               Transfers           Gas Manager
      Trace               NFTs                Transactions
         │                Prices
         │                Webhooks
         │                Simulation
         └────────────────────┬─────────────────────┘
                              ▼
                     BLOCKCHAIN NETWORKS
                              │
                              ▼
                       SMART CONTRACTS
```

Use this decision tree:

``` text
Need raw blockchain state?
→ Chain API / JSON-RPC

Need indexed application data?
→ Data API

Need event notifications?
→ Webhooks

Need real-time subscriptions?
→ WebSockets

Need transaction preview?
→ Simulation

Need deep execution inspection?
→ Debug / Trace

Need smart accounts?
→ Wallet APIs / Account Abstraction
```

------------------------------------------------------------------------

# 47. Mastery Checklist

## Fundamentals

-   [ ] Explain Alchemy
-   [ ] Explain blockchain nodes
-   [ ] Explain RPC
-   [ ] Explain JSON-RPC
-   [ ] Create an Alchemy account
-   [ ] Create/configure an application
-   [ ] Get an API key
-   [ ] Understand networks
-   [ ] Understand Sepolia

## Ethereum API

-   [ ] `eth_blockNumber`
-   [ ] `eth_chainId`
-   [ ] `eth_getBalance`
-   [ ] `eth_getBlockByNumber`
-   [ ] `eth_getTransactionByHash`
-   [ ] `eth_getTransactionReceipt`
-   [ ] `eth_call`
-   [ ] `eth_estimateGas`
-   [ ] `eth_getLogs`
-   [ ] `eth_sendRawTransaction`

## Viem

-   [ ] `createPublicClient`
-   [ ] `http`
-   [ ] Read blocks
-   [ ] Read balances
-   [ ] Read transactions
-   [ ] Read receipts
-   [ ] Contract reads
-   [ ] Contract writes

## Data APIs

-   [ ] Portfolio
-   [ ] Transfers
-   [ ] Tokens
-   [ ] NFTs
-   [ ] Prices
-   [ ] Simulation

## Real-time

-   [ ] Webhooks
-   [ ] Webhook signatures
-   [ ] Address Activity
-   [ ] NFT Activity
-   [ ] Custom webhooks
-   [ ] WebSockets
-   [ ] Log subscriptions
-   [ ] Block subscriptions

## Advanced

-   [ ] Debug API
-   [ ] Trace API
-   [ ] Account abstraction
-   [ ] Smart accounts
-   [ ] User operations
-   [ ] Bundlers
-   [ ] Gas sponsorship
-   [ ] Transaction APIs

## Production

-   [ ] Environment variables
-   [ ] API-key management
-   [ ] Rate-limit strategy
-   [ ] Caching
-   [ ] Retry strategy
-   [ ] Webhook validation
-   [ ] Chain validation
-   [ ] Contract-address management
-   [ ] Error handling
-   [ ] Monitoring

------------------------------------------------------------------------

# 🚀 Final Interview Answer

If asked:

> **"How would you use Alchemy in a full-stack blockchain
> application?"**

A strong answer:

> "I would use Alchemy as the blockchain infrastructure layer. For
> low-level blockchain interaction, I can use its Chain APIs and
> standard JSON-RPC. For structured indexed data, I can use Data APIs
> such as Portfolio, Transfers, Token, and NFT APIs. For event-driven
> backend processing, I can use Webhooks, while WebSockets are useful
> for real-time subscriptions. For advanced applications, Alchemy also
> provides transaction simulation, debugging and tracing, plus
> smart-wallet/account-abstraction infrastructure such as Bundler and
> Gas Manager. In a React application, I would typically combine
> RainbowKit for wallet UX, Wagmi for React Web3 state and hooks, Viem
> for EVM interaction, and Alchemy for RPC and data infrastructure."

------------------------------------------------------------------------

# 🧠 Ultimate Full-Stack Blockchain Architecture

``` text
                         USER
                          │
                          ▼
                    ┌───────────┐
                    │   React   │
                    └─────┬─────┘
                          │
                    RainbowKit
                          │
                       Wagmi
                          │
                        Viem
                          │
            ┌─────────────┴──────────────┐
            │                            │
          Wallet                       Alchemy
            │                            │
            │              ┌─────────────┼─────────────┐
            │              │             │             │
            │            RPC          Data APIs     Webhooks
            │              │             │             │
            │              │             │             ▼
            │              │             │          Backend
            │              │             │             │
            │              │             │          Database
            │              │             │
            └──────────────┼─────────────┘
                           │
                       Blockchain
                           │
                    Smart Contracts
                           │
                        Solidity
```

## Final mental model

``` text
RainbowKit
→ Which wallet does the user connect?

Wagmi
→ What is the current wallet/Web3 state in React?

Viem
→ How do I interact with the EVM?

Alchemy
→ How does my application access blockchain infrastructure and indexed onchain data?

Solidity
→ What logic executes onchain?

Blockchain
→ What is the decentralized source of truth?
```

> **Master the boundaries between these layers, and modern full-stack
> EVM dApp architecture becomes much easier to understand.**
