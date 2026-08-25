# 🪙 ERC-20 Token Implementation in Solidity — Complete In-Depth Revision

> 🎯 **Goal:** Learn how to implement an ERC-20 token in Solidity, understand the complete code line by line, build it manually for learning, implement it using OpenZeppelin for real projects, and understand minting, burning, transfers, allowances, approvals, decimals, events, access control, testing, deployment, and common mistakes.

---

# 🪙 1. What Are We Building?

We will create an ERC-20 token called:

```text
MyToken
```

with symbol:

```text
MTK
```

The token will support:

```text
✅ Token name
✅ Token symbol
✅ Token decimals
✅ Total supply
✅ Balance tracking
✅ transfer()
✅ approve()
✅ allowance()
✅ transferFrom()
✅ Transfer event
✅ Approval event
✅ Minting
✅ Burning
```

---

# 🧠 2. ERC-20 Implementation Architecture

```text
                    MyToken
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
     Metadata       Balances       Allowances
        │              │              │
        ▼              ▼              ▼
 name/symbol       mapping()       nested mapping
 decimals             │              │
                       │              │
                       ▼              ▼
                   transfer()    approve()
                                      │
                                      ▼
                                 allowance()
                                      │
                                      ▼
                                transferFrom()
```

---

# 🏗️ 3. Basic ERC-20 Storage

An ERC-20 implementation needs to track:

### Token metadata

```solidity
string public name;
string public symbol;
uint8 public decimals;
```

### Total supply

```solidity
uint256 public totalSupply;
```

### User balances

```solidity
mapping(address => uint256) public balances;
```

### Allowances

```solidity
mapping(address => mapping(address => uint256))
    public allowances;
```

---

# 🧠 4. Why Do We Need a Balance Mapping?

The blockchain needs to know:

> How many tokens does each address own?

We can represent this as:

```solidity
mapping(address => uint256) balances;
```

Conceptually:

```text
Address                 Balance

Alice     ────────────► 1000
Bob       ────────────► 500
Charlie   ────────────► 250
```

---

# 🧠 5. Why Do We Need an Allowance Mapping?

ERC-20 supports:

```solidity
approve()
```

and:

```solidity
transferFrom()
```

Therefore, we need to remember:

```text
WHO owns the tokens?
        +
WHO is allowed to spend them?
        +
HOW MUCH can they spend?
```

So we use:

```solidity
mapping(address => mapping(address => uint256))
    allowances;
```

Conceptually:

```text
Alice
  │
  ├── DApp → 500
  │
  └── Exchange → 1000
```

---

# 📢 6. ERC-20 Events

We need two important events:

```solidity
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
```

---

# 🔄 7. Transfer Event

When tokens move:

```solidity
emit Transfer(
    sender,
    recipient,
    amount
);
```

Example:

```text
Alice
  │
  │ 100 MTK
  ▼
Bob
```

Event:

```text
Transfer(
    Alice,
    Bob,
    100
)
```

---

# 🔐 8. Approval Event

When an allowance is created or changed:

```solidity
emit Approval(
    owner,
    spender,
    amount
);
```

Example:

```text
Alice approves DApp for 500 MTK
```

Event:

```text
Approval(
    Alice,
    DApp,
    500
)
```

---

# 🧱 9. Manual ERC-20 Implementation

