# 🔌 Interfaces in Solidity — One Page Revision

> 🎯 **Goal:** Understand what an Interface is, how to implement one, interface function rules, why interfaces are important, real-world examples, and the difference between **Interfaces vs Inheritance**.

---

# 🔌 1. What is an Interface?

## 📌 Definition

An **interface** in Solidity is a contract-like definition that specifies **what functions a contract must provide**, without providing their implementation.

It defines a **standard way for contracts to communicate with each other**.

Think of an interface as a **contract/API specification**.

```text
Interface
    │
    ├── Function Name
    ├── Parameters
    └── Return Values
           │
           ▼
    Implementing Contract
           │
           ▼
    Actual Function Logic
```

---

## 🧒 Explain Like I'm 10

Imagine a restaurant menu.

The menu says:

```text
🍕 Pizza
🍔 Burger
🥤 Drink
```

It tells you **what is available**, but it doesn't explain how the food is cooked.

Similarly:

```text
Interface

add()
transfer()
balanceOf()
```

The interface tells us **what functions exist**.

The implementing contract provides **how those functions work**.

---

## 💡 Remember

> **Interface = What a contract can do, not how it does it.**

---

# 🏗️ 2. Basic Interface Syntax

```solidity
interface ICalculator {

    function add(
        uint a,
        uint b
    )
        external
        pure
        returns(uint);

}
```

Notice:

```solidity
;
```

There is **no function body**.

---

## Implementing Contract

```solidity
contract Calculator is ICalculator {

    function add(
        uint a,
        uint b
    )
        external
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

---

## Flow

```text
          Interface
       ICalculator
             │
             │ defines
             ▼
          add()
             │
             │ implemented by
             ▼
         Calculator
             │
             ▼
       return a + b
```

---

# 📌 3. Implementing an Interface

A contract implements an interface using the `is` keyword.

```solidity
contract Calculator is ICalculator {

}
```

The implementing contract must provide implementations for the interface's functions.

---

## Complete Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ICalculator {

    function add(
        uint a,
        uint b
    )
        external
        pure
        returns(uint);

}

contract Calculator is ICalculator {

    function add(
        uint a,
        uint b
    )
        external
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

---

## Calling

```text
add(10, 20)

      ↓

Calculator

      ↓

10 + 20

      ↓

30
```

---

# 📜 4. Interface Function Rules

Functions declared in an interface must follow specific rules.

---

## Rule 1 — No Function Body

❌ Incorrect:

```solidity
interface ICalculator {

    function add(uint a, uint b)
        external
        returns(uint)
    {
        return a + b;
    }

}
```

An interface function has no implementation.

---

## Correct

```solidity
interface ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint);

}
```

---

# Rule 2 — Functions Must Be `external`

Interface functions are declared as:

```solidity
external
```

Example:

```solidity
function transfer(
    address to,
    uint amount
)
    external
    returns(bool);
```

---

# Rule 3 — No State Variables

Interfaces cannot contain normal state variables.

❌ Not allowed:

```solidity
interface Test {

    uint public number;

}
```

Instead, interfaces can declare functions that expose information.

```solidity
interface Test {

    function number()
        external
        view
        returns(uint);

}
```

---

# Rule 4 — No Constructor

Interfaces do not have constructors.

❌

```solidity
interface Test {

    constructor() {

    }

}
```

---

# Rule 5 — No Function Implementation

Interface functions only define the function signature.

```solidity
function getBalance(address user)
    external
    view
    returns(uint);
```

---

# Rule 6 — Can Declare Events

Interfaces can declare events.

```solidity
interface IToken {

    event Transfer(
        address indexed from,
        address indexed to,
        uint amount
    );

}
```

---

# Rule 7 — Can Declare Errors

Interfaces can also declare custom errors.

```solidity
interface IBank {

    error InsufficientBalance();

}
```

---

# Rule 8 — Implementing Contract Must Match the Function

The implementation must be compatible with the interface declaration.

Example:

```solidity
interface ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint);

}
```

Implementation:

```solidity
contract Calculator is ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

---

# 🧠 5. Interface Function Signature

A function declaration contains:

```text
Function Name
      +
Parameters
      +
Visibility
      +
State Mutability
      +
Return Values
```

Example:

```solidity
function balanceOf(address user)
    external
    view
    returns(uint);
```

Breakdown:

```text
balanceOf
   │
   ▼
Function Name

address user
   │
   ▼
Parameter

external
   │
   ▼
Visibility

view
   │
   ▼
State Mutability

returns(uint)
   │
   ▼
Return Value
```

---

# ⭐ 6. Why Are Interfaces Important?

Interfaces are extremely important in Web3 because **smart contracts frequently communicate with other smart contracts**.

Instead of knowing the entire source code of another contract, we only need its interface.

---

## Without Interface

Imagine Contract A wants to interact with Contract B.

Contract A would need to know:

```text
Contract B

↓

Entire implementation
```

This is unnecessary.

---

## With Interface

Contract A only needs:

```text
Contract B Interface

↓

Required Function Signatures

↓

Call Contract B
```

