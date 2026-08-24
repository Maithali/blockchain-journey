# 🪙 ERC-20 in Solidity — Complete In-Depth Revision

> 🎯 **Goal:** Understand ERC-20 tokens from the ground up — what ERC-20 is, why it exists, token architecture, standard functions, events, `mapping`, `allowance`, `approve()`, `transfer()`, `transferFrom()`, minting, burning, decimals, OpenZeppelin, security, gas, common mistakes, and interview questions.

---

# 🪙 1. What is ERC-20?

## 📌 Definition

**ERC-20** is a standard interface for **fungible tokens** on Ethereum-compatible networks.

ERC stands for:

> **Ethereum Request for Comment**

ERC-20 defines a common set of functions and events that token contracts should implement so that wallets, exchanges, DApps, and other contracts can interact with tokens in a predictable way.

---

# 🧒 Explain Like I'm 10

Imagine you create your own money called:

```text
MAI Token
```

You want:

- Wallets to display it
- Users to transfer it
- Exchanges to support it
- Smart contracts to interact with it
- DApps to know how much each user owns

Instead of inventing your own rules, you follow the **ERC-20 standard**.

Then other applications already understand:

```solidity
balanceOf()
transfer()
approve()
allowance()
transferFrom()
```

---

# 💡 Remember

> **ERC-20 = Standard rules for fungible Ethereum tokens.**

---

# 🪙 2. What is a Fungible Token?

A **fungible token** is interchangeable with another token of the same type.

For example:

```text
1 MAI Token = 1 MAI Token
```

Just like:

```text
₹100 = another ₹100
```

assuming the same currency and denomination.

---

## Fungible vs Non-Fungible

| Type            | Standard | Example         |
| --------------- | -------- | --------------- |
| 🪙 Fungible     | ERC-20   | USDC, DAI, LINK |
| 🎨 Non-Fungible | ERC-721  | Unique NFT      |
| 🧩 Multi-token  | ERC-1155 | Gaming assets   |

---

# 🧠 ERC-20 Mental Model

```text
                   ERC-20 TOKEN
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
      Balances      Transfers      Allowances
          │             │             │
          ▼             ▼             ▼
     balanceOf()     transfer()    approve()
                                      │
                                      ▼
                                  allowance()
                                      │
                                      ▼
                                transferFrom()
```

---

# 🏗️ 3. ERC-20 Token Architecture

A simple ERC-20 token typically contains:

```text
Token Contract
      │
      ├── Token Name
      ├── Token Symbol
      ├── Decimals
      ├── Total Supply
      │
      ├── Balances
      │
      ├── Allowances
      │
      ├── Transfer Logic
      ├── Approval Logic
      ├── Mint Logic
      └── Burn Logic
```

---

# 📊 4. ERC-20 Standard Functions

The core ERC-20 interface defines these functions:

```solidity
totalSupply()
balanceOf()
transfer()
allowance()
approve()
transferFrom()
```

It also defines these events:

```solidity
Transfer
Approval
```

---

# 🔢 5. `totalSupply()`

## 📌 What is it?

Returns the total number of tokens currently in existence.

Conceptually:

```solidity
function totalSupply()
    external
    view
    returns (uint256);
```

Example:

```text
Total Supply = 1,000,000 MAI
```

---

## 🧠 Important

`totalSupply()` does not necessarily mean:

> The maximum number of tokens that can ever exist.

It means:

> The current total token supply.

If tokens are minted:

```text
Supply increases
```

If tokens are burned:

```text
Supply decreases
```

---

# 👤 6. `balanceOf()`

Returns the token balance of an address.

Syntax:

```solidity
balanceOf(address account)
```

Example:

```solidity
uint256 balance = token.balanceOf(user);
```

Suppose:

```text
Alice → 500 tokens
Bob   → 200 tokens
```

Then:

```solidity
balanceOf(Alice)
```

returns:

```text
500
```

---

# 📤 7. `transfer()`

Allows the token holder to transfer tokens from their own balance.

Syntax:

```solidity
transfer(address to, uint256 amount)
```

Example:

```solidity
token.transfer(bob, 100);
```

Meaning:

```text
Alice
 │
 │ 100 tokens
 ▼
Bob
```

The caller's balance decreases:

```text
Alice: 500 → 400
```

Recipient balance increases:

```text
Bob: 200 → 300
```

---

# 🔄 8. Transfer Flow

```text
                 Alice
                   │
                   │ transfer( Bob, 100 )
                   ▼
             ERC-20 Contract
                   │
          ┌────────┴────────┐
          ▼                 ▼
   Alice balance       Bob balance
      -100                +100
```

---

# 🔐 9. `approve()`

