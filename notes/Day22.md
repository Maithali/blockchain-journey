# 🧬 Inheritance in Solidity — One Page Revision

> 🎯 **Goal:** Learn what Inheritance is, why it is used, understand inheritance syntax, access parent contract members, explore types of inheritance, advantages, and practice with Solidity coding examples. Inheritance is one of the **core OOP concepts** in Solidity and is heavily used in **OpenZeppelin** smart contracts.

---

# 🧬 1. What is Inheritance?

## 📌 Definition

**Inheritance** is an Object-Oriented Programming (OOP) feature that allows one smart contract (**Child Contract**) to **reuse the variables, functions, and modifiers** of another contract (**Parent Contract**).

Instead of rewriting the same code multiple times, the child contract can inherit the parent contract.

---

## 🧒 Explain Like I'm 10

Imagine a family.

```text
👨 Father

↓

House

Car

Money

Knowledge
```

The child inherits these things from the father.

Similarly,

```text
Parent Contract

↓

Variables

Functions

Modifiers

↓

Child Contract
```

The child contract automatically gets access to the parent's features.

---

## Flow

```text
Parent Contract

↓

Child Contract

↓

Uses Parent Variables

↓

Uses Parent Functions

↓

Can Add New Features
```

---

## 💡 Remember

> **Inheritance = Reuse Existing Smart Contract Code**

---

# ❓ 2. Why Use Inheritance?

Without inheritance,

developers would copy the same code into multiple contracts.

Example

```text
Owner Variable

↓

Copied

↓

Contract A

↓

Copied

↓

Contract B

↓

Copied

↓

Contract C
```

This leads to:

- Duplicate Code
- Difficult Maintenance
- More Bugs

Inheritance solves these problems.

---

## Benefits

- Code Reusability
- Cleaner Contracts
- Easier Maintenance
- Less Code Duplication
- Extensible Design

---

## 💡 Remember

> **Write Once → Reuse Everywhere**

---

# 🏗️ 3. Basic Syntax

## Syntax

```solidity
contract Parent {

    // Parent Code

}

contract Child is Parent {

    // Child Code

}
```

The keyword **`is`** is used for inheritance.

---

## Structure

```text
Parent

↓

Variables

Functions

Modifiers

↓

Child

↓

Automatically Gets Parent Features
```

---

## 💡 Remember

> **Child `is` Parent**

---

# 👨‍👦 4. Accessing Parent Contract Members

A child contract can directly access:

- ✅ Public Variables
- ✅ Internal Variables
- ✅ Public Functions
- ✅ Internal Functions
- ✅ Public Modifiers
- ✅ Internal Modifiers

It **cannot directly access**:

- ❌ Private Variables
- ❌ Private Functions

---

## Example

```text
Parent

↓

public age

↓

Child

↓

Can Access
```

---

```text
Parent

↓

private salary

↓

Child

↓

Cannot Access
```

---

## Visibility Summary

| Visibility | Parent           | Child            | Outside |
| ---------- | ---------------- | ---------------- | ------- |
| Public     | ✅               | ✅               | ✅      |
| Internal   | ✅               | ✅               | ❌      |
| Private    | ✅               | ❌               | ❌      |
| External   | ❌ Internal Call | ❌ Internal Call | ✅      |

---

# 🧩 Example 1 – Basic Inheritance

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {

    string public message = "Welcome to Solidity";

    function greet()
        public
        pure
        returns(string memory)
    {
        return "Hello Developer";
    }

}

contract Child is Parent {

}
```

---

## Explanation

The `Child` contract automatically inherits:

```text
message

↓

Welcome to Solidity
```

and

```text
greet()

↓

Hello Developer
```

Even though they are not written again inside the child contract.

---

# 🧩 Example 2 – Parent and Child Functions

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Animal {

    function sound()
        public
        pure
        returns(string memory)
    {
        return "Animal Sound";
    }

}

contract Dog is Animal {

    function bark()
        public
        pure
        returns(string memory)
    {
        return "Woof";
    }

}
```

---

## Explanation

The `Dog` contract has access to:

```text
sound()

↓

Inherited
```

and

```text
bark()

↓

Own Function
```

---

# 🧩 Example 3 – Using Parent State Variables

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Person {

    string public name = "Alice";

}

contract Student is Person {

    uint public rollNumber = 101;

}
```

---

## Explanation

`Student` contains:

```text
name

↓

Alice

+

rollNumber

↓

101
```

---

# 🧩 Example 4 – Parent Modifier

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Owner {

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

}

contract Wallet is Owner {

    uint public balance;

    function deposit(uint amount)
        public
        onlyOwner
    {
        balance += amount;
    }

}
```

---

## Explanation

The `Wallet` contract inherits:

- `owner`
- `onlyOwner`

without rewriting them.

---

# 🏛️ 5. Types of Inheritance

---

## 1️⃣ Single Inheritance

One child inherits from one parent.

```text
Parent

↓

Child
```

```solidity
contract A { }

contract B is A { }
```

---

## 2️⃣ Multiple Inheritance

One child inherits from multiple parents.

```text
Parent A

      \

       Child

      /

Parent B
```

```solidity
contract A { }

contract B { }

contract C is A, B { }
```

---

## 3️⃣ Multilevel Inheritance

Inheritance continues across multiple generations.

```text
A

↓

B

↓

C
```

```solidity
contract A { }

contract B is A { }

contract C is B { }
```

---

