# 📦 Solidity Variables — Complete One Page Revision

> 🎯 **Goal:** Learn everything about Solidity variables including **State Variables, Local Variables, Global Variables**, their differences, lifetime, storage location, gas cost, and practical coding examples. Variables are the foundation of every Solidity smart contract.

---

# 📦 1. What is a Variable?

## 📌 Definition

A **Variable** is a named storage location used to **store data** inside a smart contract.

Variables allow contracts to remember information such as:

- User balances
- Owner address
- Student names
- Token supply
- Boolean status

Without variables, smart contracts cannot store or process data.

---

## 🧒 Explain Like I'm 10

Imagine you have three boxes.

```text
📦 Box 1

Name

↓

Alice

------------------

📦 Box 2

Age

↓

20

------------------

📦 Box 3

Balance

↓

100 ETH
```

Each box stores different information.

Variables work exactly like these boxes.

---

## 💡 Remember

> **Variable = Named Storage Location for Data**

---

# 🏗️ Types of Variables in Solidity

Solidity has **three main types of variables**:

```text
             Variables
                  │
      ┌───────────┼───────────┐
      ▼           ▼           ▼
 State      Local      Global
 Variables Variables Variables
```

---

# 📌 2. State Variables

## Definition

State variables are declared **inside a contract but outside all functions**.

They are stored permanently on the blockchain.

Every function inside the contract can access them.

---

## Characteristics

- Permanent
- Stored in Storage
- Lives until contract is destroyed
- Costs gas to modify
- Accessible by all contract functions

---

## Syntax

```solidity
contract Demo {

    uint public age;

}
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    string public name = "Alice";

    uint public age = 20;

}
```

---

## Memory Representation

```text
Blockchain Storage

------------------

name

↓

Alice

------------------

age

↓

20
```

---

## Example with Update

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    uint public age = 20;

    function updateAge(uint _age) public {

        age = _age;

    }

}
```

---

## Explanation

Initially

```text
Age = 20
```

After

```text
updateAge(25)
```

Result

```text
Age = 25
```

The value is permanently stored.

---

## Common Uses

- Owner Address
- Token Supply
- User Balance
- Student Data
- Contract Settings

---

## 💡 Remember

> **State Variables = Permanent Blockchain Data**

---

# 📌 3. Local Variables

## Definition

Local variables are declared **inside a function**.

They exist only while that function is executing.

After the function finishes,

they are automatically removed.

---

## Characteristics

- Temporary
- Stored in Memory
- Cannot be accessed outside the function
- Cheaper than state variables
- Destroyed after execution

---

## Syntax

```solidity
function demo() public {

    uint number = 100;

}
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Calculator {

    function add()
        public
        pure
        returns(uint)
    {

        uint a = 10;

        uint b = 20;

        uint sum = a + b;

        return sum;

    }

}
```

---

## Flow

```text
Function Starts

↓

Create Local Variables

↓

Perform Calculation

↓

Return Result

↓

Variables Deleted
```

---

## Explanation

Variables

```text
a

b

sum
```

exist only during function execution.

---

## Common Uses

- Temporary Calculations
- Loops
- Intermediate Results
- Function Logic

---

## 💡 Remember

> **Local Variables = Temporary Variables**

---

# 🌍 4. Global Variables

## Definition

Global variables are **built-in variables provided by Solidity**.

They provide information about:

- Blockchain
- Transaction
- Block
- Message Sender
- Gas
- Timestamp

You do not declare them.

They already exist.

---

## Characteristics

- Built into Solidity
- Available everywhere
- Read blockchain information
- Do not need declaration

---

# Most Important Global Variables

---

## 🔹 msg.sender

Returns the address of the account that called the function.

### Example

```solidity
address public sender;

function saveSender() public {

    sender = msg.sender;

}
```

Suppose Alice calls the function.

```text
msg.sender

↓

Alice Wallet Address
```

---

## 🔹 msg.value

Returns the amount of Ether sent with the transaction.

### Example

```solidity
function deposit()
    public
    payable
{

    uint amount = msg.value;

}
```

If user sends

```text
2 ETH
```

Then

```text
msg.value = 2 ETH
```

---

## 🔹 msg.data

Contains the complete calldata (encoded function selector and arguments) sent with the call.

Example

```text
Function Signature

+

Arguments
```

---

## 🔹 block.timestamp

Returns the timestamp of the current block (set by the block producer within protocol constraints).

Example

```solidity
uint public currentTime;

function getTime() public {

    currentTime = block.timestamp;

}
```

---

## 🔹 block.number

Returns the current block number.

Example

```solidity
uint public currentBlock;

function getBlock() public {

    currentBlock = block.number;

}
```

---

## 🔹 block.chainid

Returns the blockchain network ID.

Example

```text
Ethereum Mainnet

↓

1
```

```text
Sepolia

↓

