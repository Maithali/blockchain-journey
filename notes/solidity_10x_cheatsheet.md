# ⚡ Solidity 10X Cheat Sheet

> **Purpose:** One-page-to-many-pages reference for learning, coding, debugging, interviews, and building real Ethereum smart contracts.
>
> **Rule:** Don't memorize Solidity line-by-line. Memorize the **patterns**.
>
> Solidity is easiest when you think in 5 boxes:
>
> **STATE → ACCESS → LOGIC → MONEY → EVENTS**

---

# 🧠 0. THE MASTER MENTAL MODEL

```text
CONTRACT
│
├── STATE        → data stored on-chain
│   ├── uint
│   ├── address
│   ├── mapping
│   ├── struct
│   └── arrays
│
├── ACCESS       → who can call?
│   ├── public
│   ├── external
│   ├── internal
│   ├── private
│   └── modifiers
│
├── LOGIC        → what happens?
│   ├── require
│   ├── if/else
│   ├── loops
│   └── functions
│
├── MONEY        → ETH / tokens
│   ├── payable
│   ├── msg.value
│   ├── transfer
│   └── call
│
└── EVENTS       → what should the outside world know?
    └── emit
```

### Golden formula

```text
Smart Contract = State + Functions + Access Control + Validation + Events
```

---

# 🧩 1. CONTRACT SKELETON

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyContract {

    // 1. State variables
    uint256 public value;
    address public owner;

    // 2. Events
    event ValueChanged(uint256 newValue);

    // 3. Constructor
    constructor() {
        owner = msg.sender;
    }

    // 4. Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // 5. Write function
    function setValue(uint256 _value) external onlyOwner {
        value = _value;
        emit ValueChanged(_value);
    }

    // 6. Read function
    function getValue() external view returns (uint256) {
        return value;
    }
}
```

### Remember this order

```text
pragma
↓
contract
↓
state variables
↓
events
↓
constructor
↓
modifiers
↓
functions
↓
receive/fallback
```

---

# 🔢 2. DATA TYPES — THE FAST TABLE

| Type | Example | Use |
|---|---|---|
| `uint256` | `100` | balances, IDs, amounts |
| `uint8` | `18` | small integers |
| `int256` | `-10` | signed values |
| `bool` | `true` | flags |
| `address` | `0x...` | wallet/contract |
| `address payable` | `payable(...)` | address that can receive ETH |
| `string` | `"Hello"` | text |
| `bytes` | `hex"1234"` | dynamic raw data |
| `bytes32` | `keccak256(...)` | hashes, compact data |
| `enum` | `Status.Pending` | fixed states |
| `struct` | `struct User {...}` | grouped data |

### Common defaults

```solidity
uint256  → 0
bool     → false
address  → address(0)
string   → ""
bytes    → empty
```

---

# 🗃️ 3. STORAGE vs MEMORY vs CALLDATA

This is one of the highest-value concepts in Solidity.

```text
storage  = permanent blockchain storage
memory   = temporary RAM-like data during function execution
calldata = read-only external function input
```

### Pattern

```solidity
function setName(string calldata _name) external {
    name = _name;
}
```

```solidity
function getName() external view returns (string memory) {
    return name;
}
```

### Cheat code

```text
State variable         → storage
external input         → calldata
temporary local copy   → memory
```

### Gas instinct

For external read-only parameters:

```text
calldata usually beats memory
```

---

# 🔐 4. VISIBILITY — DON'T CONFUSE THEM

| Visibility | Who can call? | Typical use |
|---|---|---|
| `public` | anyone | externally accessible + internal |
| `external` | external callers | API-like functions |
| `internal` | contract + child contracts | reusable internals |
| `private` | only same contract | hidden implementation detail |

### Memory trick

```text
PUBLIC   = everybody
EXTERNAL = outside only
INTERNAL = family
PRIVATE  = me
```

⚠️ `private` does **NOT** mean secret on a public blockchain.

---

# 👑 5. OWNERSHIP — THE CORE PATTERN

```solidity
address public owner;

constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}
```

Usage:

```solidity
function withdraw() external onlyOwner {
    payable(owner).transfer(address(this).balance);
}
```

### Better production pattern

Use OpenZeppelin:

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyContract is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}

    function adminAction() external onlyOwner {
        // ...
    }
}
```

---

# 🧱 6. MAPPING — MOST IMPORTANT STORAGE TOOL

```solidity
mapping(address => uint256) public balances;
```

Read:

```solidity
uint256 balance = balances[msg.sender];
```

Write:

```solidity
balances[msg.sender] += 100;
```

### Mapping patterns

```solidity
mapping(address => bool) public approved;
mapping(address => uint256) public balances;
mapping(uint256 => address) public owners;
mapping(address => mapping(address => uint256)) public allowance;
```

### Critical limitation

Mappings do NOT give you their keys.

Wrong mental model:

```text
mapping = database table you can iterate ❌
```

Correct:

```text
mapping = key → value lookup table ✅
```

---

