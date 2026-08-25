# 🎯 Solidity + OpenZeppelin 10X Interview Cheat Sheet

## Interview questions, model answers, traps, follow-ups, and coding prompts

> **Goal:** Move beyond memorized definitions. In a strong Solidity/OpenZeppelin interview, you should be able to explain **what**, **why**, **how**, **trade-offs**, and **security implications**.
>
> This guide targets modern Solidity and OpenZeppelin Contracts 5.x concepts. Always verify exact APIs against the version installed in your project. OpenZeppelin uses semantic versioning, and major versions should be treated as potentially incompatible for upgradeable storage layouts.

---

# 🧠 HOW TO ANSWER A BLOCKCHAIN INTERVIEW QUESTION

Use this 5-step formula:

```text
1. DEFINE
   What is it?

2. PURPOSE
   Why do we use it?

3. EXAMPLE
   Show a tiny example.

4. SECURITY
   What can go wrong?

5. TRADE-OFF
   When would you NOT use it?
```

Example:

> **What is Ownable?**

Weak:

> "Ownable is an OpenZeppelin contract."

Strong:

> "`Ownable` is a simple access-control module for contracts with a single administrative owner. It provides ownership management and the `onlyOwner` modifier. I would use it for a simple admin-controlled contract, but for multiple independent permissions I'd prefer `AccessControl`. For higher-risk ownership transfers, `Ownable2Step` can reduce mistakes because the new owner must explicitly accept ownership.

---

# 🏆 LEVEL 1 — SOLIDITY FUNDAMENTALS

## Q1. What is Solidity?

**Answer:**

Solidity is a statically typed, contract-oriented programming language used to write smart contracts for Ethereum-compatible blockchains.

It compiles to EVM bytecode.

```text
Solidity
   ↓
Compiler
   ↓
EVM Bytecode
   ↓
Blockchain
```

---

## Q2. What is a smart contract?

A smart contract is blockchain-deployed code whose functions can change on-chain state according to predefined rules.

Important properties:

```text
Deterministic execution
Persistent state
Publicly verifiable behavior
Transaction-based state changes
```

A smart contract is not automatically:

```text
Legal contract
Private
Bug-free
Immutable in every architecture
```

---

## Q3. What is the EVM?

The Ethereum Virtual Machine is the execution environment for Ethereum smart contracts.

Think:

```text
Transaction
   ↓
EVM executes bytecode
   ↓
State transition
   ↓
New blockchain state
```

---

## Q4. What is `msg.sender`?

```solidity
msg.sender
```

is the immediate caller of the current function.

Example:

```solidity
function withdraw() external {
    balances[msg.sender] -= 1 ether;
}
```

Security warning:

Do not blindly assume `msg.sender` is always the original human user. If a contract calls another contract, the receiving contract sees the calling contract as `msg.sender`.

This becomes especially important with `AccessManager`, where calls can execute through the manager.

---

## Q5. What is `msg.value`?

`msg.value` is the amount of native ETH sent with a payable call.

```solidity
function deposit() external payable {
    balances[msg.sender] += msg.value;
}
```

---

## Q6. Difference between `storage`, `memory`, and `calldata`?

### Storage

Persistent blockchain state.

```solidity
uint256 public value;
```

### Memory

Temporary data during execution.

```solidity
function foo(string memory name) external {}
```

### Calldata

Read-only function input data, especially useful for external functions.

```solidity
function foo(string calldata name) external {}
```

Mental model:

```text
storage  = permanent
memory   = temporary + mutable
calldata = temporary + read-only
```

---

# Q7. `public` vs `external`?

```solidity
public
```

Can be called internally and externally.

```solidity
external
```

Designed for external calls.

For large input arrays/bytes, `calldata` can often be more efficient than copying into memory.

---

# Q8. `view` vs `pure`?

```solidity
view
```

Can read state but cannot modify it.

```solidity
pure
```

Cannot read or modify contract state.

Example:

```solidity
function getValue()
    external
    view
    returns (uint256)
{
    return value;
}
```

---

# Q9. What is a mapping?

A mapping stores key → value relationships.

```solidity
mapping(address => uint256) public balances;
```

Conceptually:

```text
Alice → 100
Bob   → 50
Carol → 0
```

Mappings don't provide normal array-style enumeration.

---

# Q10. What is a modifier?

A modifier reuses pre/post-condition logic around functions.

```solidity
modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}
```

Then:

```solidity
function withdraw()
    external
    onlyOwner
{
}
```

OpenZeppelin provides many production-ready modifiers such as `onlyOwner` and `onlyRole`.

---

# Q11. What are events?

Events create EVM logs that applications and indexers can consume.

```solidity
event Deposited(
    address indexed user,
    uint256 amount
);

emit Deposited(msg.sender, msg.value);
```

Use events for important off-chain observable actions.

---

# Q12. Events vs storage?

```text
Storage
→ contract state
→ readable by contracts

Event
→ transaction log
→ useful for frontend/indexers
→ not contract state
```

Never use events as a replacement for state required by contract logic.

---

# Q13. What is `address(0)`?

The zero address:

```solidity
address(0)
```

is commonly used as an invalid/null address.

Typical validation:

```solidity
if (user == address(0)) {
    revert InvalidAddress();
}
```

But don't treat every use of zero address as invalid automatically; token standards sometimes intentionally use it in mint/burn semantics.

---

# Q14. Why use custom errors?

Instead of:

```solidity
require(
    balance >= amount,
    "Insufficient balance"
);
```

you can use:

```solidity
error InsufficientBalance(
    uint256 available,
    uint256 requested
);
```

Then:

```solidity
revert InsufficientBalance(
    balance,
    amount
);
```

Advantages:

```text
Structured
Clear
Often cheaper than long revert strings
```

---

# Q15. What is inheritance?

Solidity supports contract inheritance.

