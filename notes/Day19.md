# 🚨 Error Handling in Solidity — One Page Revision

> 🎯 **Goal:** Learn why error handling is important, understand `require()`, `revert()`, and `assert()`, know when and why to use each, compare them, and practice with Solidity examples. Error handling is one of the **most frequently asked Solidity interview topics**.

---

# 🚨 1. What is Error Handling?

## 📌 Definition

**Error Handling** is the process of **detecting invalid conditions and stopping a transaction safely** before incorrect data is stored on the blockchain.

If an error occurs:

- ❌ Transaction stops
- ❌ State changes are reverted
- ⛽ Remaining gas is refunded (except gas already spent)
- 📢 Error message is returned (if provided)

---

## 🧒 Explain Like I'm 10

Imagine an ATM.

You want to withdraw ₹5000.

But your balance is only ₹1000.

Instead of giving negative money,

the ATM displays:

```text
❌ Insufficient Balance
```

and cancels the transaction.

Solidity works the same way.

---

## Flow

```text
User Calls Function

↓

Check Conditions

↓

Valid?

├── Yes → Execute Function
│
└── No → Revert Transaction
```

---

## 💡 Remember

> **Error Handling = Stop Invalid Transactions Before They Change the Blockchain**

---

# ❓ 2. Why Do We Need Error Handling?

Without error handling,

- Invalid transactions would execute.
- Funds could be lost.
- Smart contracts could enter invalid states.
- Security vulnerabilities would increase.

---

## Example

Without checking balance:

```text
Balance = 100

Withdraw = 200

↓

Balance = -100 ❌
```

With error handling:

```text
Balance = 100

Withdraw = 200

↓

❌ Transaction Reverted
```

---

## Benefits

- Prevent invalid transactions
- Protect user funds
- Maintain contract integrity
- Improve security
- Save gas by stopping execution early

---

## 💡 Remember

> **Error Handling Protects the Smart Contract**

---

# ⚠️ 3. `require()`

## 📌 Definition

`require()` checks **conditions that depend on user input, function parameters, permissions, or contract state**.

If the condition is **false**:

- Transaction reverts
- Remaining gas is refunded
- Custom error message is returned

---

## Syntax

```solidity
require(condition, "Error Message");
```

---

## Flow

```text
Condition True?

↓

Yes

↓

Continue Execution

----------------------

Condition False

↓

Revert Transaction

↓

Show Error Message
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AgeVerification {

    function checkAge(uint age)
        public
        pure
        returns(string memory)
    {

        require(age >= 18, "Age must be 18 or above");

        return "Eligible";

    }

}
```

---

### Execution

```text
Input

20

↓

Eligible
```

```text
Input

15

↓

Transaction Reverted

↓

Age must be 18 or above
```

---

## Common Uses

- Validate user input
- Check permissions
- Verify balances
- Validate addresses
- Check contract state

---

## 💡 Remember

> **require() = Check External Conditions Before Continuing**

---

# 🔄 4. `revert()`

## 📌 Definition

`revert()` manually stops execution when a condition inside an `if` statement is met.

Unlike `require()`, it allows more complex decision-making before reverting.

---

## Syntax

```solidity
if(condition){

    revert("Error Message");

}
```

---

## Flow

```text
Execute Code

↓

Condition True?

↓

Yes

↓

Revert

↓

Error Message
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Marks {

    function checkMarks(uint marks)
        public
        pure
        returns(string memory)
    {

        if(marks < 35){

            revert("Student Failed");

        }

        return "Student Passed";

    }

}
```

---

### Execution

```text
Marks = 80

↓

Student Passed
```

```text
Marks = 20

↓

Student Failed
```

---

## Common Uses

- Complex conditions
- Multiple nested checks
- Business logic validation
- Conditional execution

---

## 💡 Remember

> **revert() = Manually Stop Execution When Needed**

---

# 🛑 5. `assert()`

## 📌 Definition

`assert()` is used to check **internal errors** and **conditions that should never be false**.

It is mainly used to verify contract correctness and detect programming bugs.

If an assertion fails,

the transaction reverts because something unexpected has happened.

---

## Syntax

```solidity
assert(condition);
```

---

## Flow

```text
Internal Check

↓

True

↓

Continue

------------------

False

↓

Bug Detected

↓

Transaction Reverted
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssertDemo {

    uint public total = 100;

    function checkTotal()
        public
        view
    {

        assert(total == 100);

    }

}
```

---

### Explanation

Initially,

```text
total = 100

↓

Assertion Passes
```

If a programming error changes `total` unexpectedly,

```text
total = 50

↓

assert(total == 100)

↓

Transaction Reverted
```

---

## Common Uses

- Check internal invariants
- Detect programming bugs
- Verify impossible conditions
- Validate internal logic

---

## 💡 Remember

> **assert() = Check Internal Bugs and Invariants**

---

# 📊 6. `require()` vs `revert()` vs `assert()`

| Feature | `require()` | `revert()` | `assert()` |
|----------|-------------|------------|------------|
| Purpose | Validate external input and conditions | Manually stop execution | Check internal correctness |
| Error Message | ✅ Yes | ✅ Yes | ❌ Usually No custom message |
| Used For | User input, permissions, balances | Complex business logic | Bugs, invariants |
| Condition Style | Direct condition | Usually inside `if` | Internal condition |
| Typical Cause | User error | Business rule failure | Programming error |
| Recommended Usage | ⭐ Most Common | Common | Rare |

---