11155111
```

---

## 🔹 tx.origin

Returns the original externally owned account (EOA) that started the transaction.

⚠️ **Security Note:** Avoid using `tx.origin` for authorization checks. Prefer `msg.sender`.

---

## Common Global Variables

| Variable          | Description                                               |
| ----------------- | --------------------------------------------------------- |
| `msg.sender`      | Address of function caller                                |
| `msg.value`       | Ether sent with the call                                  |
| `msg.data`        | Complete calldata                                         |
| `block.timestamp` | Current block timestamp                                   |
| `block.number`    | Current block number                                      |
| `block.chainid`   | Current chain ID                                          |
| `tx.origin`       | Original transaction initiator (avoid for access control) |

---

## 💡 Remember

> **Global Variables = Blockchain Information**

---

# 📊 State vs Local vs Global Variables

| Feature       | State Variable  | Local Variable       | Global Variable            |
| ------------- | --------------- | -------------------- | -------------------------- |
| Declared By   | Developer       | Developer            | Solidity                   |
| Location      | Contract        | Function             | Built-in                   |
| Lifetime      | Permanent       | Temporary            | Available during execution |
| Storage       | Storage         | Memory (typically)   | Provided by EVM            |
| Gas to Modify | High            | Low                  | Depends on usage           |
| Accessible    | Entire Contract | Only Inside Function | Anywhere applicable        |
| Example       | `balance`       | `sum`                | `msg.sender`               |

---

# 🧩 Example 1 – State Variable

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {

    uint public count = 0;

    function increment() public {

        count++;

    }

}
```

### Explanation

`count` is permanently stored on the blockchain.

---

# 🧩 Example 2 – Local Variable

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Math {

    function multiply()
        public
        pure
        returns(uint)
    {

        uint a = 5;

        uint b = 10;

        uint result = a * b;

        return result;

    }

}
```

### Explanation

`a`, `b`, and `result` exist only while the function executes.

---

# 🧩 Example 3 – Global Variable

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract User {

    address public lastCaller;

    function saveCaller() public {

        lastCaller = msg.sender;

    }

}
```

### Explanation

Whenever someone calls `saveCaller()`, their wallet address is stored in `lastCaller`.

---

# 🔄 Complete Concept Flow

```text
                 Variables
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
     State         Local         Global
        │             │             │
 Permanent      Temporary      Built-in
        │             │             │
 Storage        Memory      Blockchain Info
        │             │             │
        └─────────────┼─────────────┘
                      ▼
              Smart Contract Logic
```

---

# 🧠 60-Second Revision

| Topic              | One-Line Summary                                       |
| ------------------ | ------------------------------------------------------ |
| 📦 Variable        | Named storage location for data.                       |
| 🏗️ State Variable  | Permanent data stored on the blockchain.               |
| 📌 Local Variable  | Temporary variable inside functions.                   |
| 🌍 Global Variable | Built-in variables providing blockchain information.   |
| ⚡ Storage         | State variables live in storage.                       |
| 🧠 Memory          | Local variables typically use memory during execution. |

---

# 🎯 Golden Rules

- 📦 Variables store data.
- 🏗️ State variables are stored permanently on the blockchain.
- 📌 Local variables exist only during function execution.
- 🌍 Global variables are built into Solidity.
- 🔹 Use `msg.sender` to identify the caller.
- 💰 Use `msg.value` to get Ether sent.
- ⏰ Use `block.timestamp` for time-related logic (with care).
- 🔒 Avoid using `tx.origin` for authorization.
- ⛽ Writing to state variables is expensive because it updates blockchain storage.

---

# 💼 Solidity Variables — Interview Questions & Answers

## Q1. What is a variable in Solidity?

**Answer:**

A variable is a named storage location used to store data in a smart contract.

---

## Q2. What are the three main types of variables?

**Answer:**

- State Variables
- Local Variables
- Global Variables

---

## Q3. What is a state variable?

**Answer:**

A state variable is declared outside functions and stored permanently on the blockchain.

---

## Q4. What is a local variable?

**Answer:**

A local variable is declared inside a function and exists only while the function executes.

---

## Q5. What are global variables?

**Answer:**

Global variables are built-in variables provided by Solidity to access blockchain and transaction information.

---

## Q6. What does `msg.sender` return?

**Answer:**

The address of the account that called the function.

---

## Q7. What does `msg.value` return?

**Answer:**

The amount of Ether sent with the transaction.

---

## Q8. What does `block.timestamp` return?

**Answer:**

The timestamp of the current block.

---

## Q9. Which variable type is stored permanently?

**Answer:**

State variables.

---

## Q10. Which variable type exists only during function execution?

**Answer:**

Local variables.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Where are state variables stored?

Storage.

---

### Q12. Where are local variables stored?

Memory (for reference types) or on the stack for simple value types.

---

### Q13. Which variable gives the caller's address?

`msg.sender`

---

### Q14. Which variable gives the Ether amount sent?

`msg.value`

---

### Q15. Which variable returns the current block number?

`block.number`

---

### Q16. Which variable returns the chain ID?

`block.chainid`

---

### Q17. Can local variables be accessed outside a function?

No.

---

### Q18. Can state variables be accessed by multiple functions?

Yes.

---

### Q19. Which variable type is the most gas expensive to modify?

State variables.

---

### Q20. Why should `tx.origin` generally not be used for access control?

Because it can introduce security vulnerabilities through intermediary contract calls; `msg.sender` is the recommended choice.

---

# 🎯 Interview Tips

- Start with: **"Variables are named storage locations used to store data inside a smart contract."**
- Explain the three categories clearly:
  - **State Variables** → Permanent contract data.
  - **Local Variables** → Temporary function data.
  - **Global Variables** → Built-in blockchain and transaction information.
- Mention common global variables like **`msg.sender`**, **`msg.value`**, **`block.timestamp`**, and **`block.number`**.
- Remember that **state variables consume storage gas**, while **local variables are temporary and cheaper**.
- Mention the security best practice: **use `msg.sender` instead of `tx.origin` for authorization**.