```solidity
contract Child is Parent {
}
```

OpenZeppelin heavily uses inheritance to provide modular reusable behavior.

Example:

```solidity
contract MyToken is ERC20, Ownable {
}
```

OpenZeppelin explicitly uses inheritance as a mechanism for modular smart-contract development.

---

# 🪙 LEVEL 2 — ERC TOKEN INTERVIEW

# Q16. What is ERC-20?

ERC-20 is the standard interface for fungible tokens.

Common functions:

```text
totalSupply()
balanceOf()
transfer()
allowance()
approve()
transferFrom()
```

OpenZeppelin provides an implementation rather than requiring you to implement the standard from scratch.

---

# Q17. ERC-20 vs ERC-721?

```text
ERC20
→ fungible
→ each unit equivalent

ERC721
→ non-fungible
→ each token ID identifies a unique asset
```

Example:

```text
ERC20 → USDC-like currency
ERC721 → NFT
```

---

# Q18. ERC-1155?

ERC-1155 supports multiple token types within one contract.

Useful for:

```text
Game currencies
Weapons
Items
Tickets
Bundles
```

Mental model:

```text
ERC20  = one fungible asset type
ERC721 = unique asset IDs
ERC1155 = many asset IDs/types
```

---

# Q19. Explain `approve()` + `transferFrom()`.

User:

```text
approve(Spender, 100)
```

means:

```text
Spender may spend up to 100
```

Then:

```solidity
transferFrom(owner, recipient, amount)
```

lets the approved spender transfer tokens subject to allowance.

Typical flow:

```text
User
 ↓ approve
Protocol
 ↓ transferFrom
User's tokens
```

This pattern is foundational to DeFi protocols.

---

# Q20. What is an allowance race issue?

If a user changes an allowance from:

```text
100 → 50
```

a spender may potentially observe and front-run transactions depending on the exact token/interaction pattern.

Safer application patterns often include:

```text
approve 0
then approve new amount
```

or token-specific safe allowance helpers.

Always account for non-standard ERC-20 implementations.

---

# Q21. What is `_mint()`?

OpenZeppelin token implementations use internal minting functions such as:

```solidity
_mint(to, amount);
```

Your custom contract should define **who is authorized to call your public mint operation**.

For example:

```solidity
function mint(address to, uint256 amount)
    external
    onlyRole(MINTER_ROLE)
{
    _mint(to, amount);
}
```

---

# Q22. What is `_burn()`?

It destroys tokens from an account's balance and reduces supply according to the token implementation.

Typical:

```solidity
_burn(msg.sender, amount);
```

---

# Q23. What is `decimals()`?

ERC-20 commonly exposes decimals for user-interface denomination.

For example:

```text
1 token
=
1 × 10^18 base units
```

Important:

> `decimals()` is primarily a display/denomination convention. It does not magically change arithmetic precision or blockchain storage.

---

# 🏠 LEVEL 3 — OPENZEPPELIN ACCESS CONTROL

# Q24. What is OpenZeppelin?

OpenZeppelin Contracts is a reusable Solidity library providing implementations and building blocks for standards and security-sensitive functionality, including ERC tokens, access control, utilities, governance, and proxy patterns.

The key interview phrase:

> **"I use OpenZeppelin to avoid reinventing standardized and security-sensitive components."**

---

# Q25. What is `Ownable`?

`Ownable` provides simple single-owner access control.

```solidity
contract Vault is Ownable {

    constructor(address owner)
        Ownable(owner)
    {}

    function withdraw()
        external
        onlyOwner
    {
    }
}
```

Use when:

```text
one administrative authority
```

OpenZeppelin documents `Ownable` as the basic single-owner access-control mechanism.

---

# Q26. What is `Ownable2Step`?

It changes ownership transfer into two steps:

```text
current owner
    ↓
transferOwnership(newOwner)
    ↓
pending owner
    ↓
acceptOwnership()
    ↓
new owner
```

Why?

It reduces mistakes where ownership is accidentally transferred to an unusable address.

### Interview gold:

> "I prefer two-step ownership transfer when ownership is security-critical because the receiving party explicitly accepts the role."

---

# Q27. `Ownable` vs `AccessControl`?

| Ownable               | AccessControl      |
| --------------------- | ------------------ |
| One main owner        | Multiple roles     |
| Simple                | Granular           |
| `onlyOwner`           | `onlyRole`         |
| Easy to reason about  | More configuration |
| Good for simple admin | Good for protocols |

Example:

```text
Owner
→ pause

vs

MINTER
→ mint

PAUSER
→ pause

TREASURER
→ withdraw

UPGRADER
→ upgrade
```

## OpenZeppelin recommends role-based access when granular permissions are needed.

# Q28. What is `AccessControl`?

`AccessControl` implements role-based access control.

```solidity
bytes32 public constant MINTER_ROLE =
    keccak256("MINTER_ROLE");
```

Then:

```solidity
function mint(...)
    external
    onlyRole(MINTER_ROLE)
{
}
```

It supports granting, revoking, and checking roles.

---

# Q29. What is `DEFAULT_ADMIN_ROLE`?

It is the default administrator role for other roles and is itself its own admin by default.

This makes it highly sensitive.

Interview answer:

> "`DEFAULT_ADMIN_ROLE` is powerful because it can manage roles. I treat it as a high-value security key and consider stronger admin protections such as `AccessControlDefaultAdminRules`, multisig, or a governance/timelock architecture depending on the protocol."

---

# Q30. What is the principle of least privilege?

Give an account only the permissions it needs.

Bad:

```text
Everyone → ADMIN
```

Better:

```text
Minter → mint
Pauser → pause
Treasurer → treasury
Upgrader → upgrade
```

OpenZeppelin specifically highlights least privilege as a security practice in its access-control documentation.

---

# Q31. What is `AccessManager`?