> ⚠️ This implementation is primarily for learning. Production contracts should generally use a well-tested implementation such as OpenZeppelin rather than reinventing token accounting.

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract MyToken {

    string public name = "My Token";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    uint256 public totalSupply;

    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256))
        public allowances;

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

    constructor(uint256 initialSupply) {

        uint256 amount =
            initialSupply * 10 ** decimals;

        balances[msg.sender] = amount;

        totalSupply = amount;

        emit Transfer(
            address(0),
            msg.sender,
            amount
        );
    }

    function balanceOf(
        address account
    )
        public
        view
        returns (uint256)
    {
        return balances[account];
    }

    function transfer(
        address to,
        uint256 amount
    )
        public
        returns (bool)
    {
        require(
            to != address(0),
            "Invalid recipient"
        );

        require(
            balances[msg.sender] >= amount,
            "Insufficient balance"
        );

        balances[msg.sender] -= amount;

        balances[to] += amount;

        emit Transfer(
            msg.sender,
            to,
            amount
        );

        return true;
    }

    function approve(
        address spender,
        uint256 amount
    )
        public
        returns (bool)
    {
        require(
            spender != address(0),
            "Invalid spender"
        );

        allowances[msg.sender][spender] = amount;

        emit Approval(
            msg.sender,
            spender,
            amount
        );

        return true;
    }

    function allowance(
        address owner,
        address spender
    )
        public
        view
        returns (uint256)
    {
        return allowances[owner][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    )
        public
        returns (bool)
    {
        require(
            to != address(0),
            "Invalid recipient"
        );

        require(
            balances[from] >= amount,
            "Insufficient balance"
        );

        require(
            allowances[from][msg.sender] >= amount,
            "Insufficient allowance"
        );

        balances[from] -= amount;

        balances[to] += amount;

        allowances[from][msg.sender] -= amount;

        emit Transfer(
            from,
            to,
            amount
        );

        return true;
    }
}
```

---

# 🔍 10. Code Explanation — Metadata

```solidity
string public name = "My Token";
```

Token name:

```text
My Token
```

---

```solidity
string public symbol = "MTK";
```

Token symbol:

```text
MTK
```

---

```solidity
uint8 public decimals = 18;
```

The token uses:

```text
18 decimal places
```

---

# 🔢 11. Total Supply

```solidity
uint256 public totalSupply;
```

Stores the total number of token base units currently in existence.

Example:

```text
1,000 MTK
```

with 18 decimals is represented internally as:

```text
1,000 × 10^18
```

base units.

---

# 🗺️ 12. Balance Mapping

```solidity
mapping(address => uint256) public balances;
```

This stores:

```text
address → token balance
```

Example:

```text
Alice → 1000 MTK
Bob   → 500 MTK
```

---

# 🗺️ 13. Allowance Mapping

```solidity
mapping(address => mapping(address => uint256))
    public allowances;
```

Think:

```solidity
allowances[owner][spender]
```

Example:

```solidity
allowances[Alice][DApp] = 500;
```

means:

```text
DApp can spend up to 500
tokens from Alice.
```

---

# 🚀 14. Constructor

```solidity
constructor(uint256 initialSupply) {

    uint256 amount =
        initialSupply * 10 ** decimals;

    balances[msg.sender] = amount;

    totalSupply = amount;

    emit Transfer(
        address(0),
        msg.sender,
        amount
    );
}
```

The constructor executes once when the contract is deployed.

---

# 🧠 15. Why `msg.sender` in Constructor?

During deployment:

```text
Deployer
    │
    ▼
Contract Constructor
```

Inside the constructor:

```solidity
msg.sender
```

is the address performing deployment.

Therefore:

```solidity
balances[msg.sender] = amount;
```

gives the initial tokens to the deployer.

---

# 🪙 16. Why Transfer From `address(0)`?

Minting is conventionally represented by:

```text
address(0)
      │
      │ tokens created
      ▼