# 🧍 7. STRUCTS — GROUP RELATED DATA

```solidity
struct User {
    string name;
    uint256 age;
    bool active;
    address wallet;
}
```

Create:

```solidity
users[msg.sender] = User({
    name: "Maithali",
    age: 25,
    active: true,
    wallet: msg.sender
});
```

Array of structs:

```solidity
User[] public users;
```

Mapping of structs:

```solidity
mapping(address => User) public users;
```

---

# 📦 8. ARRAYS

### Dynamic

```solidity
uint256[] public numbers;
```

### Fixed

```solidity
uint256[5] public numbers;
```

### Add

```solidity
numbers.push(10);
```

### Length

```solidity
numbers.length
```

### Remove last

```solidity
numbers.pop();
```

### Loop

```solidity
for (uint256 i = 0; i < numbers.length; i++) {
    // ...
}
```

⚠️ Large unbounded loops can become unusable because block gas is limited.

---

# 🔧 9. FUNCTIONS — THE 4 QUESTIONS

Whenever you write a function, ask:

```text
1. Who can call it?
2. Does it change state?
3. Does it receive ETH?
4. What should it return?
```

### Read only

```solidity
function getValue() external view returns (uint256) {
    return value;
}
```

### Pure

```solidity
function add(uint256 a, uint256 b) external pure returns (uint256) {
    return a + b;
}
```

### Write

```solidity
function setValue(uint256 _value) external {
    value = _value;
}
```

### Receive ETH

```solidity
function deposit() external payable {
    // msg.value = ETH sent
}
```

---

# 🔍 10. `view` vs `pure` vs normal

```text
view  → can read state, cannot modify state
pure  → cannot read or modify state
normal → can modify state
```

Example:

```solidity
uint256 public x;

function read() external view returns (uint256) {
    return x;
}

function math(uint256 a) external pure returns (uint256) {
    return a * 2;
}

function write(uint256 _x) external {
    x = _x;
}
```

---

# 💰 11. ETH / `payable` MASTER PATTERN

### Deposit

```solidity
function deposit() external payable {}
```

### Amount received

```solidity
msg.value
```

### Current contract balance

```solidity
address(this).balance
```

### Sender

```solidity
msg.sender
```

### Withdraw

Preferred low-level pattern:

```solidity
(bool success, ) = payable(msg.sender).call{value: amount}("");
require(success, "ETH transfer failed");
```

### Receive function

```solidity
receive() external payable {
    // called when ETH is sent with empty calldata
}
```

### Fallback

```solidity
fallback() external payable {
    // called when no function matches calldata
}
```

---

# 🚨 12. `require`, `revert`, `assert`

### `require`

User/input/permission validation:

```solidity
require(amount > 0, "Amount must be > 0");
```

### `revert`

Manual failure:

```solidity
if (amount == 0) {
    revert("Zero amount");
}
```

### Custom errors — preferred for many production cases

```solidity
error InsufficientBalance(uint256 available, uint256 required);

if (balance < amount) {
    revert InsufficientBalance(balance, amount);
}
```

### `assert`

Internal invariants / conditions that should never fail:

```solidity
assert(totalSupply >= burnedAmount);
```

### Interview shortcut

```text
require → user/input validation
custom error → gas-efficient validation
assert → impossible/internal invariant
```

---

# 📢 13. EVENTS

Define:

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount);
```

Emit:

```solidity
emit Transfer(msg.sender, recipient, amount);
```

### `indexed`

```solidity
event Deposit(address indexed user, uint256 amount);
```

`indexed` makes values easier for off-chain filtering/log queries.

### Mental model

```text
State     → source of truth
Event     → activity log for outside systems
```

Events are NOT a replacement for contract storage.

---

# 🧮 14. MATH / UNITS

### ETH units

```solidity
1 ether
1 gwei
1 wei
```

Relationship:

```text
1 ether = 10^18 wei
1 gwei  = 10^9 wei
```

Example:

```solidity
uint256 amount = 1 ether;
```

### Integer division

```solidity
5 / 2 == 2
```

No floating-point numbers.

---

# 🧪 15. ADDRESS CHEAT CODES

```solidity
msg.sender
msg.value
address(this)
address(0)
```

### Convert to payable

```solidity
address payable receiver = payable(user);
```

### Detect contract

```solidity
uint256 size;
assembly {
    size := extcodesize(account)
}
```

⚠️ Don't treat `extcodesize == 0` as a universal EOA detector; constructors and account-abstraction patterns complicate that assumption.

---

# 🎯 16. `msg.sender` vs `tx.origin`

```text
msg.sender → immediate caller ✅
tx.origin  → original EOA initiating transaction ⚠️
```

Security rule:

```text
Use msg.sender for access control.
Avoid tx.origin for authorization.
```

---

# 🔁 17. LOOPS

```solidity
for (uint256 i = 0; i < 10; i++) {
    // code
}
```

```solidity
while (condition) {
    // code
}
```

### Gas warning

Never casually do:

```solidity
for (uint256 i = 0; i < users.length; i++) {
    // expensive operation
}
```

if `users.length` can grow without bound.

### Better design

```text
small bounded loop → okay
user-controlled unbounded loop → danger
```

---

# 🧬 18. ENUMS

```solidity
enum Status {
    Pending,
    Approved,
    Rejected
}