`approve()` gives another address permission to spend tokens on your behalf.

Syntax:

```solidity
approve(address spender, uint256 amount)
```

Example:

```solidity
approve(exchange, 1000);
```

Meaning:

```text
Alice
  │
  │ "Exchange can spend
  │  up to 1000 tokens"
  ▼
Exchange
```

Important:

> `approve()` does **not** transfer tokens.

It creates an allowance.

---

# 🧠 Remember

```text
approve()
    ↓
Permission

NOT

approve()
    ↓
Transfer
```

---

# 📊 10. Allowance

An **allowance** represents how many tokens a spender is authorized to spend on behalf of an owner.

Conceptually:

```text
Owner
  │
  │ approves
  ▼
Spender
  │
  │ can spend up to X
  ▼
Owner's Tokens
```

Example:

```solidity
approve(Bob, 500);
```

means:

```text
Bob can spend up to 500
tokens from Alice's balance.
```

---

# 🔍 11. `allowance()`

Checks how many tokens a spender is allowed to spend.

Syntax:

```solidity
allowance(
    address owner,
    address spender
)
```

Example:

```solidity
uint256 amount = token.allowance(
    alice,
    exchange
);
```

Suppose:

```text
Alice approved Exchange = 1000
```

Then:

```solidity
allowance(alice, exchange)
```

returns:

```text
1000
```

---

# 📤 12. `transferFrom()`

Allows an approved spender to transfer tokens from another address.

Syntax:

```solidity
transferFrom(
    address from,
    address to,
    uint256 amount
)
```

Example:

```solidity
token.transferFrom(
    alice,
    bob,
    100
);
```

This only works if the caller has sufficient allowance.

---

# 🔄 13. `approve()` + `transferFrom()` Flow

This is one of the **most important ERC-20 concepts**.

Suppose Alice wants a DApp to spend her tokens.

### Step 1 — Alice approves

```solidity
token.approve(dapp, 1000);
```

Now:

```text
Alice
  │
  │ allowance = 1000
  ▼
DApp
```

### Step 2 — DApp spends

```solidity
token.transferFrom(
    alice,
    bob,
    100
);
```

Result:

```text
Alice balance
1000 → 900

Bob balance
0 → 100

Remaining allowance
1000 → 900
```

---

# 🧠 Complete Allowance Flow

```text
             Alice
               │
               │ approve(DApp, 1000)
               ▼
              DApp
               │
               │ transferFrom(
               │ Alice,
               │ Bob,
               │ 100
               │ )
               ▼
              Bob

Alice's Balance
      │
      └── -100

Bob's Balance
      │
      └── +100

Allowance
      │
      └── 1000 → 900
```

---

# 📊 14. ERC-20 Core Functions — Comparison

| Function         | Purpose                  | Moves Tokens? |
| ---------------- | ------------------------ | ------------- |
| `totalSupply()`  | Current token supply     | ❌            |
| `balanceOf()`    | Check balance            | ❌            |
| `transfer()`     | Send your own tokens     | ✅            |
| `approve()`      | Give spending permission | ❌            |
| `allowance()`    | Check permission         | ❌            |
| `transferFrom()` | Spend approved tokens    | ✅            |

---

# 📢 15. ERC-20 Events

ERC-20 defines two important events:

```solidity
Transfer
Approval
```

Events allow off-chain applications to observe important token activity.

---

# 📤 16. `Transfer` Event

Standard event:

```solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
);
```

Emitted when tokens are transferred.

Example:

```solidity
emit Transfer(
    msg.sender,
    recipient,
    amount
);
```

---

# 🧠 What Does `indexed` Mean?

```solidity
address indexed from
```

allows applications to efficiently filter event logs by that value.

For example:

```text
Show all transfers involving Alice
```

can be efficiently queried using the indexed address.

---

# 📢 17. `Approval` Event

Standard event:

```solidity
event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
);
```

Emitted when an allowance is set.

Example:

```solidity
emit Approval(
    msg.sender,
    spender,
    amount
);
```

---

# 📊 18. Events vs State

| Event                              | State                                   |
| ---------------------------------- | --------------------------------------- |
| Stored in transaction logs         | Stored in contract storage              |
| Useful for off-chain applications  | Used by contract logic                  |
| Can be indexed                     | Variables/mappings store current values |
| Not directly readable by contracts | Readable by contracts                   |
| Useful for history/activity        | Represents current state                |

---

# 🔢 19. ERC-20 Decimals

ERC-20 tokens commonly use:

```solidity
decimals()
```

to indicate the number of decimal places used for display.

A common value is:

```text
18
```

---

## Example

Suppose:

```solidity
decimals() = 18
```

Then:

```text
1 token
=
1 × 10¹⁸ base units
```

So:

```text
1 MAI
=
1,000,000,000,000,000,000
```

base units.

---

# ⚠️ 20. Important: Token Amounts Are Integers

Solidity does not use floating-point token balances.

If:

```solidity
decimals() = 18
```

then:

```solidity
1 ether
```

is commonly used as a convenient notation for:

```text
10^18
```

base units.

For example:

```solidity
_mint(msg.sender, 1000 * 10 ** decimals());
```

creates:

```text
1000 display tokens
```

---

# 🪙 21. Token Name

ERC-20 implementations commonly expose:

```solidity
name()
```

Example:

```text
Maithali Token
```

---

# 🔤 22. Token Symbol

```solidity
symbol()
```

Example:

```text
MAI
```

---

# 📋 23. ERC-20 Metadata

Common metadata functions are:

```solidity
name()
symbol()
decimals()
```

Example:

```text
Name:     Maithali Token
Symbol:   MAI
Decimals: 18
```

These help wallets and DApps display the token.

---

# 🏗️ 24. Minimal ERC-20 Structure

Conceptually:

```solidity
contract MyToken {

    string public name;
    string public symbol;

    uint8 public decimals;

    uint256 public totalSupply;

    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256))
        public allowances;

    function transfer(...) external returns (bool) {}

    function approve(...) external returns (bool) {}

    function transferFrom(...) external returns (bool) {}

}
```

---

# 🗺️ 25. ERC-20 Balance Mapping

The most common balance structure is:

```solidity
mapping(address => uint256) private _balances;
```

Conceptually:

```text
address
   ↓
token balance
```

Example:

```text
Alice → 1000
Bob   → 500
Carol → 200
```

---

# 🗺️ 26. Allowance Mapping

Allowance requires two addresses:

```solidity
mapping(address => mapping(address => uint256))
    private _allowances;
```

Conceptually:

```text
Owner
  ↓
Spender
  ↓
Allowance
```

Example:

```text
Alice
  ↓
Uniswap
  ↓
1000
```

Meaning:

```text
Uniswap can spend 1000
tokens from Alice.
```

---

# 🔢 27. Why Is Allowance a Nested Mapping?

Because the allowance depends on **two addresses**:

```text
WHO owns the tokens?
        +
WHO is allowed to spend them?
```

Therefore:

```solidity
allowances[owner][spender]
```

---

# 🪙 28. Minting

## 📌 What is Minting?

**Minting** creates new tokens.

Conceptually:

```text
Total Supply
     +
New Tokens
     ↓
New Total Supply
```

Example:

```solidity
_mint(user, 1000);
```

---

# ⚠️ 29. Minting Is Powerful

If anyone can mint:

```solidity
function mint(uint256 amount) external {
    _mint(msg.sender, amount);
}
```

then anyone may create unlimited tokens.

That is usually dangerous.

---

# 🔐 30. Owner-Only Minting

A common pattern:

```solidity
function mint(
    address to,
    uint256 amount
) external onlyOwner {

    _mint(to, amount);
}
```

Now:

```text
Owner
  │
  └── Can mint

Normal User
  │
  └── Cannot mint
```

---

# 🔥 31. Burning

## 📌 What is Burning?

Burning permanently removes tokens from circulation.

Example:

```solidity
_burn(msg.sender, amount);
```

Conceptually:

```text
User Balance
     -
Burned Tokens
     ↓
Lower Balance

Total Supply
     -
Burned Tokens
     ↓
Lower Supply
```

---

# 📊 32. Mint vs Burn

| Operation |               Balance | Total Supply |
| --------- | --------------------: | -----------: |
| Mint      |                    ⬆️ |           ⬆️ |
| Burn      |                    ⬇️ |           ⬇️ |
| Transfer  | Changes between users |    No change |

---

# 🔄 33. Transfer Does NOT Change Total Supply

Suppose:

```text
Total Supply = 1,000
```

Alice:

```text
700
```

Bob:

```text
300
```

Alice transfers 100 to Bob:

```text
Alice = 600
Bob   = 400
```

Total:

```text
600 + 400 = 1000
```

Therefore:

> **Transfers move existing tokens; they do not create or destroy them.**

---

# 🧠 34. ERC-20 Token Lifecycle

```text
              MINT
                │
                ▼
          Tokens Created
                │
                ▼
            BALANCE
                │
                ▼
            TRANSFER
                │
       ┌────────┴────────┐
       ▼                 ▼
    Receiver           Sender
       │
       ▼
     APPROVE
       │
       ▼
  transferFrom()
       │
       ▼
    Spending
       │
       ▼
      BURN
       │
       ▼
 Tokens Destroyed
```

