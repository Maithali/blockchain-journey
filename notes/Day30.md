# 🛡️ Solidity Security Fundamentals — One Page Revision

> 🎯 **Goal:** Understand the most important Solidity smart-contract security vulnerabilities and learn the basic patterns used to write safer contracts.

---

# 🛡️ 1. What Are Smart Contract Vulnerabilities?

## 📌 Definition

A **smart contract vulnerability** is a weakness or mistake in a smart contract that an attacker can exploit to:

- 💰 Steal funds
- 🔓 Bypass authorization
- ✏️ Modify unauthorized data
- 🔄 Execute unintended logic
- 🚫 Deny service
- 📉 Manipulate contract behavior

Unlike traditional applications, smart contracts often manage **real assets on a public blockchain**, so security mistakes can be extremely costly.

---

## 🧠 Common Vulnerabilities

```text
              Smart Contract Security
                       │
       ┌───────────────┼────────────────┐
       ▼               ▼                ▼
   Reentrancy     Access Control    Input Validation
       │               │                │
       ▼               ▼                ▼
 External Calls    tx.origin       Bad Parameters
       │
       └───────────────┬────────────────┘
                       ▼
                Integer Errors
                       │
                       ▼
                Unsafe Logic
```

---

# 🔄 2. Reentrancy Attack

## 📌 What is Reentrancy?

A **reentrancy attack** happens when a contract makes an external call before updating its internal state, allowing the called contract to call back into the vulnerable function again.

The attacker repeatedly enters the function before the original execution finishes.

---

# 💥 Vulnerable Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableBank {

    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {

        require(
            balances[msg.sender] >= amount,
            "Insufficient balance"
        );

        // ❌ External call happens first
        (bool success, ) = payable(msg.sender).call{
            value: amount
        }("");

        require(success, "Transfer failed");

        // ❌ State updated after external call
        balances[msg.sender] -= amount;
    }
}
```

---

# 🔥 How the Attack Works

Suppose:

```text
Attacker deposits = 1 ETH
```

The attacker calls:

```solidity
withdraw(1 ether)
```

The vulnerable contract sends the Ether:

```text
Bank
 │
 │ 1 ETH
 ▼
Attacker Contract
```

The attacker's fallback/receive function can call:

```text
withdraw(1 ETH)
```

again **before the original withdrawal has reduced the attacker's recorded balance**.

---

## 🔄 Reentrancy Flow

```text
Attacker
   │
   │ withdraw()
   ▼
Bank
   │
   │ send ETH
   ▼
Attacker Contract
   │
   │ calls withdraw() again
   ▼
Bank
   │
   │ send ETH again
   ▼
Attacker Contract
   │
   └───────► repeats
```

---

# 🛡️ 3. Checks-Effects-Interactions

One of the most important Solidity security patterns is:

```text
CHECKS
   ↓
EFFECTS
   ↓
INTERACTIONS
```

---

## ① Checks

Validate conditions first.

```solidity
require(
    balances[msg.sender] >= amount,
    "Insufficient balance"
);
```

---

## ② Effects

Update contract state.

```solidity
balances[msg.sender] -= amount;
```

---

## ③ Interactions

Only then make the external call.

```solidity
(bool success, ) = payable(msg.sender).call{
    value: amount
}("");

require(success, "Transfer failed");
```

---

# ✅ Safer Version

```solidity
function withdraw(uint256 amount) external {

    // CHECK
    require(
        balances[msg.sender] >= amount,
        "Insufficient balance"
    );

    // EFFECT
    balances[msg.sender] -= amount;

    // INTERACTION
    (bool success, ) = payable(msg.sender).call{
        value: amount
    }("");

    require(success, "Transfer failed");
}
```

---

# 🧠 Remember

> **Check → Update → Interact**

Never casually do:

```text
External Call
      ↓
State Update
```

Prefer:

```text
State Update
      ↓