Status public status;
```

Set:

```solidity
status = Status.Approved;
```

---

# 🪄 19. MODIFIERS

Basic:

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}
```

Usage:

```solidity
function update(uint256 x) external onlyOwner {
    value = x;
}
```

Multiple modifiers:

```solidity
function withdraw(uint256 amount)
    external
    onlyOwner
    nonReentrant
{
    // ...
}
```

---

# 🛡️ 20. REENTRANCY — THE CLASSIC SECURITY BUG

### Dangerous pattern

```solidity
(bool success, ) = msg.sender.call{value: amount}("");
require(success);
balances[msg.sender] = 0;
```

The external call happens before state is updated.

### Checks-Effects-Interactions

```solidity
require(balances[msg.sender] >= amount);

balances[msg.sender] -= amount;

(bool success, ) = msg.sender.call{value: amount}("");
require(success);
```

Order:

```text
CHECKS
  ↓
EFFECTS
  ↓
INTERACTION
```

### OpenZeppelin guard

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vault is ReentrancyGuard {
    function withdraw() external nonReentrant {
        // ...
    }
}
```

---

# 🪙 21. ERC-20 — THE CORE PATTERN

Using OpenZeppelin:

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1_000_000 ether);
    }
}
```

Important functions:

```text
balanceOf(address)
transfer(address,uint256)
approve(address,uint256)
allowance(address,address)
transferFrom(address,address,uint256)
```

### ERC-20 flow

```text
User
 │
 ├── approve(spender, amount)
 │
 ▼
Contract
 │
 └── transferFrom(user, receiver, amount)
```

### Key distinction

```text
approve → permission
transfer → own tokens
transferFrom → spend approved tokens
```

---

# 🖼️ 22. ERC-721 — NFT CHEAT CODE

Conceptually:

```text
tokenId → owner
```

Common functions:

```text
ownerOf(tokenId)
transferFrom(from, to, tokenId)
approve(to, tokenId)
setApprovalForAll(operator, approved)
```

Minting with OpenZeppelin commonly uses:

```solidity
_safeMint(to, tokenId);
```

---

# 🧱 23. ERC-1155 — MULTI-TOKEN IDEA

Best mental model:

```text
(tokenId, owner) → balance
```

Useful for:

```text
fungible items
non-fungible items
semi-fungible game assets
```

---

# 📚 24. INTERFACES

An interface tells Solidity what functions exist.

```solidity
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}
```

Use an external contract:

```solidity
IERC20 token = IERC20(tokenAddress);
uint256 balance = token.balanceOf(msg.sender);
```

### Mental model

```text
interface = phone number + function signatures
```

It does not contain the implementation.

---

# 🧩 25. INHERITANCE

```solidity
contract Child is Parent {
}
```

OpenZeppelin-heavy pattern:

```solidity
contract MyContract is ERC20, Ownable, ReentrancyGuard {
}
```

### Multiple inheritance

Always understand which parent provides:

```text
state
functions
modifiers
constructor arguments
```

---

# 🧠 26. OVERRIDE / VIRTUAL

Parent:

```solidity
function foo() public virtual returns (uint256) {
    return 1;
}
```

Child:

```solidity
function foo() public override returns (uint256) {
    return 2;
}
```

---

# 📍 27. CONSTANT / IMMUTABLE

### Constant

```solidity
uint256 public constant MAX_SUPPLY = 1_000_000;
```

### Immutable

```solidity
address public immutable owner;

constructor() {
    owner = msg.sender;
}
```

Mental model:

```text
constant  → fixed at compile time
immutable → assigned once during deployment
```

---

# 🧮 28. GAS — THINK LIKE THE EVM

### Expensive

```text
SSTORE / changing storage
creating contracts
large storage writes
large loops
some external calls
```

### Cheaper ideas

```text
memory
calldata
constants
immutables
custom errors
packed storage where appropriate
bounded loops
```

### Gas optimization rule #1

```text
Optimize architecture before micro-optimizing syntax.
```

Don't save 5 gas while creating a 100,000-iteration loop.

---

# 🗂️ 29. STORAGE PACKING

This can matter for gas and layout.

Example:

```solidity
uint128 a;
uint128 b;
uint256 c;
```

The first two may share a storage slot because together they fit into 256 bits.

But:

```solidity
uint128 a;
uint256 b;
uint128 c;
```

is less layout-friendly.

### Think

```text
1 storage slot ≈ 32 bytes = 256 bits
```

Do not reorder variables blindly in upgradeable contracts—storage layout becomes a compatibility concern.

---

# 🔬 30. STORAGE SLOT INTUITION

EVM storage behaves conceptually like:

```text
slot 0 → 32 bytes
slot 1 → 32 bytes
slot 2 → 32 bytes
...
```

Mappings/arrays use hashing-based locations.

For:

```solidity
mapping(address => uint256) balances;
```

conceptually:

```text
storage location = keccak256(key . mappingSlot)
```

Useful when debugging advanced EVM/storage behavior.

---

# 🧮 31. KECCAK / HASHING

```solidity
bytes32 hash = keccak256(abi.encodePacked("hello"));
```

Use `abi.encode` when you want safer typed encoding semantics across multiple values.

```solidity
bytes32 hash = keccak256(abi.encode(user, amount));
```

### Common use cases

```text
IDs
commit-reveal schemes
signatures
allowlists
function selectors
```

---

# ✍️ 32. ABI ENCODING

### `abi.encode`

```solidity
bytes memory data = abi.encode(user, amount);
```

### `abi.encodePacked`

```solidity
bytes memory packed = abi.encodePacked(user, amount);
```

### Decode

```solidity
(user, amount) = abi.decode(data, (address, uint256));
```

⚠️ Be careful with `abi.encodePacked` + multiple dynamic types because concatenation can become ambiguous.

---

# 📨 33. LOW-LEVEL CALL

```solidity
(bool success, bytes memory data) = target.call(payload);
```

ETH transfer:

```solidity
(bool success, ) = payable(recipient).call{value: amount}("");
require(success, "Call failed");
```

General rule:

```text
Low-level call = powerful + dangerous
```

Prefer typed interfaces when possible.

---

# 🎯 34. FUNCTION SELECTOR

The first 4 bytes of calldata identify a function.

Conceptually:

```text
selector = first 4 bytes of keccak256(function signature)
```

Example signature:

```text
transfer(address,uint256)
```

Useful in:

```text
ABI debugging
proxies
fallback functions
EVM analysis
```

---

# 🔌 35. FALLBACK / DELEGATECALL / PROXY — ADVANCED TRIAD

### `call`

```text
code executes in target contract
storage belongs to target contract
```

### `delegatecall`

```text
code comes from target
storage/context belongs to caller
```

### `staticcall`

```text
read-only external call
```

### Proxy mental model

```text
User
 ↓
Proxy
 ↓ delegatecall
Implementation
```

This is the foundation of many upgradeable contract designs.

---

# 🧨 36. COMMON SECURITY BUGS

Memorize this list.

```text
1. Reentrancy
2. Access-control mistakes
3. tx.origin authorization
4. Unchecked external calls
5. Integer logic mistakes
6. Oracle manipulation
7. Flash-loan-assisted attacks
8. Signature replay
9. Missing nonce/deadline checks
10. Unbounded loops
11. Denial of service
12. Incorrect accounting
13. Front-running / MEV exposure
14. Unsafe delegatecall
15. Bad upgradeable storage layout
16. Initialization bugs
17. Price/decimal mismatches
18. Incorrect token assumptions
```

---

# 🧱 37. CHECKS-EFFECTS-INTERACTIONS

Use this as a default mental template:

```solidity
function withdraw(uint256 amount) external {
    // CHECKS
    require(amount > 0, "Zero amount");
    require(balances[msg.sender] >= amount, "Insufficient");

    // EFFECTS
    balances[msg.sender] -= amount;

    // INTERACTIONS
    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");
}
```

---

# 🪪 38. SIGNATURES / ECDSA — INTERVIEW CHEAT CODE

Core idea:

```text
message
   ↓
hash
   ↓
signature
   ↓
recover signer
   ↓
verify permission
```

OpenZeppelin often provides:

```solidity
ECDSA
MessageHashUtils
EIP712
```

Important anti-replay concepts:

```text
nonce
chainId
contract address
deadline
```

---

# ⏱️ 39. BLOCK / TIMESTAMP

```solidity
block.timestamp
block.number
block.chainid
```

Do not assume `block.timestamp` is a perfectly precise wall clock.

Good uses:

```text
deadlines
vesting boundaries
auction phases
```

Avoid treating it as a high-precision randomness source.

---

# 🎲 40. RANDOMNESS WARNING

Bad:

```solidity
uint256 random = uint256(
    keccak256(abi.encodePacked(block.timestamp, msg.sender))
);
```

For secure randomness in blockchain applications, use a proper randomness design such as a verifiable randomness oracle when appropriate.

---

# 🧪 41. MODERN ERROR PATTERN

Instead of:

```solidity
require(balance >= amount, "Insufficient balance");
```

Use:

```solidity
error InsufficientBalance(uint256 balance, uint256 amount);

if (balance < amount) {
    revert InsufficientBalance(balance, amount);
}
```

Pattern:

```solidity
error ErrorName(type arg1, type arg2);
```

---

# 🧰 42. OPENZEPPELIN — MEMORIZE THESE

Common imports:

```solidity
ERC20
ERC721
ERC1155
Ownable
AccessControl
ReentrancyGuard
Pausable
ECDSA
EIP712
SafeERC20
```

### Think of them as building blocks

