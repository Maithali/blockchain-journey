# 🌈 RainbowKit Learning Guide

> A practical, interview-ready guide to RainbowKit for building
> React-based Web3 dApps.

**Source:** Official RainbowKit documentation\
**Current docs version checked:** 2.2.11

## How to Use This Guide

This guide is written for someone who is new to frontend Web3
development. Read the first sections in order. They explain the problem
RainbowKit solves, the tools around it, and the smallest working setup.
The later sections work as a reference when you start adding networks,
custom UI, authentication, or smart-contract calls.

You do not need to memorize every API. Try to understand these four
questions whenever you read an example:

1. **What does the user see?** Usually this is RainbowKit's wallet UI.
2. **What state does the React app need?** Wagmi exposes account, chain,
   balance, and transaction state through hooks.
3. **How does the app communicate with the EVM?** Viem creates typed
   requests that travel through a wallet or an RPC transport.
4. **What must be trusted?** The wallet approves signatures, while the
   smart contract enforces on-chain rules.

> **Important:** Code in this note is educational. Replace placeholder
> project IDs, RPC URLs, contract addresses, and ABIs before using it in
> a real application. Never put a private key in frontend code.

## 0. Prerequisites

RainbowKit is a React library, so it is not a replacement for React,
JavaScript, or a smart contract. Before starting, you should be
comfortable with:

- JavaScript modules such as `import` and `export`
- React components and JSX
- `npm install` and running a development server
- The basic idea of an Ethereum address and a blockchain transaction

You can learn the advanced parts while building. For example, you do
not need to know every detail of Viem before displaying a Connect Wallet
button.

### A few words you will see often

| Term            | Beginner-friendly meaning                                                                                                |
| --------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **dApp**        | An application whose important rules or data use a blockchain.                                                           |
| **EVM**         | The Ethereum Virtual Machine, the execution environment used by Ethereum and many compatible chains.                     |
| **Wallet**      | Software that controls a user's private keys and asks for approval before signing.                                       |
| **Address**     | A public identifier, similar to an account number. It is safe to display and share.                                      |
| **Private key** | Secret data that controls an address. Anyone who has it can control the funds, so it must never be requested or exposed. |
| **RPC**         | The communication endpoint a frontend uses to ask a blockchain node for data or to broadcast a transaction.              |
| **Chain**       | One blockchain network, such as Ethereum Mainnet or Sepolia. Each chain has its own chain ID.                            |
| **Gas**         | The fee paid for computation and state changes on an EVM network.                                                        |
| **Testnet**     | A network used for development and testing. Testnet assets are not real assets.                                          |

### Read versus write

Most blockchain actions fit into one of two categories:

- A **read** asks the chain for existing information. Examples include
  reading a token balance or checking an owner's address. A read normally
  does not need a wallet signature and does not cost the user gas.
- A **write** requests a state change. Examples include transferring a
  token, voting, or minting an NFT. The wallet normally asks the user to
  sign a transaction, and the transaction may require gas.

This distinction explains much of the RainbowKit ecosystem. RainbowKit
helps the user connect a wallet. Wagmi and Viem then help your React app
read from contracts or prepare and send writes.

## 0.1 The Complete Request Story

Imagine a user clicking **Connect Wallet**:

```text
User clicks a button
        |
        v
RainbowKit opens a wallet-selection modal
        |
        v
The selected wallet exposes a standard provider
        |
        v
The user approves the connection in the wallet
        |
        v
Wagmi stores the connected address and chain in React state
        |
        v
Your components render the connected state
```

Now imagine the user clicking **Transfer**:

```text
React component
        |
        v
Wagmi/Viem prepares the contract call
        |
        v
Wallet shows the exact transaction request
        |
        v
User approves or rejects it
        |
        v
The transaction is broadcast through an RPC transport
        |
        v
The blockchain mines it and returns a receipt
        |
        v
The UI shows success or failure
```

The wallet does not secretly execute the transaction for you. It asks
the user for permission. The blockchain does not know about your button
or modal; it only receives valid requests and executes contract code.

## 0.2 The Libraries in Plain English

### React

React renders the page. It does not know how to connect to Ethereum by
itself.

### RainbowKit

RainbowKit supplies polished wallet connection components and wallet
selection UX. It answers questions such as “Which wallet can the user
connect with?” and “How should the connected wallet be presented?”

### Wagmi

Wagmi connects React components to EVM state. Its hooks let a component
ask questions such as “Is a wallet connected?”, “What is the current
chain?”, and “What is the result of this transaction?”

### Viem