`AccessManager` is designed to centralize permissions across multiple contracts.

Think:

```text
              AccessManager
              /       |        \
          Token     Staking    Treasury
```

Instead of managing fragmented permissions separately in every contract, the manager can map roles to target functions.

OpenZeppelin describes `AccessManager` as a system-level permission manager using roles and target function selectors. citeturn0search0turn0search2

---

# Q32. `AccessControl` vs `AccessManager`?

### AccessControl

```text
Permissions live in each contract.
```

### AccessManager

```text
Permissions can be centralized
for a system of contracts.
```

Use:

```text
Simple contract
→ AccessControl

Complex multi-contract protocol
→ Consider AccessManager
```

---

# Q33. What is a role admin?

In `AccessControl`, each role has an admin role that controls who can grant/revoke that role.

Concept:

```text
MINTER_ROLE
      ↑
MINTER_ADMIN
```

or by default:

```text
DEFAULT_ADMIN_ROLE
      ↓
MINTER_ROLE
```

---

# Q34. Why can role management be dangerous?

Because permission bugs can be worse than ordinary logic bugs.

Ask:

```text
Who grants MINTER?
Who can revoke MINTER?
Who controls DEFAULT_ADMIN?
Can admin grant itself something?
Can admin permanently freeze users?
```

---

# 🛡️ LEVEL 4 — SECURITY

# Q35. What is reentrancy?

Reentrancy occurs when an external call allows control to re-enter a vulnerable function before the first execution has finished.

Classic vulnerable pattern:

```text
check balance
 ↓
external call
 ↓
attacker re-enters
 ↓
balance still unchanged
 ↓
withdraw again
```

---

# Q36. How do you prevent reentrancy?

Common defenses:

```text
Checks-Effects-Interactions
+
ReentrancyGuard when appropriate
+
careful state accounting
```

OpenZeppelin provides `ReentrancyGuard` as a reusable module.

---

# Q37. What is Checks-Effects-Interactions?

Order:

```text
1. Checks
2. State effects
3. External interactions
```

Example:

```solidity
require(balance >= amount);

balance -= amount;

(bool ok, ) =
    payable(msg.sender).call{value: amount}("");

require(ok);
```

The key idea:

> Update internal state before making the external call.

---

# Q38. Is `nonReentrant` enough?

No.

Strong answer:

> "`nonReentrant` is an important defense, but security still depends on state accounting, external calls, authorization, and contract architecture. I wouldn't treat a modifier as proof that a function is secure."

---

# Q39. What is `Pausable`?

`Pausable` provides an emergency-stop mechanism.

Concept:

```text
NORMAL
  ↓
attack/bug discovered
  ↓
PAUSE
  ↓
investigate
  ↓
fix
  ↓
UNPAUSE
```

OpenZeppelin's `Pausable` provides pause state and internal pause/unpause mechanisms; your contract must expose appropriately protected functions to control it. citeturn0search7

---

# Q40. Does inheriting `Pausable` automatically pause my contract?

**No.**

This is a very common interview trap.

You must connect pause state to the relevant operations.

For example:

```solidity
function mint(...)
    external
    whenNotPaused
{
}
```

And expose protected pause/unpause functions.

OpenZeppelin explicitly notes that extensions such as `ERC721Pausable` do not automatically provide public pause/unpause functions. citeturn0search7

---

# Q41. What is a flash-loan attack?

A flash loan lets an attacker borrow a large amount of capital within one transaction, perform actions, and repay it before the transaction ends.

The problem isn't the flash loan itself.

The vulnerability is usually:

```text
Protocol assumes temporary capital
is trustworthy
```

Defenses depend on the protocol:

```text
Robust pricing
TWAP/oracles
Economic checks
Slippage limits
Reentrancy defenses
Correct accounting
```

---

# Q42. What is oracle manipulation?

If a protocol trusts an easily manipulated price source, an attacker can manipulate the input and exploit the protocol.

Never assume:

```text
spot price
=
safe oracle
```

---

# Q43. What is frontrunning?

An attacker observes a pending transaction and submits another transaction with a strategy designed to execute before it.

Examples:

```text
DEX trade
NFT mint
liquidation
governance
```

Possible defenses vary:

```text
commit-reveal
slippage protection
deadlines
private order flow
batching
protocol-specific design
```

---

# Q44. What is sandwich attack?

Typical DEX scenario:

```text
Attacker buys
   ↓
Victim trade
   ↓
Attacker sells
```

The attacker attempts to profit from price movement caused by the victim's transaction.

Frontend/protocol defenses include appropriate slippage controls and transaction deadlines.

---

# Q45. What is access-control vulnerability?

An attacker calls a function they should not have permission to call.

Example:

```solidity
function mint(address to, uint256 amount)
    external
{
    _mint(to, amount);
}
```

If unlimited minting was supposed to be admin-only, this is catastrophic.

Fix:

```solidity
onlyOwner
```

or:

```solidity
onlyRole(MINTER_ROLE)
```

---

# 🧬 LEVEL 5 — UPGRADEABLE CONTRACTS

# Q46. What is an upgradeable smart contract?

A proxy architecture separates:

```text
Proxy
  ↓
Implementation
```

Users interact with the proxy while logic lives in the implementation.

The implementation can be replaced according to the upgrade mechanism.

OpenZeppelin documents multiple proxy patterns and upgrade tooling. citeturn0search5

---

# Q47. Why use upgradeability?

Benefits:

```text
Bug fixes
Feature upgrades
Protocol evolution
```

Costs:

```text
More complexity
Admin risk
Storage-layout risk
Upgrade authorization risk
Less "immutability"
```

---

# Q48. Why can't upgradeable contracts use normal constructors?

The proxy is the address users interact with.

Constructor execution happens for the implementation deployment, not as initialization of proxy storage.