---

# 🏗️ 35. Building ERC-20 With OpenZeppelin

In real-world development, you generally should **not write the entire ERC-20 implementation from scratch** unless you are learning or have a specific reason.

A widely used approach is OpenZeppelin Contracts.

Typical import:

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

---

# 🪙 36. Basic OpenZeppelin ERC-20

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    constructor(
        uint256 initialSupply
    ) ERC20("My Token", "MYT") {

        _mint(
            msg.sender,
            initialSupply * 10 ** decimals()
        );
    }
}
```

---

# 🔍 37. Understanding the Code

## Import

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

We reuse OpenZeppelin's ERC-20 implementation.

---

## Inheritance

```solidity
contract MyToken is ERC20
```

means:

```text
MyToken
   ↓ inherits
ERC20
```

Your contract gets ERC-20 functionality.

---

## Constructor

```solidity
constructor(
    uint256 initialSupply
) ERC20("My Token", "MYT")
```

Sets:

```text
Name   = My Token
Symbol = MYT
```

---

## Mint

```solidity
_mint(
    msg.sender,
    initialSupply * 10 ** decimals()
);
```

Creates the initial tokens for the deployer.

---

# 💰 38. Example Deployment

Suppose:

```text
initialSupply = 1,000,000
decimals = 18
```

Then:

```solidity
1,000,000 * 10^18
```

base units are minted.

The wallet displays:

```text
1,000,000 MYT
```

---

# ⚠️ 39. Why Multiply by `10 ** decimals()`?

Because token balances are stored in the smallest unit.

If:

```text
decimals = 18
```

then:

```text
1 MYT = 10^18 base units
```

Therefore:

```solidity
1000 * 10 ** 18
```

represents:

```text
1000 MYT
```

---

# 🔐 40. Owner-Controlled ERC-20

If the token needs an owner who can mint, OpenZeppelin's ownership functionality can be combined with ERC-20.

Conceptually:

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    constructor(
        uint256 initialSupply
    )
        ERC20("My Token", "MYT")
        Ownable(msg.sender)
    {
        _mint(
            msg.sender,
            initialSupply * 10 ** decimals()
        );
    }

    function mint(
        address to,
        uint256 amount
    ) external onlyOwner {

        _mint(to, amount);
    }
}
```

---

# 🔐 41. Why `onlyOwner`?

Without access control:

```solidity
function mint(...) external {
    _mint(...);
}
```

anyone could potentially mint.

With:

```solidity
onlyOwner
```

only the owner can call it.

---

# 🧠 42. ERC-20 Approval Security

One important issue with ERC-20 allowances is the **approval race-condition pattern**.

Suppose Alice has:

```text
Allowance = 100
```

She wants to change it to:

```text
50
```

A spender may potentially observe the pending approval change and use the old allowance before the new one takes effect.

---

# 🛡️ 43. Safer Allowance Pattern

A common recommendation is:

```text
Set allowance to 0
       ↓
Set new allowance
```

For example:

```solidity
approve(spender, 0);
approve(spender, 50);
```

Many modern token implementations also provide safer allowance helper patterns.

---

# ⚠️ 44. Infinite Allowance

Users sometimes approve:

```text
type(uint256).max
```

This is often called:

```text
Infinite Allowance
```

It means the spender can potentially spend a very large amount without requiring a new approval each time.

---

## Why Is This Risky?

If the approved spender contract is compromised or malicious:

```text
Large allowance
      ↓
Potential token loss
```

Therefore, users should understand what they are approving.

---

# 🔐 45. `approve()` Does Not Transfer Tokens

This is a common interview trick.

```solidity
approve(spender, 100);
```

does NOT mean:

```text
100 tokens moved
```

It means:

```text
spender is authorized
to spend up to 100
```

---

# 🧠 Remember

```text
approve()
   =
permission

transfer()
   =
move your tokens

transferFrom()
   =
move approved tokens
```

---

# 📊 46. `transfer()` vs `transferFrom()`

| Feature               | `transfer()` | `transferFrom()`           |
| --------------------- | ------------ | -------------------------- |
| Transfers tokens      | ✅           | ✅                         |
| Uses caller's balance | ✅           | ❌                         |
| Uses allowance        | ❌           | Usually ✅                 |
| Typical caller        | Token owner  | Approved spender           |
| Example               | Alice → Bob  | DApp spends Alice's tokens |

---

# 🔄 47. Real-World DApp Example

Suppose you use a DeFi application.

You own:

```text
1000 USDC
```

You want a DeFi protocol to use:

```text
500 USDC
```

First:

```solidity
USDC.approve(
    defiProtocol,
    500
);
```

Then:

```solidity
USDC.transferFrom(
    msg.sender,
    protocol,
    500
);
```

The protocol can now move the approved amount.

---

# 🏦 48. ERC-20 in DeFi

ERC-20 tokens are fundamental to DeFi.

They are used in:

- 💱 DEXs
- 🏦 Lending protocols
- 📈 Yield farming
- 🔒 Staking
- 💰 Liquidity pools
- 🪙 Stablecoins
- 🎁 Governance tokens

---

# 🔄 49. ERC-20 + DEX Flow

```text
User
 │
 │ approve()
 ▼
DEX
 │
 │ transferFrom()
 ▼
User Tokens
 │
 ▼
Swap
 │
 ▼
Another ERC-20 Token
```

---

# 🏦 50. ERC-20 + Lending Protocol

```text
User
 │
 │ approve(Protocol, amount)
 ▼
Lending Protocol
 │
 │ transferFrom()
 ▼
Protocol receives tokens
 │
 ▼
User receives lending position
```

---

# 🎮 51. ERC-20 + Gaming

ERC-20 tokens can represent:

```text
Gold
Coins
Energy
Rewards
Governance tokens
```

Example:

```text
Player wins game
       ↓
Reward tokens
       ↓
ERC-20 balance increases
```

---

# 🗳️ 52. ERC-20 Governance

ERC-20 tokens can also represent governance power.

Conceptually:

```text
More tokens
    ↓
More voting power
```

However, the exact voting mechanism depends on the governance system.

---

# 🧩 53. ERC-20 Interface

A simplified interface looks like:

```solidity
interface IERC20 {

    function totalSupply()
        external
        view
        returns (uint256);

    function balanceOf(address account)
        external
        view
        returns (uint256);

    function transfer(
        address to,
        uint256 amount
    )
        external
        returns (bool);

    function allowance(
        address owner,
        address spender
    )
        external
        view
        returns (uint256);

    function approve(
        address spender,
        uint256 amount
    )
        external
        returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    )
        external
        returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
```

---

# 🔍 54. Why Does ERC-20 Return `bool`?

Standard ERC-20 transfer-related functions are defined to return:

```solidity
bool
```

For example:

```solidity
function transfer(
    address to,
    uint256 amount
)
    external
    returns (bool);
```

This indicates whether the operation succeeded according to the token implementation.

Modern OpenZeppelin implementations use Solidity reverts for failed operations and return `true` on successful transfers.

---

# ⚠️ 55. Not Every Token Behaves Identically

Although ERC-20 defines a standard interface, real-world tokens can have unusual behaviors.

Examples include:

- Fee-on-transfer tokens
- Rebasing tokens
- Tokens with transfer restrictions
- Tokens with unusual approval behavior
- Legacy tokens with non-standard return behavior

Therefore:

> ⚠️ **ERC-20 compatibility does not always mean every token behaves identically.**

---

# 🧠 56. Fee-on-Transfer Tokens

Some tokens deduct a fee during transfer.

Suppose:

```text
User sends 100 tokens
```

Recipient may receive:

```text
98 tokens
```

because:

```text
2 tokens = fee
```

So DApps should not always assume:

```text
amount sent == amount received
```

---

# 🔢 57. Decimals Are Display Information

A common misconception is:

```text
decimals = 18
```

means the token has a special mathematical precision.

More accurately, it tells applications how to interpret the integer token amounts for display.

For example:

```text
balance = 1500000000000000000
decimals = 18
```

is displayed as:

```text
1.5 tokens
```

---

# 🔐 58. ERC-20 Security Checklist

Before deploying an ERC-20, ask:

```text
☑️ Who can mint?

☑️ Is minting capped?

☑️ Who can burn?

☑️ Can users transfer tokens?

☑️ Can tokens be paused?

☑️ Are allowances handled safely?

☑️ Is access control correct?

☑️ Are zero addresses handled?

☑️ Are arithmetic operations safe?

☑️ Are external calls minimized?

☑️ Is the token upgradeable?

☑️ If upgradeable, who controls upgrades?

☑️ Are special transfer restrictions documented?

☑️ Have the contracts been tested?
```

---

# 🚨 59. Common ERC-20 Mistakes

## ❌ Mistake 1 — Anyone Can Mint

```solidity
function mint(uint256 amount) external {
    _mint(msg.sender, amount);
}
```

Potential problem:

```text
Anyone
  ↓
mint unlimited tokens
```

---

## ❌ Mistake 2 — Incorrect Decimals

Developers may confuse:

```text
display units
```

with:

```text
base units
```

Always understand the token's decimal configuration.