Viem provides the lower-level, typed EVM operations used by Wagmi. It
understands addresses, ABIs, chains, contract calls, and transaction
receipts.

### TanStack Query

Wagmi uses TanStack Query to cache asynchronous data and coordinate
loading, success, and error states. This is why the provider hierarchy
includes `QueryClientProvider`.

### Wallet and RPC

A wallet is used when user permission or a signature is required. An RPC
transport is used when the application needs to communicate with a
blockchain node. A read can often use only RPC; a write generally uses
both the wallet and RPC.

## 0.3 Your First Working Example

The fastest path is to create a small React project with RainbowKit's
scaffold:

```bash
npm init @rainbow-me/rainbowkit@latest
```

The command asks for a project name and creates the main configuration
for you. If you already have a React application, install the packages
manually:

```bash
npm install @rainbow-me/rainbowkit wagmi viem @tanstack/react-query
```

The following example shows the important pieces in one place. It is
usually placed in `main.tsx` or `main.jsx`, depending on the project.

```tsx
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "@rainbow-me/rainbowkit/styles.css";
import { getDefaultConfig, RainbowKitProvider } from "@rainbow-me/rainbowkit";
import { WagmiProvider } from "wagmi";
import { sepolia } from "wagmi/chains";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import App from "./App";

const config = getDefaultConfig({
  appName: "My First dApp",
  // Create this at https://cloud.walletconnect.com/.
  projectId: "YOUR_PROJECT_ID",
  // Sepolia is a testnet, which is safer for learning than Mainnet.
  chains: [sepolia],
});

const queryClient = new QueryClient();

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>
          <App />
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  </StrictMode>,
);
```

Here is the smallest useful `App` component:

```tsx
import { ConnectButton } from "@rainbow-me/rainbowkit";
import { useAccount } from "wagmi";

export default function App() {
  const { address, isConnected, chain } = useAccount();

  return (
    <main>
      <h1>My first dApp</h1>
      <ConnectButton />

      {isConnected ? (
        <p>
          Connected as {address} on {chain?.name}.
        </p>
      ) : (
        <p>Connect a wallet to continue.</p>
      )}
    </main>
  );
}
```

### Reading the example line by line

1. The RainbowKit stylesheet gives the built-in components their layout
   and appearance. Without it, the modal may look broken.
2. `getDefaultConfig` creates one shared configuration for supported
   chains, the application name, and WalletConnect.
3. `WagmiProvider` makes that configuration available to Wagmi hooks.
4. `QueryClientProvider` gives Wagmi a place to cache asynchronous data.
5. `RainbowKitProvider` gives RainbowKit components their context and
   UI settings.
6. `ConnectButton` renders a ready-made connect/disconnect button.
7. `useAccount` reads connection state inside a React component.

All providers must wrap the components that use them. If `App` is
outside `WagmiProvider`, `useAccount` has no Wagmi context and will fail.

## 0.4 What Happens When the User Connects?

The connection flow has several distinct stages:

1. **Disconnected:** The app knows no wallet address.
2. **Modal open:** RainbowKit displays available wallet options.
3. **Wallet approval:** The wallet asks the user to approve the dApp
   connection.
4. **Connected:** Wagmi exposes the address and current chain.
5. **Wrong chain:** The wallet is connected, but the active chain is not
   one your feature supports.
6. **Disconnected again:** The user or wallet removes the connection.

Connection does not give your app the user's private key. It gives the
app permission to request specific wallet actions through the wallet's
provider.

## 0.5 The Most Useful Beginner Hooks

### `useAccount`

Use it to render different UI for connected and disconnected users:

```tsx
const { address, isConnected, chain } = useAccount();
```

`address` may be undefined when disconnected, so do not use it without
checking `isConnected` first.

### `useChainId`

Use it when you need to compare the active network with the network your
feature requires:

```tsx
import { useChainId } from "wagmi";
import { sepolia } from "wagmi/chains";

const chainId = useChainId();
const isCorrectChain = chainId === sepolia.id;
```

### `useBalance`

Use it to read the native currency balance of an address:

```tsx
import { useAccount, useBalance } from "wagmi";

const { address } = useAccount();
const { data: balance, isLoading, isError } = useBalance({ address });

if (isLoading) return <p>Loading balance...</p>;
if (isError) return <p>Could not load balance.</p>;
return (
  <p>
    Balance: {balance?.formatted} {balance?.symbol}
  </p>
);
```

### `useDisconnect`

Use it when you need your own disconnect control:

