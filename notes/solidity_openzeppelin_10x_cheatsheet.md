# 🔐 Solidity + OpenZeppelin 10X Cheat Sheet

> **Build rule:** `Requirement → Solidity primitive → OpenZeppelin module → Security rule → Test → Deploy`
>
> This guide targets OpenZeppelin Contracts 5.x concepts. Always match examples to the exact package version installed in your project. OpenZeppelin provides reusable implementations for ERC-20, ERC-721, ERC-1155, access control, governance, cryptography, utilities and upgradeable systems.

## 1. The Mental Model

```text
                    DAPP
                     │
        ┌────────────┴────────────┐
        │                         │
   Business Logic             Security
        │                         │
        └────────────┬────────────┘
                     ▼
              Solidity + OZ
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
        Token      Access     Safety
```

For every function ask:

```text
WHO can call it?
WHAT can they change?
HOW MUCH can they change?
WHAT if the input is invalid?
WHAT if an external contract is malicious?
WHAT event proves it happened?
CAN an admin abuse it?
CAN the contract be upgraded?
```

---

# 2. Install

```bash
npm install @openzeppelin/contracts
```

Upgradeable:

```bash
npm install @openzeppelin/contracts-upgradeable @openzeppelin/contracts
```

Import installed code instead of copying OpenZeppelin source:

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

OpenZeppelin recommends using the installed library as-is and documents audited releases through npm tags.

---

# 3. Solidity Skeleton

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MyContract {
    // state
    // events
    // errors
    // modifiers
    // constructor
    // external/public functions
    // internal/private functions
    // view/pure functions
}
```

## Types

```solidity
uint256
int256
bool
address
address payable
string
bytes
bytes32

uint256[]
mapping(address => uint256)

struct User {
    address wallet;
    uint256 balance;
}

enum Status { Pending, Active, Closed }
```

## Visibility

```solidity
public      // inside + outside
external    // outside-facing
internal    // contract + children
private     // current contract only
```

## Read vs pure

```solidity
function get() external view returns (uint256) { return value; }

function add(uint256 a, uint256 b)
    external pure returns (uint256)
{
    return a + b;
}
```

## ETH

```solidity
msg.sender              // caller
msg.value               // ETH sent
address(this).balance   // contract ETH balance
block.timestamp         // block time
```

## Events

```solidity
event Deposited(address indexed user, uint256 amount);

emit Deposited(msg.sender, msg.value);
```

## Custom errors

```solidity
error InsufficientBalance(uint256 available, uint256 requested);

if (balance < amount) {
    revert InsufficientBalance(balance, amount);
}
```

---

# 4. OpenZeppelin Decision Engine

| Requirement                       | Use                                                 |
| --------------------------------- | --------------------------------------------------- |
| One administrator                 | `Ownable`                                           |
| Safer ownership handoff           | `Ownable2Step`                                      |
| Multiple roles                    | `AccessControl`                                     |
| Permissions across many contracts | `AccessManager`                                     |
| Emergency stop                    | `Pausable`                                          |
| Reentrancy defense                | `ReentrancyGuard`                                   |
| Fungible token                    | `ERC20`                                             |
| NFT                               | `ERC721`                                            |
| Many token IDs                    | `ERC1155`                                           |
| Voting/governance                 | `Governor` ecosystem                                |
| Voting token                      | `ERC20Votes`                                        |
| Delayed execution                 | `TimelockController` / governance timelock patterns |
| Upgradeable contract              | `@openzeppelin/contracts-upgradeable`               |
| Signature authorization           | cryptography utilities                              |

**Important:** inheriting a module does not automatically apply its behavior to your business functions. You must wire the feature into the relevant operations.

---

# 5. Ownable

Use when there is one primary administrator.

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}

    function adminAction() external onlyOwner {
        // ...
    }
}
```

Mental model:

```text
owner → onlyOwner → protected function
```

---

# 6. Ownable2Step

Safer ownership transfer:

```text
old owner
   │
   ▼
transferOwnership(newOwner)
   │
   ▼
pending owner
   │
   ▼
acceptOwnership()
   │
   ▼
new owner
```

