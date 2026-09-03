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
14. [Interview Questions & Answers (Q&A)](#14-interview-questions--answers-qa)
15. [Rapid-Fire Revision Q&A](#15-rapid-fire-revision-qa)

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

---

## 14. Interview Questions & Answers (Q&A)

### Q1: What is the main architectural difference between Viem and Ethers v5/v6?

**Answer:**
Ethers is monolithic and object-oriented (`new ethers.Contract()`, `new ethers.providers.Web3Provider()`). As a consequence, bundling tools cannot easily tree-shake unused utilities.

Viem uses a **stateless, functional architecture**. Core actions (such as `getBalance`, `readContract`, `sendTransaction`) are exported as standalone pure functions that accept lightweight `Client` objects as their first parameter. This allows modern bundlers (Vite, Next.js, Webpack) to remove unused code, keeping bundle sizes under ~15kB compared to 100kB+ in traditional libraries.

---

### Q2: Why is `as const` mandatory when defining ABIs in Viem? How does `abitype` work under the hood?

**Answer:**
In TypeScript, arrays and objects are mutable by default, so TS infers ABI inputs as general strings (`type: string`) rather than literal types (`type: 'address'`).

Adding `as const` forces TypeScript to treat the JSON ABI as immutable literal types. Viem leverages `@wevm/abitype` mapped generics under the hood to parse ABI inputs and outputs at compile-time. This provides instant IDE auto-completion for contract function names, argument types, and return values without requiring code generation tools like TypeChain.

```ts
// Without 'as const': TS sees string[]
// With 'as const': TS sees exact function signature & parameter types!
const abi = [
  {
    type: "function",
    name: "balanceOf",
    inputs: [{ name: "owner", type: "address" }],
    outputs: [{ type: "uint256" }],
    stateMutability: "view",
  },
] as const;
```

---

### Q3: What is the difference between `readContract` and `simulateContract`? Why should you always call `simulateContract` before `writeContract`?

**Answer:**

- `readContract`: Executes `eth_call` for `pure` or `view` functions that do not alter blockchain state.
- `simulateContract`: Performs an `eth_call` dry-run for state-changing functions (`nonpayable` or `payable`). It returns a prepared `request` object.

Calling `simulateContract` before `writeContract` ensures that if the transaction will revert on-chain (e.g., due to insufficient balance, allowance, or unfulfilled contract conditions), the error is caught client-side **before broadcasting**. This prevents users from wasting real gas fees on failing transactions.

```ts
// 1. Dry run simulation
const { request } = await publicClient.simulateContract({
  account,
  address: tokenAddress,
  abi: erc20Abi,
  functionName: "transfer",
  args: [recipient, amount],
});

// 2. Broadcast only if simulation succeeds
const hash = await walletClient.writeContract(request);
```

---

### Q4: Explain the difference between JSON-RPC Accounts and Local Accounts in Viem.

**Answer:**

- **JSON-RPC Account**: Represented as a plain address string (`'0x...'`). Cryptographic key management and signing are handled externally by a wallet extension or node (e.g. MetaMask via EIP-1193 `eth_sendTransaction`).
- **Local Account** (`privateKeyToAccount`, `mnemonicToAccount`): Holds the private key in local JavaScript memory. Cryptographic signing occurs directly inside your application process (ECDSA), and the signed payload is broadcast using `eth_sendRawTransaction`.

---

### Q5: How does Viem handle RPC node failure and rate limiting in production?

**Answer:**
Viem provides a native `fallback()` transport. Developers can list multiple HTTP or WebSocket RPC endpoints along with retry policies and latency ranking options.

If the primary RPC endpoint returns HTTP 429 (Too Many Requests), times out, or experiences a network error, Viem automatically and transparently retries the JSON-RPC request on the next healthy provider in the fallback stack.

```ts
import { fallback, http } from "viem";

const transport = fallback(
  [
    http("https://eth-mainnet.g.alchemy.com/v2/KEY"),
    http("https://mainnet.infura.io/v3/KEY"),
  ],
  { rank: true },
);
```

---

### Q6: How do native JS `BigInt` values solve issues previously handled by Ethers' `BigNumber` library?

**Answer:**
Ethers v5 relied on a custom `BigNumber` wrapper class because JavaScript historical `Number` type lost precision past $2^{53} - 1$. This required verbose instance calls like `bn.add(other)`.

Viem natively uses ES2020 `BigInt` primitives (e.g. `1000000000000000000n`). Native arithmetic operators (`+`, `-`, `*`, `/`, `<`, `>`) work directly without wrapper objects. Viem utilities (`parseEther`, `formatEther`, `parseUnits`) accept and return native `BigInt`s directly.

---

### Q7: How do you extract and handle custom contract revert errors in Viem?

**Answer:**
All Viem errors inherit from `BaseError`. You use the `err.walk()` method to recursively inspect the causal chain for `ContractFunctionRevertedError`. If found, you can read `revertError.data?.errorName` to identify custom Solidity error names.

```ts
try {
  await walletClient.writeContract(request);
} catch (err) {
  if (err instanceof BaseError) {
    const revertErr = err.walk(
      (e) => e instanceof ContractFunctionRevertedError,
    );
    if (revertErr instanceof ContractFunctionRevertedError) {
      console.error("Reverted with reason:", revertErr.data?.errorName);
    }
  }
}
```

---

### Q8: How do you listen to real-time smart contract events in Viem?

**Answer:**
Using `publicClient.watchContractEvent()`:

```ts
const unwatch = publicClient.watchContractEvent({
  address: "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48",
  abi: erc20Abi,
  eventName: "Transfer",
  onLogs: (logs) => {
    logs.forEach((log) =>
      console.log(log.args.from, log.args.to, log.args.value),
    );
  },
});

// Unsubscribe when done
// unwatch()
```

---

### Q9: How do you sign and verify EIP-712 Structured Typed Data in Viem?

**Answer:**
Use `walletClient.signTypedData()`:

```ts
const signature = await walletClient.signTypedData({
  account,
  domain: {
    name: "MyApp",
    version: "1",
    chainId: 1,
    verifyingContract: "0x...",
  },
  types: { Mail: [{ name: "contents", type: "string" }] },
  primaryType: "Mail",
  message: { contents: "Hello!" },
});

const valid = await publicClient.verifyTypedData({
  address: account.address,
  domain: {
    name: "MyApp",
    version: "1",
    chainId: 1,
    verifyingContract: "0x...",
  },
  types: { Mail: [{ name: "contents", type: "string" }] },
  primaryType: "Mail",
  message: { contents: "Hello!" },
  signature,
});
```

---

### Q10: What are EIP-4844 Blob Transactions, and how does Viem support them?

**Answer:**
EIP-4844 introduced blob-carrying transactions ("Proto-Danksharding") to significantly reduce L2 rollup transaction fees. Viem provides native support by allowing developers to pass `blobs` (array of hex strings or bytes) and `kzg` commitments directly inside `sendTransaction`:

```ts
await walletClient.sendTransaction({
  account,
  to: "0x0000000000000000000000000000000000000000",
  blobs: [stringToHex("Blob payload data")],
  kzg,
  maxFeePerBlobGas: 100n,
});
```

---

### Q11: How do `Test Actions` assist in writing deterministic integration tests with Anvil?

**Answer:**
Viem's `TestClient` exposes methods to control local nodes (Anvil/Hardhat):

- `testClient.impersonateAccount({ address })`: Transact from any address without needing its private key.
- `testClient.setBalance({ address, value })`: Set ETH balance arbitrarily.
- `testClient.mine({ blocks: 5 })`: Mine blocks instantly.
- `testClient.snapshot()` & `testClient.revert({ id })`: Save and reset node state between tests.

---

### Q12: What is EIP-7702 and how does Viem support account delegation?

**Answer:**
EIP-7702 allows standard EOAs (Externally Owned Accounts) to temporarily adopt Smart Contract Account code during transaction execution. Viem supports signing authorization tuples via `walletClient.signAuthorization()` and attaching `authorizationList` payloads to transaction requests.

---

### Q13: How do you batch multiple read requests in Viem to optimize network calls?

**Answer:**

1. **HTTP Batching**: Enable `batch: true` on `http()` transport to aggregate multiple JSON-RPC calls made in the same event loop tick into a single HTTP POST payload.
2. **Multicall**: Use `publicClient.multicall({ contracts: [...] })` to aggregate multiple smart contract read calls into a single `eth_call` via MakerDAO's Multicall3 contract.

---

### Q14: What is the purpose of `getContract` in Viem?

**Answer:**
`getContract` creates a typed object-oriented wrapper around `publicClient` and `walletClient` for a specific contract address and ABI:

```ts
const contract = getContract({
  address,
  abi,
  client: { public: publicClient, wallet: walletClient },
});
const balance = await contract.read.balanceOf(["0x..."]);
const txHash = await contract.write.transfer(["0x...", 100n]);
```

It provides ergonomic convenience for object-style usage while preserving full static TypeScript inferencing.

---

### Q15: How do you define a custom EVM L2 chain in Viem if it is not present in `viem/chains`?

**Answer:**
Use `defineChain()`:

```ts
import { defineChain } from "viem";

export const myL2 = defineChain({
  id: 99999,
  name: "My Custom Rollup",
  nativeCurrency: { name: "Ether", symbol: "ETH", decimals: 18 },
  rpcUrls: { default: { http: ["https://rpc.myl2.io"] } },
  blockExplorers: {
    default: { name: "Explorer", url: "https://explorer.myl2.io" },
  },
});
```

---

## 15. Rapid-Fire Revision Q&A

| #      | Question                                           | Answer                                                                        |
| ------ | -------------------------------------------------- | ----------------------------------------------------------------------------- |
| **1**  | What is Viem?                                      | A lightweight, modular, tree-shakeable TypeScript interface for Ethereum/EVM. |
| **2**  | Which team created Viem?                           | `wevm` (the team behind `wagmi`).                                             |
| **3**  | Bundle size comparison vs Ethers v5?               | ~10x to 20x smaller (~15kB vs 100kB+ minified+gzipped).                       |
| **4**  | Does Viem use custom `BigNumber` objects?          | No, it uses ES2020 native `BigInt` (e.g. `100n`).                             |
| **5**  | What TS modifier is required on ABI arrays?        | `as const`.                                                                   |
| **6**  | Which library powers Viem's static type inference? | `@wevm/abitype`.                                                              |
| **7**  | Client used for read-only chain queries?           | `PublicClient` (`createPublicClient`).                                        |
| **8**  | Client used for signing transactions & messages?   | `WalletClient` (`createWalletClient`).                                        |
| **9**  | Client used for controlling local test nodes?      | `TestClient` (`createTestClient`).                                            |
| **10** | How to convert 1.5 ETH to Wei in Viem?             | `parseEther('1.5')` (returns `1500000000000000000n`).                         |
| **11** | How to convert Wei to an Ether string?             | `formatEther(1500000000000000000n)` (returns `'1.5'`).                        |
| **12** | Transport for browser extensions (MetaMask)?       | `custom(window.ethereum)`.                                                    |
| **13** | How to set up multi-RPC failover?                  | Wrap `http()` providers inside `fallback([...])`.                             |
| **14** | Action to dry-run a write TX before sending?       | `publicClient.simulateContract()`.                                            |
| **15** | How to wait for a transaction hash to be mined?    | `publicClient.waitForTransactionReceipt({ hash })`.                           |
| **16** | Function to create account from private key hex?   | `privateKeyToAccount('0x...')`.                                               |
| **17** | Function to parse human-readable ABI strings?      | `parseAbi(['function transfer(address, uint256)'])`.                          |
| **18** | How to compute Keccak-256 hash in Viem?            | `keccak256(toHex('hello'))`.                                                  |
| **19** | Method used to traverse nested Viem errors?        | `err.walk()`.                                                                 |
| **20** | Function to resolve an ENS domain to address?      | `publicClient.getEnsAddress({ name: 'vitalik.eth' })`.                        |
| **21** | How to impersonate an address in Anvil?            | `testClient.impersonateAccount({ address: '0x...' })`.                        |
| **22** | How to enable HTTP JSON-RPC request batching?      | Pass `{ batch: true }` option to `http()`.                                    |
| **23** | Standard introducing L2 Blob Transactions?         | EIP-4844 (Proto-Danksharding).                                                |
| **24** | Action to sign EIP-712 structured typed data?      | `walletClient.signTypedData(...)`.                                            |
| **25** | Function to construct a contract wrapper instance? | `getContract({ address, abi, client })`.                                      |