recipient
```

Therefore:

```solidity
emit Transfer(
    address(0),
    msg.sender,
    amount
);
```

signals token creation.

---

# 👤 17. `balanceOf()`

Implementation:

```solidity
function balanceOf(
    address account
)
    public
    view
    returns (uint256)
{
    return balances[account];
}
```

Calling:

```solidity
balanceOf(alice)
```

returns Alice's token balance.

---

# 📤 18. Implementing `transfer()`

```solidity
function transfer(
    address to,
    uint256 amount
)
    public
    returns (bool)
{
```

Parameters:

```text
to
   ↓
recipient address

amount
   ↓
number of tokens
```

---

# 🔐 19. Validate Recipient

```solidity
require(
    to != address(0),
    "Invalid recipient"
);
```

We don't allow normal transfers to the zero address.

---

# 💰 20. Check Balance

```solidity
require(
    balances[msg.sender] >= amount,
    "Insufficient balance"
);
```

The sender must have enough tokens.

---

# ➖ 21. Subtract From Sender

```solidity
balances[msg.sender] -= amount;
```

Example:

```text
Alice = 1000

Transfer = 200

Alice = 800
```

---

# ➕ 22. Add To Recipient

```solidity
balances[to] += amount;
```

Example:

```text
Bob = 500

Received = 200

Bob = 700
```

---

# 📢 23. Emit Transfer Event

```solidity
emit Transfer(
    msg.sender,
    to,
    amount
);
```

This records the token transfer in the transaction logs.

---

# ✅ 24. Return `true`

```solidity
return true;
```

This indicates successful execution.

---

# 🔐 25. Implementing `approve()`

```solidity
function approve(
    address spender,
    uint256 amount
)
    public
    returns (bool)
{
```

The caller gives:

```text
spender
```

permission to spend:

```text
amount
```

tokens.

---

# 🧠 26. Store Allowance

```solidity
allowances[msg.sender][spender] = amount;
```

Example:

```solidity
allowances[Alice][DApp] = 500;
```

Now:

```text
DApp → can spend up to 500
Alice's tokens
```

---

# 📢 27. Emit Approval

```solidity
emit Approval(
    msg.sender,
    spender,
    amount
);
```

---

# 🔍 28. Implementing `allowance()`

```solidity
function allowance(
    address owner,
    address spender
)
    public
    view
    returns (uint256)
{
    return allowances[owner][spender];
}
```

Example:

```solidity
allowance(alice, dapp)
```

returns:

```text
500
```

---

# 📤 29. Implementing `transferFrom()`

This is the most important function for:

```text
DeFi
DEXs
Staking
Lending
DApps
```

It allows an approved spender to move tokens.

---

# 🔄 30. `transferFrom()` Flow

```text
Alice
 │
 │ approve(DApp, 500)
 ▼
DApp
 │
 │ transferFrom(Alice, Bob, 200)
 ▼
Bob
```

After the transaction:

```text
Alice balance    -200
Bob balance      +200
Allowance        500 → 300
```

---

# 🔐 31. Check Token Balance

```solidity
require(
    balances[from] >= amount,
    "Insufficient balance"
);
```

The owner must have enough tokens.

---

# 🔐 32. Check Allowance

```solidity
require(
    allowances[from][msg.sender] >= amount,
    "Insufficient allowance"
);
```

The caller must have enough permission.

---

# ➖ 33. Update Sender Balance

```solidity
balances[from] -= amount;
```

---

# ➕ 34. Update Recipient Balance

```solidity
balances[to] += amount;
```

---

# ➖ 35. Decrease Allowance

```solidity
allowances[from][msg.sender] -= amount;
```

Example:

```text
Allowance = 500

Spent = 200

Remaining = 300
```

---

# 📢 36. Emit Transfer

```solidity
emit Transfer(
    from,
    to,
    amount
);
```

---

# 🧠 37. Complete `transferFrom()` Logic

```text
             transferFrom()
                    │
                    ▼
            Is recipient valid?
                    │
                    ▼
            Does owner have
             enough tokens?
                    │
                    ▼
           Does caller have
             enough allowance?
                    │
                    ▼
         Subtract from owner
                    │
                    ▼
         Add to recipient
                    │
                    ▼
        Decrease allowance
                    │
                    ▼
         Emit Transfer
                    │
                    ▼
                Success
```

---

# 🪙 38. Adding Minting

A token can include a mint function:

```solidity
function mint(
    address to,
    uint256 amount
)
    public
{
    balances[to] += amount;

    totalSupply += amount;

    emit Transfer(
        address(0),
        to,
        amount
    );
}
```

---

# 🚨 39. Why This Mint Function Is Dangerous

The function above has:

```text
NO ACCESS CONTROL
```

Therefore:

```text
Alice → mint
Bob → mint
Charlie → mint
Anyone → mint
```

If unlimited minting is not intended, this is a serious vulnerability.

---

# 🔐 40. Owner-Controlled Minting

Add:

```solidity
address public owner;
```

Constructor:

```solidity
constructor(uint256 initialSupply) {

    owner = msg.sender;

    ...
}
```

Modifier:

```solidity
modifier onlyOwner() {

    require(
        msg.sender == owner,
        "Not owner"
    );

    _;
}
```

Then:

```solidity
function mint(
    address to,
    uint256 amount
)
    public
    onlyOwner
{
    balances[to] += amount;

    totalSupply += amount;

    emit Transfer(
        address(0),
        to,
        amount
    );
}
```

---

# 🔥 41. Adding Burn

A simple burn function:

```solidity
function burn(
    uint256 amount
)
    public
{
    require(
        balances[msg.sender] >= amount,
        "Insufficient balance"
    );

    balances[msg.sender] -= amount;

    totalSupply -= amount;

    emit Transfer(
        msg.sender,
        address(0),
        amount
    );
}
```

---

# 🧠 42. Why Burn Uses Zero Address?

Burning is conventionally represented as:

```text
User
 │
 │ tokens destroyed
 ▼
address(0)
```

So:

```solidity
emit Transfer(
    msg.sender,
    address(0),
    amount
);
```

represents token destruction.

---

# 📊 43. Mint vs Burn

```text
MINT

address(0)
    │
    ▼
User

Supply ⬆️
```

```text
BURN

User
  │
  ▼
address(0)

Supply ⬇️
```

---

# 🧮 44. Important Token Unit Concept

Suppose:

```solidity
decimals = 18;
```

User wants:

```text
100 MTK
```

The actual integer amount is:

```text
100 × 10^18
```

Therefore:

```solidity
uint256 amount =
    100 * 10 ** decimals;
```

---

# ⚠️ 45. A Common Beginner Mistake

Do not confuse:

```solidity
100
```

with:

```text
100 tokens
```

If:

```text
decimals = 18
```

then:

```solidity
100
```

means:

```text
100 base units
```

while:

```solidity
100 * 10 ** 18
```

represents:

```text
100 display tokens
```

---

# 🧪 46. Example Token Deployment

Suppose:

```text
Name = My Token
Symbol = MTK
Decimals = 18
Initial Supply = 1,000,000
```

The constructor receives:

```solidity
1000000
```

and calculates:

```solidity
1000000 * 10 ** 18
```

The deployer receives:

```text
1,000,000 MTK
```

---

# 🔄 47. Example Transfer

Alice owns:

```text
1000 MTK
```

Bob owns:

```text
100 MTK
```

Alice calls:

```solidity
transfer(
    bob,
    200 * 10 ** 18
);
```

Result:

```text
Alice = 800 MTK
Bob   = 300 MTK
```

Total supply:

```text
UNCHANGED
```

---

# 🔐 48. Example Approval

Alice calls:

```solidity
approve(
    dapp,
    500 * 10 ** 18
);
```

State becomes:

```text
Alice
  │
  └── DApp → 500 MTK allowance
```

---

# 🔄 49. Example `transferFrom()`

DApp calls:

```solidity
transferFrom(
    alice,
    bob,
    200 * 10 ** 18
);
```

Result:

```text
Alice balance:
1000 → 800

Bob balance:
100 → 300

Allowance:
500 → 300
```

---

# 🧠 50. Complete Token Interaction

```text
                  Alice
                    │
                    │ owns
                    ▼
                1000 MTK
                    │
                    │ approve(DApp, 500)
                    ▼
                  DApp
                    │
                    │ transferFrom(Alice, Bob, 200)
                    ▼
                   Bob

Final:

Alice = 800
Bob   = 300

Remaining allowance = 300
```

---

# 🏗️ 51. Production ERC-20 — OpenZeppelin

For production development, use a standard implementation rather than manually implementing all token accounting.

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    constructor(
        uint256 initialSupply
    )
        ERC20("My Token", "MTK")
    {
        _mint(
            msg.sender,
            initialSupply * 10 ** decimals()
        );
    }
}
```

---

# 🔍 52. Why OpenZeppelin?

OpenZeppelin provides reusable implementations for common Ethereum standards and security patterns.

Instead of writing:

```text
balance accounting
allowances
events
transfer logic
minting internals
burning internals
```

from scratch, you can inherit:

```solidity
ERC20
```

and use its tested functionality.

---

# 🧬 53. ERC-20 Inheritance

```solidity
contract MyToken is ERC20
```

means:

```text
             ERC20
               ▲
               │
               │ inherits
               │
             MyToken
```

Your token gets ERC-20 functionality from the parent implementation.

---

# 🪙 54. OpenZeppelin `_mint()`

Instead of manually writing:

```solidity
balances[to] += amount;
totalSupply += amount;
emit Transfer(...);
```

use:

```solidity
_mint(to, amount);
```

The inherited implementation handles the necessary token accounting and events.

---

# 🔥 55. OpenZeppelin `_burn()`

Instead of manually implementing burn logic:

```solidity
_burn(
    msg.sender,
    amount
);
```

This removes tokens from the account and supply according to the implementation.

---

# 🔐 56. OpenZeppelin Owner-Controlled Mint

A common design is:

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    constructor(
        uint256 initialSupply
    )
        ERC20("My Token", "MTK")
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
    )
        external
        onlyOwner
    {
        _mint(to, amount);
    }
}
```

---

# 🔍 57. Understanding This Contract

```solidity
contract MyToken is ERC20, Ownable
```

inherits from:

```text
ERC20
Ownable
```

Therefore:

```text
ERC20
 ↓
