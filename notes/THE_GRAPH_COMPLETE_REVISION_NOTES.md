# The Graph --- Complete Revision Notes

> A developer-focused, interview-ready revision guide for **The Graph
> Protocol**, based on the official documentation:
> https://thegraph.com/docs/en/

------------------------------------------------------------------------

## 1. The Graph in One Sentence

**The Graph turns difficult-to-query blockchain data into structured,
indexed data that applications can query efficiently.**

Core flow:

``` text
Blockchain
   ↓
Subgraph / Substreams
   ↓
Indexing + transformation
   ↓
Structured data
   ↓
GraphQL / streaming
   ↓
DApp / analytics / AI
```

The official docs describe The Graph as a blockchain data solution
supporting 60+ chains, with **Subgraphs** and **Substreams** as core
products.

------------------------------------------------------------------------

# 2. Why The Graph Exists

Blockchain RPC gives low-level access to blocks, transactions, logs and
contract calls. A DApp often needs higher-level historical and
relational data.

Without indexing:

``` text
DApp → RPC → blocks/logs → filter → decode → database → response
```

With The Graph:

``` text
Blockchain → Indexer → Subgraph → GraphQL → DApp
```

Use The Graph when you need:

-   historical event data
-   filtering
-   pagination
-   relationships
-   analytics
-   application-specific data models

------------------------------------------------------------------------

# 3. The Graph Ecosystem

Important participants/components:

  Concept         Meaning
  --------------- ---------------------------------------------
  Developer       Builds Subgraphs/Substreams
  Consumer        Uses indexed data
  Indexer         Runs infrastructure and serves indexed data
  Curator         Signals GRT on useful Subgraphs
  Delegator       Delegates GRT to Indexers
  Graph Node      Indexing engine
  Subgraph        Custom indexed API
  Substreams      Parallel blockchain data processing
  GRT             The Graph Token
  Graph Horizon   Modular data-service architecture

------------------------------------------------------------------------

# 4. Core Products

The current official docs highlight:

-   **Subgraphs** --- extract, process and query blockchain data.
-   **Substreams** --- parallel blockchain data processing and
    streaming.
-   **Graph Node** --- indexes Subgraphs and serves GraphQL.
-   **Firehose** --- high-performance blockchain data ingestion.
-   **Graph Network** --- decentralized indexing/data marketplace.
-   **Graph Horizon** --- modular data-services architecture.

------------------------------------------------------------------------

# 5. Subgraph

## Definition

A **Subgraph** is a custom open API that extracts data from a
blockchain, processes it, stores it, and makes it easy to query via
GraphQL.

Mental model:

``` text
Smart Contract
      ↓
Events / calls
      ↓
Subgraph
      ↓
Mapping
      ↓
Entities
      ↓
GraphQL
```

A Subgraph lets a developer define:

1.  What data to index.
2.  How to transform it.
3.  What data model to store.
4.  How applications query it.

------------------------------------------------------------------------

# 6. Three Core Subgraph Files

A typical Subgraph centers around:

``` text
subgraph.yaml
schema.graphql
src/mapping.ts
```

## `subgraph.yaml`

Defines **where and what to index**.

Contains things such as:

-   network
-   contract address
-   ABI
-   data sources
-   event handlers
-   mappings
-   templates

## `schema.graphql`

Defines **what data to store and query**.

## `mapping.ts`

Defines **how blockchain data becomes entities**.

Memorize:

``` text
Manifest = WHERE / WHAT
Schema   = DATA MODEL
Mapping  = TRANSFORMATION
```

------------------------------------------------------------------------

# 7. Subgraph Manifest

Conceptual example:

``` yaml
specVersion: 1.0.0

schema:
  file: ./schema.graphql

dataSources:
  - kind: ethereum
    name: MyContract
    network: sepolia

    source:
      address: "0x..."
      abi: MyContract

    mapping:
      kind: ethereum/events
      apiVersion: 0.0.9
      language: wasm/assemblyscript

      entities:
        - User
        - Deposit

      abis:
        - name: MyContract
          file: ./abis/MyContract.json

      eventHandlers:
        - event: Deposit(address,uint256)
          handler: handleDeposit

      file: ./src/mapping.ts
```

Always verify exact syntax against the current manifest specification
for production work.

------------------------------------------------------------------------

# 8. Schema

Example:

``` graphql
type User @entity {
  id: ID!
  address: Bytes!
  totalDeposited: BigInt!
}
```

The schema is the blueprint for the indexed data.

------------------------------------------------------------------------

# 9. `@entity`

`@entity` marks a type as persistent Subgraph data.

Example:

``` graphql
type User @entity {
  id: ID!
  address: Bytes!
}
```

Every entity needs:

``` graphql
id: ID!
```

as its unique identifier.

------------------------------------------------------------------------

# 10. Common GraphQL Types

  Blockchain data   Graph type
  ----------------- --------------
  Address           `Bytes`
  uint256           `BigInt`
  Decimal value     `BigDecimal`
  Identifier        `ID`
  Text              `String`
  Flag              `Boolean`
  Raw bytes/hash    `Bytes`

Avoid normal JavaScript `number` for large blockchain integers.

------------------------------------------------------------------------

# 11. Entity IDs

Good ID strategies depend on the entity.

### Address

``` typescript
address.toHexString()
```

Good for one entity per wallet.

### Transaction hash + log index

