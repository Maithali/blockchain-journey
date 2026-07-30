# 🗂️ Mappings in Solidity — One Page Revision

> 🎯 **Goal:** Learn what mappings are, their syntax, how to add and read values, understand default values, advantages, limitations, and practice with Solidity examples. Mappings are one of the most important data structures in Solidity and are widely used in ERC-20 tokens, NFTs, DeFi, and smart contracts.

---

# 🗂️ 1. What is a Mapping?

## 📌 Definition

A **Mapping** is a **key-value data structure** that stores values associated with unique keys.

Each key maps to exactly one value.

It is similar to a **dictionary**, **hash table**, or **Map** in other programming languages.

---

## 🧒 Explain Like I'm 10

Imagine a school attendance register.

```text
Roll No.      Student

101      →    Alice

102      →    Bob

103      →    Charlie
```

Here,

- Roll Number = Key
- Student Name = Value

This is exactly how a mapping works.

---

## Real-Life Examples

```text
Bank Account Number

↓

Account Balance

------------------------

Wallet Address

↓

Token Balance

------------------------

Student ID

↓

Student Name
```

---

## 💡 Remember

> **Mapping = Key → Value Pair**

---

# 🔤 2. Mapping Syntax

## 📌 Syntax

```solidity
mapping(KeyType => ValueType) visibility variableName;
```

---

## Example

```solidity
mapping(address => uint) public balances;
```

Meaning

```text
Wallet Address

↓

Balance
```

---

## Another Example

```solidity
mapping(uint => string) public students;
```

Meaning

```text
Student ID

↓

Student Name
```

---

## 💡 Remember

> **mapping(Key => Value)**

---

# ➕ 3. Adding Values to a Mapping

Values are added simply by assigning them using a key.

---

## Example

```solidity
balances[msg.sender] = 100;
```

---

## Another Example

```solidity
students[101] = "Alice";

students[102] = "Bob";
```

---

## Representation

```text
Key          Value

101      →   Alice

102      →   Bob
```

---

## 💡 Remember

> **mapping[key] = value;**

---

# 📖 4. Reading Values from a Mapping

Use the key to retrieve the value.

---

## Example

```solidity
uint balance = balances[msg.sender];
```

---

## Another Example

```solidity
string memory name = students[101];
```

---

## Representation

```text
students[101]

↓

Alice
```

---

## 💡 Remember

> **mapping[key] returns value**

---

# 🎯 5. Default Values

Mappings always return a default value if a key has never been assigned.

---

## Examples

### uint

```text
0
```

---

### bool

```text
false
```

---

### address

```text
0x0000000000000000000000000000000000000000
```

---

### string

```text
""
```

---

## Example

```solidity
mapping(address => uint) public balances;
```

If a user never deposits,

```solidity
balances[msg.sender]
```

returns

```text
0
```

---

## 💡 Remember

> **Uninitialized Keys Return Default Values**

---

# ⭐ 6. Advantages of Mappings

## Fast Lookup

Searching is very efficient.

```text
Address

↓

Balance
```

No looping required.

---

## Gas Efficient

Reading and writing values is efficient compared to searching arrays.

---

## Unique Keys

Each key has exactly one value.

---

## Scalable

Can store millions of entries efficiently.

---

## Common Use Cases

- Token balances
- Ownership records
- Voting systems
- Student databases
- NFT ownership
- Bank accounts

---

## 💡 Remember

> **Mappings are ideal for fast lookups.**

---

# ⚠️ 7. Limitations of Mappings

## Cannot Iterate

You cannot loop through all keys because mappings do not store a list of keys.

---

## No Length

Mappings do not have a `.length` property.

---

## No Ordering

Keys are not stored in any particular order.

---

## No Push/Pop

Mappings do not support array operations like:

```solidity
push()

pop()
```

---

## Cannot Return All Keys

You need a separate array if you want to keep track of every key.

---

## 💡 Remember

> **Mappings store values, not a list of keys.**

---

# 🧩 8. Example 1 – Student Registry

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistry {

    mapping(uint => string) public students;

    function addStudent(
        uint _id,
        string memory _name
    ) public {

        students[_id] = _name;

    }

}
```

### Usage

```text
addStudent(101, "Alice")

↓

students[101]

↓

Alice
```

### Explanation

- Key = Student ID
- Value = Student Name

---

# 🧩 9. Example 2 – Wallet Balances

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {

    mapping(address => uint) public balances;

    function deposit() public payable {

        balances[msg.sender] += msg.value;

    }

    function getBalance()
        public
        view
        returns(uint)
    {

        return balances[msg.sender];

    }

}
```

### Explanation

- Each wallet address is the key.
- The deposited Ether amount is stored as the value.
- `msg.sender` ensures every user has a separate balance.

---