```text
Ownable        → one admin
AccessControl  → roles
Pausable       → emergency stop
ReentrancyGuard→ anti-reentrancy
SafeERC20      → safer ERC-20 interaction
ECDSA          → signatures
EIP712         → typed signatures
```

---

# 🏷️ 43. ACCESSCONTROL ROLE PATTERN

```solidity
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
```

Typical usage:

```solidity
_grantRole(MINTER_ROLE, msg.sender);
```

Authorization:

```solidity
function mint(address to, uint256 amount)
    external
    onlyRole(MINTER_ROLE)
{
    _mint(to, amount);
}
```

### Mental model

```text
Owner model     → 1 powerful identity
Role model      → many specialized identities
```

---

# ⏸️ 44. PAUSABLE

Emergency-control pattern:

```solidity
whenNotPaused
whenPaused
_pause()
_unpause()
```

Typical design:

```text
Normal state
    ↓
exploit detected
    ↓
pause
    ↓
fix / migrate
    ↓
unpause
```

---

# 🪙 45. SAFE ERC-20 INTERACTION

Tokens do not all behave identically.

OpenZeppelin:

```solidity
using SafeERC20 for IERC20;
```

Then:

```solidity
token.safeTransfer(to, amount);
token.safeTransferFrom(from, to, amount);
```

---

# 🔄 46. TOKEN DECIMALS

Common ERC-20 convention:

```text
18 decimals
```

But DO NOT assume every token uses 18.

Example:

```solidity
uint256 amount = 2 * 10 ** 18;
```

This represents 2 tokens only if the token uses 18 decimals.

### Critical DApp rule

Always know:

```text
token decimals
price decimals
oracle decimals
UI decimals
```

---

# 🌐 47. ORACLES

Basic concept:

```text
Blockchain
   ↑
Oracle
   ↑
Real-world / external data
```

Typical issues:

```text
stale data
wrong decimals
bad heartbeat assumptions
single-source dependency
price manipulation
```

For Chainlink-style feeds, always understand the feed's decimals and freshness behavior before using the price.

---

# 🧠 48. MAPPINGS + ARRAYS TOGETHER

A very common pattern:

```solidity
mapping(address => bool) public exists;
address[] public users;
```

On first registration:

```solidity
if (!exists[msg.sender]) {
    exists[msg.sender] = true;
    users.push(msg.sender);
}
```

Why?

```text
mapping → fast lookup
array   → iterable list
```

This combo appears everywhere.

---

# 🧪 49. TESTING MENTAL MODEL

A good smart contract test suite checks:

```text
HAPPY PATH
EDGE CASES
REVERTS
ACCESS CONTROL
EVENTS
BALANCES
STATE CHANGES
REENTRANCY / SECURITY
```

### Basic test thought process

```text
Arrange
  ↓
Act
  ↓
Assert
```

Example:

```text
Arrange → deploy + fund
Act     → withdraw
Assert  → balance decreased + event emitted
```

---

# 🧰 50. HARDHAT COMMAND CHEAT SHEET

Typical commands:

```bash
npx hardhat compile
npx hardhat test
npx hardhat node
```

Deploying depends on your Hardhat version/configuration; use your project's configured deployment workflow.

Useful debugging workflow:

```text
compile
 ↓
test
 ↓
local node
 ↓
deploy
 ↓
verify
 ↓
frontend integration
```

---

# 🧪 51. FOUNDRY COMMAND CHEAT SHEET

Common commands:

```bash
forge build
forge test
forge test -vvv
anvil
```

Mental model:

```text
forge  → build/test
anvil  → local chain
cast   → interact with chain
```

---

# 🖥️ 52. REMIX EXECUTION FLOW

```text
1. Create .sol file
2. Paste contract
3. Compiler tab
4. Select matching compiler
5. Compile
6. Deploy & Run Transactions
7. Deploy
8. Read functions
9. Write functions
10. Inspect transaction / logs
```

### Tiny rule

```text
Blue button in Remix → read/view-style interaction
Orange/red button → state-changing transaction
```

Exact colors can vary with UI/theme/version, but the key distinction is **free local read simulation vs transaction that changes state**.

---

# 🧭 53. DEPLOYMENT CHECKLIST

Before mainnet:

```text
✅ compiler version pinned
✅ optimizer settings checked
✅ tests passing
✅ access control reviewed
✅ event coverage reviewed
✅ reentrancy reviewed
✅ external calls reviewed
✅ token decimals checked
✅ oracle assumptions checked
✅ upgradeability reviewed if applicable
✅ constructor/init path reviewed
✅ secrets/private keys NOT in source
✅ network/RPC checked
✅ contract verified where appropriate
```

---

# 🧯 54. DEBUGGING FLOW — DON'T PANIC

When a Solidity error appears:

```text
ERROR
 ↓
Read FIRST line carefully
 ↓
Identify category
 ↓
Check compiler version
 ↓
Check imports
 ↓
Check function visibility
 ↓
Check types
 ↓
Check constructor arguments
 ↓
Check network/config
 ↓
Compile again
```