``` typescript
event.transaction.hash.toHex() +
"-" +
event.logIndex.toString()
```

Useful when multiple entities can be created by one transaction.

### Token ID

Useful for NFT entities.

Rule:

> Choose an ID that is deterministic and uniquely identifies the entity.

------------------------------------------------------------------------

# 12. Relationships

Example:

``` graphql
type User @entity {
  id: ID!
  deposits: [Deposit!]! @derivedFrom(field: "user")
}

type Deposit @entity {
  id: ID!
  user: User!
  amount: BigInt!
}
```

Mental model:

``` text
User 1 ──────── * Deposit
```

------------------------------------------------------------------------

# 13. `@derivedFrom`

`@derivedFrom` creates a reverse relationship based on another entity's
field.

Example:

``` graphql
type User @entity {
  id: ID!
  deposits: [Deposit!]! @derivedFrom(field: "user")
}

type Deposit @entity {
  id: ID!
  user: User!
}
```

The source relationship is:

``` text
Deposit.user
```

and the reverse query is:

``` text
User.deposits
```

------------------------------------------------------------------------

# 14. Solidity Events and Indexing

Events are one of the most important indexing inputs.

Solidity:

``` solidity
event Deposit(
    address indexed user,
    uint256 amount
);
```

Manifest:

``` yaml
eventHandlers:
  - event: Deposit(address,uint256)
    handler: handleDeposit
```

Mapping:

``` typescript
export function handleDeposit(event: Deposit): void {
  // transform event into entities
}
```

Important rule:

> Good event design makes good indexing much easier.

------------------------------------------------------------------------

# 15. Indexed Event Parameters

Solidity:

``` solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint256 amount
);
```

`indexed` parameters become event topics and can be useful for
filtering.

Use `indexed` for fields you expect to search/filter by.

------------------------------------------------------------------------

# 16. Mapping

A mapping transforms source blockchain data into entities.

Basic pattern:

``` text
Event
 ↓
Handler
 ↓
Load entity
 ↓
Create/update entity
 ↓
Save entity
```

Example:

``` typescript
export function handleDeposit(event: Deposit): void {
  let user = User.load(event.params.user.toHexString())

  if (!user) {
    user = new User(event.params.user.toHexString())
    user.address = event.params.user
    user.totalDeposited = BigInt.zero()
  }

  user.totalDeposited =
    user.totalDeposited.plus(event.params.amount)

  user.save()
}
```

------------------------------------------------------------------------

# 17. Mapping Rules

Good mappings should:

-   be deterministic
-   use correct IDs
-   safely handle missing entities
-   avoid unnecessary blockchain calls
-   minimize storage operations
-   save entities correctly
-   avoid duplicate entities

Determinism means:

``` text
Same chain history
+
Same manifest
+
Same mapping
=
Same indexed result
```

------------------------------------------------------------------------

# 18. Event Handlers

Use event handlers when contracts emit useful events.

Example:

``` yaml
eventHandlers:
  - event: Transfer(address,address,uint256)
    handler: handleTransfer
```

Typical events:

``` text
Transfer
Deposit
Withdraw
Stake
Unstake
Swap
Mint
Burn
Approval
Purchase
Sale
```

------------------------------------------------------------------------

# 19. Block Handlers

Subgraphs can react to blocks.

Conceptual flow:

``` text
New block
 ↓
Block handler
 ↓
Mapping
 ↓
Entity update
```

Use carefully because block handlers may execute frequently.

Prefer targeted event indexing when events provide the required
information.

------------------------------------------------------------------------

# 20. Call Handlers

Call handlers can process contract calls.

They can be useful when event data is insufficient.

However, some call-based indexing features require additional RPC/trace
capabilities and can affect indexing performance.

------------------------------------------------------------------------

# 21. Dynamic Data Source Templates

Templates are important for contracts created dynamically.

Example:

``` text
Factory
  ↓
PairCreated
  ↓
New Pair address
  ↓
Create Pair template
  ↓
Index Pair
```

Useful for:

-   AMM pools
-   factories
-   marketplaces
-   dynamically created contracts

------------------------------------------------------------------------

# 22. File Data Sources

The Graph supports File Data Sources.

Useful flow:

``` text
NFT contract
 ↓
metadata URI / CID
 ↓
IPFS file
 ↓
metadata
 ↓
Subgraph entity
```

This is useful for blockchain applications where metadata lives in IPFS.

------------------------------------------------------------------------

# 23. One Subgraph, Multiple Contracts

A Subgraph can index multiple smart contracts.

The official manifest documentation notes that a single Subgraph can
index multiple contracts but not multiple networks as one combined data
source.

For multiple networks, use appropriate separate
Subgraphs/configurations.

------------------------------------------------------------------------

# 24. Graph CLI

Install:

``` bash
npm install -g @graphprotocol/graph-cli@latest
```

Check:

``` bash
graph --version
```

Common commands:

``` bash
graph init
graph codegen
graph build
graph auth <DEPLOY_KEY>
graph deploy <SUBGRAPH_SLUG>
```

------------------------------------------------------------------------

# 25. Standard Development Workflow

``` text
1. Deploy smart contract
2. Create Subgraph
3. Configure manifest
4. Define schema
5. Write mappings
6. Generate types
7. Build
8. Test
9. Deploy to Studio
10. Query
11. Publish
```

------------------------------------------------------------------------

# 26. Code Generation

Run:

``` bash
graph codegen
```

Purpose:

-   generate schema types
-   generate contract bindings
-   generate event types
-   provide typed mapping interfaces

------------------------------------------------------------------------

# 27. Build

Run:

``` bash
graph build
```

Common workflow:

``` bash
graph codegen && graph build
```

Build before deployment.

------------------------------------------------------------------------

# 28. Testing

The Graph ecosystem supports **Matchstick** for Subgraph unit testing.

Test:

-   event handlers
-   entity creation
-   entity updates
-   relationships
-   calculations
-   edge cases

Mental model:

``` text
Mock event
 ↓
Mapping
 ↓
Entity store
 ↓
Assertions
```

------------------------------------------------------------------------

# 29. Local Graph Node

Graph Node can run locally.

The official documentation describes infrastructure including:

-   Graph Node
-   PostgreSQL
-   blockchain JSON-RPC
-   IPFS
-   Prometheus metrics

Local architecture:

``` text
Local blockchain
      ↓
JSON-RPC
      ↓
Graph Node
      ↓
PostgreSQL
      ↓
GraphQL
```

------------------------------------------------------------------------

# 30. Graph Node

**Graph Node is the component that indexes Subgraphs and makes the
resulting data available through GraphQL.**

Responsibilities:

1.  Read manifest.
2.  Connect to blockchain data.
3.  Detect relevant data.
4.  Execute mappings.
5.  Store entities.
6.  Serve GraphQL.

------------------------------------------------------------------------

# 31. Graph Node Architecture

``` text
Blockchain RPC
      ↓
 Graph Node
   ┌──┴──┐
   ↓     ↓
Mapping PostgreSQL
         ↓
      GraphQL
```

Graph Node can scale horizontally and can separate indexing/query
workloads.

------------------------------------------------------------------------

# 32. Graph Node Infrastructure

Important components:

### PostgreSQL

Main data store.

### Blockchain JSON-RPC

Provides blockchain data.

### IPFS

Used for Subgraph deployment metadata and linked files.

### Prometheus

Provides metrics for monitoring.

------------------------------------------------------------------------

# 33. Graph Node Ports

Common defaults:

  Port   Purpose
  ------ ---------------------
  8000   GraphQL HTTP
  8001   GraphQL WebSocket
  8020   Admin JSON-RPC
  8030   Indexing status API
  8040   Prometheus metrics

**Security:** do not expose administrative/internal ports publicly.

------------------------------------------------------------------------

# 34. GraphQL

The Graph uses GraphQL to query Subgraphs.

Example:

``` graphql
{
  users(first: 10) {
    id
    address
    totalDeposited
  }
}
```

GraphQL lets the client specify the fields it needs.

------------------------------------------------------------------------

# 35. Query One Entity

``` graphql
{
  user(id: "0x123") {
    id
    address
  }
}
```

------------------------------------------------------------------------

# 36. Query Multiple Entities

``` graphql
{
  users(first: 20) {
    id
    address
  }
}
```

------------------------------------------------------------------------

# 37. Filtering

``` graphql
{
  users(
    where: {
      address: "0x123"
    }
  ) {
    id
    address
  }
}
```

------------------------------------------------------------------------

# 38. Ordering

``` graphql
{
  deposits(
    first: 20
    orderBy: timestamp
    orderDirection: desc
  ) {
    id
    amount
    timestamp
  }
}
```

------------------------------------------------------------------------

# 39. Pagination

Avoid unlimited queries.

Example:

``` graphql
{
  users(
    first: 100
    skip: 0
  ) {
    id
  }
}
```

Next page:

``` graphql
skip: 100
```

For very large datasets, prefer efficient cursor/entity-ID based
strategies where appropriate rather than huge `skip` values.

------------------------------------------------------------------------

# 40. Relationships in Queries

``` graphql
{
  users {
    id
    deposits {
      id
      amount
    }
  }
}
```

GraphQL makes entity relationships easy to consume.

------------------------------------------------------------------------

# 41. GraphQL Variables

``` graphql
query GetUser($id: ID!) {
  user(id: $id) {
    id
    address
  }
}
```

Variables:

``` json
{
  "id": "0x123..."
}
```

------------------------------------------------------------------------

# 42. GraphQL and Writes

A Subgraph is primarily a **read/indexing layer**.

Blockchain writes are still done through:

-   wallet
-   Viem
-   Ethers
-   Wagmi
-   RPC
-   smart contract interaction

Architecture:

``` text
WRITE
React → Viem/Wagmi → Contract → Blockchain

READ
Blockchain → Subgraph → GraphQL → React
```

------------------------------------------------------------------------

# 43. The Graph + Viem

Use **Viem** for:

-   wallet interaction
-   contract reads
-   contract writes
-   transactions
-   receipts

Use **The Graph** for:

-   indexed history
-   filtering
-   relationships
-   analytics
-   application-specific datasets

------------------------------------------------------------------------

# 44. Simple GraphQL Fetch

``` typescript
const query = `
  query {
    deposits(
      first: 20
      orderBy: timestamp
      orderDirection: desc
    ) {
      id
      amount
      timestamp
    }
  }
`

const response = await fetch(SUBGRAPH_URL, {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify({ query })
})

const result = await response.json()
```

------------------------------------------------------------------------

# 45. Graph Explorer

Before creating a Subgraph:

> **Search Graph Explorer first.**

Graph Explorer lets developers discover existing Subgraphs and
inspect/query them.

You can inspect:

-   query endpoint
-   schema/entities
-   indexed network
-   deployment information
-   Indexers
-   activity
-   statistics
-   playground

------------------------------------------------------------------------

# 46. Subgraph Studio

Subgraph Studio is used for development, staging and testing.

Typical flow:

``` text
Create
 ↓
Build
 ↓
Deploy to Studio
 ↓
Run queries
 ↓
Inspect logs
 ↓
Fix
 ↓
Publish
```

Studio deployments are intended for development/testing and are indexed
by the Upgrade Indexer operated by Edge & Node.

------------------------------------------------------------------------

# 47. Deploy to Studio

Typical commands:

``` bash
graph auth <DEPLOY_KEY>
graph deploy <SUBGRAPH_SLUG>
```

Never commit deployment credentials.

------------------------------------------------------------------------

# 48. Publish to The Graph Network

Publishing is an onchain action.

It makes a Subgraph:

-   available to decentralized Indexers
-   publicly searchable/queryable
-   available for curation/signal

Studio is useful for testing before production publication.

------------------------------------------------------------------------

# 49. Studio vs Network

  Studio            Network
  ----------------- ------------------------
  Development       Production
  Testing           Decentralized indexing
  Staging           Public discovery
  Upgrade Indexer   Network Indexers
  Rate-limited      Network service

------------------------------------------------------------------------

# 50. Subgraph Lifecycle

``` text
Create
 ↓
Develop
 ↓
Build
 ↓
Test
 ↓
Deploy
 ↓
Studio
 ↓
Query
 ↓
Publish
 ↓
Index
 ↓
Serve queries
 ↓
Update
```

Published Subgraphs have an associated NFT representing ownership.

------------------------------------------------------------------------

# 51. Curation / Signal

Signal is locked GRT associated with a Subgraph.

It indicates that a Subgraph is considered useful and can encourage
Indexers to index it.

``` text
Curator
 ↓
GRT signal
 ↓
Subgraph
 ↓
Indexer interest
 ↓
Indexing
```

------------------------------------------------------------------------

# 52. GRT

**GRT = Graph Token**

GRT participates in The Graph's network economics, including:

-   staking
-   delegation
-   curation/signal
-   payments/rewards

Do not confuse:

``` text
GRT ≠ GraphQL
```

------------------------------------------------------------------------

# 53. Indexers

Indexers operate infrastructure.

They:

-   stake GRT
-   run Graph infrastructure
-   index selected Subgraphs/data services
-   serve queries
-   earn network rewards/fees according to protocol rules

Mental model:

``` text
Subgraph
 ↓
Indexer selects it
 ↓
Graph Node
 ↓
Indexed data
 ↓
Queries
```

------------------------------------------------------------------------

# 54. Delegators

Delegators delegate GRT to Indexers.

Benefits include:

-   supporting network security/capacity
-   participating in eligible rewards

The current docs describe a delegation capacity ratio of **16** relative
to an Indexer's self-stake.

Example:

``` text
Self-stake = 1M GRT
Delegation capacity ≈ 16M GRT
```

Under Graph Horizon, delegation is associated with an Indexer and a data
service.

------------------------------------------------------------------------

# 55. Graph Horizon

**Graph Horizon is a major protocol upgrade that makes The Graph more
modular.**

Older conceptual model:

``` text
Staking
+
Payments
+
Subgraphs
```

Horizon separates core primitives:

``` text
Core staking
+
Core payments
+
Data services
```

This makes it easier to support additional data services.

------------------------------------------------------------------------

# 56. Data Service Framework

Horizon introduces a modular Data Service Framework.

The first/current primary data service described in the docs is:

``` text
SubgraphService
```

It supports existing Subgraph indexing and query serving.

Future data services can use the same core protocol infrastructure.

------------------------------------------------------------------------

# 57. Horizon Mental Model

``` text
              Graph Protocol
                    │
       ┌────────────┼────────────┐
       ↓            ↓            ↓
   Staking       Payments    Data Services
                                  │
                                  ↓
                            SubgraphService
```

------------------------------------------------------------------------

# 58. Horizon Provisions

Under Horizon, Indexers assign/provision staked GRT to data services.

Conceptually:

``` text
GRT stake
 ↓
Provision
 ↓
Data Service
 ↓
Allocation
 ↓
Indexing
```

Stake that is not provisioned to a data service cannot be used for
indexing that service.

------------------------------------------------------------------------

# 59. Horizon Allocations

Current docs describe the SubgraphService allocation lifecycle as:

``` text
Open
 ↓
Active / POI collection
 ↓
Optional Close
```

Under Horizon, allocations can remain open indefinitely; stale POIs can
trigger forced closure according to protocol rules.

------------------------------------------------------------------------

# 60. Proof of Indexing

POI = **Proof of Indexing**.

It is used to demonstrate indexing work/correctness for protocol
accounting and rewards.

High-level:

``` text
Blockchain
 ↓
Deterministic indexing
 ↓
POI
 ↓
Protocol verification/accounting
```

------------------------------------------------------------------------

# 61. Subgraphs vs Substreams

  Subgraphs                         Substreams
  --------------------------------- --------------------------------------
  Structured indexed API            High-performance data stream
  GraphQL                           Streaming/pipeline model
  Entity-oriented                   Module/stream-oriented
  Great for DApp reads              Great for high-throughput processing
  Application-specific data model   Large-scale processing
  Common frontend integration       Analytics/backfills/streaming