```tsx
import { useDisconnect } from "wagmi";

const { disconnect } = useDisconnect();

return <button onClick={() => disconnect()}>Disconnect</button>;
```

The default `ConnectButton` already includes connection controls, so you
only need this hook for a custom interface.

## 0.6 Chain IDs and Wrong-Network Errors

A chain name is for humans; a chain ID is the machine-readable identity
of a network. Your application should check the ID, not only the display
name.

```tsx
import { sepolia } from "wagmi/chains";
import { useChainId, useSwitchChain } from "wagmi";

const chainId = useChainId();
const { switchChain } = useSwitchChain();

if (chainId !== sepolia.id) {
  return (
    <button onClick={() => switchChain({ chainId: sepolia.id })}>
      Switch to Sepolia
    </button>
  );
}
```

Why is this necessary? A contract address is meaningful only on the
network where that contract was deployed. The same hexadecimal address
can exist on several chains but point to different code or no code at
all.

## 0.7 The Basic UI States You Should Design

A beginner dApp often works on the happy path and becomes confusing
when a wallet or network behaves differently. Plan for these states:

| State              | What the user needs to know                                                      |
| ------------------ | -------------------------------------------------------------------------------- |
| Loading            | The app is fetching data; keep the user from guessing.                           |
| Disconnected       | Explain that a wallet connection is needed.                                      |
| Wrong chain        | Name the required network and offer a switch action.                             |
| Awaiting signature | The wallet is waiting for the user's approval.                                   |
| Submitted          | The transaction was sent but is not final yet.                                   |
| Confirmed          | The chain accepted the transaction and the UI can refresh.                       |
| Rejected           | The user declined; this is different from a contract failure.                    |
| RPC error          | The app could not communicate with a node; provide a retry path.                 |
| Contract revert    | The contract rejected the requested action; show a useful reason when available. |

Treating these as normal states makes a dApp feel understandable rather
than mysterious.

## 1. What is RainbowKit?

RainbowKit is a React library that makes wallet connection easy for
dApps. It provides wallet connection/disconnection, support for many
wallets, chain switching, ENS resolution, balance display, and
customizable wallet UI.

RainbowKit relies on **Wagmi** and **Viem** for the underlying Web3
stack and supports wallet standards including **EIP-1193** and
**EIP-6963**.

## 2. The Web3 Stack

```text
React
  ↓
RainbowKit
  ↓
Wagmi
  ↓
Viem
  ↓
Wallet / RPC
  ↓
EVM Blockchain
```

Remember:

- **RainbowKit** → wallet connection UI/UX
- **Wagmi** → React hooks and Web3 application state
- **Viem** → typed EVM interaction primitives
- **RPC** → communication with blockchain nodes
- **Wallet** → user authorization and signing
- **Solidity** → smart-contract logic

## 3. Why RainbowKit?

Without a wallet UI library, a dApp may need to build wallet discovery,
connection, disconnection, chain switching, wallet presentation, and
responsive wallet UI itself.

RainbowKit provides these capabilities out of the box and is
customizable.

## 4. Installation

Quick scaffold:

```bash
npm init @rainbow-me/rainbowkit@latest
```

Other package managers:

```bash
pnpm create @rainbow-me/rainbowkit@latest
```

```bash
yarn create @rainbow-me/rainbowkit
```

Manual installation:

```bash
npm install @rainbow-me/rainbowkit wagmi viem @tanstack/react-query
```

## 5. Basic Setup

Import the styles and required libraries:

```tsx
import "@rainbow-me/rainbowkit/styles.css";

import { getDefaultConfig, RainbowKitProvider } from "@rainbow-me/rainbowkit";

import { WagmiProvider } from "wagmi";

import { mainnet, polygon, optimism, arbitrum, base } from "wagmi/chains";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
```

Create the configuration:

```tsx
const config = getDefaultConfig({
  appName: "My RainbowKit App",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet, polygon, optimism, arbitrum, base],
});
```

For SSR:

```tsx
const config = getDefaultConfig({
  appName: "My RainbowKit App",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet],
  ssr: true,
});
```

## 6. Provider Hierarchy

Create a query client:

```tsx
const queryClient = new QueryClient();
```

Wrap your application:

```tsx
function App() {
  return (
    <WagmiProvider config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>{/* Your app */}</RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProvider>
  );
}
```

Mental model:

```text
WagmiProvider
   ↓
QueryClientProvider
   ↓
RainbowKitProvider
   ↓
Your App
```

## 7. ConnectButton

The simplest way to add wallet connection UI:

```tsx
import { ConnectButton } from "@rainbow-me/rainbowkit";

function Header() {
  return <ConnectButton />;
}
```

RainbowKit handles wallet selection, connection, wallet information,
transaction information, and network/wallet switching through its UI.

## 8. WalletConnect Project ID

If your dApp relies on WalletConnect, RainbowKit's documentation
requires a WalletConnect Cloud `projectId`.

```tsx
const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet],
});
```

A project ID is not a wallet private key.

## 9. Chains

Configure only the networks your dApp supports.

```tsx
import { mainnet, sepolia, polygon, arbitrum, base } from "wagmi/chains";
```

Example:

```tsx
const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [sepolia],
});
```

For learning and testing, a testnet such as Sepolia is appropriate.

## 10. Wallet Connection Flow

Understand this sequence:

```text
User opens dApp
       ↓
ConnectButton
       ↓
RainbowKit wallet modal
       ↓
User chooses wallet
       ↓
Wallet provider
       ↓
User approves connection
       ↓
Account connected
       ↓
Wagmi exposes account/chain state
       ↓
Viem can interact with EVM
```

Connection is different from signing a transaction.

## 11. RainbowKit vs Wagmi vs Viem

Technology Main responsibility

---

RainbowKit Wallet connection UI
Wagmi React Web3 hooks/state
Viem EVM interaction
Wallet Signing/authorization
RPC Blockchain communication

Interview answer:

> RainbowKit handles wallet connection UX, Wagmi provides React-oriented
> Web3 hooks and state, and Viem provides the underlying typed EVM
> interaction primitives.

## 12. Chain Switching

A dApp may support multiple networks.

Example:

```text
Ethereum
Polygon
Arbitrum
Optimism
Base
Sepolia
```

Always reason about:

```text
Connected chain
Required chain
Contract deployment chain
```

Example problem:

```text
Wallet → Mainnet
Contract → Sepolia

Result → Wrong network
```

Your application should detect the active chain and guide the user to
the required network.

## 13. ENS and Balances

RainbowKit supports wallet-related information including ENS resolution
and balances.

Example ENS concept:

```text
alice.eth
```

instead of displaying only:

```text
0x1234...abcd
```

## 14. Customization

RainbowKit supports customization including:

- Accent colors
- Border-radius configurations
- Custom themes
- Custom ConnectButton
- Custom wallet list
- Custom wallets
- Custom chains
- Custom app information
- Custom avatars
- Localization
- Modal sizes
- Dark mode
- WalletButton
- Cool Mode

## 15. Theming

For simple customization, use the available theme configuration.

For advanced applications, RainbowKit supports fully custom themes.

Design goal:

```text
Your dApp UI
      +
RainbowKit UI
      ↓
Consistent brand experience
```

## 16. Dark Mode

RainbowKit includes dark-mode support.

Your application should ideally keep the wallet modal visually
consistent with the rest of the dApp.

## 17. Modal Sizes

RainbowKit provides modal-size configuration so developers can adjust
the wallet modal experience for their application.

## 18. Localization

RainbowKit supports localization for applications serving international
users.

## 19. Recent Transactions

RainbowKit includes recent transaction functionality.

A good dApp should communicate transaction state clearly:

```text
Preparing
   ↓
Waiting for signature
   ↓
Submitted
   ↓
Pending
   ↓
Confirmed / Failed
```

## 20. Custom ConnectButton

The default:

```tsx
<ConnectButton />
```

can be replaced with a customized wallet connection experience.

Use this when the default button does not fit your application
navigation or design system.

## 21. Custom Wallet List

RainbowKit allows developers to customize which wallets appear in the
wallet list.

Useful when you want to:

- Emphasize preferred wallets
- Customize wallet presentation
- Build a specialized wallet experience

## 22. Custom Wallets

Advanced applications can integrate custom wallets.

This is different from simply customizing the default wallet list.

## 23. Custom Chains

RainbowKit supports custom chains.

This can be useful for:

- Custom EVM networks
- Application-specific networks
- Private networks
- Networks requiring custom metadata

## 24. Custom App Info

RainbowKit supports custom application information so the wallet
experience can represent your dApp more accurately.

## 25. Custom Avatars

Custom avatars allow further control over the visual identity used in
wallet-related UI.

## 26. Authentication

RainbowKit has authentication-related functionality, but wallet
connection itself should not automatically be treated as server-side
authentication.

A typical authentication architecture is:

```text
Connect wallet
     ↓
Server challenge
     ↓
User signs message
     ↓
Server verifies signature
     ↓
Authenticated session
```