External Call
```

---

# ⚠️ 4. Why Are External Calls Dangerous?

An external call can transfer control to code that you **do not control**.

Example:

```solidity
(bool success, ) = payable(user).call{
    value: amount
}("");
```

`user` could be:

```text
👤 EOA
```

or:

```text
🤖 Smart Contract
```

If it is a smart contract, its code can execute.

---

## External Call Flow

```text
Your Contract
      │
      │ external call
      ▼
Other Contract
      │
      ├── execute code
      ├── call your contract again
      ├── revert
      └── consume gas
```

Therefore, external calls can introduce risks such as:

- 🔄 Reentrancy
- ❌ Unexpected revert
- ⛽ Gas-related issues
- 🔀 Unexpected control flow

---

# 🛡️ Safe External Call Mindset

Whenever you see:

```solidity
call()
```

ask:

```text
❓ Who am I calling?
❓ Can that address contain code?
❓ Can it call me back?
❓ Have I updated my state first?
❓ Did I check the result?
```

---

# 🔐 5. Access-Control Vulnerabilities

## 📌 What Is Access Control?

**Access control** determines **who is allowed to perform an action**.

For example:

```text
Owner
  │
  ├── Can change settings
  ├── Can withdraw funds
  └── Can pause contract

Normal User
  │
  └── Cannot perform owner-only actions
```

---

# 💥 Vulnerable Example

```solidity
contract Bank {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAll() external {

        // ❌ No access control
        payable(msg.sender).transfer(
            address(this).balance
        );
    }
}
```

Anyone can call:

```solidity
withdrawAll()
```

---

# 🛡️ Basic Protection

```solidity
require(
    msg.sender == owner,
    "Not owner"
);
```

Example:

```solidity
function withdrawAll() external {

    require(
        msg.sender == owner,
        "Not owner"
    );

    (bool success, ) = payable(owner).call{
        value: address(this).balance
    }("");

    require(success, "Transfer failed");
}
```

---

# 🔐 6. `msg.sender` vs `tx.origin`

This is a very important interview topic.

---

## `msg.sender`

```solidity
msg.sender
```

means:

> The immediate address that called the current function.

---

## `tx.origin`

```solidity
tx.origin
```

means:

> The original externally owned account that started the entire transaction.

---

# 🔄 Example

Suppose:

```text
Alice
  │
  ▼
Contract A
  │
  ▼
Contract B
```

When Contract A calls Contract B:

Inside Contract B:

```text
msg.sender = Contract A
tx.origin  = Alice
```

---

# 📊 Comparison

| Feature                       | `msg.sender`     | `tx.origin`                       |
| ----------------------------- | ---------------- | --------------------------------- |
| Represents                    | Immediate caller | Original transaction initiator    |
| Changes during contract calls | ✅ Yes           | ❌ No                             |
| Recommended for authorization | ✅ Yes           | ❌ No                             |
| Useful for access control     | ✅               | ❌ Dangerous                      |
| Security                      | Safer            | Can enable phishing-style attacks |

---

# 🚨 Why `tx.origin` Is Dangerous

Bad pattern:

```solidity
require(
    tx.origin == owner,
    "Not owner"
);
```

An attacker contract could trick the owner into interacting with the attacker contract.

Flow:

```text
Owner
  │
  │ starts transaction
  ▼
Attacker Contract
  │
  │ calls
  ▼
Your Contract
```

Inside your contract:

```text
tx.origin  = Owner
msg.sender = Attacker Contract
```

If authorization uses:

```solidity
tx.origin == owner
```

the attacker contract may pass the check.

---

# 🧠 Golden Rule

> 🔐 **Use `msg.sender` for authorization, not `tx.origin`.**

---

# 🔢 7. Integer Overflow & Underflow

## 📌 Overflow

An **overflow** occurs when a number goes above the maximum value representable by its type.

Example concept:

```text
uint8 maximum = 255

255 + 1
   ↓