------------------------------------------------------------------------

# 62. Substreams

Substreams is a parallel blockchain indexing technology designed for
performance and scalability.

The official docs describe a workflow where:

1.  You write transformations, commonly in Rust.
2.  They are packaged into WASM.
3.  A Substreams endpoint executes them against blockchain data.
4.  Data is sent to a sink.

Possible sinks include:

-   Subgraph
-   SQL database
-   direct application stream
-   PubSub
-   other supported data systems

------------------------------------------------------------------------

# 63. Substreams Mental Model

``` text
Blockchain
    ↓
Substreams
    ↓
Parallel processing
    ↓
Transformation
    ↓
Sink
```

Use it when you need:

-   high throughput
-   real-time streams
-   large historical backfills
-   analytics pipelines
-   low-latency processing

------------------------------------------------------------------------

# 64. Standardized Subgraphs

Standardized Subgraphs provide reusable schemas that normalize onchain
data across protocols of the same type.

Instead of:

``` text
Protocol A → schema A
Protocol B → schema B
Protocol C → schema C
```

a standardized schema aims for:

``` text
Protocol A ─┐
Protocol B ─┼→ common schema
Protocol C ─┘
```

This makes downstream applications and analytics more reusable.

------------------------------------------------------------------------

# 65. Query Optimization

Rules:

-   paginate
-   request only required fields
-   filter early
-   avoid huge result sets
-   avoid unnecessary nested relationships
-   model entities around real application queries
-   monitor query performance
-   consider dedicated query infrastructure at scale

Bad:

``` graphql
{
  users {
    deposits {
      token {
        ...
      }
    }
  }
}
```

Better:

``` graphql
{
  deposits(
    first: 20
    orderBy: timestamp
    orderDirection: desc
  ) {
    id
    amount
    timestamp
  }
}
```

------------------------------------------------------------------------

# 66. Indexing Performance

Graph Node indexing can be viewed as three major stages:

``` text
1. Fetch blockchain data
2. Process events/calls/mappings
3. Write entities to storage
```

Potential bottlenecks:

-   slow event retrieval
-   expensive call handlers
-   many `eth_call`s
-   heavy store operations
-   huge writes
-   too many events
-   slow database
-   provider lag
-   slow receipt retrieval

------------------------------------------------------------------------

# 67. Indexing Problem vs Query Problem

These are different.

### Indexing problem

``` text
Blockchain
 ↓
Graph Node
 ↓
Database
```

is slow.

### Query problem

``` text
Database
 ↓
GraphQL
 ↓
Client
```

is slow.

Always identify which side is failing.

------------------------------------------------------------------------

# 68. Query Caching

Graph Node supports query caching.

Caching can reduce repeated database work.

At scale:

``` text
Client
 ↓
Query layer/cache
 ↓
Query node
 ↓
Database
```

Dedicated query infrastructure can prevent query traffic from
interfering with indexing.

------------------------------------------------------------------------

# 69. Reorganizations and Finality

Blockchain data can reorganize.

Do not assume:

``` text
latest block = final forever
```

Indexing infrastructure must account for forks/reorgs.

For financial applications, understand the difference between:

-   latest indexed data
-   confirmed data
-   finalized data

depending on the target network.

------------------------------------------------------------------------

# 70. Common Mistakes

### 1. Poor events

If contracts don't emit useful events, indexing becomes harder.

### 2. Bad IDs

Use deterministic unique IDs.

### 3. Huge GraphQL queries

Use filtering and pagination.

### 4. Too many block handlers

Prefer event-driven indexing where possible.

### 5. Too many `eth_call`s

Avoid unnecessary chain calls inside mappings.

### 6. Duplicate relationships

Use relationships and `@derivedFrom` appropriately.

### 7. Treating GraphQL as transaction execution

Use Viem/Ethers/Wagmi for writes.

### 8. Exposing secrets

Never commit deploy keys/private keys.

------------------------------------------------------------------------

# 71. Security

Never put these in Git:

``` text
private keys
seed phrases
deployment keys
secret credentials
```

Use:

``` text
.env
CI/CD secrets
secret managers
```

Remember:

> A Subgraph is not a privacy layer. Public blockchain-derived data
> should be treated as public.

------------------------------------------------------------------------

# 72. Production Architecture

``` text
                  React
                    │
          ┌─────────┴─────────┐
          ↓                   ↓
     Viem/Wagmi           GraphQL
          ↓                   ↓
    Smart Contract         Subgraph
          ↓                   ↓
      Blockchain          Indexers
                              ↓
                         Graph Node
                              ↓
                         PostgreSQL
```

Use:

``` text
Viem/Wagmi
→ transactions and direct contract access

The Graph
→ indexed application data
```

------------------------------------------------------------------------

# 73. Example: Creator Funding DApp

Contract:

``` solidity
event Donation(
    address indexed donor,
    address indexed creator,
    uint256 amount
);
```

Schema:

``` graphql
type Creator @entity {
  id: ID!
  totalReceived: BigInt!
}

type Donation @entity {
  id: ID!
  donor: Bytes!
  creator: Creator!
  amount: BigInt!
  timestamp: BigInt!
}
```

Architecture:

``` text
Donor
 ↓
Wallet
 ↓
Donation transaction
 ↓
Contract emits Donation
 ↓
Subgraph indexes it
 ↓
GraphQL
 ↓
Creator dashboard
```