## 4️⃣ Hierarchical Inheritance

Multiple children inherit from the same parent.

```text
      Parent
      /    \
     ▼      ▼
 Child1  Child2
```

```solidity
contract A { }

contract B is A { }

contract C is A { }
```

---

# ⭐ 6. Advantages of Inheritance

## Code Reusability

Write common logic once.

---

## Easy Maintenance

Update the parent contract logic.

All child contracts automatically benefit.

---

## Cleaner Code

Less duplication.

---

## Better Organization

Separate common and specialized logic.

---

## Extensibility

Child contracts can add new features without changing the parent.

---

## 💡 Remember

> **Inheritance makes smart contracts modular and reusable.**

---

# ⚖️ Parent vs Child Contract

| Feature                           | Parent Contract | Child Contract |
| --------------------------------- | --------------- | -------------- |
| Defines Common Logic              | ✅              | ❌             |
| Reuses Parent Code                | ❌              | ✅             |
| Can Add New Features              | ❌              | ✅             |
| Can Access Parent Public Members  | N/A             | ✅             |
| Can Access Parent Private Members | ✅              | ❌             |

---

# 🔄 Complete Concept Flow

```text
             Parent Contract
                    │
     Variables • Functions • Modifiers
                    │
                    ▼
             Child Contract
                    │
         Reuses Parent Features
                    │
                    ▼
          Adds New Functionality
```

---

# 🧠 60-Second Revision

| Topic            | One-Line Summary                                    |
| ---------------- | --------------------------------------------------- |
| 🧬 Inheritance   | Reuse code from another contract.                   |
| ❓ Why Use       | Reduce duplicate code and improve maintainability.  |
| 🏗️ Syntax        | `contract Child is Parent`                          |
| 👨‍👦 Parent Access | Child can use parent's public and internal members. |
| ⭐ Advantages    | Reusable, modular, maintainable, extensible.        |
| 🏛️ Types         | Single, Multiple, Multilevel, Hierarchical.         |

---

# 🎯 Golden Rules

- 🧬 Inheritance allows one contract to reuse another contract's code.
- 🏗️ Use the **`is`** keyword to inherit.
- 👨‍👦 Child contracts inherit public and internal members.
- 🔒 Private members are **not inherited** directly.
- 🛠️ Child contracts can add their own variables and functions.
- 🚀 Inheritance reduces code duplication and improves maintainability.
- 📚 OpenZeppelin contracts like `Ownable`, `ERC20`, and `ERC721` heavily rely on inheritance.

---

# 💼 Solidity Inheritance — Interview Questions & Answers

## Q1. What is inheritance in Solidity?

**Answer:**

Inheritance is an OOP feature that allows one contract to inherit variables, functions, and modifiers from another contract, enabling code reuse.

---

## Q2. Which keyword is used for inheritance?

**Answer:**

`is`

Example:

```solidity
contract Child is Parent {

}
```

---

## Q3. Why is inheritance used?

**Answer:**

- Code reuse
- Less duplication
- Better maintenance
- Cleaner architecture
- Easier upgrades

---

## Q4. Can a child contract access a parent's private variables?

**Answer:**

No.

Private members are only accessible within the contract where they are declared.

---

## Q5. Which parent members can a child access?

**Answer:**

- Public
- Internal

---

## Q6. What are the main types of inheritance?

**Answer:**

- Single
- Multiple
- Multilevel
- Hierarchical

---

## Q7. Can Solidity support multiple inheritance?

**Answer:**

Yes.

Example:

```solidity
contract C is A, B {

}
```

---

## Q8. Can child contracts have their own functions?

**Answer:**

Yes.

They inherit parent functionality and can also define additional functions.

---

## Q9. Does inheritance reduce gas costs?

**Answer:**

Inheritance mainly improves **code organization and reuse**. It does **not automatically reduce runtime gas costs**, although cleaner code can simplify development and deployment.

---

## Q10. Which popular Solidity library uses inheritance extensively?

**Answer:**

**OpenZeppelin**

Examples:

- `Ownable`
- `ERC20`
- `ERC721`
- `AccessControl`

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword creates inheritance?

`is`

---

### Q12. Can Solidity inherit multiple contracts?

Yes.

---

### Q13. Can a child contract access public variables?

Yes.

---

### Q14. Can a child contract access private variables?

No.

---

### Q15. Which visibility is inherited besides public?

`internal`

---

### Q16. Can modifiers be inherited?

Yes, if they are accessible (public/internal).

---

### Q17. Which contract provides common functionality?

Parent contract.

---

### Q18. Which contract extends functionality?

Child contract.

---

### Q19. What is multilevel inheritance?

A child inherits from a parent, which itself inherits from another parent.

---

### Q20. Why is inheritance important?

Because it enables reusable, modular, and maintainable smart contract code.

---

# 🎯 Interview Tips

- Start with: **"Inheritance allows a child contract to reuse variables, functions, and modifiers from a parent contract."**
- Remember the keyword: **`is`**.
- Mention that **public** and **internal** members are inherited, while **private** members are not directly accessible.
- Explain the four inheritance types: **Single**, **Multiple**, **Multilevel**, and **Hierarchical**.
- Give real-world examples such as **OpenZeppelin's `ERC20`, `ERC721`, and `Ownable`**, which are built using inheritance.
- If asked about production contracts, mention that Solidity uses **C3 linearization** to resolve multiple inheritance order and supports **function overriding** using the `virtual` and `override` keywords.