256
```

A `uint8` cannot represent 256.

---

## 📌 Underflow

An **underflow** occurs when a number goes below its minimum value.

Example:

```text
0 - 1
```

A `uint8` cannot represent a negative number.

---

# 🧠 Solidity 0.8+

Since Solidity **0.8.0**, arithmetic operations automatically check for overflow and underflow.

Example:

```solidity
uint256 balance = 0;

balance -= 1;
```

The transaction reverts instead of silently wrapping around.

---

# ⚠️ `unchecked`

Solidity allows developers to disable these checks:

```solidity
unchecked {

    balance -= amount;

}
```

This can save gas in carefully proven situations, but it removes the automatic protection.

Therefore:

> ⚠️ Use `unchecked` only when you are certain the arithmetic cannot overflow or underflow.

---

# 🛡️ 8. Why Is `require()` Important?

`require()` is used to validate conditions and stop execution when a condition is not satisfied.

Syntax:

```solidity
require(condition, "Error message");
```

Example:

```solidity
require(
    amount > 0,
    "Amount must be greater than zero"
);
```

---

# 🔐 Common Uses of `require()`

### Access Control

```solidity
require(
    msg.sender == owner,
    "Not owner"
);
```

### Balance Check

```solidity
require(
    balances[msg.sender] >= amount,
    "Insufficient balance"
);
```

### Input Validation

```solidity
require(
    amount > 0,
    "Invalid amount"
);
```

### State Validation

```solidity
require(
    !paused,
    "Contract is paused"
);
```

---

# 🔄 `require()` Flow

```text
Condition
   │
   ├── TRUE
   │    ↓
   │ Continue
   │
   └── FALSE
        ↓
      Revert
```

---

# 🎯 9. Basic Input Validation

Input validation means checking that user-provided values satisfy expected conditions.

---

## ❌ Unsafe

```solidity
function withdraw(uint256 amount) external {

    balances[msg.sender] -= amount;

}
```

What if:

```text
amount = 0
```

or:

```text
amount > user's balance
```

---

## ✅ Safer

```solidity
function withdraw(uint256 amount) external {

    require(
        amount > 0,
        "Amount must be greater than zero"
    );

    require(
        balances[msg.sender] >= amount,
        "Insufficient balance"
    );

    balances[msg.sender] -= amount;
}
```

---

# 🧠 Input Validation Checklist

Before using user input, ask:

```text
❓ Is it zero?
❓ Is it within the allowed range?
❓ Is the caller authorized?
❓ Does the user have enough balance?
❓ Is the address valid?
❓ Is the current contract state appropriate?
```

---

# 🔒 10. Why `private` Variables Are NOT Secret

This is a common Solidity misconception.

Suppose we write:

```solidity
uint256 private secretNumber;
```

`private` means:

> Other Solidity contracts cannot directly access this variable through normal Solidity member access.

It does **NOT** mean:

> Nobody can see the value.

---

# 🌍 Blockchain Is Public

Blockchain data is stored on-chain.

Therefore:

```solidity
uint256 private secretNumber;
```

does not provide cryptographic secrecy.

The value may still be discoverable by inspecting blockchain state/data.

---

# ❌ Don't Do This

```solidity
contract Secret {

    string private password;

}
```

Do not assume:

```text
private = encrypted
```

It is not.

---

# 🧠 Visibility vs Secrecy

```text
private
   ↓
Solidity access restriction

NOT

private
   ↓
Cryptographic secrecy
```

---

# 🔐 11. If Data Must Be Secret

Do not store plaintext secrets directly on a public blockchain.

Possible approaches depend on the application, such as:

- 🔒 Keep sensitive data off-chain
- 🔐 Encrypt data before storage
- 🧩 Store only commitments/hashes when appropriate
- 🔑 Use cryptographic protocols designed for privacy

---

# 🛡️ 12. How to Write Safer Solidity Code

Use a security-first mindset.

---

## ① Validate Inputs

```solidity
require(amount > 0, "Invalid amount");
```

---

## ② Check Authorization

```solidity
require(msg.sender == owner, "Not authorized");
```

---

## ③ Follow Checks-Effects-Interactions

```text
CHECK
  ↓