## 27. WalletButton

RainbowKit provides `WalletButton` for more granular wallet-specific UI.

Use it when a normal `ConnectButton` is not the desired experience.

## 28. Cool Mode

Cool Mode is an optional RainbowKit visual/UX feature. It affects
presentation rather than blockchain functionality.

## 29. Production RPC Transports

The official installation documentation notes that default public RPC
providers can be rate-limited and may create reliability issues.

For production, define your own transports.

Example:

```tsx
import { http } from "wagmi";
import { mainnet, sepolia } from "wagmi/chains";

const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet, sepolia],
  transports: {
    [mainnet.id]: http("https://your-mainnet-rpc"),
    [sepolia.id]: http("https://your-sepolia-rpc"),
  },
});
```

A transport is the networking middle layer used to send JSON-RPC
requests to an Ethereum node provider.

Production architecture:

```text
RainbowKit
   ↓
Wagmi
   ↓
Transport
   ↓
RPC Provider
   ↓
Ethereum Node
```

## 30. EIP-1193

EIP-1193 defines a standard Ethereum provider interface.

Conceptually:

```text
dApp
 ↓
Provider interface
 ↓
Wallet
```

This improves interoperability between wallets and dApps.

## 31. EIP-6963

EIP-6963 is a wallet discovery standard designed to improve
interoperability between browser wallets and dApps.

RainbowKit supports EIP-6963.

## 32. RainbowKit + Smart Contracts

RainbowKit is not a Solidity or smart-contract interaction library.

Typical architecture:

```text
RainbowKit
    ↓
Wallet connection
    ↓
Wagmi
    ↓
Viem
    ↓
Smart contract
```

Typical user flow:

```text
Connect wallet
      ↓
Check account
      ↓
Check chain
      ↓
Prepare contract call
      ↓
Wallet confirmation
      ↓
Transaction
      ↓
Receipt
      ↓
Update UI
```

### A contract read: no signature required

Suppose a contract has this Solidity function:

```solidity
function greeting() external view returns (string memory) {
    return "Hello, blockchain!";
}
```

The frontend needs three pieces of information:

1. The deployed contract address on the selected chain.
2. The ABI entry describing the function.
3. The chain on which that address is valid.

The ABI is a machine-readable description of the contract interface. It
does not contain the contract's private source code or state; it tells
the frontend how to encode a call and decode the result.

```tsx
import { useReadContract } from 'wagmi'

const greetingAbi = [
  {
    type: 'function',
    name: 'greeting',
    stateMutability: 'view',
    inputs: [],
    outputs: [{ type: 'string' }],
  },
] as const

const { data: greeting, isLoading, isError } = useReadContract({
  address: '0xYourDeployedContractAddress',
  abi: greetingAbi,
  functionName: 'greeting',
})
```

This is a read because the Solidity function is marked `view`. The
request can normally be sent through an RPC transport without asking the
user to open a wallet. `isLoading`, `isError`, and `greeting` are all
useful UI states; do not render an empty value and make the user guess
whether the request worked.

### A contract write: wallet approval is required

Now suppose the contract has a state-changing function:

```solidity
function setGreeting(string calldata newGreeting) external {
    greeting = newGreeting;
}
```

The frontend can request that write with Wagmi:

```tsx
import {
  useWaitForTransactionReceipt,
  useWriteContract,
} from 'wagmi'

const greetingAbi = [
  {
    type: 'function',
    name: 'setGreeting',
    stateMutability: 'nonpayable',
    inputs: [{ name: 'newGreeting', type: 'string' }],
    outputs: [],
  },
] as const

export function UpdateGreeting() {
  const {
    data: hash,
    error: writeError,
    isPending,
    writeContract,
  } = useWriteContract()

  const { isLoading: isConfirming, isSuccess: isConfirmed } =
    useWaitForTransactionReceipt({ hash })

  function submitGreeting() {
    writeContract({
      address: '0xYourDeployedContractAddress',
      abi: greetingAbi,
      functionName: 'setGreeting',
      args: ['Hello from my dApp!'],
    })
  }

  return (
    <section>
      <button disabled={isPending} onClick={submitGreeting}>
        {isPending ? 'Confirm in wallet...' : 'Update greeting'}
      </button>

      {hash && <p>Transaction submitted: {hash}</p>}
      {isConfirming && <p>Waiting for confirmation...</p>}
      {isConfirmed && <p>Greeting updated successfully.</p>}
      {writeError && <p>Transaction failed or was rejected.</p>}
    </section>
  )
}
```