Therefore OpenZeppelin's upgradeable contracts use initializer functions instead of constructors. citeturn0search1

---

# Q49. What is an initializer?

Example:

```solidity
function initialize(
    address owner
)
    public
    initializer
{
    __Ownable_init(owner);
}
```

The initializer performs setup in proxy storage.

---

# Q50. What is the storage-layout problem?

Suppose V1:

```text
slot 0 → owner
slot 1 → balance
```

V2 must not accidentally reinterpret those slots:

```text
slot 0 → balance
slot 1 → owner
```

That can corrupt state.

OpenZeppelin recommends upgrade tooling to help detect storage-layout incompatibilities. citeturn0search6

---

# Q51. Can you upgrade OpenZeppelin 4.x implementation directly to 5.x?

For a live upgradeable contract, you should treat major-version storage layouts as incompatible.

OpenZeppelin explicitly states that major releases should be assumed incompatible and that upgrading a live contract between major versions is unsafe.

---

# Q52. UUPS vs Transparent Proxy?

High-level answer:

```text
Transparent
→ proxy handles upgrade administration pattern

UUPS
→ upgrade logic lives in implementation
```

UUPS can reduce proxy bytecode/storage overhead, but it puts upgrade authorization and upgrade logic inside the implementation.

OpenZeppelin's current proxy API documents UUPS-specific security checks and ERC-1822 compatibility. citeturn0search5

---

# Q53. What is an upgrade-authority vulnerability?

If an attacker gets upgrade authority:

```text
attacker
 ↓
upgrade implementation
 ↓
new malicious code
 ↓
steal/control protocol
```

Therefore:

```text
UPGRADER
=
extremely sensitive role
```

Use appropriate:

```text
multisig
+
timelock
+
governance
```

depending on protocol design.

---

# 🧪 LEVEL 6 — TESTING INTERVIEW

# Q54. What should you test in a smart contract?

Don't only test happy paths.

Test:

```text
Happy path
Unauthorized caller
Zero values
Maximum values
Repeated calls
Invalid state transitions
Events
Reverts
External calls
Economic edge cases
```

---

# Q55. How do you test access control?

Example:

```javascript
await expect(contract.connect(attacker).adminFunction()).to.be.reverted;
```

Then verify the authorized user succeeds.

---

# Q56. What is fuzz testing?

Instead of testing a few manually selected values:

```text
1
10
100
1000
```

fuzzing generates many inputs.

Goal:

```text
Find unexpected edge cases
```

---

# Q57. What is invariant testing?

Instead of checking only:

```text
function X works
```

you define properties that should always remain true.

Example:

```text
total balances == total supply
```

or:

```text
user cannot withdraw more than deposited
```

---

# Q58. Unit vs integration tests?

### Unit

Test one contract/function behavior.

### Integration

Test multiple contracts together.

Example:

```text
ERC20
 +
Staking
 +
RewardManager
```

A serious DeFi project needs both.

---

# 🧩 LEVEL 7 — SOLIDITY INTERVIEW TRAPS

# Q59. Is `private` data actually private on blockchain?

**No.**

`private` means other Solidity contracts cannot directly access that variable through the normal Solidity interface.

But blockchain state is generally observable.

Interview gold:

> "`private` is a Solidity visibility restriction, not encryption."

---

# Q60. Is `view` always free?

Not exactly.

A local `eth_call` doesn't create a state-changing transaction, so the user normally doesn't pay gas for that RPC read.

But executing a view function from another on-chain transaction consumes EVM resources as part of that transaction.

---

# Q61. Can a contract receive ETH?

Yes.

Using:

```solidity
receive() external payable {}
```

or:

```solidity
fallback() external payable {}
```

depending on the intended behavior.

---

# Q62. Difference between `receive()` and `fallback()`?

Simplified:

```text
receive()
→ ETH sent with empty calldata

fallback()
→ unmatched function call / fallback path
```

A payable fallback can also receive ETH when appropriate.

---

# Q63. Why is `tx.origin` dangerous for authorization?

Do not use:

```solidity
require(tx.origin == owner);
```

for authentication.

`tx.origin` represents the original EOA at the start of the transaction chain, not the immediate caller.

Prefer:

```solidity
msg.sender
```

for authorization.

---

# Q64. What is `delegatecall`?

`delegatecall` executes another contract's code while preserving the caller's:

```text
storage
msg.sender
msg.value
```

context.

This is fundamental to proxy contracts.

But it is extremely powerful and dangerous if storage layouts or trusted implementations are wrong.

---

# Q65. What is `call` vs `delegatecall`?

```text
call
→ execute target code
→ target's storage

delegatecall
→ execute target code
→ caller's storage
```

---

# 🏗️ LEVEL 8 — ARCHITECTURE QUESTIONS

# Q66. How would you design an ERC-20 with minting and pausing?

Strong answer:

```text
ERC20
+
AccessControl
+
Pausable
```

Roles:

```text
MINTER_ROLE
PAUSER_ROLE
DEFAULT_ADMIN_ROLE
```

Then:

```text
mint → MINTER_ROLE
pause → PAUSER_ROLE
role management → admin
```

Test:

```text
authorized mint
unauthorized mint
pause
blocked operation
unpause
```

---

# Q67. How would you design a staking protocol?

Architecture:

```text
Staking
  │
  ├── token
  ├── balances
  ├── reward accounting
  ├── stake()
  ├── unstake()
  └── claim()
```

Security:

```text
Access control
Reentrancy analysis
Safe token interactions
Pause mechanism if justified
Correct reward accounting
```

Testing:

```text
stake
unstake
reward
claim
zero amount
insufficient balance
multiple users
time progression
```

---

# Q68. How would you design an NFT marketplace?

```text
ERC721
   │
   ▼
Marketplace
   │
   ├── list
   ├── cancel
   ├── buy
   └── withdraw
```

Security questions:

```text
Does seller own NFT?
Is marketplace approved?
Can price be zero?
Can listing be bought twice?
Can seller receive payment safely?
Can reentrancy occur?
```

---

# Q69. How would you design a DAO?

```text
Governance token
       ↓
Voting
       ↓
Governor
       ↓
Timelock
       ↓
Protocol/Treasury
```

OpenZeppelin provides governance building blocks in its Contracts library. citeturn0search8

---

# Q70. How would you secure a protocol administrator?

Weak:

```text
EOA → admin
```

Stronger architecture may be:

```text
Multisig
   ↓
Timelock
   ↓
Protocol
```

For complex systems:

```text
Governor
   ↓
Timelock
   ↓
Protocol
```

The exact design depends on governance and operational requirements.

OpenZeppelin's `TimelockController` is intended to add delay between ordering and execution of sensitive operations. citeturn0search0

---

# 🔥 LEVEL 9 — OPENZEPPELIN RAPID FIRE

## Q71. What does `onlyOwner` do?

Restricts a function to the contract owner.

---

## Q72. What does `onlyRole()` do?

Restricts a function to accounts holding a specified role.

---

## Q73. What does `_grantRole()` do?

Internally grants a role, commonly useful during initialization/deployment logic.

---

## Q74. `grantRole()` vs `_grantRole()`?

Conceptually:

```text
grantRole()
→ public/external role-management flow with admin authorization

_grantRole()
→ internal programmatic assignment
```

---

## Q75. What is `AccessControlDefaultAdminRules`?

An OpenZeppelin extension designed to add stronger protections around `DEFAULT_ADMIN_ROLE`, including a single default admin and a two-step transfer with delay. citeturn0search0

---

## Q76. What is `AccessManaged`?

A contract module that lets a contract delegate permission decisions to an authority such as `AccessManager`.

It provides the `restricted` modifier. citeturn0search2

---

## Q77. What is `Pausable` used for?

Emergency stopping of selected contract operations.

---

## Q78. What is `ReentrancyGuard`?

A reusable guard against reentrant calls to protected functions.

---

## Q79. What is `ERC721URIStorage`?

An ERC-721 extension supporting per-token metadata URI storage. citeturn0search4

---

## Q80. What is `ERC20Votes`?

An ERC-20 extension designed to integrate token-based voting power with governance systems.

---

# 🧠 LEVEL 10 — "WHY?" QUESTIONS

These are the questions that separate beginners from developers.

---

# Q81. Why not write your own ERC-20?

Because standardized token behavior is security-sensitive and widely implemented.

Using OpenZeppelin reduces the amount of standard logic you have to implement yourself.

OpenZeppelin recommends using its published library code rather than copy-pasting library source. citeturn0search3turn0search9

---

# Q82. Why use `AccessControl` instead of `Ownable`?

Because permission boundaries may be different.

Example:

```text
Minter ≠ Pauser ≠ Treasury ≠ Upgrader
```

Least privilege reduces blast radius.

---

# Q83. Why use `Ownable2Step`?

Because an ownership transfer can otherwise become operationally dangerous if the receiving address is incorrect or unable to interact.

The new owner explicitly accepts ownership. citeturn0search0turn0search2

---

# Q84. Why use a multisig?

Because a single private key creates a single point of failure.

Instead:

```text
2-of-3
3-of-5
```

can require multiple signers.

---

# Q85. Why use a timelock?

Because authorization alone doesn't protect users from a malicious or compromised administrator.

A delay gives:

```text
Detection time
Review time
Exit time
```

before sensitive changes execute.

---

# Q86. Why not make every contract upgradeable?

Because upgradeability introduces:

```text
Admin risk
Complexity
Storage-layout risk
Implementation risk
Governance risk
```

If immutability is sufficient, it can be simpler.

---

# Q87. Why should events be emitted?

They make important state transitions discoverable by:

```text
Frontend
Indexers
Analytics
Monitoring systems
```

---

# Q88. Why use custom errors?

They provide structured revert information and can be more gas-efficient than long strings.

---

# 🧨 LEVEL 11 — SECURITY SCENARIO QUESTIONS

# Q89. "Anyone can call mint(). What's wrong?"

If unlimited minting was intended to be privileged, this is a critical authorization vulnerability.

Fix:

```solidity
onlyOwner
```

or:

```solidity
onlyRole(MINTER_ROLE)
```

---

# Q90. "Owner accidentally transferred ownership to the wrong address. What could happen?"

Administrative functions may become inaccessible.

Mitigation:

```text
Ownable2Step
+
multisig
+
operational checks
```

---

# Q91. "The contract inherits Pausable but attackers can still call a function during pause. Why?"

Because the function may not use a pause check.

Example:

```solidity
whenNotPaused
```

must be applied where appropriate.

OpenZeppelin's pausable token extensions also require developers to expose protected pause/unpause controls. citeturn0search7

---

# Q92. "Admin can upgrade implementation. Why is that dangerous?"

Because upgrade authority effectively controls future code behavior.

A malicious upgrade can:

```text
Steal funds
Change balances
Bypass permissions
Freeze users
```

Therefore upgrade authorization is one of the highest-value security boundaries.

---

# Q93. "You upgraded V1 to V2 and balances are corrupted. What do you investigate?"

Immediately investigate:

```text
Storage layout
Variable order
Inherited storage
Deleted/inserted variables
Types
OpenZeppelin version
Upgrade tooling
Initializer logic
```

OpenZeppelin recommends upgrade tooling to detect storage-layout incompatibilities. citeturn0search6

---

# Q94. "A user calls your contract through another contract. What is msg.sender?"

The immediate calling contract.

Example:

```text
User
 ↓
Contract A
 ↓
Contract B
```

Inside B:

```solidity
msg.sender == Contract A
```

This matters enormously for authorization design.

---

