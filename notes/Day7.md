# 📦 Solidity Variables — One Page Revision

> 🎯 **Goal:** Understand Solidity variables, where they are stored, their lifetime, value types, and default values. These are among the most common Solidity interview topics.

---

# 📦 1. What are Variables in Solidity?

## 📌 Definition

A **Variable** is a named storage location that holds data.

Variables allow smart contracts to store and manipulate information such as numbers, addresses, strings, and boolean values.

---

## 🧒 Explain Like I'm 10

Imagine you have labeled boxes.

```text
📦 Age      → 25
📦 Name     → Alice
📦 Balance  → 100 ETH
```

Each box stores one piece of information.

A variable is simply one of these labeled boxes.

---

## Example

```solidity
uint256 age = 25;
bool isActive = true;
address owner;
string name = "Alice";
```

---

## Why Variables?

Variables are used to:

- Store blockchain data
- Track balances
- Store addresses
- Save contract state
- Perform calculations

---

## 💡 Remember

> **Variable = Named container that stores data.**

---

# 🏛️ 2. Types of Variables

Solidity has three main types of variables.

```text
Variables
     │
 ┌───┼───────────┐
 ▼   ▼           ▼
State Local   Global
```

---

## State Variables

Stored permanently on the blockchain.

---

## Local Variables

Exist only while a function executes.

---

## Global Variables

Provided automatically by Solidity.

Examples:

- msg.sender
- msg.value
- block.timestamp
- block.number
- tx.origin

---

## 💡 Remember

> State = Permanent

> Local = Temporary

> Global = Built into Solidity

---

# 🏠 3. State Variables

## 📌 Definition

State variables are declared **inside a contract but outside functions**.

They are stored permanently on the blockchain.

---

## Example

```solidity
contract Bank {

    uint256 public balance;

    address public owner;

    bool public paused;

}
```

---

## Characteristics

- Stored on blockchain
- Persistent
- Gas required to modify
- Shared by every function

---

## Memory Layout

```text
Blockchain Storage

┌─────────────────────┐
│ balance = 500       │
│ owner = 0x123...    │
│ paused = false      │
└─────────────────────┘
```

---

## Example

```solidity
contract Counter {

    uint256 public count;

    function increment() public {

        count++;

    }

}
```

Calling `increment()` changes the stored value forever.

---

## 💡 Remember

> **State Variables = Permanent Contract Storage**

---

# 🧮 4. Local Variables

## 📌 Definition

Local variables are declared **inside functions**.

They exist only while that function executes.

---

## Example

```solidity
function add() public pure returns(uint256){

    uint256 a = 5;

    uint256 b = 10;

    uint256 sum = a + b;

    return sum;

}
```

---

## Characteristics

- Temporary
- Stored in memory or stack
- Destroyed after execution
- Cheaper than state variables

---

## Lifetime

```text
Function Starts

↓

Variable Created

↓

Used

↓

Function Ends

↓

Variable Destroyed
```

---

## 💡 Remember

> **Local Variables disappear after the function finishes.**

---

# 💎 5. Value Types

## 📌 Definition

Value types store their own value directly.

When copied, an entirely new copy is created.

---

## Value Types

- bool
- uint
- int
- address
- bytes1 - bytes32
- enum

---

## Example

```solidity
uint256 a = 10;

uint256 b = a;

b = 20;
```

Result

```text
a = 10

b = 20
```

Because a copy was made.

---

## Diagram

```text
a

↓

10

Copy

↓

b

↓

10

↓

20
```

---

## 💡 Remember

> **Value Types are copied.**

---

# 📝 6. Reference Types (Preview)

Reference types store the location of data instead of the data itself.

Examples:

- string
- bytes
- array
- struct
- mapping

---

## Example

```solidity
string public name = "Alice";
```

Reference types require a data location.

```solidity
memory

storage

calldata
```

You'll study these in depth later.

---

## 💡 Remember

> **Reference Types store references, not direct values.**

---

# 🔄 7. Default Values

Every variable automatically gets a default value if one isn't assigned.

---

## Examples

| Type    | Default                                    |
| ------- | ------------------------------------------ |
| bool    | false                                      |
| uint    | 0                                          |
| int     | 0                                          |
| address | 0x0000000000000000000000000000000000000000 |
| string  | ""                                         |
| bytes   | empty                                      |
| enum    | First Value                                |

---

## Example

```solidity
uint256 public age;

bool public active;

address public owner;
```

Stored values

```text
age = 0

active = false

owner = 0x0000000000000000000000000000000000000000
```

---

## 💡 Remember

> Solidity never leaves variables uninitialized.

---

# 💾 8. Storage of Variables

Variables are stored in different places.

```text
Variables
     │
 ┌───┼──────────────┐
 ▼   ▼              ▼
Storage Memory   Calldata
```

---

## Storage

Permanent blockchain storage.

```solidity
uint256 public balance;
```

Characteristics

- Permanent
- Expensive
- Persistent

---

## Memory

Temporary memory.

```solidity
function test() public pure {

    string memory name = "Alice";

}
```

Characteristics

- Temporary
- Deleted after execution
- Cheaper