Use it when accidentally transferring ownership to the wrong address would be costly.

---

# 7. AccessControl

Use when responsibilities differ.

```solidity
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract Token is AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function mint(address to, uint256 amount)
        external onlyRole(MINTER_ROLE)
    {
        // ...
    }
}
```

Typical roles:

```text
DEFAULT_ADMIN_ROLE → manages roles
MINTER_ROLE        → mint
PAUSER_ROLE        → pause
TREASURER_ROLE     → treasury operations
UPGRADER_ROLE      → upgrades
```

### Default admin warning

`DEFAULT_ADMIN_ROLE` is powerful and is its own admin by default. Treat it as a master key. OpenZeppelin provides `AccessControlDefaultAdminRules` for additional protections such as single-admin and delayed two-step transfer.

---

# 8. AccessManager

For multi-contract systems:

```text
                AccessManager
               /      |       \
              ▼       ▼        ▼
           Token   Staking   Treasury
```

Use when permissions become a system-level problem rather than a single-contract problem.

---

# 9. ERC-20

Fungible token:

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply)
        ERC20("MyToken", "MTK")
    {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
}
```

Know these:

```text
totalSupply()
balanceOf()
transfer()
approve()
allowance()
transferFrom()
```

### ERC20 architecture

```text
ERC20
 ├─ balance accounting
 ├─ transfer
 ├─ allowance
 └─ supply
       │
       └─ YOUR POLICY
           ├─ who can mint?
           ├─ cap?
           ├─ pause?
           ├─ burn?
           └─ voting?
```

---

# 10. ERC20 + AccessControl

```solidity
contract MyToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address admin) ERC20("MyToken", "MTK") {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function mint(address to, uint256 amount)
        external onlyRole(MINTER_ROLE)
    {
        _mint(to, amount);
    }
}
```

Before shipping, answer:

```text
Can minters mint forever?
Is there a maximum supply?
Who grants MINTER_ROLE?
Who revokes it?
Can admin mint?
What happens if admin key is compromised?
```

---

# 11. ERC20 Extensions: Decision Map

```text
Need maximum supply?
→ ERC20Capped

Need signatures for approvals?
→ ERC20Permit

Need voting power?
→ ERC20Votes

Need pausing?
→ ERC20Pausable / Pausable integration

Need burning?
→ ERC20Burnable
```

Use only the extensions your design actually requires.

---

# 12. ERC-721

Unique assets / NFTs:

```solidity
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    uint256 private nextTokenId;

    constructor() ERC721("MyNFT", "MNFT") {}

    function mint(address to) external returns (uint256) {
        uint256 id = nextTokenId++;
        _mint(to, id);
        return id;
    }
}
```

Core mental model:

```text
tokenId → owner
```

Know:

```text
ownerOf()
balanceOf()
transferFrom()
safeTransferFrom()
approve()
getApproved()
setApprovalForAll()
```

---

# 13. ERC721 Metadata

If each NFT has its own metadata:

```solidity
import {ERC721URIStorage} from
    "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
```

Concept:

```text
Token #1 → ipfs://CID/1.json
Token #2 → ipfs://CID/2.json
```

---

# 14. ERC-1155

Use one contract for many token IDs:

```text
ERC20  → fungible
ERC721 → unique
ERC1155 → multi-token
```

Great for:

```text
Game currency
Weapons
Skins
Tickets
Collectibles
Bundles
```

---

# 15. Token Standard Decision Tree

```text
Are units interchangeable?
        │
       YES ──→ ERC20
        │
       NO
        │
Are individual items unique?
        │
       YES ──→ ERC721
        │
Need many asset types in one contract?
        │
       YES ──→ ERC1155
```

---

# 16. Pausable

Emergency brake:

```solidity
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
```

Concept:

```text
NORMAL
  ↓
incident
  ↓
PAUSE
  ↓
investigate/fix
  ↓
UNPAUSE
```

Typical pattern:

```solidity
function sensitiveAction()
    external
    whenNotPaused
{
    // ...
}
```

Then protect pause/unpause with appropriate access control.

---

# 17. ReentrancyGuard

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

function withdraw(uint256 amount)
    external nonReentrant
{
    // ...
}
```