# Q95. "You use AccessManager. Who may appear as msg.sender inside the managed function?"

When execution goes through the manager's `execute` flow, the managed contract can see the AccessManager contract as the caller rather than the original external caller. OpenZeppelin explicitly highlights this as an important migration/integration consideration. citeturn0search0

---

# 🧠 LEVEL 12 — CODING INTERVIEW PROMPTS

# Challenge 1 — Ownable Vault

Build:

```solidity
contract Vault
```

Requirements:

```text
deposit()
withdraw()
onlyOwner withdrawal
Deposited event
Withdrawn event
```

Interviewer expects:

```text
payable
msg.value
msg.sender
Ownable
events
checks
```

---

# Challenge 2 — ERC20 Minter

Build:

```text
ERC20
+
AccessControl
```

Requirements:

```text
MINTER_ROLE
mint()
role-based restriction
```

Tests:

```text
authorized mint
unauthorized mint
```

---

# Challenge 3 — Pausable Token

Build:

```text
ERC20
+
Pausable
+
AccessControl
```

Requirements:

```text
PAUSER_ROLE
pause()
unpause()
blocked operations while paused
```

---

# Challenge 4 — NFT Minting

Build:

```text
ERC721
```

Requirements:

```text
mint()
token IDs
metadata URI
only authorized minter
```

OpenZeppelin provides ERC-721 implementations and extensions such as `ERC721URIStorage`. citeturn0search4turn0search8

---

# Challenge 5 — Secure Staking

Build:

```text
stake()
unstake()
claimReward()
```

Add:

```text
ReentrancyGuard
Pausable
AccessControl
events
custom errors
```

Then ask yourself:

```text
Can rewards be claimed twice?
Can users withdraw more than deposited?
Can an attacker re-enter?
Can admin steal funds?
```

---

# Challenge 6 — Upgradeable Box

Build:

```text
BoxUpgradeable
```

Use:

```text
contracts-upgradeable
initializer
upgrade authorization
storage discipline
```

OpenZeppelin's upgradeable package uses `Upgradeable` variants and initializer functions instead of constructors. citeturn0search1

---

# 🎤 LEVEL 13 — MOCK INTERVIEW

## Interviewer:

"Tell me about your Solidity experience."

### Strong answer template:

> "I've been working with Solidity and Ethereum smart-contract development, focusing on contract architecture, access control, ERC standards, testing, and deployment. I've used OpenZeppelin for reusable standards such as ERC-20/ERC-721 and security patterns such as ownership, role-based access control, pausing, and reentrancy protection. My development workflow is to design the state and permissions first, implement the contract, write positive and adversarial tests, deploy locally, integrate the frontend, and then move to testnet."

---

## Interviewer:

"Why OpenZeppelin?"

### Answer:

> "I use OpenZeppelin because it provides reusable implementations of standardized and security-sensitive components. Rather than implementing ERC-20, access control, or upgrade patterns from scratch, I compose established modules and focus my custom code on business logic. I still treat the resulting system as my responsibility and test the composition and configuration." citeturn0search3turn0search9

---

## Interviewer:

"How would you secure an admin?"

### Answer:

> "First I'd minimize the admin's permissions. For simple systems I might use Ownable or Ownable2Step. For multiple responsibilities I'd use AccessControl. For a multi-contract production protocol I'd consider AccessManager. For high-impact operations I'd consider a multisig and timelock. The exact architecture depends on the threat model and governance requirements." citeturn0search0turn0search2

---

# ⚡ LEVEL 14 — 30-SECOND RAPID FIRE

### Solidity

```text
msg.sender
= immediate caller

msg.value
= ETH sent with call

storage
= persistent state

memory
= temporary mutable data

calldata
= temporary read-only input

view
= reads state

pure
= doesn't read/write state

payable
= can receive ETH

event
= blockchain log

modifier
= reusable function condition
```

### OpenZeppelin

```text
Ownable
= one owner

Ownable2Step
= two-step ownership

AccessControl
= roles

AccessManager
= system-wide permissions

Pausable
= emergency stop

ReentrancyGuard
= reentrancy defense

ERC20
= fungible token

ERC721
= NFT

ERC1155
= multi-token

Governor
= governance

Timelock
= delayed execution

Upgradeable
= proxy-oriented contracts
```

---

# 🔥 LEVEL 15 — INTERVIEW TRAPS

## Trap 1

### "OpenZeppelin means my contract is secure."

**Wrong.**

Correct:

> OpenZeppelin reduces implementation risk for reusable components, but my custom business logic, permissions, integrations, economics, and deployment configuration still require testing and security review.

---

## Trap 2

### "Pausable means the whole contract is frozen."

**Wrong.**

Correct:

> Pause behavior must be connected to the specific functions or token operations that should be restricted.

---

## Trap 3

### "Private means encrypted."

**Wrong.**

Correct:

> `private` controls Solidity-level access, not blockchain data visibility.

---

## Trap 4

### "OnlyOwner is always better."

**Wrong.**

Correct:

> It is simpler, but role-based access may be more appropriate when different responsibilities need different permissions.

---

## Trap 5

### "Upgradeability is free."

**Wrong.**

Correct:

> Upgradeability adds operational flexibility but introduces admin, implementation, governance, and storage-layout risks.

---

# 🧠 LEVEL 16 — DESIGN QUESTIONS

# Q96. How would you choose between Ownable and AccessControl?

Use this decision tree:

```text
One administrator?
      │
     YES
      ↓
   Ownable

Need safer ownership transfer?
      ↓
 Ownable2Step

Multiple permission types?
      ↓
 AccessControl

Many contracts with centralized permissions?
      ↓
 AccessManager
```

This matches OpenZeppelin's current access-control model. citeturn0search0turn0search2

---

# Q97. How would you design a secure minting system?