### Common categories

```text
ParserError      → syntax
TypeError        → wrong type / conversion
DeclarationError → missing/duplicate declaration
Undeclared       → variable/function not found
ImportError      → dependency/path
Compiler version → pragma mismatch
Runtime revert   → require/custom error/assert
```

---

# 💥 55. COMMON BEGINNER MISTAKES

### Mistake 1

```solidity
function setValue(uint256 x) public view {
    value = x;
}
```

❌ `view` cannot modify state.

### Mistake 2

```solidity
owner == msg.sender
```

by itself does nothing.

Need:

```solidity
require(owner == msg.sender, "Not owner");
```

### Mistake 3

```solidity
return newMessage = message;
```

This assigns the wrong direction for a typical getter/update design.

Usually you want:

```solidity
message = newMessage;
```

or:

```solidity
return message;
```

### Mistake 4

Using `tx.origin` for ownership.

❌ Avoid.

### Mistake 5

Assuming `private` means invisible.

❌ Blockchain storage can be inspected.

---

# ⚡ 56. 10-SECOND SYNTAX MEMORY CARD

```solidity
uint256 public amount;
address public owner;
bool public active;
string public message;

mapping(address => uint256) public balances;

constructor() {
    owner = msg.sender;
}

modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    _;
}

event Deposited(address indexed user, uint256 amount);

function deposit() external payable {
    emit Deposited(msg.sender, msg.value);
}

function setAmount(uint256 _amount) external onlyOwner {
    amount = _amount;
}

function getAmount() external view returns (uint256) {
    return amount;
}
```

Memorize this block and many beginner contracts become variations of it.

---

# 🧠 57. CONTRACT DESIGN RECIPE BOOK

## A. Digital Wallet

```text
owner
 ↓
deposit()
 ↓
balance
 ↓
withdraw()
 ↓
onlyOwner / user checks
 ↓
event
```

## B. Voting

```text
candidate list
 ↓
voter mapping
 ↓
vote()
 ↓
prevent double voting
 ↓
count votes
```

## C. Crowdfunding

```text
campaign struct
 ↓
donations mapping
 ↓
donate()
 ↓
goal/deadline
 ↓
withdraw/refund
```

## D. Staking

```text
stake token
 ↓
record amount + time
 ↓
calculate reward
 ↓
claim
 ↓
unstake
```

## E. NFT Marketplace

```text
NFT approval
 ↓
list
 ↓
buy
 ↓
transfer NFT
 ↓
pay seller
 ↓
marketplace fee
```

---

# 🧩 58. SMART CONTRACT BUILD ORDER

When starting from a blank file:

```text
STEP 1  → define state
STEP 2  → define events
STEP 3  → define errors
STEP 4  → constructor / initialization
STEP 5  → modifiers / access control
STEP 6  → core write functions
STEP 7  → read functions
STEP 8  → ETH/token flows
STEP 9  → edge-case validation
STEP 10 → tests
STEP 11 → security review
STEP 12 → deploy
```

---

# 🧠 59. THE 5-LAYER REVIEW METHOD

Before considering a contract “done”, review it in this order:

### Layer 1 — State

```text
What can change?
Who owns it?
Can values overflow/underflow or become inconsistent?
```

### Layer 2 — Permissions

```text
Who can call each function?
Can an attacker become privileged?
```

### Layer 3 — Money

```text
Where does ETH/token enter?
Where does it leave?
Can accounting become negative/inconsistent?
```

### Layer 4 — External Calls

```text
Can another contract execute code here?
Can it reenter?
Can it return unexpected data?
```

### Layer 5 — Failure

```text
What happens when everything goes wrong?
Can the contract recover?
Can funds become stuck?
```

---

# 🚨 60. INTERVIEW RAPID-FIRE

### Q: What is `msg.sender`?

```text
The immediate caller of the current function.
```

### Q: What is `msg.value`?

```text
ETH amount sent with the call.
```

### Q: `memory` vs `storage`?

```text
memory = temporary
storage = persistent blockchain state
```

### Q: `view` vs `pure`?

```text
view = reads state
pure = reads neither state nor environment state
```

### Q: What is a modifier?

```text
Reusable pre/post function logic.
```

### Q: What is an event?

```text
A log emitted for off-chain consumers.
```

### Q: What is a mapping?

```text
A key → value lookup structure.
```

### Q: Why use `onlyOwner`?

```text
Access control.
```

### Q: What is reentrancy?

```text
A contract is called externally before its state is safely updated, enabling recursive re-entry.
```

### Q: Best defense?

```text
Checks-Effects-Interactions + appropriate reentrancy protection.
```

---

# 🧠 61. “IF YOU ONLY MEMORIZE 20 THINGS”

```text
1. msg.sender
2. msg.value
3. address(this).balance
4. payable
5. require
6. custom errors
7. mapping
8. struct
9. array
10. modifier
11. event + emit
12. view
13. pure
14. storage / memory / calldata
15. constructor
16. receive / fallback
17. onlyOwner / AccessControl
18. Checks-Effects-Interactions
19. ERC-20 approve/transfer/transferFrom
20. test before deploy
```