Mental model:

```text
CALL
 ↓
LOCK
 ↓
execute
 ↓
UNLOCK
```

But do not treat `nonReentrant` as a replacement for sound state ordering and external-call analysis.

---

# 18. Checks → Effects → Interactions

Prefer:

```text
1. CHECK
2. UPDATE STATE
3. EXTERNAL CALL
```

Example:

```solidity
if (balances[msg.sender] < amount) revert InsufficientBalance();

balances[msg.sender] -= amount;

(bool ok, ) = payable(msg.sender).call{value: amount}("");
if (!ok) revert TransferFailed();
```

The key idea is to make the state reflect the withdrawal before control is handed to external code.

---

# 19. ETH Payment Security Stack

For a vault/payment contract, consider:

```text
Access control
+
Checks-effects-interactions
+
Reentrancy analysis
+
Pausable when appropriate
+
Custom errors
+
Events
+
Tests
```

Never assume one OpenZeppelin module makes the whole payment system safe.

---

# 20. Upgradeable Contracts

Normal:

```text
User → Contract
```

Proxy architecture:

```text
User → Proxy → Implementation V1
                 │
                 ▼
              V2 later
```

The proxy address can remain stable while its implementation changes.

Upgradeable package:

```bash
npm install @openzeppelin/contracts-upgradeable @openzeppelin/contracts
```

---

# 21. Upgradeable vs Normal

Normal:

```solidity
constructor() {
    owner = msg.sender;
}
```

Upgradeable:

```solidity
function initialize(address initialOwner)
    public initializer
{
    // initialize state
}
```

Parent initializers must also be handled correctly.

---

# 22. Upgradeable Imports

Normal:

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

Upgradeable:

```solidity
import {ERC20Upgradeable} from
    "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
```

Typical pattern:

```solidity
contract MyToken is ERC20Upgradeable, OwnableUpgradeable {
    function initialize(address initialOwner)
        public initializer
    {
        __ERC20_init("MyToken", "MTK");
        __Ownable_init(initialOwner);
    }
}
```

---

# 23. Storage Layout = Upgradeability Survival Rule

Do not casually reorder, remove, or reinterpret storage variables in an upgradeable contract.

```text
V1
slot 0 → owner
slot 1 → balances
slot 2 → paused

V2
slot 0 → owner
slot 1 → balances
slot 2 → paused
slot 3 → new variable   ✅
```

Danger:

```text
V2 changes slot meaning
→ old state interpreted incorrectly
→ possible state corruption
```

OpenZeppelin warns that major versions should be considered incompatible for upgradeable storage layouts and recommends upgrade tooling for storage-layout safety.

---

# 24. Governance Architecture

DAO mental model:

```text
Governance Token
      ↓
Voting Power
      ↓
Proposal
      ↓
Vote
      ↓
Timelock
      ↓
Execute
```

Typical stack:

```text
ERC20Votes
   +
Governor
   +
Timelock
```

Use a timelock when users need time to see and react to approved administrative actions.

---

# 25. Signatures / EIP-712

Mental model:

```text
Domain
  +
Type
  +
Data
  +
Nonce
  ↓
Signature
  ↓
Contract verifies
```

Useful concepts:

```text
ECDSA
EIP-712
Nonces
SignatureChecker / signature utilities
```

Never invent a signature protocol when a well-tested OpenZeppelin primitive covers the requirement.

---

# 26. Libraries vs Contracts

OpenZeppelin components are not all used the same way.

Contracts:

```solidity
contract MyToken is ERC20 {}
```

Libraries:

```solidity
using SomeLibrary for SomeType;
```

Rule:

```text
Contract → inheritance
Library → using for / library calls
```

---

# 27. Multiple Inheritance

Sometimes multiple parents expose the same function.

You may need:

```solidity
function supportsInterface(bytes4 id)
    public
    view
    override(ERC721, AccessControl)
    returns (bool)
{
    return super.supportsInterface(id);
}
```

Mental model:

```text
Parent A ─┐
          ├→ same function
Parent B ─┘
          ↓
       explicit override
          ↓
         super
```

---

# 28. `super` Cheat Code

