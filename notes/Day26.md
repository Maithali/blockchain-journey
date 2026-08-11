# 📚 Libraries in Solidity — One Page Revision

> 🎯 **Goal:** Understand what a library is, how to create and use libraries, why libraries are useful, the `using for` pattern, `internal` library functions, and **Library vs Contract**.

---

# 📚 1. What is a Library?

## 📌 Definition

A **library** in Solidity is a special type of contract that contains **reusable functions and logic** that can be used by other contracts.

Libraries are mainly used to:

- ♻️ Reuse code
- 🧹 Keep contracts clean
- 🧩 Separate utility logic
- 🔐 Reduce code duplication
- 🛠️ Create reusable helper functions

---

## 🧒 Explain Like I'm 10

Imagine you have a calculator toolbox.

Instead of writing:

```text
Addition
Subtraction
Multiplication
```

again in every project, you create one toolbox:

```text
📚 Math Library
   │
   ├── add()
   ├── subtract()
   └── multiply()
```

Then many contracts can use the same toolbox.

```text
             Math Library
            /     |      \
           /      |       \
          ▼       ▼        ▼
     Contract A Contract B Contract C
```

---

## 💡 Remember

> **Library = Reusable collection of Solidity functions**

---

# 🏗️ 2. Creating a Library

A library is declared using:

```solidity
library LibraryName {

    // functions

}
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLibrary {

    function add(
        uint a,
        uint b
    )
        internal
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

Here:

```text
library
   ↓
MathLibrary
   ↓
add()
```

---

# 🧩 3. Using a Library

A library function can be called using the library name.

```solidity
contract Calculator {

    function calculate(
        uint a,
        uint b
    )
        public
        pure
        returns(uint)
    {
        return MathLibrary.add(a, b);
    }

}
```

---

## Complete Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLibrary {

    function add(
        uint a,
        uint b
    )
        internal
        pure
        returns(uint)
    {
        return a + b;
    }

}

contract Calculator {

    function calculate(
        uint a,
        uint b
    )
        public
        pure
        returns(uint)
    {
        return MathLibrary.add(a, b);
    }

}
```

---

## Execution

Call:

```text
calculate(10, 20)
```

Flow:

```text
Calculator
     │
     ▼
MathLibrary.add(10, 20)
     │
     ▼
10 + 20
     │
     ▼
30
```

---

# 🎯 4. Why Use Libraries?

Libraries are useful when the same logic needs to be used by multiple contracts.

---

## Without Library

Imagine three contracts:

```text
Contract A
   └── add()

Contract B
   └── add()

Contract C
   └── add()
```

The same code is repeated.

❌ Code duplication

---

## With Library

```text
             MathLibrary
                  │
          ┌───────┼───────┐
          ▼       ▼       ▼
      Contract A Contract B Contract C
```

All contracts can reuse the same utility logic.

---

## Advantages

### ♻️ 1. Code Reusability

Write logic once and reuse it.

---

### 🧹 2. Less Code Duplication

Common functionality can be placed in one library.

---

### 🧩 3. Better Organization

Large contracts can move utility functions into separate libraries.

---

### 🛠️ 4. Maintainability

Utility logic is easier to organize and maintain.

---

### 🔐 5. Reusable Security Logic

Libraries can contain carefully tested helper functions for common operations.

---

# 🔒 5. Understanding `internal` in Libraries

You will frequently see library functions declared as:

```solidity
internal
```

Example:

```solidity
library MathLibrary {

    function add(
        uint a,
        uint b
    )
        internal
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

---

## What Does `internal` Mean?

`internal` means the function can be accessed:

- From the library itself
- From contracts that use/inherit the library functionality as appropriate

It is **not directly callable by an external user as a public contract API**.

---

## Example

```solidity
library MathLibrary {

    function square(uint x)
        internal
        pure
        returns(uint)
    {
        return x * x;
    }

}
```

A contract can use:

```solidity
MathLibrary.square(5);
```

---

## 💡 Important

Library utility functions are commonly declared:

```solidity
internal
```

because they are intended to be used as reusable internal logic.

---

# 🔗 6. `using for`

One of the most useful Solidity library features is:

```solidity
using LibraryName for Type;
```

This allows library functions to be used as if they were functions belonging to a particular type.

---

## Example

```solidity
library MathLibrary {

    function square(uint x)
        internal
        pure
        returns(uint)
    {
        return x * x;
    }

}

