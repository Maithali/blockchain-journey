# 🛡️ Function Modifiers in Solidity — One Page Revision

> 🎯 **Goal:** Learn what Function Modifiers are, why they are used, understand modifier syntax, compare code **with and without modifiers**, know when to use them, and practice with Solidity examples. Function modifiers are widely used in production smart contracts for **access control, validation, and code reusability**.

---

# 🛡️ 1. What is a Function Modifier?

## 📌 Definition

A **Function Modifier** is a special piece of reusable code that **executes before and/or after a function** to check certain conditions.

Instead of writing the same validation code inside multiple functions, we write it once in a modifier and reuse it.

A modifier can:

- Validate conditions
- Restrict access
- Reduce code duplication
- Improve readability

---

## 🧒 Explain Like I'm 10

Imagine a school classroom.

Before entering,

the teacher checks:

```text
Are you wearing your ID Card?

↓

Yes

↓

Enter Class

-----------------------

No

↓

Entry Denied
```

Instead of every teacher checking IDs separately,

there is **one security guard**.

That security guard is like a **modifier**.

---

## Flow

```text
User Calls Function

↓

Modifier Checks Condition

↓

Condition True?

│

├── Yes

│      ↓

│   Execute Function

│

└── No

       ↓

Transaction Reverted
```

---

## 💡 Remember

> **Modifier = Reusable Validation Before Function Execution**

---

# ❓ 2. Why Do We Use Modifiers?

Without modifiers,

we write the same validation repeatedly.

Example

```solidity
require(msg.sender == owner);

...

require(msg.sender == owner);

...

require(msg.sender == owner);
```

This creates:

- Duplicate code
- Poor readability
- Difficult maintenance

Modifiers solve this problem.

---

## Benefits

- Code Reusability
- Better Readability
- Easy Maintenance
- Consistent Security
- Less Repetition

---

## 💡 Remember

> **Write Once → Use Many Times**

---

# ⚖️ 3. Without Modifier vs With Modifier

---

## ❌ Without Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {

    address public owner;

    constructor() {

        owner = msg.sender;

    }

    function withdraw() public {

        require(
            msg.sender == owner,
            "Not Owner"
        );

        // Withdraw Logic

    }

    function changeOwner(address _newOwner) public {

        require(
            msg.sender == owner,
            "Not Owner"
        );

        owner = _newOwner;

    }

}
```

### Problem

The same `require()` statement is repeated in every function.

---

## ✅ With Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {

    address public owner;

    constructor() {

        owner = msg.sender;

    }

    modifier onlyOwner() {

        require(
            msg.sender == owner,
            "Not Owner"
        );

        _;

    }

    function withdraw()
        public
        onlyOwner
    {

        // Withdraw Logic

    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
    {

        owner = _newOwner;

    }

}
```

---

## Why Better?

```text
Validation

↓

Modifier

↓

Reuse Everywhere
```

---

## 💡 Remember

> **Modifiers remove duplicate validation code.**

---

# 🏗️ 4. Modifier Syntax

## 📌 Syntax

```solidity
modifier modifierName() {

    // Validation

    _;

}
```

---

### Using Modifier

```solidity
function withdraw()
    public
    modifierName
{

}
```

---

## What is `_` ?

The underscore (`_`) is a **placeholder**.

It tells Solidity:

> **"Execute the function body here."**

---

## Flow

```text
Modifier Starts

↓

Validation

↓

_

↓

Function Executes

↓

Modifier Ends
```

---

## 💡 Remember

> **`_` = Function Execution Point**

---

# 🔍 5. How a Modifier Works

Example

```solidity
modifier onlyOwner(){

    require(
        msg.sender == owner
    );

    _;

}
```

Function

```solidity
function withdraw()
    public
    onlyOwner
{

    balance = 0;

}
```

Execution

```text
Call withdraw()

↓

onlyOwner()

↓

require()

↓

Pass?

↓

Yes

↓

balance = 0
```

---

# ⭐ 6. Advantages of Modifiers

## Code Reusability

One modifier can be used by many functions.

---

## Better Readability

Instead of reading multiple `require()` statements,

developers immediately understand

```solidity
onlyOwner
```

---

## Improved Security

Access control becomes consistent.

---

## Easy Maintenance

Update the validation once.

Every function automatically uses the updated logic.

---

## Lower Chance of Bugs

No repeated validation code.

---

## 💡 Remember

> **Modifiers make contracts cleaner, safer, and easier to maintain.**

---

# 🎯 7. When to Use Modifiers?

Use modifiers whenever the **same validation logic** is needed in multiple functions.

---

## Common Uses

### 🔐 Access Control

```text
Only Owner
```

---

### 👤 Admin Access

```text
Only Admin
```

---

### 💰 Balance Checking

```text
Enough Balance
```

---

### 🗳️ Voting

```text
Voting Open
```

---

### ⏰ Time Restrictions

```text
Only Before Deadline
```

---

### 🎓 Student Admission

```text
Only Verified Students
```

---

## 💡 Remember

> **Use Modifiers for Repeated Conditions**

---

# 🧩 Example 1 – Only Owner Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {

    address public owner;

    constructor() {

        owner = msg.sender;

    }

    modifier onlyOwner() {

        require(
            msg.sender == owner,
            "Only owner can call"
        );

        _;

    }

    function withdraw()
        public
        onlyOwner
    {

        // Withdraw Logic

    }

}
```

### Explanation

If anyone except the owner calls `withdraw()`,

the transaction reverts.

---

# 🧩 Example 2 – Minimum Age Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    modifier eligible(uint age) {

        require(
            age >= 18,
            "Not Eligible"
        );

        _;

    }

    function vote(uint age)
        public
        eligible(age)
    {

        // Voting Logic

    }

}
```