```solidity
super.someFunction()
```

Think:

> Continue through the inherited implementation chain.

This is especially important when composing OpenZeppelin extensions.

---

# 29. The Requirement → Module Method

Requirement:

> Only one admin can configure fees.

```text
Ownable
+
onlyOwner
```

Requirement:

> Several accounts can mint.

```text
ERC20
+
AccessControl
+
MINTER_ROLE
```

Requirement:

> Emergency stop.

```text
Pausable
+
admin/pauser permission
+
whenNotPaused
```

Requirement:

> Withdrawals must resist reentrancy.

```text
ReentrancyGuard
+
checks-effects-interactions
```

Requirement:

> Contract code must be upgradeable.

```text
contracts-upgradeable
+
initializer
+
secure upgrade authorization
+
storage discipline
```

---

# 30. Access Matrix Before Code

Create this first:

| Function | User | Minter | Pauser | Admin | Upgrader |
| -------- | ---: | -----: | -----: | ----: | -------: |
| deposit  |   ✅ |     ✅ |     ❌ |    ✅ |       ❌ |
| withdraw |   ✅ |     ✅ |     ❌ |    ✅ |       ❌ |
| mint     |   ❌ |     ✅ |     ❌ |    ✅ |       ❌ |
| pause    |   ❌ |     ❌ |     ✅ |    ✅ |       ❌ |
| upgrade  |   ❌ |     ❌ |     ❌ |    ❌ |       ✅ |

Then translate it into roles/modifiers.

---

# 31. Security Checklist

```text
[ ] Access control
[ ] Least privilege
[ ] Input validation
[ ] Zero-address checks
[ ] Reentrancy analysis
[ ] External-call analysis
[ ] Pause/emergency plan
[ ] Upgrade authorization
[ ] Storage-layout review if upgradeable
[ ] Signature replay protection
[ ] Economic attack analysis
[ ] Events
[ ] Custom errors
[ ] Unit tests
[ ] Negative/attacker tests
[ ] Integration tests
```

---

# 32. Attacker's Test Questions

For every important function:

```text
Can a random address call it?
Can it be called twice?
What if amount == 0?
What if amount is enormous?
What if address == address(0)?
What if an external contract re-enters?
What if token transfer fails?
What if the admin key is compromised?
Can a role grant itself a stronger role?
Can an upgrade change the meaning of old storage?
Can a signature be replayed?
```

---

# 33. ERC20 Test Matrix

```text
[ ] name
[ ] symbol
[ ] decimals
[ ] initial supply
[ ] balanceOf
[ ] transfer
[ ] insufficient balance
[ ] approve
[ ] allowance
[ ] transferFrom
[ ] mint authorization
[ ] burn
[ ] cap if used
[ ] pause if used
[ ] events
```

# 34. ERC721 Test Matrix

```text
[ ] mint
[ ] ownerOf
[ ] balanceOf
[ ] transfer
[ ] safeTransfer
[ ] approve
[ ] operator approval
[ ] metadata
[ ] invalid token
[ ] mint authorization
```

# 35. AccessControl Test Matrix

```text
[ ] role holder succeeds
[ ] non-role fails
[ ] grantRole
[ ] revokeRole
[ ] renounceRole
[ ] admin role behavior
[ ] default admin protection
```

# 36. Pausable Test Matrix

```text
[ ] normal operation
[ ] pause
[ ] protected operation fails
[ ] unpause
[ ] operation works again
[ ] unauthorized pause fails
```

# 37. Upgrade Test Matrix

```text
[ ] initial deployment
[ ] initialize exactly once
[ ] implementation upgrade
[ ] state survives upgrade
[ ] new feature works
[ ] unauthorized upgrade fails
[ ] storage layout is safe
```

---

# 38. Full-Stack DApp Architecture

```text
React
  │
  ▼
ethers / wallet library
  │
  ├── Provider → READ
  └── Signer   → WRITE
          │
          ▼
         RPC
          │
          ▼
    OpenZeppelin-based
    Solidity contract
```

Frontend needs:

```text
ABI + deployed address + correct network
```

---

# 39. Example: Secure Creator Funding

Requirements:

```text
Users donate ETH
Creator receives funds
Admin can pause
Withdrawals are protected
Events are emitted
```

Architecture:

```text
CreatorFunding
 ├─ Ownable2Step
 ├─ Pausable
 ├─ ReentrancyGuard
 ├─ custom errors
 ├─ donation mapping
 └─ events
```

State:

```solidity
mapping(address => uint256) public donations;
```

Events:

```solidity
event Donated(address indexed donor, uint256 amount);
event Withdrawn(address indexed creator, uint256 amount);
```

Tests:

```text
normal donation
withdrawal
insufficient funds
unauthorized admin action
pause behavior
reentrancy scenario
failed external call
```

---

# 40. Example: Staking DApp

```text
RewardToken
     │
     ▼
  Staking
     │
     ├── stake()
     ├── unstake()
     ├── claim()
     └── reward calculation
```

Possible building blocks:

```text
IERC20/token interaction
ReentrancyGuard
Pausable
AccessControl
```

Ask:

```text
Who controls reward rate?
Can rewards become insolvent?
What happens during pause?
Can users withdraw principal while paused?
Can rewards be manipulated by timestamp assumptions?
```

---

# 41. Example: NFT Marketplace

```text
NFT
 │
 ▼
Marketplace
 ├── list
 ├── buy
 ├── cancel
 └── withdraw fees
```

Security:

```text
ownership
approval
price validation
reentrancy
seller checks
payment accounting
admin permissions
```

---

# 42. OpenZeppelin + Hardhat Workflow

```text
Write Solidity
     ↓
Import OZ modules
     ↓
Compile
     ↓
Unit tests
     ↓
Attacker tests
     ↓
Local deployment
     ↓
React integration
     ↓
Testnet
     ↓
Verification
     ↓
Security review
```

Useful commands:

```bash
npm install @openzeppelin/contracts
npx hardhat compile
npx hardhat test
npx hardhat node
```

---

# 43. Version Discipline

Always check:

```text
Solidity compiler version
OpenZeppelin major version
Hardhat/plugin versions
Upgradeable package version
```

Do not mix a v4 tutorial blindly into a v5 project.

For upgradeable systems, OpenZeppelin explicitly warns that major releases can be storage-layout incompatible.

---

# 44. Don't Do This

```text
Random GitHub contract
→ copy
→ deploy
```

Instead:

```text
Official package
→ understand inheritance
→ add your business logic
→ write tests
→ threat-model it
→ deploy
```

Do not assume:

```text
OpenZeppelin = automatically secure protocol
```

OpenZeppelin reduces implementation risk; your architecture, configuration, economics, permissions and deployment can still be wrong.

---

# 45. OpenZeppelin Source Reading Method

When reading a module, find these in order:

```text
1. contract declaration
2. inheritance
3. state variables
4. constructor / initializer
5. modifiers
6. public/external functions
7. internal functions/hooks
8. events
9. errors
10. overrides
```

Then answer:

> **What behavior does this module give me, and what behavior must I still implement?**

---

# 46. The 10X Contract Design Formula

```text
REQUIREMENT
    ↓
STATE MACHINE
    ↓
ASSET STANDARD
    ↓
ACCESS MATRIX
    ↓
OPENZEPPELIN MODULES
    ↓
BUSINESS LOGIC
    ↓
SECURITY MODEL
    ↓
EVENTS + ERRORS
    ↓
TEST MATRIX
    ↓
DEPLOYMENT
```

---

# 47. State-Machine Method

Example staking:

```text
NOT STAKED
    ↓ stake()
STAKED
    ↓ time passes
REWARD AVAILABLE
    ↓ claim()
STAKED
    ↓ unstake()
NOT STAKED
```

For each state transition define:

```text
Who can trigger it?
What state changes?
What can make it revert?
What event is emitted?
Can it happen twice?
```

---

# 48. Portfolio Project Ladder

### Beginner

```text
1. Ownable Wallet
2. ERC20 Token
3. NFT Minting DApp
```

### Intermediate

```text
4. Staking
5. NFT Marketplace
6. Crowdfunding
7. Token Sale
```

### Advanced