contract Calculator {

    using MathLibrary for uint;

    function calculate(uint value)
        public
        pure
        returns(uint)
    {
        return value.square();
    }

}
```

---

## Without `using for`

You write:

```solidity
MathLibrary.square(value);
```

---

## With `using for`

You can write:

```solidity
value.square();
```

---

## Comparison

```text
Without using for

MathLibrary.square(5)


With using for

5.square()
```

---

# 🧠 7. How `using for` Works

Consider:

```solidity
using MathLibrary for uint;
```

This means:

> Attach the library's compatible functions to the `uint` type.

If the library has:

```solidity
function square(uint x)
    internal
    pure
    returns(uint)
```

then:

```solidity
uint value = 5;

value.square();
```

is possible.

Conceptually:

```text
value.square()

        ↓

MathLibrary.square(value)
```

---

# 🧩 8. `using for` with Arrays

Libraries become especially useful for complex types such as arrays.

---

## Example

```solidity
library ArrayLibrary {

    function sum(uint[] memory numbers)
        internal
        pure
        returns(uint)
    {
        uint total = 0;

        for(uint i = 0; i < numbers.length; i++) {

            total += numbers[i];

        }

        return total;
    }

}
```

Use it:

```solidity
contract Calculator {

    using ArrayLibrary for uint[];

    function calculate(
        uint[] memory numbers
    )
        public
        pure
        returns(uint)
    {
        return numbers.sum();
    }

}
```

---

## Execution

Input:

```text
[10, 20, 30]
```

Flow:

```text
numbers.sum()

      ↓

ArrayLibrary.sum(numbers)

      ↓

10 + 20 + 30

      ↓

60
```

---

# 🔢 9. Practical Example — Safe Math Utility

A library can contain reusable arithmetic logic.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library MathLibrary {

    function multiply(
        uint a,
        uint b
    )
        internal
        pure
        returns(uint)
    {
        return a * b;
    }

    function square(uint x)
        internal
        pure
        returns(uint)
    {
        return x * x;
    }

}

contract Calculator {

    function multiply(
        uint a,
        uint b
    )
        public
        pure
        returns(uint)
    {
        return MathLibrary.multiply(a, b);
    }

    function square(uint x)
        public
        pure
        returns(uint)
    {
        return MathLibrary.square(x);
    }

}
```

---

# 💰 10. Practical Example — Balance Validation

Libraries can also contain reusable validation/helper logic.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library BalanceLibrary {

    function hasEnoughBalance(
        uint balance,
        uint amount
    )
        internal
        pure
        returns(bool)
    {
        return balance >= amount;
    }

}

contract Bank {

    using BalanceLibrary for uint;

    uint public balance;

    constructor(uint _balance) {

        balance = _balance;

    }

    function canWithdraw(uint amount)
        public
        view
        returns(bool)
    {
        return balance.hasEnoughBalance(amount);
    }

}
```

---

## Flow

Suppose:

```text
balance = 1000

amount = 300
```

Call:

```text
balance.hasEnoughBalance(300)
```

Conceptually:

```text
BalanceLibrary.hasEnoughBalance(
    1000,
    300
)

        ↓

1000 >= 300

        ↓

true
```

---

# 🏦 11. Practical Example — Percentage Calculator

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library PercentageLibrary {

    function calculate(
        uint amount,
        uint percentage
    )
        internal
        pure
        returns(uint)
    {
        return (amount * percentage) / 100;
    }

}

contract Payment {

    function calculateFee(
        uint amount,
        uint percentage
    )
        public
        pure
        returns(uint)
    {
        return PercentageLibrary.calculate(
            amount,
            percentage
        );
    }

}
```

Example:

```text
amount = 1000

percentage = 5

        ↓

1000 × 5 / 100

        ↓

50
```

---

# 🧠 12. Library Functions and State

Libraries are mainly intended for reusable logic.

For example:

```solidity
library MathLibrary {

    function add(
        uint a,
        uint b
    )
        internal
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

This function:

```solidity
pure
```

means it does not read or modify blockchain state.

Libraries can also work with data passed into their functions.

---

# ⚠️ 13. Important Library Restrictions

Libraries are different from normal contracts.

Important restrictions include:

- A library cannot inherit from a contract.
- A library cannot be inherited by another contract.
- A library cannot have a constructor.
- Libraries cannot receive Ether through a normal Ether-receiving mechanism.
- Library functions intended for direct contract use are commonly `internal`.
- Libraries are designed primarily for reusable logic.

---

# 🔗 14. Library Calls

There are two common styles.

## Style 1 — Library Name

```solidity
MathLibrary.add(10, 20);
```

---

## Style 2 — `using for`

```solidity
using MathLibrary for uint;

value.square();
```

---

## Comparison

| Style               | Example                 |
| ------------------- | ----------------------- |
| Direct library call | `MathLibrary.add(a, b)` |
| `using for`         | `a.add(b)`              |

---

# ⚖️ 15. Library vs Contract

This is an important interview question.

| Feature                    | Library                     | Contract                   |
| -------------------------- | --------------------------- | -------------------------- |
| Main Purpose               | Reusable utility logic      | Application/business logic |
| Can Be Deployed            | ✅ Yes                      | ✅ Yes                     |
| Can Be Inherited           | ❌ No                       | ✅ Yes                     |
| Can Inherit                | ❌ No                       | ✅ Yes                     |
| Constructor                | ❌ No                       | ✅ Yes                     |
| State Variables            | Limited/different semantics | ✅ Yes                     |
| `msg.sender`               | Context-dependent           | ✅ Yes                     |
| Can Receive Ether Normally | ❌ No                       | ✅ Yes                     |
| Function Reuse             | ⭐ Main purpose             | Possible                   |
| `using for`                | ⭐ Common                   | Not the primary use        |
| Typical Example            | Math/Array utilities        | Bank/Token/Voting          |

---

# 🧠 Simple Difference

## Contract

```text
Contract
   │
   ├── State
   ├── Functions
   ├── Business Logic
   └── User Interaction
```

Example:

```text
Bank
Token
Voting
Marketplace
```

---

## Library

```text
Library
   │
   ├── Helper Functions
   ├── Utility Logic
   └── Reusable Code
```

Example:

```text
Math
Array
String
Validation
```

---

# 🧩 16. Library vs Inheritance

Don't confuse libraries with inheritance.

### Library

```text
Contract
    │
    ▼
Uses Library
```

The contract **uses reusable functionality**.

---

### Inheritance

```text
Parent Contract
       │
       ▼
Child Contract
```

The child **inherits functionality and characteristics** from the parent.

---

## 💡 Remember

> **Library = Use reusable logic**

> **Inheritance = Extend/reuse a parent contract**

---

# 🔄 Complete Library Flow

```text
                 📚 Library
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
        Math       Array     Validation
          │          │          │
          └──────────┼──────────┘
                     ▼
              Reusable Logic
                     │
                     ▼
                Smart Contract
                     │
              ┌──────┴──────┐
              ▼             ▼
        Direct Call      using for
              │             │
              ▼             ▼
      Library.function()   value.function()