EFFECT
  ↓
INTERACTION
```

---

## ④ Be Careful With External Calls

```solidity
(bool success, ) = target.call(...);

require(success, "Call failed");
```

Understand what the target can do.

---

## ⑤ Don't Use `tx.origin` for Authorization

Prefer:

```solidity
msg.sender
```

---

## ⑥ Understand Arithmetic

Solidity 0.8+ protects normal arithmetic, but still be careful with:

```solidity
unchecked { ... }
```

and type conversions.

---

## ⑦ Don't Store Secrets On-Chain

```solidity
private
```

does not make data secret.

---

## ⑧ Keep Functions Simple

Simple code is easier to:

- Review
- Test
- Audit
- Understand
- Secure

---

# 🧩 13. Safer Mini Bank Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SafeBank {

    address public owner;

    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    // 📥 Deposit
    function deposit() external payable {

        require(
            msg.value > 0,
            "Send ETH"
        );

        balances[msg.sender] += msg.value;
    }

    // 📤 Withdraw
    function withdraw(uint256 amount) external {

        // CHECK
        require(
            amount > 0,
            "Invalid amount"
        );

        require(
            balances[msg.sender] >= amount,
            "Insufficient balance"
        );

        // EFFECT
        balances[msg.sender] -= amount;

        // INTERACTION
        (bool success, ) = payable(msg.sender).call{
            value: amount
        }("");

        require(
            success,
            "Transfer failed"
        );
    }

    // 🔐 Owner-only function
    function withdrawAll() external {

        require(
            msg.sender == owner,
            "Not owner"
        );

        uint256 amount = address(this).balance;

        (bool success, ) = payable(owner).call{
            value: amount
        }("");

        require(
            success,
            "Transfer failed"
        );
    }

}
```

---

# 🔍 14. Security Concepts in the Example

### Access Control

```solidity
require(
    msg.sender == owner,
    "Not owner"
);
```

---

### Input Validation

```solidity
require(
    amount > 0,
    "Invalid amount"
);
```

---

### Balance Validation

```solidity
require(
    balances[msg.sender] >= amount,
    "Insufficient balance"
);
```

---

### Checks-Effects-Interactions

```text
Check balance
      ↓
Reduce balance
      ↓
Send ETH
```

---

### External Call Result

```solidity
(bool success, ) = payable(msg.sender).call{
    value: amount
}("");

require(success);
```

---

# 📊 15. Vulnerability → Protection

| Vulnerability              | Protection                                                       |
| -------------------------- | ---------------------------------------------------------------- |
| 🔄 Reentrancy              | Checks-Effects-Interactions, reentrancy guards where appropriate |
| 🔐 Access control          | `require(msg.sender == ...)`, modifiers, role-based access       |
| 🎭 `tx.origin` misuse      | Use `msg.sender`                                                 |
| 🔢 Arithmetic errors       | Solidity 0.8+ checks; carefully review `unchecked`               |
| ❌ Invalid input           | `require()` validation                                           |
| 📤 Unsafe external calls   | Check results and follow secure interaction patterns             |
| 🔑 Fake secrecy            | Never treat `private` as encryption                              |
| 💰 Unauthorized withdrawal | Strong access control                                            |
| 🚫 Unexpected state        | Validate contract state before execution                         |

---

# 🔄 16. Complete Security Flow