```text
8. DAO
9. Upgradeable DeFi protocol
10. Multi-contract treasury
```

### Strong portfolio stack

```text
Solidity
+ OpenZeppelin
+ Hardhat
+ tests
+ React
+ ethers
+ MetaMask
+ Sepolia
+ verification
+ README
```

---

# 49. One-Page Memory Card

```text
INSTALL
npm install @openzeppelin/contracts

ONE ADMIN
Ownable
onlyOwner

SAFER OWNERSHIP
Ownable2Step

MANY ROLES
AccessControl
onlyRole(ROLE)

SYSTEM PERMISSIONS
AccessManager

EMERGENCY BRAKE
Pausable
_pause()
_unpause()
whenNotPaused

REENTRANCY
ReentrancyGuard
nonReentrant

FUNGIBLE
ERC20

NFT
ERC721

MULTI-ASSET
ERC1155

VOTING
ERC20Votes + Governor

DELAY
Timelock

UPGRADEABLE
contracts-upgradeable
initializer

CALLER
msg.sender

ETH SENT
msg.value

EVENT
emit Event(...)

ERROR
revert CustomError(...)

SECURITY ORDER
CHECKS → EFFECTS → INTERACTIONS

FRONTEND
ABI + ADDRESS + NETWORK
```

---

# 50. Ultimate Cheat Code

When someone says:

> **"Build X blockchain application."**

Run this algorithm:

```text
What asset?
   ↓
ERC20 / ERC721 / ERC1155 / none
   ↓
Who has power?
   ↓
Ownable / AccessControl / AccessManager
   ↓
Can it be paused?
   ↓
Pausable
   ↓
Can external calls re-enter?
   ↓
Reentrancy analysis + CEI
   ↓
Can users authorize by signature?
   ↓
EIP-712 / signature utilities
   ↓
Can code change?
   ↓
Upgradeable or immutable
   ↓
What must frontend/indexers know?
   ↓
Events
   ↓
How can an attacker break it?
   ↓
Negative tests
   ↓
How do we ship?
   ↓
Hardhat → testnet → verification
```

---

# 51. Final Rules

1. **Don't reinvent ERC standards.**
2. **Use the installed OpenZeppelin package instead of copying its source.**
3. **Treat access control as part of the architecture, not an afterthought.**
4. **Use least privilege.**
5. **A module gives capabilities; your code decides where they apply.**
6. **Test attackers, not only honest users.**
7. **Upgradeable contracts require storage discipline.**
8. **Pin and understand dependency versions.**
9. **Never assume OpenZeppelin makes your business logic safe automatically.**
10. **Read the API/source for the exact version you installed.**
11. **Build local → test → testnet → verify.**
12. **Learn to translate requirements into modules.**

---

# 52. Official References

- OpenZeppelin Contracts: https://docs.openzeppelin.com/contracts/5.x/
- Access Control: https://docs.openzeppelin.com/contracts/5.x/access-control
- ERC-20: https://docs.openzeppelin.com/contracts/5.x/erc20
- ERC-721: https://docs.openzeppelin.com/contracts/5.x/erc721
- API Reference: https://docs.openzeppelin.com/contracts/5.x/api
- Upgradeable Contracts: https://docs.openzeppelin.com/contracts/5.x/upgradeable
- Upgrading Smart Contracts: https://docs.openzeppelin.com/contracts/5.x/learn/upgrading-smart-contracts
- Contracts Wizard: https://wizard.openzeppelin.com/

---

# 🏁 Final Challenge

Build a **Secure Creator Funding Protocol** using:

```text
Ownable2Step
Pausable
ReentrancyGuard
custom errors
Events
Hardhat tests
React frontend
MetaMask
Sepolia
contract verification
```

Requirements:

```text
Users
├── donate ETH
├── view contribution
└── withdraw/refund according to rules

Creator
└── receive funds

Admin
├── pause
└── emergency administration
```

Don't copy a finished contract. Design the state machine, access matrix and attack tests first.

> **The real skill is not memorizing OpenZeppelin imports. It is seeing a blockchain requirement and immediately knowing which Solidity primitive, OpenZeppelin module, permission model, security control and tests belong around it.**