---

## ❌ Mistake 3 — Ignoring Allowances

DApps must understand:

```text
approve()
allowance()
transferFrom()
```

---

## ❌ Mistake 4 — Assuming Every Token Is Identical

Some tokens have:

```text
fees
rebasing
restrictions
non-standard behavior
```

---

## ❌ Mistake 5 — Unsafe Access Control

Minting, pausing, upgrading, or administrative functions must have carefully designed authorization.

---

# 🧪 60. Basic ERC-20 Test Checklist

After creating a token, test:

### Deployment

```text
☑️ Name correct
☑️ Symbol correct
☑️ Decimals correct
☑️ Initial supply correct
```

### Transfers

```text
☑️ transfer() works
☑️ Sender balance decreases
☑️ Receiver balance increases
```

### Approvals

```text
☑️ approve() works
☑️ allowance() returns correct amount
```

### `transferFrom()`

```text
☑️ Approved spender can transfer
☑️ Allowance decreases correctly
☑️ Unauthorized spender fails
```

### Minting

```text
☑️ Authorized account can mint
☑️ Unauthorized account cannot mint
☑️ Total supply increases
```

### Burning

```text
☑️ Tokens are removed
☑️ Total supply decreases
```

---

# 🧪 61. Simple ERC-20 Testing Scenario

Suppose:

```text
Initial Supply = 1,000,000
```

Deployer receives:

```text
1,000,000
```

Then:

```text
Alice → Bob = 100
```

Expected:

```text
Alice = 999,900
Bob   = 100
```

Then:

```text
Alice approves DApp = 500
```

Expected:

```text
allowance(Alice, DApp) = 500
```

DApp transfers:

```text
Alice → Bob = 200
```

Expected:

```text
Alice = 999,700
Bob   = 300
Allowance = 300
```

---

# 🧠 62. ERC-20 Complete Concept Flow

```text
                    ERC-20
                      │
        ┌─────────────┼──────────────┐
        ▼             ▼              ▼
     BALANCE       TRANSFER       ALLOWANCE
        │             │              │
        ▼             ▼              ▼
 balanceOf()      transfer()      approve()
                                      │
                                      ▼
                                  allowance()
                                      │
                                      ▼
                                transferFrom()
```

---

# 🔥 63. ERC-20 vs ETH

ERC-20 tokens and native Ether are **not the same thing**.

| Feature                                  | ETH                       | ERC-20                         |
| ---------------------------------------- | ------------------------- | ------------------------------ |
| Native asset                             | ✅                        | ❌                             |
| Controlled by token contract             | ❌                        | ✅                             |
| Uses `balance` mapping in token contract | ❌                        | Usually ✅                     |
| Transfer mechanism                       | Native protocol operation | Token contract function        |
| `msg.value`                              | Can carry ETH             | Not automatically token amount |
| `approve()`                              | ❌                        | ✅                             |
| `transferFrom()`                         | ❌                        | ✅                             |

---

# 💡 Important

When you call:

```solidity
token.transfer(...)
```

you are calling a **smart contract function**.

You are not transferring native ETH.

---

# 💰 64. ERC-20 Tokens and `msg.value`

This is a common confusion.

Suppose:

```solidity
token.transfer(user, 100);
```

The:

```solidity
100
```

is token units.

It is NOT:

```solidity
msg.value
```

`msg.value` represents native Ether attached to the transaction.

---

# 🧠 Remember

```text
ETH
 ↓
msg.value

ERC-20
 ↓
token amount
```

---

# 🪙 65. ERC-20 + Payable

A contract can accept:

```solidity
msg.value
```

and separately interact with ERC-20 tokens.

Example:

```solidity
function depositETH()
    external
    payable
{

}
```

For ERC-20:

```solidity
function depositToken(
    IERC20 token,
    uint256 amount
) external {

    token.transferFrom(
        msg.sender,
        address(this),
        amount
    );
}
```

Before calling:

```solidity
approve(address(this), amount);
```

---

# 🔄 66. ERC-20 Deposit Flow

```text
User
 │
 │ approve()
 ▼
Token Contract
 │
 │ allowance
 ▼
DApp
 │
 │ transferFrom()
 ▼
DApp receives tokens
```

---

# 🧠 67. The Most Important ERC-20 Relationships

Memorize this:

```text
balanceOf()
     ↓
"How many tokens do I have?"

transfer()
     ↓
"Send my tokens."

approve()
     ↓
"Give someone permission."

allowance()
     ↓
"How much permission exists?"

transferFrom()
     ↓
"Use that permission to transfer."
```

---

# 📊 68. ERC-20 Function Cheat Sheet