# 🧩 10. Example 3 – Voting System

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    mapping(address => bool) public hasVoted;

    function vote() public {

        require(
            !hasVoted[msg.sender],
            "Already voted"
        );

        hasVoted[msg.sender] = true;

    }

}
```

### Explanation

- Key = Voter's wallet address
- Value = `true` or `false`
- Prevents the same address from voting more than once.

---

# ⚖️ Mapping vs Array

| Feature      | Mapping             | Array                 |
| ------------ | ------------------- | --------------------- |
| Access       | By Key              | By Index              |
| Lookup Speed | Very Fast           | Slower (for searches) |
| Ordering     | None                | Ordered               |
| Length       | ❌ Not Available    | ✅ Available          |
| Iteration    | ❌ Not Possible     | ✅ Possible           |
| Common Use   | Balances, Ownership | Lists, Collections    |

---

# 🔄 Complete Concept Flow

```text
                Mapping
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
        Key                Value
          │                   │
          └─────────┬─────────┘
                    ▼
            Add / Read Values
                    │
                    ▼
          Default Values
                    │
                    ▼
      Fast Lookup & Storage
```

---

# 🧠 60-Second Revision

| Topic            | One-Line Summary                                    |
| ---------------- | --------------------------------------------------- |
| 🗂️ Mapping       | Stores data as key-value pairs.                     |
| 🔤 Syntax        | `mapping(KeyType => ValueType)`                     |
| ➕ Add Value     | `mapping[key] = value;`                             |
| 📖 Read Value    | `mapping[key]`                                      |
| 🎯 Default Value | Returns type-specific default if key doesn't exist. |
| ⭐ Advantages    | Fast lookup, scalable, gas efficient.               |
| ⚠️ Limitations   | No iteration, no length, no ordering.               |

---

# 🎯 Golden Rules

- 🗂️ A mapping stores **key-value pairs**.
- 🔑 Every key maps to one value.
- 📖 Reading an unknown key returns the **default value**.
- ⚡ Mappings provide **constant-time lookups** (conceptually O(1)).
- 🚫 Mappings cannot be iterated directly.
- 📏 Mappings do not have a `.length` property.
- 📋 Use an additional array if you need to list all keys.
- 🌍 Mappings are heavily used in ERC-20, ERC-721, DeFi, and DAO contracts.

---

# 💼 Solidity Mappings — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity mapping interview questions.

---

## Q1. What is a mapping in Solidity?

**Answer:**

A mapping is a key-value data structure that associates unique keys with corresponding values for efficient storage and retrieval.

---

## Q2. What is the syntax of a mapping?

**Answer:**

```solidity
mapping(KeyType => ValueType) public variableName;
```

Example:

```solidity
mapping(address => uint) public balances;
```

---

## Q3. How do you add a value to a mapping?

**Answer:**

Assign a value using a key.

```solidity
balances[msg.sender] = 100;
```

---

## Q4. How do you read a value from a mapping?

**Answer:**

Access the value using its key.

```solidity
uint balance = balances[msg.sender];
```

---

## Q5. What happens if a key doesn't exist?

**Answer:**

The mapping returns the default value for the value type.

Examples:

- `uint` → `0`
- `bool` → `false`
- `address` → `0x000...000`
- `string` → `""`

---

## Q6. Can mappings be iterated?

**Answer:**

No. Solidity mappings do not store a list of keys, so they cannot be iterated directly.

---

## Q7. Do mappings have a `length` property?

**Answer:**

No.

---

## Q8. Why are mappings gas efficient?

**Answer:**

Mappings provide direct access to values using keys without searching through a collection.

---

## Q9. Can mappings use different key types?

**Answer:**

Yes. Common key types include `address`, `uint`, and `bytes32` (not reference types like `string` as keys in typical usage).

---

## Q10. Where are mappings commonly used?

**Answer:**

- ERC-20 token balances
- NFT ownership
- Voting systems
- User records
- Bank accounts
- Access control

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which operator defines a mapping?

`=>`

---

### Q12. What does a mapping store?

Key-value pairs.

---

### Q13. Can mappings have duplicate keys?

No. Each key maps to a single current value.

---

### Q14. What happens when you assign a new value to an existing key?

The previous value is overwritten.

---

### Q15. Can mappings be nested?

Yes.

Example:

```solidity
mapping(address => mapping(address => uint)) public allowance;
```

---

### Q16. Do mappings preserve insertion order?

No.

---

### Q17. Can mappings be looped through directly?

No.

---

### Q18. Which data structure is better for balances?

Mapping.

---

### Q19. What is the default value of `mapping(address => bool)`?

`false`

---

### Q20. Why are mappings heavily used in smart contracts?

Because they provide fast, efficient key-based access and scale well.

---

# 🎯 Interview Tips

- Start with: **"A mapping is a key-value data structure used for efficient storage and retrieval."**
- Explain mappings using a real-world example such as **wallet balances** or **student records**.
- Remember that **reading a non-existent key returns a default value**, not an error.
- Don't forget the major limitation: **mappings cannot be iterated because they don't store keys**.
- Mention that mappings are the foundation of standards like **ERC-20** (`balances`) and **ERC-721** (`ownerOf`-related storage).

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BalanceMapping {

   mapping(address => uint) public balances;

   function setbalance(uint _amount) public {
    balances[msg.sender]=_amount;
   }

   function getMyBalance() public  view  returns (uint) {
    return balances[msg.sender];
   }

}



----------------------------------------------------------------------------------------------

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProductRegistry {

    mapping(uint => string) public products;

    function addProducts(uint id, string memory name) public {
        products[id]=name;
    }

    function getProducts(uint id) public view returns(string memory){
        return products[id];
    }


}

```
