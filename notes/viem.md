# Complete Viem Master Guide: From Zero to Production

A comprehensive, production-grade reference and deep-dive learning guide for **Viem** (TypeScript Interface for Ethereum), based on the official [Viem Documentation](https://viem.sh/docs/introduction).

---

## Table of Contents

1. [Introduction & Core Philosophy](#1-introduction--core-philosophy)
2. [Installation & Setup](#2-installation--setup)
3. [Clients & Transports](#3-clients--transports)
   - [Public Client](#public-client)
   - [Wallet Client](#wallet-client)
   - [Test Client](#test-client)
   - [Transports (HTTP, WebSocket, IPC, Fallback, Custom)](#transports)
4. [Accounts & Signers](#4-accounts--signers)
   - [JSON-RPC Accounts](#json-rpc-accounts)
   - [Local Accounts (Private Key & Mnemonic)](#local-accounts)
   - [Custom & Smart Contract Accounts](#custom--smart-contract-accounts)
5. [Public Actions (Reading State)](#5-public-actions-reading-state)
6. [Wallet Actions (State Mutating & Signing)](#6-wallet-actions-state-mutating--signing)
7. [Smart Contract Interactivity](#7-smart-contract-interactivity)
   - [Strongly-Typed ABIs (`as const`)](#strongly-typed-abis-as-const)
   - [`readContract` & `simulateContract`](#readcontract--simulatecontract)
   - [`writeContract` & `deployContract`](#writecontract--deploycontract)
   - [`getContract` Wrapper](#getcontract-wrapper)
   - [Event Subscriptions (`watchContractEvent`)](#event-subscriptions)
8. [ABI Utilities & Parsing](#8-abi-utilities--parsing)
9. [Units, Hex & Utility Functions](#9-units-hex--utility-functions)
10. [ENS (Ethereum Name Service) & SIWE](#10-ens--siwe)
11. [Advanced & EIP Standards (EIP-1559, EIP-4844 Blobs, EIP-7702)](#11-advanced--eip-standards)
12. [Test Actions (Anvil / Hardhat / Ganache)](#12-test-actions)
13. [Error Handling & Best Practices](#13-error-handling--best-practices)

---

## 1. Introduction & Core Philosophy

### What is Viem?

**Viem** is a lightweight, modular, and composable TypeScript interface for Ethereum. Developed by the team behind `wagmi`, Viem was created to solve the **quadrilemma** of existing web3 JS/TS libraries (Ethers.js, Web3.js):

- **Developer Experience (DX)**: Automatic TypeScript inferencing via `abitype`, predictable APIs, and zero implicit mutations.
- **Stability**: Tree-shakeable, functional-first primitives with robust unit & integration test coverage.
- **Bundle Size**: Up to 10x–20x smaller than Ethers v5/Web3.js (under ~15kB minified + gzipped for core actions).
- **Performance**: Asynchronous decoding, direct JSON-RPC mapping, lightweight payload serialization.

### Functional Architecture vs Object-Oriented

Unlike Ethers.js where actions are attached to instances (e.g. `contract.transfer()`), Viem favors a **tree-shakeable action design**:

```ts
import { createPublicClient, http } from "viem";
import { mainnet } from "viem/chains";
import { getBalance } from "viem/actions";

const client = createPublicClient({ chain: mainnet, transport: http() });

// Method 1: Client decoration (Syntactic sugar)
const balance1 = await client.getBalance({ address: "0x..." });

// Method 2: Tree-shakeable standalone action
const balance2 = await getBalance(client, { address: "0x..." });
```

---

## 2. Installation & Setup

### Package Installation

Viem relies on modern Node.js environments and browser ESNext compatibility.

```bash
# npm
npm install viem

# pnpm
pnpm add viem

# yarn
yarn add viem
```

### TypeScript Configuration (`tsconfig.json`)

Ensure your TypeScript environment supports strict mode and `as const` ABI inference:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "skipLibCheck": true
  }
}
```

---

## 3. Clients & Transports

Clients are the core abstraction for interacting with Ethereum nodes. Viem categorizes clients into **Public**, **Wallet**, and **Test** clients.

### Public Client

Used for read-only operations on the blockchain (reading blocks, balances, event logs, contract states).

```ts
import { createPublicClient, http } from "viem";
import { mainnet } from "viem/chains";

export const publicClient = createPublicClient({
  chain: mainnet,
  transport: http("https://eth-mainnet.g.alchemy.com/v2/YOUR_API_KEY"),
  pollingInterval: 4_000, // Optional: block polling frequency in ms
});

// Usage:
const blockNumber = await publicClient.getBlockNumber();
console.log("Current Block:", blockNumber);
```

### Wallet Client

Used to sign transactions, send ETH/tokens, sign messages, and interact with user accounts (MetaMask, Coinbase Wallet, or Private Keys).

```ts
import { createWalletClient, custom, http } from "viem";
import { mainnet } from "viem/chains";

// 1. Browser Extension (Window.ethereum / EIP-1193)
export const walletClientInBrowser = createWalletClient({
  chain: mainnet,
  transport: custom(window.ethereum!),
});

// 2. Node.js with explicit Private Key Account
import { privateKeyToAccount } from "viem/accounts";

const account = privateKeyToAccount("0xPRIV_KEY...");
export const nodeWalletClient = createWalletClient({
  account,
  chain: mainnet,
  transport: http(),
});
```

### Test Client

Provides methods to manipulate local test nodes such as **Anvil**, **Hardhat**, or **Ganache**.

```ts
import { createTestClient, http } from "viem";
import { mainnet } from "viem/chains";

export const testClient = createTestClient({
  chain: mainnet,
  mode: "anvil",
  transport: http("http://127.0.0.1:8545"),
});
```

### Transports

Transports define _how_ Viem communicates with the Ethereum node.

#### 1. HTTP Transport

```ts
import { http } from "viem";

const transport = http("https://mainnet.infura.io/v3/YOUR_KEY", {
  batch: true, // Batch JSON-RPC requests automatically
  retryCount: 3,
  timeout: 10_000,
});
```

#### 2. WebSocket Transport (Real-time updates)

```ts
import { webSocket } from "viem";

const transport = webSocket("wss://mainnet.infura.io/ws/v3/YOUR_KEY", {
  reconnect: true,
});
```

#### 3. Fallback Transport (High Availability / Failover)

Automatically switches RPC endpoints if one rate-limits or fails.

```ts
import { fallback, http } from "viem";

const transport = fallback(
  [
    http("https://eth-mainnet.g.alchemy.com/v2/KEY_1"),
    http("https://mainnet.infura.io/v3/KEY_2"),
    http("https://cloudflare-eth.com"),
  ],
  {
    rank: true, // Automatically ranks endpoints based on latency & success rate
  },
);
```

#### 4. Custom (EIP-1193 Provider)

```ts
import { custom } from "viem";

const transport = custom(window.ethereum);
```

---

## 4. Accounts & Signers

Viem handles accounts explicitly without hidden state.

### JSON-RPC Accounts

Represents an account stored on the external wallet node (e.g. MetaMask). Address is specified as a string.

```ts
const [address] = await walletClient.requestAddresses();

await walletClient.sendTransaction({
  account: address, // JSON-RPC account address
  to: "0xa5cc3c43e7441ce24ece33875e500a3cc069a655",
  value: 100000000000000000n, // 0.1 ETH
});
```

### Local Accounts

Private keys or seed phrases stored locally inside application memory.

```ts
import { privateKeyToAccount, mnemonicToAccount } from "viem/accounts";

// From Private Key
const accountFromPK = privateKeyToAccount(
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
);

// From Mnemonic (BIP-39)
const accountFromMnemonic = mnemonicToAccount(
  "test test test test test test test test test test test junk",
  { addressIndex: 0 }, // HD derivation path index
);

console.log("Account Address:", accountFromPK.address);
```

---

## 5. Public Actions (Reading State)

Public Actions allow querying any chain data.

```ts
import { publicClient } from "./client";
import { parseAbiItem } from "viem";

// 1. Fetch ETH Balance
const balance = await publicClient.getBalance({
  address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", // vitalik.eth
});

// 2. Fetch Latest Block & Gas Information
const block = await publicClient.getBlock({ blockTag: "latest" });
console.log("Base Fee Per Gas:", block.baseFeePerGas);

// 3. Fetch Transaction Receipt
const receipt = await publicClient.getTransactionReceipt({
  hash: "0x5c504ed432cb51138bcf09aa5e8a410dd4a1e204ef84bfed1be16dfba1b22060",
});

// 4. Query Historical Logs (Events)
const logs = await publicClient.getLogs({
  address: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48", // USDC Token
  event: parseAbiItem(
    "event Transfer(address indexed from, address indexed to, uint256 value)",
  ),
  fromBlock: 18000000n,
  toBlock: 18000100n,
});

// 5. Watch Real-time Block Numbers
const unwatch = publicClient.watchBlockNumber({
  onBlockNumber: (blockNumber) => console.log("New Block:", blockNumber),
});
// Stop watching: unwatch()
```

---

## 6. Wallet Actions (State Mutating & Signing)

Wallet actions perform transaction broadcasts and cryptographic signatures.

### Sending ETH

```ts
import { parseEther } from "viem";

const txHash = await walletClient.sendTransaction({
  account,
  to: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
  value: parseEther("0.05"), // Conversions yield BigInt
});
```

### Signing Messages & EIP-712 Typed Data

```ts
// 1. Plain Text Message
const signature = await walletClient.signMessage({
  account,
  message: "Hello Viem!",
});

// 2. Structured Data (EIP-712)
const domain = {
  name: "Ether Mail",
  version: "1",
  chainId: 1,
  verifyingContract: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCccccccCC" as const,
};

const types = {
  Person: [
    { name: "name", type: "string" },
    { name: "wallet", type: "address" },
  ],
  Mail: [
    { name: "from", type: "Person" },
    { name: "to", type: "Person" },
    { name: "contents", type: "string" },
  ],
} as const;

const typedSig = await walletClient.signTypedData({
  account,
  domain,
  types,
  primaryType: "Mail",
  message: {
    from: { name: "Cow", wallet: "0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826" },
    to: { name: "Bob", wallet: "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbBbBbBbgeneral" },
    contents: "Hello, Bob!",
  },
});
```

---

## 7. Smart Contract Interactivity

Viem provides unparalleled end-to-end type safety for EVM Smart Contracts when combining TypeScript `as const` with JSON ABIs.

### Strongly-Typed ABIs (`as const`)

```ts
export const erc20Abi = [
  {
    type: "function",
    name: "balanceOf",
    stateMutability: "view",
    inputs: [{ name: "account", type: "address" }],
    outputs: [{ name: "", type: "uint256" }],
  },
  {
    type: "function",
    name: "transfer",
    stateMutability: "nonpayable",
    inputs: [
      { name: "recipient", type: "address" },
      { name: "amount", type: "uint256" },
    ],
    outputs: [{ name: "", type: "bool" }],
  },
  {
    type: "event",
    name: "Transfer",
    inputs: [
      { indexed: true, name: "from", type: "address" },
      { indexed: true, name: "to", type: "address" },
      { indexed: false, name: "value", type: "uint256" },
    ],
  },
] as const; // <--- CRITICAL: 'as const' enables full TypeScript static types!
```

### `readContract` & `simulateContract`

```ts
// 1. Read Contract State
const balance = await publicClient.readContract({
  address: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48", // USDC
  abi: erc20Abi,
  functionName: "balanceOf", // Auto-completed by IDE!
  args: ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045"], // Inferred as [address]
});

// 2. Simulate Write Transaction BEFORE Execution (Prevents failed gas spending)
const { request } = await publicClient.simulateContract({
  account,
  address: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
  abi: erc20Abi,
  functionName: "transfer",
  args: ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", 1000000n],
});
```

### `writeContract` & `deployContract`

```ts
// Execute using simulated request:
const hash = await walletClient.writeContract(request);

// Wait for transaction receipt
const receipt = await publicClient.waitForTransactionReceipt({ hash });
console.log("Transaction Confirmed in Block:", receipt.blockNumber);
```

### `getContract` Wrapper

Provides an object-oriented syntax wrapper around contract methods while preserving full type inference.

```ts
import { getContract } from "viem";

const usdcContract = getContract({
  address: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
  abi: erc20Abi,
  client: { public: publicClient, wallet: walletClient },
});

// Read
const bal = await usdcContract.read.balanceOf(["0x..."]);

// Write
const txHash = await usdcContract.write.transfer(["0x...", 500000n]);
```

---

## 8. ABI Utilities & Parsing

Viem includes human-readable ABI parsers (`parseAbi`, `parseAbiItem`) and low-level encoders/decoders.

```ts
import {
  parseAbi,
  encodeFunctionData,
  decodeFunctionResult,
  encodeAbiParameters,
  decodeAbiParameters,
} from "viem";

// 1. Human Readable ABI Definition
const abi = parseAbi([
  "function balanceOf(address owner) view returns (uint256)",
  "function transfer(address to, uint256 amount) returns (bool)",
  "event Transfer(address indexed from, address indexed to, uint256 amount)",
]);

// 2. Encode Call Data for low-level execution
const calldata = encodeFunctionData({
  abi,
  functionName: "transfer",
  args: ["0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", 1000n],
});
console.log("Encoded Calldata:", calldata); // 0xa9059cbb...

// 3. Encode & Decode Arbitrary ABI Parameters
const encoded = encodeAbiParameters(
  [{ type: "string" }, { type: "uint256" }],
  ["Viem Mastery", 42n],
);

const decoded = decodeAbiParameters(
  [{ type: "string" }, { type: "uint256" }],
  encoded,
);
// decoded -> ['Viem Mastery', 42n]
```

---

## 9. Units, Hex & Utility Functions

Handling EVM BigInts, ether unit conversions, byte manipulations, and hashing.

### Unit Conversions (Ether & Gwei)

```ts
import {
  parseEther,
  formatEther,
  parseGwei,
  formatGwei,
  parseUnits,
  formatUnits,
} from "viem";

// Ether <-> Wei
const weiVal = parseEther("1.5"); // 1500000000000000000n (BigInt)
const ethVal = formatEther(1500000000000000000n); // "1.5" (string)

// Custom Decimals (e.g. USDC has 6 decimals)
const usdcUnits = parseUnits("100.50", 6); // 100500000n
const usdcStr = formatUnits(100500000n, 6); // "100.5"
```

### Formatting & Crypto Utilities

```ts
import {
  isAddress,
  getAddress,
  keccak256,
  toHex,
  fromHex,
  hashMessage,
} from "viem";

// Checksum Validation
console.log(isAddress("0xd8da6bf26964af9d7eed9e03e53415d37aa96045")); // true
const checksummed = getAddress("0xd8da6bf26964af9d7eed9e03e53415d37aa96045");
// -> '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045'

// Keccak-256 Hashing
const hash = keccak256(toHex("Hello World"));

// Hex Conversions
const hex = toHex(255); // '0xff'
const num = fromHex("0xff", "number"); // 255
```

---

## 10. ENS & SIWE

### Ethereum Name Service (ENS)

```ts
import { publicClient } from "./client";

// Resolve Name to Address
const address = await publicClient.getEnsAddress({
  name: "vitalik.eth",
});

// Reverse Resolve Address to Primary Name
const name = await publicClient.getEnsName({
  address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
});

// Fetch Avatar URL
const avatarUrl = await publicClient.getEnsAvatar({
  name: "vitalik.eth",
});
```

### Sign-In With Ethereum (SIWE - EIP-4361)

```ts
import { createSiweMessage, verifySiweMessage } from "viem/siwe";

const message = createSiweMessage({
  domain: "example.com",
  address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
  statement: "Sign in with Ethereum to the app.",
  uri: "https://example.com/login",
  version: "1",
  chainId: 1,
  nonce: "32165498",
});

// Verify Signature
const valid = await verifySiweMessage(publicClient, {
  message,
  signature: "0x...",
});
```

---

## 11. Advanced & EIP Standards

### EIP-1559 Dynamic Fee Estimation

```ts
const feeHistory = await publicClient.getFeeHistory({
  blockCount: 4,
  rewardPercentiles: [25, 50, 75],
});

const estimate = await publicClient.estimateFeesPerGas();
console.log("Max Fee Per Gas:", estimate.maxFeePerGas);
console.log("Max Priority Fee Per Gas:", estimate.maxPriorityFeePerGas);
```

### EIP-4844 Blob Transactions (Proto-Danksharding)

Viem natively supports blob sidecars for Layer 2 rollup batch submissions.

```ts
import { stringToHex } from 'viem'
import { privateKeyToAccount } from 'viem/accounts'

const blobHash = await walletClient.sendTransaction({
  account,
  to: '0x0000000000000000000000000000000000000000',
  blobs: [stringToHex('hello blob world')],
  kzg: { ... }, // KZG commitment setup
  maxFeePerBlobGas: 100n,
})
```

### Defining Custom EVM Chains

```ts
import { defineChain } from "viem";

export const myCustomL2 = defineChain({
  id: 123456,
  name: "My Custom L2",
  nativeCurrency: { name: "Ether", symbol: "ETH", decimals: 18 },
  rpcUrls: {
    default: { http: ["https://rpc.mycustoml2.io"] },
  },
  blockExplorers: {
    default: { name: "Explorer", url: "https://explorer.mycustoml2.io" },
  },
});
```

---

## 12. Test Actions (Anvil / Hardhat Node Testing)

Speed up end-to-end testing by controlling local node execution state.

```ts
import { testClient } from "./client";

// 1. Mine blocks manually
await testClient.mine({ blocks: 5 });

// 2. Set account ETH balance
await testClient.setBalance({
  address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
  value: parseEther("1000"),
});

// 3. Impersonate Account (Send transactions on behalf of any address without private key!)
await testClient.impersonateAccount({
  address: "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
});

// 4. Take Snapshot & Revert
const snapshotId = await testClient.snapshot();
// ... execute test actions ...
await testClient.revert({ id: snapshotId });
```

---

## 13. Error Handling & Best Practices

Viem categorizes errors systematically under `BaseError`.

```ts
import { BaseError, ContractFunctionRevertedError, UserRejectedRequestError } from 'viem'

try {
  await walletClient.writeContract(...)
} catch (err) {
  if (err instanceof BaseError) {
    const revertError = err.walk((e) => e instanceof ContractFunctionRevertedError)
    if (revertError instanceof ContractFunctionRevertedError) {
      console.error('Revert Reason:', revertError.data?.errorName)
    }

    const userRejected = err.walk((e) => e instanceof UserRejectedRequestError)
    if (userRejected) {
      console.log('User rejected transaction request in wallet.')
    }
  }
}
```

### Production Checklist

1. **Always use `as const`** on ABI definitions to unlock strict TypeScript type checking.
2. **Simulate transactions (`simulateContract`)** before calling `writeContract` to catch execution failures early without burning gas.
3. **Use `fallback()` transport** in production to prevent single-point-of-failure RPC downtime.
4. **Prefer `BigInt` (e.g. `100n`)** over strings/numbers for all EVM quantities, gas estimates, and token amounts.