### Explanation

The modifier checks age before allowing voting.

---

# 🧩 Example 3 – Minimum Balance Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {

    uint public balance = 1000;

    modifier sufficientBalance(uint amount) {

        require(
            amount <= balance,
            "Insufficient Balance"
        );

        _;

    }

    function withdraw(uint amount)
        public
        sufficientBalance(amount)
    {

        balance -= amount;

    }

}
```

### Explanation

Withdrawal only happens if sufficient balance exists.

---

# 🧩 Example 4 – Time-Based Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Auction {

    uint public endTime = block.timestamp + 1 days;

    modifier auctionOpen() {

        require(
            block.timestamp < endTime,
            "Auction Ended"
        );

        _;

    }

    function bid()
        public
        auctionOpen
    {

        // Bidding Logic

    }

}
```

### Explanation

Bids are accepted only before the auction deadline.

---

# ⚖️ Modifier vs Function

| Feature         | Modifier                   | Function             |
| --------------- | -------------------------- | -------------------- |
| Purpose         | Validate conditions        | Perform operations   |
| Returns Value   | ❌ No                      | ✅ Can return values |
| Uses `_`        | ✅ Yes                     | ❌ No                |
| Called Directly | ❌ No                      | ✅ Yes               |
| Reusable        | ✅ Yes                     | ✅ Yes               |
| Typical Use     | Access control, validation | Business logic       |

---

# 🔄 Complete Concept Flow

```text
             User Calls Function
                     │
                     ▼
              Function Modifier
                     │
             Validate Condition
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Condition True      Condition False
          │                     │
          ▼                     ▼
    Execute Function      Revert Transaction
```

---

# 🧠 60-Second Revision

| Topic         | One-Line Summary                                       |
| ------------- | ------------------------------------------------------ |
| 🛡️ Modifier   | Reusable validation before function execution.         |
| ❓ Why Use    | Reduce duplicate validation code.                      |
| 🏗️ Syntax     | `modifier name(){ ... _; }`                            |
| 🔍 `_`        | Marks where the function body executes.                |
| ⭐ Advantages | Cleaner, reusable, secure, maintainable.               |
| 🎯 Common Use | Access control, balance checks, age checks, deadlines. |

---

# 🎯 Golden Rules

- 🛡️ A modifier contains **reusable validation logic**.
- 🏗️ Define it using the `modifier` keyword.
- 🔍 The `_` symbol indicates where the function body runs.
- 🔐 Use modifiers for access control (`onlyOwner`, `onlyAdmin`).
- 📋 Avoid repeating the same `require()` in multiple functions.
- 🚀 Modifiers improve readability and maintainability.
- ⚠️ Keep modifiers simple—complex business logic is usually better placed in functions.

---

# 💼 Solidity Function Modifiers — Interview Questions & Answers

## Q1. What is a function modifier?

**Answer:**

A function modifier is reusable code that executes before and/or after a function to validate conditions or restrict access.

---

## Q2. Why do we use modifiers?

**Answer:**

To eliminate duplicate validation code, improve readability, enhance security, and simplify maintenance.

---

## Q3. How do you declare a modifier?

**Answer:**

```solidity
modifier onlyOwner() {

    require(
        msg.sender == owner,
        "Not Owner"
    );

    _;

}
```

---

## Q4. What does `_` mean inside a modifier?

**Answer:**

It marks the position where the modified function's body is executed.

---

## Q5. Can one modifier be used by multiple functions?

**Answer:**

Yes.

That is the main purpose of modifiers.

---

## Q6. Can a modifier accept parameters?

**Answer:**

Yes.

Example:

```solidity
modifier minimumAge(uint age) {

    require(age >= 18);

    _;

}
```

---

## Q7. What happens if the modifier condition fails?

**Answer:**

The transaction reverts, the function body is not executed, and state changes are rolled back.

---

## Q8. Can multiple modifiers be applied to one function?

**Answer:**

Yes.

Example:

```solidity
function withdraw()
    public
    onlyOwner
    whenNotPaused
{
}
```

Modifiers execute in the order they are listed.

---

## Q9. What is the most common modifier in Solidity?

**Answer:**

`onlyOwner`

Used for access control.

---

## Q10. Are modifiers inherited?

**Answer:**

Yes.

Child contracts can inherit and use modifiers from parent contracts (subject to Solidity's inheritance rules).

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword creates a modifier?

`modifier`

---

### Q12. Which symbol represents the function body inside a modifier?

`_`

---

### Q13. Can modifiers return values?

No.

---

### Q14. Are modifiers mainly used for validation?

Yes.

---

### Q15. Can modifiers have parameters?

Yes.

---

### Q16. Can a function use more than one modifier?

Yes.

---

### Q17. Which modifier is commonly used in OpenZeppelin's `Ownable` contract?

`onlyOwner`

---

### Q18. Do modifiers improve code readability?

Yes.

---

### Q19. Can modifiers contain `require()` statements?

Yes.

---

### Q20. What is the biggest advantage of modifiers?

Reusability of validation logic.

---

# 🎯 Interview Tips

- Start with: **"A function modifier is reusable validation code that runs before and/or after a function."**
- Explain the purpose of the `_` symbol clearly.
- Compare **without modifier** vs **with modifier** to show why modifiers reduce repetition.
- Mention common production examples:
  - `onlyOwner`
  - `onlyAdmin`
  - `whenNotPaused`
  - `nonReentrant`
- Remember that modifiers are intended for **validation and access control**, while the main business logic belongs inside functions.