This is an excellent portfolio project because it demonstrates
Solidity + events + indexing + GraphQL + React.

------------------------------------------------------------------------

# 74. Example: NFT Marketplace

Events:

``` solidity
event Listed(
    uint256 indexed tokenId,
    address indexed seller,
    uint256 price
);

event Sold(
    uint256 indexed tokenId,
    address indexed buyer,
    uint256 price
);
```

Entities:

``` text
NFT
User
Listing
Sale
```

Query:

``` graphql
{
  listings(
    first: 20
    where: { active: true }
  ) {
    id
    tokenId
    price
  }
}
```

------------------------------------------------------------------------

# 75. Example: Staking DApp

Events:

``` solidity
event Staked(address indexed user, uint256 amount);
event Withdrawn(address indexed user, uint256 amount);
event RewardClaimed(address indexed user, uint256 amount);
```

Entities:

``` text
User
Stake
Withdrawal
Reward
```

Dashboard:

``` text
Total staked
User stake
Rewards
History
Recent activity
```

------------------------------------------------------------------------

# 76. Schema Design Principles

Ask:

> "What questions will my frontend ask?"

For example:

``` text
Who deposited?
How much?
When?
What is total?
What happened recently?
```

Then design entities for those questions.

Good schema:

-   predictable IDs
-   clear relationships
-   minimal duplication
-   query-oriented
-   correct numeric types

------------------------------------------------------------------------

# 77. Event Design Principles

A good event should expose important information.

Example:

``` solidity
event Deposit(
    address indexed user,
    uint256 amount
);
```

Don't duplicate metadata that is already reliably available to mappings
unless there is a real query/data-model reason.

------------------------------------------------------------------------

# 78. Debugging Framework

When a Subgraph fails, check in this order:

``` text
1. Network
2. Contract address
3. ABI
4. Event signature
5. Manifest
6. Schema
7. Mapping
8. Codegen
9. Build
10. Deployment
11. Indexing logs
12. GraphQL endpoint
13. Frontend
```

Ask:

``` text
Was the event emitted?
Was it recognized?
Did mapping execute?
Was entity saved?
Did indexing catch up?
Can GraphQL query it?
```

------------------------------------------------------------------------

# 79. Graph Node Scaling

At scale:

``` text
                 Load Balancer
                      │
             ┌────────┼────────┐
             ↓        ↓        ↓
          GraphNode GraphNode GraphNode
             │        │        │
             └────────┼────────┘
                      ↓
                 PostgreSQL
```

The official docs describe horizontal scaling and dedicated query nodes
for larger workloads.

------------------------------------------------------------------------

# 80. Monitoring

Monitor:

``` text
Indexing height
Chain head
Indexing lag
Query latency
Query errors
Database load
RPC errors
Mapping failures
Subgraph health
```

Prometheus + Grafana are common monitoring components for Graph Node
infrastructure.

------------------------------------------------------------------------

# 81. Firehose

Firehose is high-performance blockchain data ingestion infrastructure.

High-level:

``` text
Blockchain
 ↓
Firehose
 ↓
structured block stream
 ↓
indexing systems
```

It is designed to improve data ingestion and synchronization
performance.

------------------------------------------------------------------------

# 82. Advanced Subgraph Features

Current Subgraph tooling includes features such as:

-   File Data Sources
-   dynamic templates
-   transaction receipt access in event handlers
-   `endBlock`
-   indexer hints
-   indexed argument filtering
-   timeseries
-   aggregations

Always check current documentation for exact feature syntax and network
support.

------------------------------------------------------------------------

# 83. Subgraph Versioning

A production Subgraph may evolve:

``` text
v1
 ↓
bug fix
 ↓
v2
 ↓
new entities
 ↓
v3
```

Before an update:

``` text
schema
 ↓
mappings
 ↓
codegen
 ↓
build
 ↓
test
 ↓
Studio
 ↓
query
 ↓
publish/update
```

Ask whether an update changes:

-   entity IDs
-   historical data
-   relationships
-   derived values
-   required backfill

------------------------------------------------------------------------

# 84. The Graph vs Direct RPC

  Direct RPC         The Graph
  ------------------ ------------------------------
  Low-level access   Indexed application data
  Current state      Historical + relational data
  Contract calls     GraphQL entities
  Transactions       Read/query layer
  Logs               Indexed/filterable records

Rule:

``` text
Need blockchain primitive?
→ RPC / Viem

Need indexed application dataset?
→ The Graph
```

------------------------------------------------------------------------

# 85. The Graph vs Database

Traditional:

``` text
Application
 ↓
Backend
 ↓
Database
```

The Graph:

``` text
Blockchain
 ↓
Indexer
 ↓
Subgraph entities
 ↓
GraphQL
```

The Graph is specialized for blockchain-derived data.

------------------------------------------------------------------------

# 86. The Graph vs Etherscan

Etherscan:

-   explorer
-   human-facing blockchain inspection
-   transactions/addresses/tokens

The Graph:

-   developer data layer
-   application-specific schema
-   programmable GraphQL API
-   indexed historical data

------------------------------------------------------------------------

# 87. Interview Questions

## Q1. What is The Graph?

**Answer:**

> The Graph is a blockchain data and indexing protocol. Developers
> define Subgraphs that extract and transform blockchain data into
> structured entities, Graph Node indexes the data, and applications
> query it through GraphQL.

## Q2. What is a Subgraph?