The two pending stages are deliberately different:

- `isPending` means the wallet request is still awaiting the user's
  approval. The transaction may not have been sent yet.
- `isConfirming` means a transaction hash exists and the application is
  waiting for the blockchain to mine it.

After confirmation, invalidate or refetch the related read so the page
shows the new contract state. A successful wallet approval is not proof
that the contract call succeeded; the receipt is the important result.

### Why address, ABI, and chain must match

If any of these values is wrong, the call can fail or read unrelated
data:

```text
Frontend ABI + contract address + active chain
                must describe
        the same deployed contract
```

Keep deployment information organized, for example in a chain-specific
configuration file. Do not silently reuse a Sepolia address on Mainnet.
Before a write, check the connected chain and disable the action when
the contract is unavailable there.

## 33. RainbowKit + Vite

A common frontend stack:

```text
Vite
 ↓
React
 ↓
RainbowKit
 ↓
Wagmi
 ↓
Viem
```

This is a useful setup for learning and portfolio dApps.

## 34. RainbowKit + Next.js

RainbowKit supports Next.js.

For server-side-rendered applications, configure:

```tsx
ssr: true;
```

Example:

```tsx
const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet, sepolia],
  ssr: true,
});
```

## 35. Security

### Never request private keys

Never ask a user for their MetaMask or other wallet private key.

### Wallet connection is not authentication

Use an explicit challenge/signature flow when implementing
authentication.

### Check the chain

Do not assume the connected network is correct.

### Verify contract addresses

Use the correct contract address for the active network.

### Treat frontend code as untrusted

Important authorization must be enforced by smart contracts and trusted
backend systems.

### Be careful with signatures

Users may sign messages or typed data that have security implications.
Clearly explain what users are signing.

## 36. Common Mistakes

### Mistake 1

Thinking RainbowKit is a blockchain.

It is a React wallet connection library.

### Mistake 2

Thinking RainbowKit replaces Wagmi.

RainbowKit and Wagmi have complementary roles.

### Mistake 3

Thinking RainbowKit replaces Viem.

Viem is the EVM interaction layer.

### Mistake 4

Forgetting styles:

```tsx
import "@rainbow-me/rainbowkit/styles.css";
```

### Mistake 5

Forgetting the provider hierarchy.

```text
WagmiProvider
 ↓
QueryClientProvider
 ↓
RainbowKitProvider
```

### Mistake 6

Using the wrong chain.

### Mistake 7

Forgetting WalletConnect project configuration when required.

### Mistake 8

Relying blindly on public RPC providers in production.

## 37. Debugging Checklist

### Wallet connection

```text
RainbowKit installed?
        ↓
Wagmi installed?
        ↓
Viem installed?
        ↓
TanStack Query installed?
        ↓
RainbowKit styles imported?
        ↓
getDefaultConfig configured?
        ↓
projectId configured?
        ↓
chains configured?
        ↓
WagmiProvider present?
        ↓
QueryClientProvider present?
        ↓
RainbowKitProvider present?
        ↓
ConnectButton rendered?
```

### Contract interaction

```text
Wallet connected?
        ↓
Correct chain?
        ↓
Correct contract address?
        ↓
Correct ABI?
        ↓
Correct function?
        ↓
Correct arguments?
        ↓
Enough funds?
        ↓
Transaction approved?
        ↓
Transaction mined?
        ↓
Receipt successful?
```

## 38. Interview Questions

### Q1. What is RainbowKit?

**Answer:** RainbowKit is a React library that simplifies wallet
connection and wallet management for dApps.

### Q2. Is RainbowKit a blockchain?

**Answer:** No. It is a React wallet connection UI library.

### Q3. What does RainbowKit use underneath?

**Answer:** RainbowKit relies on Wagmi and Viem.

### Q4. RainbowKit vs Wagmi?

**Answer:** RainbowKit primarily provides wallet connection UI, while
Wagmi provides React hooks and Web3 application state.

### Q5. RainbowKit vs Viem?

**Answer:** RainbowKit handles wallet UX; Viem provides typed EVM
interaction primitives.

### Q6. What is `getDefaultConfig`?

**Answer:** It simplifies RainbowKit/Wagmi configuration including app
information, project ID, supported chains, SSR settings, and transports.

### Q7. What is `ConnectButton`?

**Answer:** It is RainbowKit's ready-made wallet connection component.

### Q8. Why is `RainbowKitProvider` required?

**Answer:** It provides the RainbowKit React context needed by
RainbowKit components and functionality.

### Q9. Why is `WagmiProvider` required?