---

## Calldata

Read-only function input.

```solidity
function setName(string calldata name) external {

}
```

Characteristics

- Read-only
- Cannot modify
- Cheapest
- External functions only

---

## Comparison

| Feature  | Storage    | Memory    | Calldata       |
| -------- | ---------- | --------- | -------------- |
| Lifetime | Permanent  | Temporary | Temporary      |
| Mutable  | Yes        | Yes       | No             |
| Gas Cost | High       | Medium    | Low            |
| Location | Blockchain | RAM       | Function Input |

---

## 💡 Remember

> Storage = Permanent

> Memory = Temporary

> Calldata = Read-only

---

# 🔄 Complete Concept Flow

```text
               Variables
                    │
      ┌─────────────┼─────────────┐
      ▼             ▼             ▼
  State         Local         Global
      │             │
      ▼             ▼
 Blockchain     Function
   Storage       Memory
      │             │
      └─────────────┼─────────────┐
                    ▼
              Data Types
          ┌─────────┴─────────┐
          ▼                   ▼
     Value Types       Reference Types
          │                   │
          └─────────┬─────────┘
                    ▼
             Default Values
                    │
                    ▼
          Storage Locations
       ┌────────┼─────────┐
       ▼        ▼         ▼
   Storage   Memory   Calldata
```

---

# 🧠 60-Second Revision

| Topic               | One-Line Summary                                               |
| ------------------- | -------------------------------------------------------------- |
| 📦 Variables        | Named containers for storing data.                             |
| 🏛️ State Variables  | Permanently stored on blockchain.                              |
| 🧮 Local Variables  | Exist only during function execution.                          |
| 🌍 Global Variables | Built-in blockchain information.                               |
| 💎 Value Types      | Store their own values and are copied.                         |
| 📝 Reference Types  | Store references to data.                                      |
| 🔄 Default Values   | Automatically assigned if not initialized.                     |
| 💾 Storage          | Storage = Permanent, Memory = Temporary, Calldata = Read-only. |

---

# 🎯 Golden Rules

- 📦 Variables store contract data.
- 🏛️ State variables live on the blockchain.
- 🧮 Local variables disappear after function execution.
- 🌍 Global variables are provided by Solidity.
- 💎 Value types are copied by value.
- 📝 Reference types require a data location.
- 🔄 Every variable has a default value.
- 💾 Storage is expensive but permanent.
- 🧠 Memory is temporary.
- 📥 Calldata is read-only and efficient.

---

# 💼 Solidity Variables — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity variable interview questions.

---

## Q1. What is a variable in Solidity?

**Answer:**

A variable is a named storage location used to store data such as numbers, addresses, strings, and booleans within a smart contract.

---

## Q2. What are the types of variables in Solidity?

**Answer:**

- State Variables
- Local Variables
- Global Variables

---

## Q3. What is a state variable?

**Answer:**

A state variable is declared inside a contract but outside functions. It is stored permanently on the blockchain and retains its value between transactions.

---

## Q4. What is a local variable?

**Answer:**

A local variable is declared inside a function. It exists only during that function call and is destroyed after execution.

---

## Q5. What are global variables?

**Answer:**

Global variables are built-in variables provided by Solidity, such as `msg.sender`, `msg.value`, `block.timestamp`, and `block.number`.

---

## Q6. What are value types?

**Answer:**

Value types store their own data directly. Assigning one value type variable to another creates an independent copy.

---

## Q7. What are reference types?

**Answer:**

Reference types store references to data rather than the data itself. Examples include arrays, strings, structs, mappings, and bytes.

---

## Q8. What is the default value of a `uint`?

**Answer:**

`0`

---

## Q9. What is the default value of a `bool`?

**Answer:**

`false`

---

## Q10. What is the default value of an `address`?

**Answer:**

`0x0000000000000000000000000000000000000000`

---

## Q11. What is storage in Solidity?

**Answer:**

Storage is the permanent data area of a smart contract. State variables are stored here and persist on the blockchain.

---

## Q12. What is memory?

**Answer:**

Memory is temporary storage used during function execution. It is erased when the function finishes.

---

## Q13. What is calldata?

**Answer:**

Calldata is a read-only data location used for external function parameters. It is gas-efficient because it avoids unnecessary copying.

---

## ⚡ Rapid Fire Interview Questions

### Q14. Which variables are stored permanently?

State variables.

---

### Q15. Which variables disappear after execution?

Local variables.

---

### Q16. Which storage location is the most expensive?

Storage.

---

### Q17. Which storage location is read-only?

Calldata.

---

### Q18. Are value types copied or referenced?

Copied.

---

### Q19. Which variables require gas to modify?

State variables.

---

### Q20. Which keyword stores data permanently?

Storage.

---

# 🎯 Interview Tips

- Always explain the difference between **State**, **Local**, and **Global** variables.
- Don't confuse **value types** with **reference types**.
- Mention that **state variables persist across transactions**, while **local variables exist only during function execution**.
- Remember the default values for `uint`, `bool`, and `address`.
- Know the differences between **storage**, **memory**, and **calldata**, as they are among the most frequently asked Solidity interview topics.