> A Subgraph is a custom open API over blockchain data. It defines what
> to index, how to transform it and how the resulting entities can be
> queried.

## Q3. What is Graph Node?

> Graph Node is the indexing engine that reads the Subgraph manifest,
> processes blockchain data and mappings, stores entities and exposes
> the indexed data through GraphQL.

## Q4. Why use The Graph instead of RPC?

> RPC provides low-level blockchain access, while The Graph provides
> indexed, historical, filtered and relational data. It reduces the
> amount of indexing logic the application must implement.

## Q5. What are the three main Subgraph files?

> `subgraph.yaml`, `schema.graphql`, and mapping code such as
> `mapping.ts`.

## Q6. What is a mapping?

> Mapping code transforms blockchain source data into the entities
> defined by the schema.

## Q7. What is `@entity`?

> It marks a GraphQL type as persistent Subgraph data.

## Q8. What is `@derivedFrom`?

> It defines a reverse relationship based on another entity field.

## Q9. What are dynamic templates?

> They allow a Subgraph to index contracts discovered or created
> dynamically at runtime.

## Q10. Why are events important?

> Events provide structured blockchain logs that are efficient to index
> and make application-specific historical data easier to reconstruct.

## Q11. Does a Subgraph change blockchain state?

> No. It is primarily an indexed read/data layer.

## Q12. What is GRT?

> GRT is The Graph Token used in the network's staking, delegation,
> curation and economic mechanisms.

## Q13. What does an Indexer do?

> An Indexer operates infrastructure, stakes GRT, indexes selected data
> services and serves queries.

## Q14. What does a Curator do?

> A Curator signals GRT on Subgraphs to indicate that they consider them
> useful.

## Q15. What does a Delegator do?

> A Delegator delegates GRT to Indexers and participates in eligible
> rewards.

## Q16. What is Substreams?

> Substreams is a parallel blockchain indexing and streaming technology
> for high-performance processing, historical backfills and real-time
> data pipelines.

## Q17. What is Graph Horizon?

> Graph Horizon is a modular protocol architecture separating core
> staking and payments from data services. SubgraphService is the
> first/current primary data service.

------------------------------------------------------------------------

# 88. High-Value Interview Comparison

### Mapping vs Schema

``` text
Schema  = WHAT data looks like
Mapping = HOW data is created/updated
```

### Manifest vs Schema

``` text
Manifest = blockchain source/configuration
Schema   = stored/queryable data model
```

### Mapping vs GraphQL

``` text
Mapping  = transformation/write side
GraphQL  = query/read side
```

### Viem vs The Graph

``` text
Viem       = blockchain interaction
The Graph  = indexed data access
```

### Subgraph vs Substreams

``` text
Subgraph   = queryable entity/API layer
Substreams = high-performance stream/processing layer
```

------------------------------------------------------------------------

# 89. One-Minute Revision

``` text
The Graph
= blockchain indexing/data protocol

Subgraph
= custom indexed API

Manifest
= what/where to index

Schema
= entity/data model

Mapping
= blockchain data → entities

Graph Node
= indexing engine

GraphQL
= query interface

Studio
= development/testing/staging

Explorer
= discover existing Subgraphs

Indexer
= indexes + serves

Curator
= signals Subgraphs

Delegator
= delegates GRT

GRT
= Graph Token

Substreams
= parallel blockchain streaming

Horizon
= modular data-service architecture
```

------------------------------------------------------------------------

# 90. Complete Full-Stack Architecture

``` text
                 ┌──────────────────┐
                 │      React       │
                 └────────┬─────────┘
                          │
               ┌──────────┴──────────┐
               ↓                     ↓
          Viem/Wagmi             GraphQL
               ↓                     ↓
        Smart Contract            Subgraph
               ↓                     ↓
           Blockchain            Indexers
                                     ↓
                                 Graph Node
                                     ↓
                                 PostgreSQL
```

This gives a clean separation:

``` text
WRITE PATH
React
 ↓
Viem/Wagmi
 ↓
Smart Contract
 ↓
Blockchain

READ PATH
Blockchain
 ↓
Subgraph
 ↓
GraphQL
 ↓
React
```

------------------------------------------------------------------------

# 91. Portfolio Project Roadmap

## Beginner

### Project 1 --- Counter Analytics

Track:

``` text
Increment
Decrement
```

### Project 2 --- ERC20 Transfer Explorer

Track:

``` text
Transfer
Approval
```

### Project 3 --- NFT Activity

Track:

``` text
Mint
Transfer
Sale
```

## Intermediate

### Project 4 --- Staking Dashboard

Track:

``` text
Stake
Withdraw
Reward
```

### Project 5 --- NFT Marketplace

Track:

``` text
Listing
Sale
Cancel
```

## Advanced

### Project 6 --- Creator Funding Portal

Track:

``` text
Creator
Donation
Withdrawal
Donor
```

### Project 7 --- DeFi Analytics Dashboard

Track:

``` text
Swaps
Liquidity
Volume
Users
Pools
```

### Project 8 --- Multi-contract Factory Indexer

Use dynamic templates:

``` text
Factory
 ↓
create contract
 ↓
dynamic template
 ↓
index new contract
```

------------------------------------------------------------------------

# 92. Learning Plan

## Week 1

Learn:

-   blockchain events
-   logs
-   GraphQL
-   Subgraph architecture
-   manifest
-   schema
-   mappings

Build:

``` text
Counter Subgraph
```