**Answer:** It provides Wagmi's configured React context.

### Q10. Why use `QueryClientProvider`?

**Answer:** The current RainbowKit/Wagmi setup uses TanStack Query, so
the application provides a query client.

### Q11. What is a transport?

**Answer:** It is the networking layer that sends JSON-RPC requests to
an Ethereum node provider.

### Q12. Why configure production transports?

**Answer:** Public RPC endpoints can be rate-limited. Dedicated RPC
infrastructure can improve reliability.

### Q13. Does RainbowKit write smart contracts?

**Answer:** No. Smart-contract interaction is normally handled through
Wagmi/Viem.

### Q14. Does wallet connection equal authentication?

**Answer:** No. Server authentication generally requires a challenge and
signature verification.

### Q15. What is EIP-1193?

**Answer:** A standard Ethereum provider interface.

### Q16. What is EIP-6963?

**Answer:** A wallet discovery standard that improves browser-wallet
interoperability.

### Q17. Can RainbowKit support multiple chains?

**Answer:** Yes. Configure the supported chains in the application
configuration.

### Q18. Can RainbowKit be customized?

**Answer:** Yes. It supports themes, custom buttons, wallets, wallet
lists, chains, app information, avatars, localization, modal
configuration, and other UI features.

### Q19. Why is SSR configuration relevant?

**Answer:** Applications using server-side rendering should configure
RainbowKit with `ssr: true` as documented.

### Q20. What should a production dApp handle?

**Answer:** Wallet connection, chain validation, transaction states,
user rejection, RPC failures, authentication where needed, secure
contract addresses, and reliable RPC infrastructure.

## 39. Coding Practice

### Beginner

1.  Build a Connect Wallet page.
2.  Build a wallet dashboard.
3.  Display connected address and chain.
4.  Display wallet balance.
5.  Add Sepolia support.

### Intermediate

6.  Build an ERC-20 dashboard.
7.  Add ERC-20 transfer.
8.  Add transaction status.
9.  Add wrong-network handling.
10. Build an NFT viewer.

### Advanced

11. Build a staking dashboard.
12. Build a voting dApp.
13. Build an NFT marketplace.
14. Build a multi-chain dashboard.
15. Add custom RainbowKit theming and wallet UI.

## 40. Portfolio Project Architecture

A strong Web3 portfolio project can use:

```text
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
Solidity
+
OpenZeppelin
+
Hardhat / Foundry
+
Tests
+
Sepolia
```

Example architecture:

```text
             React UI
                │
        ┌───────▼───────┐
        │  RainbowKit   │
        │ Wallet UI/UX  │
        └───────┬───────┘
                │
        ┌───────▼───────┐
        │     Wagmi     │
        │ React Web3    │
        └───────┬───────┘
                │
        ┌───────▼───────┐
        │     Viem      │
        │ EVM Actions   │
        └───────┬───────┘
                │
         ┌──────┴──────┐
         │             │
      Wallet          RPC
         │             │
         └──────┬──────┘
                │
          Blockchain
                │
          Smart Contract
```

## 41. 30-Day Learning Plan

### Week 1 --- Fundamentals

**Day 1:** What RainbowKit is; RainbowKit vs Wagmi vs Viem.

**Day 2:** Installation, scaffolding, project ID.

**Day 3:** `getDefaultConfig` and chains.

**Day 4:** Provider hierarchy.

**Day 5:** ConnectButton and wallet flow.

**Day 6:** Chain switching, ENS, balances.

**Day 7:** Build a wallet dashboard.

### Week 2 --- dApp Integration

**Day 8:** Wagmi fundamentals.

**Day 9:** Viem fundamentals.

**Day 10:** Read an ERC-20 contract.

**Day 11:** Write to an ERC-20 contract.

**Day 12:** Transaction states.

**Day 13:** Wrong-chain and error handling.

**Day 14:** Build an ERC-20 dApp.

### Week 3 --- Customization

**Day 15:** Themes.

**Day 16:** Custom ConnectButton.

**Day 17:** Custom wallet list.

**Day 18:** Custom wallets.

**Day 19:** Custom chains.

**Day 20:** Localization and modal configuration.

**Day 21:** Recent transactions and wallet UX.

### Week 4 --- Production

**Day 22:** EIP-1193.

**Day 23:** EIP-6963.

**Day 24:** WalletConnect project configuration.

**Day 25:** Production RPC transports.

**Day 26:** Authentication and signatures.

**Day 27:** Security review.

**Day 28:** Testing.

**Day 29:** Sepolia deployment.