```

---

# 🧠 60-Second Revision

| Topic                     | One-Line Summary                                                                  |
| ------------------------- | --------------------------------------------------------------------------------- |
| 📚 Library                | Special Solidity construct for reusable logic.                                    |
| 🏗️ Creating               | Use `library LibraryName { }`.                                                    |
| ♻️ Purpose                | Reduce duplication and organize utility logic.                                    |
| 🔒 `internal`             | Common visibility for library helper functions used internally.                   |
| 🔗 `using for`            | Attaches compatible library functions to a type.                                  |
| 📞 Direct Call            | `MathLibrary.add(a, b)`                                                           |
| ✨ `using for`            | `a.add(b)`                                                                        |
| ⚖️ Library vs Contract    | Library focuses on reusable utilities; contracts hold application/business logic. |
| 🧬 Library vs Inheritance | Library is used; inheritance extends a parent contract.                           |

---

# 🎯 Golden Rules

- 📚 **Library = Reusable Solidity utility code.**
- ♻️ Write common logic once and reuse it.
- 🔗 `using LibraryName for Type` enables convenient method-style calls.
- 🔒 Library helper functions are commonly declared `internal`.
- 🧩 `value.function()` can be syntactic sugar for using a library function with `value` as the first argument.
- 🧹 Libraries help reduce code duplication and improve organization.
- 🚫 Libraries cannot be inherited.
- 🚫 Libraries cannot have constructors.
- ⚖️ **Contract = Application logic + state.**
- 📚 **Library = Reusable utility logic.**

---

# 💼 Solidity Libraries — Interview Questions & Answers

## Q1. What is a library in Solidity?

**Answer:**

A library is a special Solidity construct used to contain reusable functions and utility logic that can be used by other contracts.

---

## Q2. Why are libraries used?

**Answer:**

Libraries are used to promote code reuse, reduce duplication, organize utility functions, and make contracts easier to maintain.

---

## Q3. How do you create a library?

```solidity
library MathLibrary {

    function add(uint a, uint b)
        internal
        pure
        returns(uint)
    {
        return a + b;
    }

}
```

---

## Q4. What is `using for`?

**Answer:**

`using for` allows library functions to be used as methods on a particular Solidity type.

Example:

```solidity
using MathLibrary for uint;

value.square();
```

---

## Q5. What does `internal` mean in a library?

**Answer:**

`internal` means the function is intended to be used from within Solidity's internal call context rather than being exposed as a normal external contract API.

---

## Q6. Can a library have a constructor?

**Answer:**

No.

---

## Q7. Can a library be inherited?

**Answer:**

No.

---

## Q8. What is the difference between a library and a contract?

**Answer:**

A contract is generally used to implement application/business logic and maintain state, while a library is designed primarily for reusable utility logic.

---

## Q9. Give a real-world use case for a library.

**Answer:**

A DApp could use a library for:

```text
Math calculations
Array operations
String utilities
Validation
Token calculations
```

---

## Q10. What is the difference between:

```solidity
MathLibrary.add(a, b);
```

and:

```solidity
a.add(b);
```

**Answer:**

The first directly calls the library function. The second uses the `using for` mechanism to make the library function available in method-style syntax.

---

# ⚡ Rapid Fire Interview Questions

### Q11. Which keyword creates a library?

```solidity
library
```

---

### Q12. Can a library have a constructor?

❌ No.

---

### Q13. Can a library inherit from another contract?

❌ No.

---

### Q14. Can a contract use a library?

✅ Yes.

---

### Q15. What keyword enables method-style library usage?

```solidity
using
```

---

### Q16. Typical library function visibility?

```solidity
internal
```

---

### Q17. Main purpose of libraries?

**Code reuse and utility logic.**

---

### Q18. Example of a library use?

```solidity
MathLibrary.add(a, b);
```

---

### Q19. What does `using MathLibrary for uint` mean?

It makes compatible `MathLibrary` functions available for values of type `uint`.

---

### Q20. Easy way to remember?

```text
📚 Library → Reuse Logic

🏢 Contract → Application Logic

🧬 Inheritance → Extend Parent

🔗 using for → Attach Library to Type
```

---

# 🎯 Interview Answer — 30 Seconds

> **"A library in Solidity is a special construct used to organize reusable utility functions that can be shared by contracts. Libraries are useful for reducing code duplication and separating helper logic from business logic. Library functions are commonly declared `internal`, and the `using for` statement allows those functions to be called using method-style syntax such as `value.square()`. Unlike normal contracts, libraries cannot be inherited and cannot have constructors."**

---

# 🧠 Final Memory Map

```text
                       📚 LIBRARY
                           │
            ┌──────────────┼──────────────┐
            ▼              ▼              ▼
          Math           Array        Validation
            │              │              │
            └──────────────┼──────────────┘
                           ▼
                    Reusable Logic
                           │
                 ┌─────────┴─────────┐
                 ▼                   ▼
          Direct Library          using for
              Call                   │
                 │                    ▼
                 ▼              value.function()
       Library.function()
```

> ⭐ **Best interview sentence:**
>
> **"A Solidity library is a reusable utility module for common logic. It helps reduce code duplication and improve contract organization. Library functions are commonly internal, and `using for` allows those functions to be called conveniently on compatible data types."**