---

## 💡 Remember

> **Interface allows one contract to communicate with another without knowing its implementation.**

---

# 🌍 7. Real-World Example — ERC-20 Token

One of the most important real-world uses of interfaces is **ERC-20**.

An ERC-20-compatible token exposes standard functions such as:

```solidity
interface IERC20 {

    function transfer(
        address to,
        uint256 amount
    )
        external
        returns(bool);

    function balanceOf(
        address account
    )
        external
        view
        returns(uint256);

    function approve(
        address spender,
        uint256 amount
    )
        external
        returns(bool);

}
```

Different tokens can have completely different internal implementations while exposing the same standard interface.

---

## Flow

```text
                IERC20
                  │
       ┌──────────┼──────────┐
       ▼          ▼          ▼
     Token A    Token B    Token C
       │          │          │
       ▼          ▼          ▼
  Different   Different   Different
 Implementation Implementation Implementation
       │          │          │
       └──────────┼──────────┘
                  ▼
        Same Standard Interface
```

---

# 🏦 8. Real-World Example — Bank Contract

Suppose a DApp wants to interact with a bank contract.

We only need the bank's interface.

```solidity
interface IBank {

    function deposit()
        external
        payable;

    function withdraw(uint amount)
        external;

    function getBalance()
        external
        view
        returns(uint);

}
```

Now another contract can communicate with the bank.

---

# 🧩 9. Contract-to-Contract Communication

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBank {

    function getBalance()
        external
        view
        returns(uint);

}

contract Bank {

    uint public balance = 1000;

    function getBalance()
        external
        view
        returns(uint)
    {
        return balance;
    }

}

contract BankViewer {

    function checkBalance(
        address bank
    )
        external
        view
        returns(uint)
    {

        IBank bankContract = IBank(bank);

        return bankContract.getBalance();

    }

}
```

---

## How It Works

```text
BankViewer

    │
    │ IBank interface
    ▼

Bank Contract

    │
    ▼

getBalance()

    │
    ▼

1000
```

`BankViewer` does not need to know how `Bank` stores or calculates its balance.

It only needs to know:

```solidity
getBalance()
```

---

# 🦄 10. Real-World Example — Uniswap-Style Interaction

Decentralized exchanges use interfaces to interact with token and pool contracts.

For example:

```solidity
interface IERC20 {

    function transfer(
        address to,
        uint256 amount
    )
        external
        returns(bool);

    function balanceOf(
        address account
    )
        external
        view
        returns(uint256);

}
```

A DEX contract can use the interface to communicate with different ERC-20 tokens.

---

## Flow

```text
             DEX
              │
              ▼
         IERC20 Interface
              │
      ┌───────┼───────┐
      ▼       ▼       ▼
    USDC     DAI     LINK
      │       │       │
      └───────┼───────┘
              ▼
       Token Functions
```

---

# 🧩 11. Interface Type Casting

An address can be converted to an interface type.

Example:

```solidity
IBank bank = IBank(bankAddress);
```

Now we can call:

```solidity
bank.getBalance();
```

---

## Flow

```text
Contract Address

      ↓

IBank(address)

      ↓

Interface Reference

      ↓

Call Function
```

---

# 🧬 12. Interface vs Inheritance

Interfaces and inheritance can look similar because both use:

```solidity
is
```

Example:

```solidity
contract Child is Parent
```

and:

```solidity
contract Token is IERC20
```

But their purpose is different.

---

# ⚖️ Interface vs Inheritance

| Feature                 | Interface                    | Inheritance                 |
| ----------------------- | ---------------------------- | --------------------------- |
| Main Purpose            | Define contract API          | Reuse/extend implementation |
| Function Implementation | ❌ No                        | ✅ Can have                 |
| State Variables         | ❌ No normal state variables | ✅ Yes                      |
| Constructor             | ❌ No                        | ✅ Yes                      |
| Function Body           | ❌ No                        | ✅ Yes                      |
| Code Reuse              | ❌ Not its main purpose      | ✅ Main purpose             |
| Contract Communication  | ⭐ Excellent                 | Possible                    |
| Standard Definition     | ⭐ Excellent                 | Not primary purpose         |
| Keyword                 | `is`                         | `is`                        |
| Example                 | `IERC20`                     | `ERC20`, `Ownable`          |

---

# 🧠 Simple Difference

## Interface

```text
WHAT

↓

What functions should exist?
```

---

## Inheritance

```text
HOW + REUSE

↓

Reuse existing implementation
and extend it
```

---

## 💡 Remember

> **Interface = Contract/API Specification**

> **Inheritance = Code Reuse + Extension**

---

# 🧩 13. Interface vs Inheritance Example

## Interface

```solidity
interface ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint);

}
```

The interface says:

```text
Calculator MUST provide add()
```

But it doesn't say how.

---

## Inheritance

```solidity
contract Calculator {

    function add(uint a, uint b)
        public
        pure
        returns(uint)
    {
        return a + b;
    }

}