Token functionality

Ownable
 ↓
Access control
```

---

# 🔐 58. `onlyOwner`

```solidity
function mint(
    address to,
    uint256 amount
)
    external
    onlyOwner
{
```

Only the owner can call:

```solidity
mint()
```

If another account calls it:

```text
Transaction reverts
```

---

# 🧠 59. Why Use `_mint()` Instead of Writing It Yourself?

Instead of:

```solidity
balances[to] += amount;
totalSupply += amount;
```

use:

```solidity
_mint(to, amount);
```

because the inherited implementation handles the token accounting and relevant hooks/events consistently.

---

# ⚠️ 60. Manual Implementation vs OpenZeppelin

| Feature                | Manual                | OpenZeppelin              |
| ---------------------- | --------------------- | ------------------------- |
| Learning value         | ⭐⭐⭐⭐⭐            | ⭐⭐⭐⭐                  |
| Production suitability | ⚠️ Risky              | ✅ Preferred              |
| Code size              | Larger                | Smaller                   |
| Security               | Developer responsible | Reusable audited codebase |
| Maintenance            | Developer responsible | Library maintained        |
| ERC-20 standard logic  | You implement         | Already implemented       |
| Customization          | High                  | High                      |
| Beginner understanding | Excellent             | Excellent                 |

---

# 🧪 61. ERC-20 Implementation Testing

You should test at least:

```text
☑️ Deployment
☑️ Name
☑️ Symbol
☑️ Decimals
☑️ Total supply
☑️ Initial balance
☑️ transfer()
☑️ approve()
☑️ allowance()
☑️ transferFrom()
☑️ Mint
☑️ Burn
☑️ Unauthorized mint
☑️ Insufficient balance
☑️ Insufficient allowance
☑️ Invalid recipient
```

---

# 🧪 62. Example Test Scenario

Initial:

```text
Alice = 1000 MTK
Bob   = 0 MTK
```

Alice transfers:

```text
100 MTK
```

Expected:

```text
Alice = 900
Bob   = 100
```

---

Then Alice approves:

```text
DApp = 500 MTK
```

Expected:

```text
allowance(Alice, DApp)
=
500
```

---

DApp transfers:

```text
200 MTK
```

Expected:

```text
Alice = 700
Bob   = 300

Allowance = 300
```

---

# 🚨 63. Security Considerations

## 🔐 Access Control

Protect:

```solidity
mint()
```

and administrative functions.

---

## 💰 Supply Control

Decide whether the token has:

```text
Fixed supply
```

or:

```text
Mintable supply
```

or:

```text
Capped supply
```

---

## 🔥 Burning

Decide:

```text
Can users burn?
```

or:

```text
Only authorized contracts can burn?
```

---

## ⏸️ Pausing

For some applications, emergency pausing may be required.

---

## 🔄 Allowances

Understand:

```text
approve()
allowance()
transferFrom()
```

and the risks of large allowances.

---

# 🛡️ 64. Fixed Supply Token

A fixed-supply token can mint the entire supply once:

```solidity
contract FixedToken is ERC20 {

    constructor()
        ERC20("Fixed Token", "FIX")
    {
        _mint(
            msg.sender,
            1_000_000 * 10 ** decimals()
        );
    }
}
```

There is no public mint function.

Therefore:

```text
Initial mint
     ↓
1,000,000 tokens
     ↓
No additional minting
```

---

# ♾️ 65. Mintable Token

A mintable token may provide:

```solidity
function mint(
    address to,
    uint256 amount
)
    external
    onlyOwner
{
    _mint(to, amount);
}
```

Now supply can increase.

---

# 🚧 66. Capped Token

A token can have a maximum supply.

Conceptually:

```text
MAX SUPPLY
     │
     ▼
Cannot mint beyond limit
```

OpenZeppelin provides reusable mechanisms for supply caps.

---

# 🧠 67. Fixed vs Mintable vs Capped

| Design   | Additional Tokens?      | Maximum Supply      |
| -------- | ----------------------- | ------------------- |
| Fixed    | ❌                      | Fixed               |
| Mintable | ✅                      | Depends on rules    |
| Capped   | ✅                      | Limited             |
| Burnable | Tokens can be destroyed | Supply can decrease |

---

# 🔄 68. ERC-20 Implementation Flow

```text
Deploy Contract
      │
      ▼
Set Metadata
      │
      ▼
Create Initial Supply
      │
      ▼
Assign Tokens
      │
      ▼
Users Hold Balances
      │
      ├───────────────┐
      ▼               ▼
  transfer()       approve()
      │               │
      ▼               ▼
 Receiver        Allowance
                      │
                      ▼
                transferFrom()
                      │
                      ▼
                 Token Movement
                      │
              ┌───────┴───────┐
              ▼               ▼
            mint            burn
              │               │
              ▼               ▼
          Supply ↑         Supply ↓
```

---

# 💼 69. Real-World ERC-20 Implementation

A typical production architecture may look like:

```text
MyToken.sol
    │
    ├── ERC20
    │
    ├── Ownable / AccessControl
    │
    ├── Minting
    │
    ├── Burning
    │
    ├── Pausing (if required)
    │
    └── Supply Rules
```

---

# 🧩 70. Example Production-Oriented Token

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ProjectToken is ERC20, Ownable {

    uint256 public constant MAX_SUPPLY =
        1_000_000 * 10 ** 18;

    constructor()
        ERC20("Project Token", "PTK")
        Ownable(msg.sender)
    {
        _mint(
            msg.sender,
            500_000 * 10 ** decimals()
        );
    }

    function mint(
        address to,
        uint256 amount
    )
        external
        onlyOwner
    {
        require(
            totalSupply() + amount <= MAX_SUPPLY,
            "Cap exceeded"
        );

        _mint(to, amount);
    }

    function burn(
        uint256 amount
    )
        external
    {
        _burn(
            msg.sender,
            amount
        );
    }
}
```

---

# 🔍 71. Understanding the Maximum Supply

```solidity
uint256 public constant MAX_SUPPLY =
    1_000_000 * 10 ** 18;
```

Maximum:

```text
1,000,000 PTK
```

The owner cannot mint beyond:

```text
1,000,000 PTK
```

---

# 🛡️ 72. Supply Cap Check

```solidity
require(
    totalSupply() + amount <= MAX_SUPPLY,
    "Cap exceeded"
);
```

Before minting:

```text
Current Supply
      +
New Amount
      ↓
Must be <= MAX_SUPPLY
```

---

# 🧠 73. Important ERC-20 Implementation Concepts

You should understand these before moving to advanced token development:

```text
ERC-20
 │
 ├── name
 ├── symbol
 ├── decimals
 ├── totalSupply
 │
 ├── balanceOf
 │
 ├── transfer
 │
 ├── approve
 │
 ├── allowance
 │
 ├── transferFrom
 │
 ├── Transfer event
 ├── Approval event
 │
 ├── mint
 └── burn
```

---

# 🎯 74. Interview Questions

## Q1. How would you implement an ERC-20 token?

**Answer:**

> I would generally inherit from a well-tested ERC-20 implementation such as OpenZeppelin's `ERC20`. I would define the token name and symbol, mint the initial supply, and add only the required custom functionality such as controlled minting, burning, caps, or access control.

---

## Q2. What data structures are required?

```solidity
mapping(address => uint256)
```

for balances.

And:

```solidity
mapping(address => mapping(address => uint256))
```

for allowances.

---

## Q3. How does `transfer()` work internally?

Conceptually:

```text
Check recipient
      ↓
Check sender balance
      ↓
Subtract sender balance
      ↓
Add recipient balance
      ↓
Emit Transfer
```

---

## Q4. How does `transferFrom()` work?

```text
Check recipient
      ↓
Check owner's balance
      ↓
Check caller's allowance
      ↓
Subtract owner's balance
      ↓
Add recipient balance
      ↓
Reduce allowance
      ↓
Emit Transfer
```

---

## Q5. How do you mint an ERC-20?

Using OpenZeppelin:

```solidity
_mint(
    to,
    amount
);
```

---

## Q6. How do you burn an ERC-20?

Using OpenZeppelin:

```solidity
_burn(
    account,
    amount
);
```

---

## Q7. Why should you avoid implementing ERC-20 from scratch in production?

Because token accounting has many edge cases, and reimplementing a standard unnecessarily increases the chance of bugs and compatibility issues.

---

## Q8. What is the difference between `_mint()` and `mint()`?

```text
_mint()
```

is an internal implementation function provided by the ERC-20 implementation.

```text
mint()
```

is typically a public/external function you design to expose minting under your chosen access-control rules.

---

## Q9. Why is minting usually access controlled?

Because uncontrolled minting allows arbitrary creation of tokens and can destroy the intended token economics.

---

## Q10. What happens when tokens are transferred?

```text
Sender balance decreases
Receiver balance increases
Total supply remains unchanged
Transfer event emitted
```

---

# ⚡ 75. Rapid-Fire Revision

### Balance storage?

```solidity
mapping(address => uint256)
```

### Allowance storage?

```solidity
mapping(address => mapping(address => uint256))
```

### Send tokens?

```solidity
transfer()
```

### Give permission?

```solidity
approve()
```

### Check permission?

```solidity
allowance()
```

### Spend approved tokens?

```solidity
transferFrom()
```

### Create tokens?

```solidity
_mint()
```

### Destroy tokens?

```solidity
_burn()
```

### Transfer event?

```solidity
Transfer
```

### Approval event?

```solidity
Approval
```

### Native ETH amount?

```solidity
msg.value
```

### Common token decimals?

```text
18
```

### Production ERC-20 library?

```text
OpenZeppelin
```

---

# 🧠 76. ERC-20 Implementation Cheat Sheet

```text
NAME
 ↓
Token identity

SYMBOL
 ↓
Ticker

DECIMALS
 ↓
Display precision

TOTAL SUPPLY
 ↓
Tokens currently existing

BALANCES
 ↓
Who owns how many?

TRANSFER
 ↓
Move own tokens

APPROVE
 ↓
Give spending permission

ALLOWANCE
 ↓
Check permission

TRANSFERFROM
 ↓
Spend approved tokens

MINT
 ↓
Create tokens

BURN
 ↓
Destroy tokens
```

---

# 🏆 77. Golden Rules

- 🪙 **ERC-20 is a fungible token standard.**
- 🗺️ **Balances are generally stored using `mapping(address => uint256)`.**
- 🔐 **Allowances require a nested mapping.**
- 📤 **`transfer()` moves the caller's tokens.**
- 🔑 **`approve()` creates spending permission.**
- 🔍 **`allowance()` checks that permission.**
- 📤 **`transferFrom()` uses the permission to move tokens.**
- 🏭 **`_mint()` creates tokens and increases supply.**
- 🔥 **`_burn()` destroys tokens and decreases supply.**
- 📢 **Transfers should emit `Transfer`.**
- 🔐 **Approvals should emit `Approval`.**
- 🔢 **Token amounts are stored as integers in base units.**
- 💰 **`decimals()` controls how those units are displayed.**
- 🔐 **Privileged token operations need access control.**
- ⚠️ **Unlimited minting can destroy token economics.**
- 🏗️ **Use OpenZeppelin for production implementations whenever appropriate.**
- 🧪 **Test transfers, approvals, allowances, minting, burning, failures, and access control.**

---

# 🚀 78. Final Mental Model

```text
                    ERC-20 TOKEN
                         │
                         ▼
                ┌─────────────────┐
                │   Token State   │
                └────────┬────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
      Metadata        Balances       Allowances
          │              │              │
          ▼              ▼              ▼
   name/symbol       Alice → 1000   Alice → DApp → 500
   decimals          Bob → 500
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                     FUNCTIONS
                         │
       ┌─────────────────┼─────────────────┐
       ▼                 ▼                 ▼
   transfer()         approve()      transferFrom()
       │                 │                 │
       ▼                 ▼                 ▼
   Move tokens      Give permission    Spend tokens
                         │
                         ▼
                     allowance()
                         │
                         ▼
                    Check permission

                 SUPPLY MANAGEMENT
                         │
                  ┌──────┴──────┐
                  ▼             ▼
                mint           burn
                  │             │
                  ▼             ▼
               Supply ↑      Supply ↓
```

> ⭐ **Ultimate ERC-20 implementation memory line:**
>
> **`STATE → BALANCE → TRANSFER → APPROVE → ALLOWANCE → TRANSFERFROM → MINT → BURN → EVENTS → ACCESS CONTROL → TEST`**
>
> If you can explain this entire flow and implement it using OpenZeppelin, you have the core knowledge required to build and discuss ERC-20 tokens in Solidity.