| Function         | Question It Answers                       |
| ---------------- | ----------------------------------------- |
| `name()`         | What is the token called?                 |
| `symbol()`       | What is its ticker?                       |
| `decimals()`     | How should amounts be displayed?          |
| `totalSupply()`  | How many tokens currently exist?          |
| `balanceOf()`    | How many tokens does this address have?   |
| `transfer()`     | Can I send my tokens?                     |
| `approve()`      | Can I authorize a spender?                |
| `allowance()`    | How much can the spender use?             |
| `transferFrom()` | Can the approved spender transfer tokens? |

---

# 💼 69. Interview Questions & Answers

## Q1. What is ERC-20?

**Answer:**

ERC-20 is a standard interface for fungible tokens on Ethereum-compatible networks. It defines common functions and events that allow wallets, DApps, exchanges, and smart contracts to interact with tokens consistently.

---

## Q2. What are the six core ERC-20 functions?

```text
totalSupply()
balanceOf()
transfer()
approve()
allowance()
transferFrom()
```

---

## Q3. What are the two standard ERC-20 events?

```text
Transfer
Approval
```

---

## Q4. What is the difference between `transfer()` and `transferFrom()`?

**Answer:**

`transfer()` moves tokens from the caller's own balance, while `transferFrom()` allows a spender to move tokens from another address when sufficient allowance has been provided.

---

## Q5. What does `approve()` do?

**Answer:**

`approve()` sets the amount of tokens that a spender is allowed to spend on behalf of the token owner.

---

## Q6. Does `approve()` transfer tokens?

```text
❌ No.
```

It creates or updates permission.

---

## Q7. What is an allowance?

**Answer:**

An allowance is the amount of tokens that an owner has authorized a particular spender to spend.

---

## Q8. Why is allowance a nested mapping?

Because it depends on:

```text
owner
+
spender
```

Conceptually:

```solidity
allowance[owner][spender]
```

---

## Q9. What happens to allowance after `transferFrom()`?

In a normal ERC-20 implementation, the spender's allowance is reduced by the amount spent, unless the implementation uses special semantics such as an effectively unlimited allowance optimization.

---

## Q10. What is minting?

**Answer:**

Minting creates new tokens and increases total supply.

---

## Q11. What is burning?

**Answer:**

Burning destroys existing tokens and decreases total supply.

---

## Q12. Does transferring tokens change total supply?

```text
❌ No.
```

It only changes the distribution of existing tokens.

---

## Q13. What is `decimals()`?

**Answer:**

It indicates how token amounts represented as integer base units should be displayed to users.

---

## Q14. Why do many ERC-20 tokens use 18 decimals?

**Answer:**

18 decimal places is a common convention in Ethereum token ecosystems, similar to the 18 decimal places commonly used for Ether denominations.

---

## Q15. What is the difference between ETH and ERC-20?

**Answer:**

ETH is Ethereum's native asset, while ERC-20 tokens are token balances managed by smart contracts implementing the ERC-20 interface.

---

## Q16. What does `msg.value` represent?

**Answer:**

`msg.value` represents the amount of native Ether sent with the current call. It does not represent an ERC-20 token amount.

---

## Q17. Why use OpenZeppelin for ERC-20?

**Answer:**

OpenZeppelin provides widely used, reusable implementations of standard token functionality, reducing the need to implement complex token logic from scratch.

---

## Q18. Who should be allowed to mint?

**Answer:**

That depends on the token's design, but minting should normally be protected by explicit access control and, where appropriate, supply limits or governance controls.

---

## Q19. What is an infinite allowance?

**Answer:**

It is an allowance set to a very large value, commonly `type(uint256).max`, allowing a spender to make repeated transfers without requiring a new approval each time.

---

## Q20. Why can infinite allowances be risky?

**Answer:**

If the approved spender is compromised or malicious, it may be able to transfer a large amount of the user's tokens subject to the allowance and token balance.

---

# ⚡ Rapid-Fire Interview Questions

### Q21. ERC-20 means?

```text
Fungible token standard
```

### Q22. Function for checking token balance?

```solidity
balanceOf()
```

### Q23. Function for sending your own tokens?

```solidity
transfer()
```

### Q24. Function for giving spending permission?

```solidity
approve()
```

### Q25. Function for checking permission?

```solidity
allowance()
```

### Q26. Function used by an approved spender?

```solidity
transferFrom()
```

### Q27. ERC-20 transfer event?

```solidity
Transfer
```

### Q28. ERC-20 approval event?

```solidity
Approval
```

### Q29. Creates tokens?

```text
Mint
```

### Q30. Destroys tokens?

```text
Burn
```

### Q31. Does transfer increase supply?