```text
                  USER INPUT
                      │
                      ▼
              ┌───────────────┐
              │ Input Checks  │
              └───────┬───────┘
                      │
                      ▼
             ┌─────────────────┐
             │ Access Control  │
             └────────┬────────┘
                      │
                      ▼
             ┌─────────────────┐
             │ Business Logic  │
             └────────┬────────┘
                      │
                      ▼
             ┌─────────────────┐
             │ Update State    │
             └────────┬────────┘
                      │
                      ▼
             ┌─────────────────┐
             │ External Calls  │
             └────────┬────────┘
                      │
                      ▼
               Check Result
                      │
                      ▼
                  SUCCESS
```

---

# 🧠 17. Security Mindset

Before deploying a contract, ask:

```text
🔐 WHO can call this function?

💰 CAN someone steal funds?

🔄 CAN the function be re-entered?

📤 DOES it make an external call?

🧮 CAN arithmetic fail?

❌ ARE inputs validated?

👤 Am I using msg.sender correctly?

🚨 Am I incorrectly using tx.origin?

🔑 Am I treating private data as secret?

↩️ What happens if an external call fails?

🧪 Have I tested failure cases?
```

---

# 🎯 18. Golden Rules

- 🔄 **External calls can execute unknown code.**
- 🛡️ **Use Checks → Effects → Interactions to reduce reentrancy risk.**
- 🔐 **Always implement proper access control for privileged functions.**
- 👤 **Use `msg.sender` for authorization instead of `tx.origin`.**
- 🔢 **Solidity 0.8+ automatically checks normal arithmetic for overflow/underflow.**
- ⚠️ **Be especially careful with `unchecked` arithmetic and type conversions.**
- ❌ **Validate user inputs before using them.**
- 🔑 **`private` does NOT mean secret on a public blockchain.**
- 📤 **Check the result of low-level external calls.**
- 🧪 **Test both successful and failing execution paths.**
- 🧠 **Simple code is easier to audit and secure.**

---

# 🧠 60-Second Revision

| Topic               | One-Line Summary                                                                                    |
| ------------------- | --------------------------------------------------------------------------------------------------- |
| 🛡️ Vulnerability    | A weakness that can be exploited by an attacker.                                                    |
| 🔄 Reentrancy       | An external call allows execution to re-enter a vulnerable function before state is safely updated. |
| 🛡️ CEI              | Checks → Effects → Interactions.                                                                    |
| 📤 External Calls   | Dangerous because the target can execute arbitrary code and may call back.                          |
| 🔐 Access Control   | Restricts sensitive functions to authorized users.                                                  |
| 👤 `msg.sender`     | Immediate caller; preferred for authorization.                                                      |
| 🚨 `tx.origin`      | Original transaction initiator; don't use it for authorization.                                     |
| 🔢 Overflow         | Number exceeds its type's maximum.                                                                  |
| 🔢 Underflow        | Number goes below its type's minimum.                                                               |
| 🛡️ Solidity 0.8+    | Automatically checks normal arithmetic overflow/underflow.                                          |
| ✅ `require()`      | Validates conditions and reverts if they fail.                                                      |
| 🔍 Input Validation | Ensures user-provided values are acceptable.                                                        |
| 🔒 `private`        | Solidity-level access restriction, NOT blockchain secrecy.                                          |

---

# 💼 Interview Questions & Answers

## Q1. What is a reentrancy attack?

**Answer:**

A reentrancy attack occurs when a contract makes an external call before safely updating its state, allowing the called contract to call back into the vulnerable function repeatedly.

---

## Q2. How can you prevent reentrancy?

**Answer:**

Use the **Checks-Effects-Interactions** pattern, update state before external calls, and where appropriate use a well-tested reentrancy guard.

---

## Q3. Why are external calls dangerous?

**Answer:**

An external call transfers control to another address. If that address is a contract, its code can execute, revert, consume gas, or call the original contract again.

---

## Q4. What is Checks-Effects-Interactions?

**Answer:**

It is a security pattern:

```text
Checks
  ↓
Effects
  ↓
Interactions
```

First validate conditions, then update state, and finally make external calls.

---

## Q5. Why should `tx.origin` not be used for authorization?