```text
ERC20
  +
MINTER_ROLE
  +
supply policy
  +
events
  +
tests
```

Ask:

```text
Who can mint?
How much?
Can they mint forever?
Can role be revoked?
Is there a cap?
Is minting pausable?
```

---

# Q98. How would you secure a treasury?

Potential architecture:

```text
Multisig
   ↓
Timelock
   ↓
Treasury
```

Then:

```text
limited permissions
withdrawal limits
events
tests
monitoring
```

Don't blindly give one EOA unlimited withdrawal authority.

---

# Q99. How would you design protocol upgrades?

```text
Implementation
      ↓
Proxy
      ↓
Upgrade authority
      ↓
Multisig / governance
      ↓
Timelock
```

Then:

```text
storage layout checks
upgrade tests
initializer tests
authorization tests
```

---

# 🏆 LEVEL 17 — PORTFOLIO QUESTIONS

## Q100. Explain one Solidity project you built.

Use:

```text
Problem
 ↓
Architecture
 ↓
Contracts
 ↓
OpenZeppelin modules
 ↓
Security
 ↓
Testing
 ↓
Deployment
 ↓
Result
```

Example:

> "I built an ERC-20 staking dApp. The token used OpenZeppelin ERC20, while the staking contract handled deposits, withdrawals, and rewards. I separated administrative permissions from user actions, added reentrancy protection where external calls required it, emitted staking events, and wrote tests for normal and unauthorized behavior. I deployed locally first, integrated a React frontend through ethers, and then deployed to a testnet."

---

# 🎯 LEVEL 18 — "SPOT THE BUG"

## Code:

```solidity
function mint(
    address to,
    uint256 amount
) external {
    _mint(to, amount);
}
```

### Question:

What's wrong?

### Answer:

If minting is supposed to be restricted, anyone can call it.

Potential fix:

```solidity
function mint(
    address to,
    uint256 amount
)
    external
    onlyRole(MINTER_ROLE)
{
    _mint(to, amount);
}
```

---

## Code:

```solidity
function withdraw(uint256 amount)
    external
{
    payable(msg.sender).call{value: amount}("");
    balances[msg.sender] -= amount;
}
```

### Question:

What's dangerous?

### Answer:

The external call occurs before state is updated.

That can create reentrancy risk.

Better conceptual ordering:

```text
check
↓
state update
↓
external call
```

and consider an appropriate reentrancy defense.

---

# 🧨 LEVEL 19 — ADVANCED SECURITY QUESTIONS

# Q101. What is a denial-of-service-by-gas problem?

If a function loops over an ever-growing array:

```solidity
for (...) {
}
```

eventually the transaction may become too expensive to execute.

Avoid unbounded loops over user-controlled collections in state-changing paths.

---

# Q102. What is a pull-payment pattern?

Instead of automatically sending funds during a complex operation:

```text
Protocol owes user
      ↓
record credit
      ↓
user withdraws
```

This can reduce external-call complexity and separate accounting from payment execution.

---

# Q103. Why are external calls dangerous?

Because the target contract may:

```text
revert
re-enter
consume gas
behave unexpectedly
be malicious
```

Treat external calls as trust boundaries.

---

# Q104. Why should you avoid `tx.origin` authorization?

Because intermediary contracts can cause unexpected authorization behavior.

Use:

```solidity
msg.sender
```

for normal caller authorization.

---

# Q105. What is a denial-of-service attack through a malicious receiver?

An NFT or ETH transfer may interact with a receiver contract that deliberately reverts.

Your architecture should consider whether a recipient can block the operation and whether that is acceptable.

---

# 🧠 LEVEL 20 — THE INTERVIEW DECISION ENGINE

When the interviewer gives you a requirement:

```text
"Build a token."
        ↓
ERC20 / ERC721 / ERC1155?
        ↓
"Who can mint?"
        ↓
Ownable / AccessControl
        ↓
"Can we pause?"
        ↓
Pausable
        ↓
"Can funds leave?"
        ↓
external-call analysis
        ↓
"Can it re-enter?"
        ↓
CEI / ReentrancyGuard
        ↓
"Can code change?"
        ↓
upgradeability
        ↓
"Who controls upgrades?"
        ↓
multisig / timelock / governance
        ↓
"How do you prove it works?"
        ↓
tests
```

This is the skill interviewers actually want.

---

# 🥇 TOP 25 QUESTIONS TO MEMORIZE

If you have very little time, master these:

```text
1. What is Solidity?
2. What is the EVM?
3. storage vs memory vs calldata?
4. msg.sender vs tx.origin?
5. view vs pure?
6. payable?
7. events?
8. custom errors?
9. ERC20 vs ERC721 vs ERC1155?
10. approve vs transferFrom?
11. What is OpenZeppelin?
12. Ownable?
13. Ownable2Step?
14. AccessControl?
15. DEFAULT_ADMIN_ROLE?
16. AccessManager?
17. Pausable?
18. ReentrancyGuard?
19. Checks-Effects-Interactions?
20. What is reentrancy?
21. What is upgradeability?
22. Why initializer instead of constructor?
23. What is storage-layout compatibility?
24. How do you test access control?
25. How would you secure an admin?
```

---

# 🧠 THE "SENIOR ANSWER" FORMULA

When asked:

> "How would you build X?"

Don't immediately say:

```text
"I'll use OpenZeppelin."
```

Say:

```text
1. Define requirements
2. Identify assets
3. Define state
4. Define permissions
5. Choose standards
6. Choose OpenZeppelin modules
7. Identify external calls
8. Identify attack surfaces
9. Design events/errors
10. Write tests
11. Deploy locally
12. Integrate frontend
13. Testnet
14. Verification
15. Monitoring
```

That answer demonstrates engineering thinking.

---

# 📌 FINAL INTERVIEW MEMORY MAP