```text
❌ No
```

### Q32. Does mint increase supply?

```text
✅ Yes
```

### Q33. Does burn decrease supply?

```text
✅ Yes
```

### Q34. Native ETH amount in a call?

```solidity
msg.value
```

### Q35. ERC-20 amount?

```text
Token amount / base units
```

### Q36. Common ERC-20 decimal count?

```text
18
```

### Q37. ERC-20 balance storage?

```solidity
mapping(address => uint256)
```

### Q38. ERC-20 allowance storage concept?

```solidity
mapping(address => mapping(address => uint256))
```

### Q39. Standard event for token transfers?

```solidity
Transfer
```

### Q40. Standard event for approvals?

```solidity
Approval
```

---

# 🎯 70. Interview Answer — 30 Seconds

> **"ERC-20 is the standard interface for fungible tokens on Ethereum-compatible networks. The core functions are `totalSupply`, `balanceOf`, `transfer`, `approve`, `allowance`, and `transferFrom`, with `Transfer` and `Approval` as the main events. Balances are typically stored in a mapping from addresses to token amounts, while allowances use a nested mapping of owner to spender to amount. `approve()` gives a spender permission, and `transferFrom()` uses that permission to move tokens. Minting increases total supply and burning decreases it. In production, I would generally use a well-tested OpenZeppelin ERC-20 implementation rather than implementing the standard from scratch."**

---

# 🧠 71. ERC-20 Complete Mental Model

```text
                         🪙 ERC-20
                            │
            ┌───────────────┼────────────────┐
            │               │                │
            ▼               ▼                ▼
        BALANCES        TRANSFERS        ALLOWANCES
            │               │                │
            ▼               ▼                ▼
      balanceOf()       transfer()       approve()
                                            │
                                            ▼
                                       allowance()
                                            │
                                            ▼
                                      transferFrom()
            │               │                │
            └───────────────┼────────────────┘
                            ▼
                       ERC-20 Events
                            │
                  ┌─────────┴─────────┐
                  ▼                   ▼
              Transfer            Approval
                  │
                  ▼
             Token History
```

---

# 🔥 72. Mint / Transfer / Burn Model

```text
                    TOKEN SUPPLY
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
           MINT                     BURN
             │                       │
             ▼                       ▼
       Supply increases        Supply decreases
             │                       │
             └───────────┬───────────┘
                         ▼
                     TRANSFER
                         │
              Moves existing tokens
                         │
                         ▼
              Supply stays unchanged
```

---

# 🔐 73. ERC-20 Security Mindset

Before saying:

> "My ERC-20 token is finished."

Ask:

```text
🔐 Who controls minting?

🔥 Is there a maximum supply?

👤 Can unauthorized users mint?

🗑️ Who can burn?

⏸️ Is pausing required?

💰 Are balances updated correctly?

🔄 Are allowances handled correctly?

⚠️ Can users accidentally approve too much?

🧩 Does the DApp handle non-standard tokens?

🔢 Are base units and decimals handled correctly?

🧪 Are all edge cases tested?

🔑 If upgradeable, who controls upgrades?
```

---

# 🏆 74. Golden Rules

- 🪙 **ERC-20 = Fungible Token Standard.**
- 📊 **`balanceOf()` = token balance.**
- 📤 **`transfer()` = move your own tokens.**
- 🔐 **`approve()` = grant spending permission.**
- 🔍 **`allowance()` = check spending permission.**
- 📤 **`transferFrom()` = spend tokens using allowance.**
- 📢 **`Transfer` and `Approval` are the core ERC-20 events.**
- 🏭 **Minting increases supply.**
- 🔥 **Burning decreases supply.**
- 🔄 **Transfer does not change total supply.**
- 🔢 **Token amounts are integer base units; `decimals()` controls display interpretation.**
- 💰 **`msg.value` is native ETH, not ERC-20 tokens.**
- 🏗️ **Use OpenZeppelin's well-tested implementation for production when appropriate.**
- 🔐 **Protect privileged functions such as minting with strong access control.**
- ⚠️ **Never blindly trust that every ERC-20 behaves identically.**

---

# 🚀 75. Final One-Line Memory Trick

```text
balanceOf = "How much do I have?"

transfer = "Send my tokens."

approve = "Give permission."

allowance = "How much permission?"

transferFrom = "Use the permission."

mint = "Create tokens."

burn = "Destroy tokens."
```

> ⭐ **Ultimate ERC-20 memory line:**
>
> **`BALANCE → TRANSFER → APPROVE → ALLOWANCE → TRANSFERFROM → MINT → BURN`**
>
> **If you understand this flow, you understand the core of ERC-20.**
