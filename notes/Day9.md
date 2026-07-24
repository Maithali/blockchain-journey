# 🧩 Solidity Data Types — One Page Revision

> 🎯 **Goal:** Learn Solidity data types, understand value types vs reference types, and master the most commonly used types such as `uint`, `int`, `bool`, `address`, `string`, `bytes`, and `bytes32`. These are among the most frequently asked Solidity interview topics.

---

# 🧩 1. What are Data Types?

## 📌 Definition

A **Data Type** defines the **kind of data** a variable can store.

It tells the Solidity compiler:

- What type of value the variable holds
- How much memory/storage is required
- What operations are allowed

---

## 🧒 Explain Like I'm 10

Imagine different containers.

```text
🥤 Bottle → Water

📦 Box → Toys

📚 Shelf → Books

💰 Wallet → Money
```

Each container stores a specific kind of item.

Similarly, every variable stores a specific type of data.

---

## Example

```solidity
uint256 age = 25;

bool isStudent = true;

address owner = msg.sender;

string name = "Alice";
```

---

## Why Data Types?

They help:

- Store data correctly
- Prevent invalid operations
- Improve security
- Optimize gas usage

---

## 💡 Remember

> **Data Type = Defines what kind of value a variable can store.**

---

# 🗂️ 2. Categories of Data Types

Solidity has two main categories.

```text
            Data Types
                 │
        ┌────────┴────────┐
        ▼                 ▼
   Value Types      Reference Types
```

---

## Value Types

Store the actual value directly.

Examples:

- bool
- uint
- int
- address
- bytes1 - bytes32
- enum

---

## Reference Types

Store a reference (location) to the data.

Examples:

- string
- bytes
- array
- struct
- mapping

---

## 💡 Remember

> **Value Types = Copy Values**

> **Reference Types = Copy References**

---

# 🔢 3. Unsigned Integer (uint)

## 📌 Definition

An **Unsigned Integer** stores **only positive whole numbers and zero**.

It cannot store negative values.

---

## Syntax

```solidity
uint age = 25;

uint256 balance = 1000;
```

---

## Common Types

```text
uint8

uint16

uint32

uint64

uint128

uint256
```

---

## Range

```text
uint8

0 → 255

uint256

0 → 2²⁵⁶ − 1
```

---

## Example

```solidity
uint256 public totalSupply = 1000000;
```

---

## Uses

- Token supply
- Age
- Balance
- Counters
- IDs

---

## 💡 Remember

> **uint = Positive numbers only**

---

# ➖ 4. Signed Integer (int)

## 📌 Definition

A **Signed Integer** stores both **positive and negative numbers**.

---

## Example

```solidity
int256 temperature = -20;
```

---

## Range

```text
int8

-128 → 127

int256

-2²⁵⁵ → (2²⁵⁵ - 1)
```

---

## Uses

- Profit/Loss
- Temperature
- Score Difference

---

## 💡 Remember

> **int = Positive + Negative numbers**

---

# ✅ 5. Boolean (bool)

## 📌 Definition

A Boolean stores only two values.

```text
true

false
```

---

## Example

```solidity
bool public isActive = true;

bool public paused = false;
```

---

## Uses

- Authentication
- Verification
- Status
- Conditions

---

## Default Value

```text
false
```

---

## 💡 Remember

> **bool = Yes or No**

---

# 🏠 6. Address

## 📌 Definition

An **address** stores an Ethereum account or smart contract address.

Length:

```text
20 Bytes

160 Bits
```

---

## Example

```solidity
address public owner;

address public user = msg.sender;
```

---

## Address Example

```text
0x742d35Cc6634C0532925a3b844Bc454e4438f44e
```

---

## Uses

- Wallet addresses
- Smart contracts
- Sending Ether
- Ownership

---

## Default Value

```text
0x0000000000000000000000000000000000000000
```

---

## 💡 Remember

> **Address = Identity on Ethereum**

---

# 📝 7. String

## 📌 Definition

A **string** stores text.

It is a **Reference Type**.

---

## Example

```solidity
string public name = "Solidity";
```

---

## Uses

- Names
- Messages
- Metadata
- Descriptions

---

## Default Value

```text
""
```

---

## 💡 Remember

> **string = Text Data**

---

# 📦 8. Bytes & Bytes32

## 📌 Definition

`bytes` stores a dynamic sequence of bytes.

`bytes32` stores exactly **32 bytes**.

---

## bytes

```solidity
bytes public data;
```

Dynamic size.

---

## bytes32

```solidity
bytes32 public hash;
```

Fixed size.

---

## Example

```solidity
bytes32 hash = keccak256("Hello");
```

---

## Comparison

| bytes           | bytes32          |
| --------------- | ---------------- |
| Dynamic         | Fixed (32 Bytes) |
| Flexible        | Gas Efficient    |
| Variable Length | Fixed Length     |

---

## Uses

- Hashes
- Signatures
- Encryption
- Raw Data

---

## 💡 Remember

> **bytes = Dynamic**

> **bytes32 = Fixed 32 Bytes**

---

# 💎 9. Value Types

## 📌 Definition

Value types store the actual value directly.

Copying creates a completely new value.

---

## Example

```solidity
uint a = 10;

uint b = a;

b = 20;
```

Result

```text
a = 10

b = 20
```