contract AdvancedCalculator is Calculator {

    function multiply(uint a, uint b)
        public
        pure
        returns(uint)
    {
        return a * b;
    }

}
```

The child gets the actual implementation from the parent.

---

# 🔄 Complete Interface Flow

```text
                 Interface
                     │
              Defines Functions
                     │
                     ▼
              Function Signature
                     │
                     ▼
           Implementing Contract
                     │
                     ▼
             Actual Logic
                     │
                     ▼
          Contract Function Call
```

---

# 🧠 Interface vs Inheritance Flow

```text
                  Solidity
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Interface              Inheritance
          │                     │
       Defines               Reuses
        WHAT                  HOW
          │                     │
          ▼                     ▼
   Contract Communication   Code Reuse
```

---

# 🧠 60-Second Revision

| Topic                       | One-Line Summary                                                     |
| --------------------------- | -------------------------------------------------------------------- |
| 🔌 Interface                | Defines what functions a contract exposes without implementing them. |
| 🏗️ Implement                | Use `is` and provide compatible function implementations.            |
| 📜 Interface Function       | Usually `external`, has no function body, and ends with `;`.         |
| 🚫 State Variables          | Interfaces cannot contain normal state variables.                    |
| 🚫 Constructor              | Interfaces cannot have constructors.                                 |
| 🔗 Communication            | Interfaces allow contracts to interact with other contracts.         |
| 💰 ERC-20                   | A major real-world example of interface-based standards.             |
| ⚖️ Interface vs Inheritance | Interface defines an API; inheritance reuses implementation.         |

---

# 🎯 Golden Rules

- 🔌 **Interface = Defines what a contract can do.**
- 🏗️ Use `is` when a contract implements an interface.
- 📜 Interface functions do not contain implementations.
- 🌐 Interface functions are declared `external`.
- 🚫 Interfaces cannot have constructors.
- 🚫 Interfaces cannot contain normal state variables.
- 📢 Interfaces can declare events and custom errors.
- 🔗 Interfaces are extremely useful for contract-to-contract communication.
- 💰 ERC-20 is a major real-world example of interface-based interaction.
- 🧬 **Inheritance = Code reuse.**
- 🔌 **Interface = Contract communication/API specification.**

---

# 💼 Solidity Interfaces — Interview Questions & Answers

## Q1. What is an interface in Solidity?

**Answer:**

An interface is a contract-like definition that specifies the functions a contract exposes without providing their implementation.

---

## Q2. Why are interfaces used?

**Answer:**

Interfaces allow contracts to communicate with other contracts without requiring knowledge of their internal implementation.

---

## Q3. How do you implement an interface?

```solidity
contract Calculator is ICalculator {

}
```

The implementing contract must provide compatible implementations of the interface functions.

---

## Q4. Can interface functions have function bodies?

**Answer:**

No.

They only contain function declarations.

---

## Q5. What visibility do interface functions use?

**Answer:**

Interface functions are declared `external`.

---

## Q6. Can an interface have state variables?

**Answer:**

No normal state variables.

---

## Q7. Can an interface have a constructor?

**Answer:**

No.

---

## Q8. Can interfaces contain events?

**Answer:**

Yes.

```solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint amount
);
```

---

## Q9. Can interfaces contain custom errors?

**Answer:**

Yes.

```solidity
error InsufficientBalance();
```

---

## Q10. What is the main difference between an interface and inheritance?

**Answer:**

An interface defines a contract's expected API without implementation, while inheritance is primarily used to reuse and extend existing contract implementation.

---

# ⚡ Rapid Fire Interview Questions

### Q11. Which keyword is used to implement an interface?

`is`

---

### Q12. Can interface functions contain logic?

❌ No.

---

### Q13. Can interfaces have constructors?

❌ No.

---

### Q14. Can interfaces declare events?

✅ Yes.

---

### Q15. Can interfaces declare custom errors?

✅ Yes.

---

### Q16. Can a contract implement multiple interfaces?

✅ Yes.

Example:

```solidity
contract MyContract is InterfaceA, InterfaceB {

}
```

---

### Q17. What is the main purpose of an interface?

Contract communication and API definition.

---

### Q18. What is a famous example of a Solidity interface?

`IERC20`

---

### Q19. Can an interface be used with an existing deployed contract?

✅ Yes.

If the deployed contract follows the expected function interface, another contract can interact with it through that interface.

---

### Q20. What is the easiest way to remember interface vs inheritance?

```text
Interface   → WHAT
Inheritance → REUSE HOW
```

---

# 🎯 Interview Tips

When asked **"What is an interface?"**, answer:

> **"An interface in Solidity defines the functions that a contract exposes without providing their implementation. It acts like an API specification and is especially useful for contract-to-contract communication."**

Then show:

```solidity
interface ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint);

}
```

Then explain:

```solidity
contract Calculator is ICalculator {

    function add(uint a, uint b)
        external
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

Finally remember:

```text
🔌 Interface
    ↓
Defines WHAT

🧬 Inheritance
    ↓
Reuses/extends HOW
```