# 🧩 Example 1 – Bank Withdrawal (`require()`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {

    uint public balance = 1000;

    function withdraw(uint amount) public {

        require(
            amount <= balance,
            "Insufficient Balance"
        );

        balance -= amount;

    }

}
```

### Explanation

If balance is sufficient,

withdrawal succeeds.

Otherwise,

the transaction reverts.

---

# 🧩 Example 2 – Voting (`revert()`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    bool public votingOpen = false;

    function vote() public {

        if(!votingOpen){

            revert("Voting has not started");

        }

    }

}
```

### Explanation

The function checks a business rule.

If voting is closed,

execution is stopped using `revert()`.

---

# 🧩 Example 3 – Token Supply (`assert()`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {

    uint public totalSupply = 1000;

    function verifySupply() public view {

        assert(totalSupply == 1000);

    }

}
```

### Explanation

The total supply should always remain correct.

If it changes unexpectedly due to a bug,

`assert()` detects it.

---

# 🚀 Best Practices

## ✅ Use `require()` For

- User input validation
- Balance checks
- Access control
- Address validation
- Preconditions

---

## ✅ Use `revert()` For

- Complex conditions
- Multiple checks
- Business logic

---

## ✅ Use `assert()` For

- Internal consistency
- Impossible conditions
- Detecting bugs

---

# 🔄 Complete Concept Flow

```text
             Function Call
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
   External Check      Internal Check
          │                   │
      require()          assert()
          │
          ▼
   Complex Business Logic
          │
       revert()
          │
          ▼
 Transaction Reverted Safely
```

---

# 🧠 60-Second Revision

| Topic | One-Line Summary |
|--------|------------------|
| 🚨 Error Handling | Prevents invalid transactions and protects contract state. |
| ⚠️ `require()` | Checks user input, permissions, balances, and preconditions. |
| 🔄 `revert()` | Manually stops execution for complex business logic. |
| 🛑 `assert()` | Checks internal correctness and programming bugs. |
| 📊 Comparison | `require` → external checks, `revert` → business logic, `assert` → internal invariants. |

---

# 🎯 Golden Rules

- 🚨 Always validate user input before changing state.
- ⚠️ Use **`require()`** for **preconditions** (input, permissions, balances).
- 🔄 Use **`revert()`** when conditional logic becomes complex.
- 🛑 Use **`assert()`** only for **internal errors and invariants**.
- 🔒 Never use `assert()` to validate user input.
- ⛽ Failing early avoids unnecessary computation and wasted gas.

---

# 💼 Solidity Error Handling — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity error handling interview questions.

---

## Q1. What is error handling in Solidity?

**Answer:**

Error handling prevents invalid transactions by checking conditions and reverting the transaction if necessary, ensuring the contract remains in a valid state.

---

## Q2. Why is error handling important?

**Answer:**

It:

- Prevents invalid state changes
- Protects user funds
- Improves security
- Maintains contract integrity

---

## Q3. What is `require()`?

**Answer:**

`require()` validates **external conditions** such as user input, permissions, balances, and contract state before execution continues.

Example:

```solidity
require(msg.sender == owner, "Not owner");
```

---

## Q4. What is `revert()`?

**Answer:**

`revert()` manually stops execution when a specific condition is met, usually after more complex logic.

Example:

```solidity
if(balance < amount){

    revert("Insufficient balance");

}
```

---

## Q5. What is `assert()`?

**Answer:**

`assert()` checks **internal invariants** and conditions that should never fail. It is mainly used to detect programming bugs.

---

## Q6. Which one should be used for user input validation?

**Answer:**

`require()`.

---

## Q7. Which one is used for internal bugs?

**Answer:**

`assert()`.

---

## Q8. Can `revert()` return an error message?

**Answer:**

Yes.

```solidity
revert("Transaction failed");
```

---

## Q9. What happens when any of these fail?

**Answer:**

- Execution stops.
- State changes are reverted.
- An error is returned.
- Remaining gas is refunded (except gas already consumed).

---

## Q10. Which error handling method is used most often?

**Answer:**

`require()`.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which function validates user input?

`require()`

---

### Q12. Which function detects programming bugs?

`assert()`

---

### Q13. Which function is commonly used inside an `if` statement?

`revert()`

---

### Q14. Which is best for access control?

`require()`

---

### Q15. Which is best for balance checking?

`require()`

---

### Q16. Should `assert()` be used for user input?

No.

---

### Q17. Can `revert()` be called without `if`?

Yes, although it is most commonly used inside conditional logic.

---

### Q18. Do failed checks modify the blockchain state?

No. The transaction is reverted.

---

### Q19. Which is more readable for simple precondition checks: `require()` or `revert()`?

`require()`.

---

### Q20. What is the safest pattern?

Validate inputs with `require()`, implement complex business rules with `revert()` when needed, and reserve `assert()` for internal invariants.

---

# 🎯 Interview Tips

- Start with: **"Error handling prevents invalid transactions and keeps the smart contract in a valid state."**
- Remember the simple rule:
  - **`require()` → Preconditions and user-controlled input**
  - **`revert()` → Complex business logic**
  - **`assert()` → Internal bugs and invariants**
- Explain **why** each exists:
  - `require()` protects against bad external input.
  - `revert()` gives flexibility for conditional failures.
  - `assert()` catches errors that should never happen in correct code.
- In modern Solidity, prefer **custom errors** for gas-efficient error handling in production contracts when appropriate, though `require()`, `revert()`, and `assert()` remain fundamental concepts for learning and interviews.