---

# 🚀 62. “BUILD THIS IN YOUR HEAD” TEMPLATE

When you see a new blockchain project requirement, translate English → Solidity.

Example:

> “Only the owner can withdraw money.”

Translate:

```text
owner
 ↓
onlyOwner modifier
 ↓
withdraw()
 ↓
payable
 ↓
Checks-Effects-Interactions
 ↓
transfer/call
```

Example:

> “A user can donate and later see how much they donated.”

Translate:

```text
mapping(address => uint256)
 ↓
donate() payable
 ↓
balances[msg.sender] += msg.value
 ↓
event
 ↓
balanceOf()
```

This is the real “cheat code”: **convert requirements into primitives**.

---

# 🧪 63. MINI PROJECT PATTERNS

## Hello Blockchain

```solidity
string public message;

constructor(string memory _message) {
    message = _message;
}

function updateMessage(string calldata _message) external {
    message = _message;
}
```

## Owner-only Update

```solidity
function updateMessage(string calldata _message) external onlyOwner {
    message = _message;
}
```

## Counter

```solidity
uint256 public count;

function increment() external {
    count++;
}

function decrement() external {
    require(count > 0, "Cannot go below zero");
    count--;
}
```

## Deposit Ledger

```solidity
mapping(address => uint256) public deposits;

function deposit() external payable {
    deposits[msg.sender] += msg.value;
}
```

---

# 🛠️ 64. FROM IDEA → DAPP

```text
IDEA
 ↓
Requirements
 ↓
State variables
 ↓
Functions
 ↓
Events
 ↓
Security rules
 ↓
Solidity contract
 ↓
Tests
 ↓
Deploy
 ↓
ABI + address
 ↓
Ethers.js / viem
 ↓
React UI
 ↓
Wallet (MetaMask / other)
```

### Frontend bridge

Your frontend normally needs:

```text
CONTRACT ADDRESS
ABI
RPC / wallet provider
NETWORK
```

---

# 🔗 65. ETHER.JS MENTAL MODEL

```text
Provider → read blockchain
Signer   → act as wallet / send transactions
Contract → interact with smart contract
```

Conceptual pattern:

```js
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const contract = new ethers.Contract(address, abi, signer);
```

Read:

```js
const value = await contract.value();
```

Write:

```js
const tx = await contract.setValue(100);
await tx.wait();
```

---

# 🧭 66. SMART CONTRACT DATA FLOW

```text
USER
 ↓
Wallet
 ↓
Frontend
 ↓
RPC provider
 ↓
Ethereum node
 ↓
EVM
 ↓
Smart Contract
 ↓
State / Event Log
 ↓
Frontend reads result
```

---

# 🧠 67. “CODE SMELL” DETECTOR

When you see this, stop and investigate:

```text
⚠️ tx.origin
⚠️ unbounded loops
⚠️ arbitrary delegatecall
⚠️ external call before state update
⚠️ missing access control
⚠️ ignored return value
⚠️ unsafe ERC-20 assumptions
⚠️ unchecked token decimals
⚠️ unvalidated oracle data
⚠️ upgradeable contract without initializer discipline
⚠️ admin can drain every asset without safeguards
```

---

# 🧮 68. TYPE CONVERSION CHEAT SHEET

```solidity
uint160(x)
uint256(x)
address(uint160Value)
payable(addressValue)
bytes32(x)
```

Be explicit and deliberate with narrowing conversions.

Example:

```solidity
uint256 big = 1000;
uint128 small = uint128(big);
```

⚠️ Narrowing can lose information.

---

# 🧰 69. CASTING / DEBUGGING VALUES

Useful concepts when using command-line tools such as Foundry `cast`:

```text
hex → bytes
uint256 → decimal
address → checksummed address
function signature → selector
```

The exact command syntax depends on the installed tool/version, so use your tool's built-in help when needed:

```bash
cast --help
```

---

# 🧠 70. PRODUCTION MINDSET

A beginner asks:

```text
“Does it compile?”
```

A smart contract developer asks:

```text
“Can anyone break the accounting?”
“Who can call this?”
“What happens on failure?”
“Can this reenter?”
“Can this become permanently stuck?”
“Can an oracle/token behave unexpectedly?”
“What assumptions does the frontend make?”
```

---

# 🏆 71. THE 10X RULES

## Rule 1

**Write the invariant first.**

Example:

```text
User balance can never exceed the amount actually deposited.
```

## Rule 2

**Every state-changing function needs a security question.**

```text
Who can call it?
What can they change?
What external code can run?
```

## Rule 3

**Every money flow needs an accounting equation.**

```text
contract assets
≈
recorded liabilities / balances + protocol-owned assets
```

## Rule 4

**Prefer known libraries over rewriting security primitives.**

## Rule 5

**Tests are part of the contract design, not decoration.**