**Answer:**

`tx.origin` represents the original transaction initiator and can remain the user's address even when an intermediate attacker contract is calling your contract. `msg.sender` identifies the immediate caller and is the appropriate primitive for normal access control.

---

## Q6. Is `private` data secret?

**Answer:**

No. `private` restricts direct Solidity-level access from other contracts, but blockchain state is publicly observable. It should not be treated as encryption or secrecy.

---

## Q7. Does Solidity 0.8 prevent overflow?

**Answer:**

Normal arithmetic operations in Solidity 0.8+ revert on overflow and underflow by default. However, developers can disable those checks using `unchecked`, so such code requires careful review.

---

## Q8. Why is `require()` important?

**Answer:**

`require()` validates preconditions such as authorization, balances, input ranges, and contract state. If the condition is false, execution reverts.

---

## Q9. Give an example of input validation.

```solidity
require(
    amount > 0,
    "Amount must be greater than zero"
);

require(
    balances[msg.sender] >= amount,
    "Insufficient balance"
);
```

---

## Q10. What is the most important rule when making an external call?

**Answer:**

Treat the external call as potentially dangerous:

```text
Validate
   ↓
Update important state
   ↓
External call
   ↓
Check result
```

---

# ⚡ Rapid-Fire Interview Questions

### Q11. Reentrancy protection pattern?

```text
Checks → Effects → Interactions
```

### Q12. Who is the immediate caller?

```solidity
msg.sender
```

### Q13. Who started the transaction?

```solidity
tx.origin
```

### Q14. Should `tx.origin` normally be used for authorization?

```text
❌ No
```

### Q15. What does `require()` do when its condition is false?

```text
Reverts
```

### Q16. Does `private` mean encrypted?

```text
❌ No
```

### Q17. Does Solidity 0.8+ check normal arithmetic?

```text
✅ Yes
```

### Q18. What keyword disables automatic arithmetic checks?

```solidity
unchecked
```

### Q19. What is the biggest danger of an external call?

```text
Unexpected code execution / reentrancy
```

### Q20. What should you check before transferring funds?

```text
Authorization
Balance
Input
State
```

---

# 🎯 Interview Answer — 30 Seconds

> **"Smart contract vulnerabilities are weaknesses that attackers can exploit to manipulate contract behavior or steal funds. Important Solidity vulnerabilities include reentrancy, access-control bugs, misuse of `tx.origin`, arithmetic errors, and insufficient input validation. Reentrancy can be reduced by following Checks-Effects-Interactions, where we validate conditions, update state, and only then make external calls. For authorization, we should use `msg.sender` rather than `tx.origin`. Solidity 0.8+ provides automatic overflow and underflow checks for normal arithmetic, and `require()` is useful for validating inputs, permissions, balances, and contract state. Finally, `private` variables should never be considered secret because blockchain data is publicly observable."**

---

# 🧠 Final Memory Map

```text
                    🛡️ SOLIDITY SECURITY
                           │
          ┌────────────────┼─────────────────┐
          ▼                ▼                 ▼
      Reentrancy      Access Control    Input Validation
          │                │                 │
          ▼                ▼                 ▼
        CEI            msg.sender        require()
          │                │                 │
          ▼                ▼                 ▼
   Update State First   Avoid tx.origin   Validate Input
          │
          ▼
   External Calls
          │
          ▼
    Check Results

          ┌─────────────────────────────┐
          │       Arithmetic            │
          │ Solidity 0.8+ checks        │
          │ unchecked = manual review   │
          └─────────────────────────────┘

          ┌─────────────────────────────┐
          │        Visibility            │
          │ private ≠ secret             │
          │ Blockchain data is public    │
          └─────────────────────────────┘
```

> ⭐ **Ultimate memory line:**
>
> **Validate inputs → Check authorization → Update state → Make external calls → Check results → Never trust `private` as secret → Never use `tx.origin` for authorization.**