## Week 2

Learn:

-   relationships
-   filtering
-   pagination
-   ordering
-   templates
-   testing

Build:

``` text
ERC20 analytics
```

## Week 3

Learn:

-   Studio
-   publishing
-   Indexers
-   GRT
-   curation
-   delegation

Build:

``` text
NFT marketplace indexer
```

## Week 4

Learn:

-   Graph Node
-   PostgreSQL
-   performance
-   Substreams
-   Firehose
-   Horizon

Build:

``` text
Production-style DApp analytics
```

------------------------------------------------------------------------

# 93. Mastery Checklist

## Fundamentals

-   [ ] Explain The Graph
-   [ ] Explain indexing
-   [ ] Explain Subgraph
-   [ ] Explain GraphQL
-   [ ] Explain Graph Node
-   [ ] Explain GRT

## Subgraphs

-   [ ] Create manifest
-   [ ] Design schema
-   [ ] Write mapping
-   [ ] Index events
-   [ ] Use entity relationships
-   [ ] Use templates
-   [ ] Use File Data Sources
-   [ ] Test mappings

## CLI

-   [ ] `graph init`
-   [ ] `graph codegen`
-   [ ] `graph build`
-   [ ] `graph auth`
-   [ ] `graph deploy`

## Querying

-   [ ] filters
-   [ ] ordering
-   [ ] pagination
-   [ ] relationships
-   [ ] variables
-   [ ] performance

## Production

-   [ ] Studio
-   [ ] publish
-   [ ] curation
-   [ ] Indexers
-   [ ] monitoring
-   [ ] security
-   [ ] scaling

## Advanced

-   [ ] Graph Node
-   [ ] PostgreSQL
-   [ ] IPFS
-   [ ] Prometheus
-   [ ] Firehose
-   [ ] Substreams
-   [ ] standardized Subgraphs
-   [ ] timeseries
-   [ ] aggregations
-   [ ] Graph Horizon
-   [ ] data services
-   [ ] provisions
-   [ ] allocations
-   [ ] POI

------------------------------------------------------------------------

# 94. Ultimate Mental Model

Remember this diagram:

``` text
                  SMART CONTRACT
                        │
                    emits events
                        │
                        ▼
                    BLOCKCHAIN
                        │
                        ▼
                SUBGRAPH MANIFEST
                        │
                        ▼
                    GRAPH NODE
                        │
                    mapping
                        │
                        ▼
                     ENTITIES
                        │
                        ▼
                   GRAPHQL API
                        │
                        ▼
                     REACT
```

For high-performance streaming:

``` text
BLOCKCHAIN
    ↓
SUBSTREAMS
    ↓
parallel processing
    ↓
 ┌───────────────┬──────────────┐
 ↓               ↓              ↓
Subgraph       Database       App stream
```

For the protocol:

``` text
                 THE GRAPH
                     │
       ┌─────────────┼─────────────┐
       ↓             ↓             ↓
   Staking       Payments     Data Services
                                   │
                                   ↓
                             SubgraphService
```

------------------------------------------------------------------------

# 95. Official Documentation Map

Use the official documentation for deeper study:

-   Main docs: https://thegraph.com/docs/en/
-   Subgraphs: https://thegraph.com/docs/en/subgraphs/overview/
-   Quick Start: https://thegraph.com/docs/en/subgraphs/quick-start/
-   Subgraph development:
    https://thegraph.com/docs/en/subgraphs/developing/introduction/
-   Starting a Subgraph:
    https://thegraph.com/docs/en/subgraphs/developing/creating/starting-your-subgraph/
-   Manifest:
    https://thegraph.com/docs/en/subgraphs/developing/creating/subgraph-manifest/
-   GraphQL API:
    https://thegraph.com/docs/en/subgraphs/querying/graphql-api/
-   Graph Node:
    https://thegraph.com/docs/en/indexing/tooling/graph-node/
-   Indexing: https://thegraph.com/docs/en/indexing/overview/
-   Substreams: https://thegraph.com/docs/en/substreams/overview/
-   Substreams Quick Start:
    https://thegraph.com/docs/en/substreams/quick-start/
-   Graph Horizon: https://thegraph.com/docs/en/graph-horizon/overview/
-   Graph Explorer:
    https://thegraph.com/docs/en/subgraphs/existing-subgraphs/explorer/
-   Delegating:
    https://thegraph.com/docs/en/resources/roles/delegating/delegating/

------------------------------------------------------------------------

# 96. Final Takeaway

The easiest way to understand The Graph is:

``` text
RAW BLOCKCHAIN DATA
        ↓
     INDEXING
        ↓
   SUBGRAPH / STREAM
        ↓
STRUCTURED DATA
        ↓
 GRAPHQL / STREAM
        ↓
      DAPP
```

For a Solidity developer, focus on this pipeline:

``` text
Solidity events
      ↓
subgraph.yaml
      ↓
schema.graphql
      ↓
mapping.ts
      ↓
Graph Node
      ↓
entities
      ↓
GraphQL
      ↓
React
```

Then add:

``` text
Viem/Wagmi → writes + direct contract access
The Graph  → indexed reads
Substreams → high-performance streaming
Horizon    → modular data services
```

If you can build a complete Subgraph from a Solidity contract, query it
from React, explain Indexers/Curators/Delegators, and compare Subgraphs
with Substreams, you have the core The Graph knowledge expected from a
modern Web3 developer.