## Rule 6

**Events are your frontend's breadcrumbs.**

## Rule 7

**Gas problems are often architecture problems.**

## Rule 8

**Never assume external contracts behave nicely.**

## Rule 9

**Never assume “private” means secret.**

## Rule 10

**A compiled contract is not automatically a secure contract.**

---

# 📌 72. MASTER ONE-PAGE MEMORY MAP

```text
                         SOLIDITY
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
      STATE               LOGIC              MONEY
        │                   │                   │
 mapping / struct        require            payable
 arrays                  modifiers           msg.value
 uint / address          if / loops          call
        │                   │                   │
        └──────────────┬────┴────┬──────────────┘
                       │         │
                    EVENTS    SECURITY
                       │         │
                      emit   CEI / roles
                               reentrancy
                               oracle safety
                               external calls

                    ↓↓↓ THE DAPP LAYER ↓↓↓

                ABI + ADDRESS + RPC + WALLET
                              │
                           Ethers/viem
                              │
                           React/UI
```

---

# 🧠 73. FINAL CHEAT CODE

When you are stuck writing Solidity, do NOT stare at the empty editor.

Write these five lines on paper first:

```text
STATE:
Who/what must be stored?

ACCESS:
Who is allowed to change it?

LOGIC:
What exact state transition should happen?

MONEY:
Where does ETH/token enter or leave?

EVENT:
What should the frontend/indexer know happened?
```

Then convert each answer into Solidity.

### Example

```text
Requirement:
“Users deposit ETH and only users can withdraw their own balance.”
```

Translate:

```solidity
mapping(address => uint256) public balances;

function deposit() external payable {
    balances[msg.sender] += msg.value;
}

function withdraw(uint256 amount) external {
    require(balances[msg.sender] >= amount, "Insufficient balance");

    balances[msg.sender] -= amount;

    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");
}
```

That translation skill is more valuable than memorizing 500 syntax rules.

---

# 🎯 74. DAILY SOLIDITY PRACTICE LOOP

Use this loop when learning:

```text
LEARN 1 concept
   ↓
WRITE 1 tiny contract
   ↓
BREAK IT intentionally
   ↓
READ compiler/runtime error
   ↓
FIX IT
   ↓
WRITE 1 TEST
   ↓
EXPLAIN IT OUT LOUD
   ↓
COMMIT TO GIT
```

### 30-minute micro-session

```text
10 min → learn
10 min → code
5 min  → test/debug
5 min  → write notes
```

---

# 🧠 75. INTERVIEW ANSWER FORMULA

When asked a Solidity question, answer in this order:

```text
1. Definition
2. Why it exists
3. Tiny code example
4. Real-world use
5. Security/gas caveat
```

Example: “What is reentrancy?”

```text
Definition → recursive external re-entry
Why       → external calls can execute attacker code
Example   → withdraw() using call before state update
Use       → security review
Defense   → CEI + ReentrancyGuard when appropriate
```

This structure makes answers sound practical rather than memorized.

---

# 🏁 LAST PAGE: THE SOLIDITY DEVELOPER'S COMMANDMENTS

```text
1. Validate inputs.
2. Control permissions.
3. Update state before external interaction when appropriate.
4. Treat external contracts as untrusted.
5. Never use tx.origin for authorization.
6. Don't make unbounded loops part of critical paths.
7. Use custom errors where they improve efficiency/clarity.
8. Emit events for important state transitions.
9. Test failure paths, not only success paths.
10. Use audited libraries for common primitives.
11. Understand token decimals.
12. Understand oracle assumptions.
13. Keep secrets out of source/config committed to Git.
14. Verify deployment configuration.
15. Read the generated ABI before frontend integration.
16. Review upgradeability and storage layout when applicable.
17. Security > cleverness.
18. Simple code > mysterious code.
19. Architecture > micro-optimization.
20. “It compiles” is the beginning, not the finish line.
```

---

# ⭐ Ultra-Compact Pocket Version

```text
SOLIDITY = STATE + ACCESS + LOGIC + MONEY + EVENTS

msg.sender       → caller
msg.value        → ETH sent
address(this)    → current contract

storage          → permanent
memory           → temporary
calldata         → external read-only input

view             → reads state
pure             → reads/changes no state
payable          → can receive ETH

mapping          → key → value
struct           → grouped data
array            → ordered list
modifier         → reusable access/check logic
event + emit     → off-chain activity log

require          → validate
custom error     → efficient failure
assert           → invariant

Checks
Effects
Interactions

Ownable          → owner-based access
AccessControl    → role-based access
Pausable         → emergency stop
ReentrancyGuard  → reentrancy protection
SafeERC20        → safer token interaction

ERC20            → tokens
ERC721           → NFTs
ERC1155          → multi-token standard

TEST → REVIEW → DEPLOY → VERIFY → INTEGRATE
```

---

> **Keep this file beside your Solidity editor.** The goal is not to memorize everything. The goal is to look up the pattern, understand it, and then write it yourself.