```text
                     SOLIDITY
                        │
        ┌───────────────┼────────────────┐
        │               │                │
       STATE          LOGIC           SECURITY
        │               │                │
 storage/memory      functions        access control
 mappings            modifiers        reentrancy
 structs             events           pause
 arrays              errors           upgrades
        │               │                │
        └───────────────┼────────────────┘
                        │
                   OPENZEPPELIN
                        │
       ┌────────────────┼─────────────────┐
       │                │                 │
    TOKENS            ACCESS            GOVERNANCE
       │                │                 │
    ERC20          Ownable             Governor
    ERC721         AccessControl       Timelock
    ERC1155        AccessManager       ERC20Votes
       │                │                 │
       └────────────────┼─────────────────┘
                        │
                     TESTING
                        │
             ┌──────────┼──────────┐
             │          │          │
           happy     attacker    edge
             │          │          │
             └──────────┼──────────┘
                        │
                      DEPLOY
                        │
                   LOCAL → TESTNET
```

---

# 🚀 7-DAY INTERVIEW PREPARATION PLAN

## Day 1 — Solidity

```text
[ ] Types
[ ] Functions
[ ] Visibility
[ ] Storage/memory/calldata
[ ] Events
[ ] Errors
[ ] Modifiers
```

## Day 2 — ERC Standards

```text
[ ] ERC20
[ ] approve
[ ] allowance
[ ] transferFrom
[ ] ERC721
[ ] ERC1155
```

## Day 3 — OpenZeppelin

```text
[ ] Ownable
[ ] Ownable2Step
[ ] AccessControl
[ ] AccessManager
[ ] Pausable
[ ] ReentrancyGuard
```

## Day 4 — Security

```text
[ ] Reentrancy
[ ] Access control
[ ] CEI
[ ] Oracle manipulation
[ ] Flash loans
[ ] Front-running
[ ] DoS
```

## Day 5 — Upgradeability

```text
[ ] Proxy
[ ] Implementation
[ ] UUPS
[ ] Initializer
[ ] Storage layout
[ ] Upgrade authorization
```

## Day 6 — Coding

Build:

```text
[ ] ERC20
[ ] NFT
[ ] Staking
[ ] Secure Vault
```

## Day 7 — Mock Interview

Practice answering:

```text
[ ] Explain your project
[ ] Explain your architecture
[ ] Explain your security
[ ] Explain your OpenZeppelin choices
[ ] Explain a bug you fixed
[ ] Explain how you test
[ ] Explain deployment
```

---

# 🏁 FINAL CHALLENGE

Build this project and use it as your interview project:

## 🔐 Secure Creator Funding Protocol

### Smart contracts

```text
CreatorFunding.sol
```

Features:

```text
createCampaign()
donate()
withdraw()
refund()
pause()
unpause()
```

### OpenZeppelin

Use appropriate modules such as:

```text
Ownable2Step
Pausable
ReentrancyGuard
```

or role-based access where the requirements justify it.

### Tests

```text
[ ] campaign creation
[ ] donation
[ ] withdrawal
[ ] refund
[ ] unauthorized withdrawal
[ ] pause
[ ] blocked operations
[ ] reentrancy scenario
[ ] zero values
[ ] invalid campaign
[ ] events
```

### React

```text
Connect wallet
Create campaign
Donate
Show campaign
Show balance
Withdraw/refund
Show transaction status
```

### Interview explanation

Be able to answer:

```text
Why this architecture?
Why these OpenZeppelin modules?
Who has admin power?
What can an attacker do?
How did you test it?
Why is reentrancy relevant?
What happens during pause?
How would you upgrade it?
How would you decentralize admin control?
```

If you can answer those questions confidently, you are demonstrating **smart-contract engineering**, not merely Solidity syntax.

---

# 🔗 OFFICIAL OPENZEPPELIN REFERENCES

- OpenZeppelin Contracts: https://docs.openzeppelin.com/contracts/5.x/
- Access Control: https://docs.openzeppelin.com/contracts/5.x/access-control
- API Reference: https://docs.openzeppelin.com/contracts/5.x/api
- Upgradeable Contracts: https://docs.openzeppelin.com/contracts/5.x/upgradeable
- ERC-721: https://docs.openzeppelin.com/contracts/5.x/erc721
- Backwards Compatibility: https://docs.openzeppelin.com/contracts/5.x/backwards-compatibility

OpenZeppelin recommends using the published library code as-is rather than copy-pasting its source into projects. citeturn0search3turn0search9

---

# ⭐ LAST-MINUTE INTERVIEW CARD

```text
ERC20
= fungible

ERC721
= unique NFT

ERC1155
= multi-token

Ownable
= one owner

Ownable2Step
= safer ownership transfer

AccessControl
= roles

AccessManager
= system-wide permission management

Pausable
= emergency brake

ReentrancyGuard
= reentrancy defense

Governor
= governance

Timelock
= delayed sensitive actions

Upgradeable
= proxy architecture

storage
= persistent

memory
= temporary mutable

calldata
= temporary read-only

msg.sender
= immediate caller

msg.value
= ETH sent

event
= log

custom error
= structured revert

CEI
= Checks → Effects → Interactions

BEST INTERVIEW ANSWER
= What + Why + Example + Security + Trade-off
```

# 💎 THE REAL CHEAT CODE

> **Don't answer Solidity questions from memory alone. Answer them from a threat model.**

For every feature ask:

```text
WHO?
 ↓
WHAT?
 ↓
WHEN?
 ↓
HOW MUCH?
 ↓
WHAT IF ATTACKED?
 ↓
WHAT IF ADMIN IS COMPROMISED?
 ↓
WHAT IF AN EXTERNAL CALL FAILS?
 ↓
HOW DO I TEST IT?
```

That mindset is what turns:

```text
Solidity learner
       ↓
Smart Contract Developer
       ↓
Blockchain Engineer
```