---

## Value Types

- bool
- uint
- int
- address
- bytes32
- enum

---

## 💡 Remember

> **Value Types are copied.**

---

# 📚 10. Reference Types

## 📌 Definition

Reference types store a reference to the data instead of the data itself.

---

## Reference Types

- string
- bytes
- array
- mapping
- struct

---

## Require Data Location

```solidity
memory

storage

calldata
```

---

## Example

```solidity
string memory name = "Alice";
```

---

## 💡 Remember

> **Reference Types store references.**

---

# ⚖️ Value Types vs Reference Types

| Feature       | Value Types     | Reference Types       |
| ------------- | --------------- | --------------------- |
| Stores        | Actual Value    | Reference             |
| Copy          | New Copy        | Reference             |
| Data Location | Not Required    | Required              |
| Gas Cost      | Lower           | Higher                |
| Examples      | uint, bool, int | string, array, struct |

---

# 🔄 Complete Concept Flow

```text
                Data Types
                     │
         ┌───────────┴───────────┐
         ▼                       ▼
    Value Types           Reference Types
         │                       │
 ┌───────┼────────┐      ┌────────┼─────────┐
 ▼       ▼        ▼      ▼        ▼         ▼
uint    int     bool   string   bytes    array
         │
         ▼
      address
         │
         ▼
      bytes32
```

---

# 🧠 60-Second Revision

| Topic              | One-Line Summary                               |
| ------------------ | ---------------------------------------------- |
| 🧩 Data Types      | Define what kind of data a variable stores.    |
| 🔢 uint            | Stores positive integers.                      |
| ➖ int             | Stores positive and negative integers.         |
| ✅ bool            | Stores `true` or `false`.                      |
| 🏠 address         | Stores Ethereum account or contract addresses. |
| 📝 string          | Stores text.                                   |
| 📦 bytes           | Dynamic byte array.                            |
| 📦 bytes32         | Fixed-size 32-byte value.                      |
| 💎 Value Types     | Store actual values directly.                  |
| 📚 Reference Types | Store references to data.                      |

---

# 🎯 Golden Rules

- 🧩 Every variable has a data type.
- 🔢 `uint` stores only positive whole numbers.
- ➖ `int` stores both positive and negative numbers.
- ✅ `bool` stores only `true` or `false`.
- 🏠 `address` stores Ethereum addresses.
- 📝 `string` stores text.
- 📦 `bytes32` is ideal for hashes.
- 💎 Value types are copied.
- 📚 Reference types require `memory`, `storage`, or `calldata`.

---

# 💼 Solidity Data Types — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity data type interview questions.

---

## Q1. What are data types in Solidity?

**Answer:**

Data types define the type of value a variable can store, such as numbers, addresses, text, or boolean values.

---

## Q2. What are the two categories of data types?

**Answer:**

- Value Types
- Reference Types

---

## Q3. What is an unsigned integer?

**Answer:**

An unsigned integer (`uint`) stores only non-negative whole numbers, including zero.

---

## Q4. What is a signed integer?

**Answer:**

A signed integer (`int`) stores both positive and negative whole numbers.

---

## Q5. What is the difference between `uint` and `int`?

**Answer:**

- `uint` stores only non-negative values.
- `int` stores both negative and positive values.

---

## Q6. What is a Boolean?

**Answer:**

A Boolean stores one of two values: `true` or `false`.

---

## Q7. What is an address?

**Answer:**

An `address` stores the 20-byte identifier of an Ethereum account or smart contract.

---

## Q8. What is the difference between `bytes` and `bytes32`?

**Answer:**

- `bytes` is a dynamic byte array.
- `bytes32` stores exactly 32 bytes and is more gas-efficient for fixed-size data.

---

## Q9. Why is `bytes32` commonly used?

**Answer:**

It is commonly used to store hashes, identifiers, and fixed-length binary data efficiently.

---

## Q10. What are value types?

**Answer:**

Value types store their data directly. Assigning them to another variable creates an independent copy.

---

## Q11. What are reference types?

**Answer:**

Reference types store references to data and require a data location such as `memory`, `storage`, or `calldata`.

---

## ⚡ Rapid Fire Interview Questions

### Q12. Which data type stores only positive numbers?

`uint`

---

### Q13. Which data type stores negative numbers?

`int`

---

### Q14. Which data type stores only `true` or `false`?

`bool`

---

### Q15. How many bytes does an `address` contain?

20 bytes.

---

### Q16. Which is fixed-size: `bytes` or `bytes32`?

`bytes32`

---

### Q17. Is `string` a value type?

No. It is a reference type.

---

### Q18. Are value types copied?

Yes.

---

### Q19. Do reference types require a data location?

Yes.

---

### Q20. Which data type is commonly used to store a hash?

`bytes32`

---

# 🎯 Interview Tips

- Always begin by defining **data types** before discussing individual types.
- Clearly distinguish **`uint`** (non-negative) from **`int`** (positive and negative).
- Remember that **`address`** is always **20 bytes (160 bits)**.
- Explain why **`bytes32`** is preferred for hashes and fixed-size binary data.
- Don't confuse **value types** (copied by value) with **reference types** (referenced by location).
- Know that reference types require a data location: **`storage`**, **`memory`**, or **`calldata`**.