**Day 30:** Polish README, architecture, screenshots, tests, and live
demo.

## 42. Final Cheat Sheet

### Install

```bash
npm install @rainbow-me/rainbowkit wagmi viem @tanstack/react-query
```

### Scaffold

```bash
npm init @rainbow-me/rainbowkit@latest
```

### Styles

```tsx
import "@rainbow-me/rainbowkit/styles.css";
```

### Configure

```tsx
const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet, sepolia],
});
```

### SSR

```tsx
const config = getDefaultConfig({
  appName: "My DApp",
  projectId: "YOUR_PROJECT_ID",
  chains: [mainnet, sepolia],
  ssr: true,
});
```

### Providers

```tsx
<WagmiProvider config={config}>
  <QueryClientProvider client={queryClient}>
    <RainbowKitProvider>
      <App />
    </RainbowKitProvider>
  </QueryClientProvider>
</WagmiProvider>
```

### Connect

```tsx
<ConnectButton />
```

### Production transport

```tsx
transports: {
  [mainnet.id]: http('YOUR_MAINNET_RPC'),
  [sepolia.id]: http('YOUR_SEPOLIA_RPC'),
}
```

## 43. 10x Mental Model

Memorize:

```text
RainbowKit
    ↓
Wallet Connection UX
    ↓
Wagmi
    ↓
React Web3 Hooks / State
    ↓
Viem
    ↓
EVM Interaction
    ↓
Wallet / RPC
    ↓
Blockchain
```

One-line definitions:

```text
RainbowKit = wallet UI
Wagmi      = React Web3 layer
Viem       = EVM interaction layer
RPC        = blockchain communication
Wallet     = authorization/signing
Solidity   = smart-contract logic
React      = application UI
```

## 44. Golden Rules

1.  RainbowKit is a React wallet connection library.
2.  RainbowKit works together with Wagmi and Viem.
3.  `ConnectButton` is the easiest starting point.
4.  Configure supported chains explicitly.
5.  Wallet connection is different from transaction signing.
6.  Never expose or request private keys.
7.  Validate the active network.
8.  Use reliable RPC transports in production.
9.  Wallet connection is not automatically authentication.
10. Keep wallet UX, Web3 interaction, and smart-contract logic
    conceptually separate.

## 45. Mastery Checklist

### RainbowKit

- [ ] Explain RainbowKit
- [ ] Install it
- [ ] Scaffold a project
- [ ] Configure `getDefaultConfig`
- [ ] Configure chains
- [ ] Configure project ID
- [ ] Configure providers
- [ ] Use `ConnectButton`

### Wallets

- [ ] Connect
- [ ] Disconnect
- [ ] Switch chain
- [ ] Understand wallet discovery
- [ ] Understand EIP-1193
- [ ] Understand EIP-6963

### Customization

- [ ] Theme
- [ ] Dark mode
- [ ] Custom ConnectButton
- [ ] Custom wallet list
- [ ] Custom wallets
- [ ] Custom chains
- [ ] Localization
- [ ] Modal configuration
- [ ] App information
- [ ] Avatars

### Web3

- [ ] Wagmi
- [ ] Viem
- [ ] RPC
- [ ] Transport
- [ ] ABI
- [ ] Contract reads
- [ ] Contract writes
- [ ] Transactions
- [ ] Events
- [ ] ENS

### Production

- [ ] Dedicated RPC
- [ ] Error handling
- [ ] Wrong-network handling
- [ ] Wallet rejection handling
- [ ] Authentication architecture
- [ ] Security
- [ ] Testing
- [ ] Deployment

## 46. Final Learning Path

```text
JavaScript
    ↓
TypeScript
    ↓
React
    ↓
Solidity
    ↓
Ethereum / EVM
    ↓
Viem
    ↓
Wagmi
    ↓
RainbowKit
    ↓
Wallet Integration
    ↓
Smart Contract Integration
    ↓
Testing
    ↓
Sepolia
    ↓
Production DApp
```

The goal is not to memorize every RainbowKit API.

You should be able to explain this complete flow:

```text
User opens dApp
       ↓
RainbowKit shows wallet UI
       ↓
User selects wallet
       ↓
Wallet connects
       ↓
Wagmi exposes account/chain state
       ↓
Viem communicates with EVM
       ↓
User initiates an action
       ↓
Wallet requests authorization
       ↓
Transaction is submitted
       ↓
Blockchain confirms
       ↓
Application state updates
       ↓
React UI updates
```

> **Master the architecture and user flow first; memorize APIs second.**
