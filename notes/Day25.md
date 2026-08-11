# 🧩 Abstract Contracts in Solidity — One Page Revision

> 🎯 **Goal:** Understand Abstract Contracts, Abstract Functions, `virtual`, `override`, how to implement abstract contracts, and the difference between **Abstract Contracts vs Interfaces**.

---

# 🧩 1. What is an Abstract Contract?

## 📌 Definition

An **abstract contract** is a contract that is **not completely implemented**.

It can contain:

- ✅ State variables
- ✅ Implemented functions
- ✅ Abstract functions
- ✅ Constructors
- ✅ Modifiers
- ✅ Events
- ✅ Other contract logic

An abstract contract is mainly used as a **base contract** that other contracts inherit from.

---

## 🧒 Explain Like I'm 10

Imagine a school rule book.

It says:

```text
Every student must:

✔ Have a name

✔ Have an ID

✔ Attend class
```

But it doesn't define exactly how every student attends class.

Different students can implement that behavior differently.

Similarly:

```text
Abstract Contract
       │
       ├── Common Code
       │
       └── Rules / Abstract Functions
                  │
                  ▼
            Child Contract
                  │
                  ▼
        Provides Implementation
```

---

## 💡 Remember

> **Abstract Contract = Partially implemented base contract**

---

# 🔲 2. Why Use Abstract Contracts?

Abstract contracts are useful when multiple child contracts share **common logic**, but some functionality must be implemented differently by each child.

---

## Example

Suppose we have different shapes:

```text
Shape
 │
 ├── Circle
 │
 ├── Square
 │
 └── Rectangle
```

All shapes have:

```text
area()
```

But the calculation is different.

Therefore:

```text
Shape
 ↓
Defines area()

Circle
 ↓
Implements area()

Square
 ↓
Implements area()
```

---

## Advantages

- ♻️ Code Reusability
- 🧱 Common Base Logic
- 📐 Enforces Structure
- 🔒 Better Architecture
- 🧩 Supports Polymorphism
- 🛠️ Easier Maintenance

---

# 🔲 3. What is an Abstract Function?

An **abstract function** is a function that has a **declaration but no implementation**.

It ends with:

```solidity
;
```

instead of a function body.

---

## Syntax

```solidity
function functionName()
    public
    virtual
    returns(uint);
```

Notice:

```solidity
;
```

There is no:

```solidity
{
    // logic
}
```

---

## Example

```solidity
abstract contract Shape {

    function area()
        public
        virtual
        returns(uint);

}
```

Here:

```solidity
area()
```

is an abstract function.

The child contract must implement it.

---

# ⚠️ 4. Why `virtual`?

The keyword:

```solidity
virtual
```

means:

> **This function can be overridden by a child contract.**

---

## Example

```solidity
function area()
    public
    virtual
    returns(uint)
{
    return 0;
}
```

A child contract can override it.

---

## 💡 Remember

> **`virtual` = Can be overridden**

---

# 🔄 5. What is `override`?

The keyword:

```solidity
override
```

is used in the child contract when it **provides a new implementation** of a parent function.

---

## Example

Parent:

```solidity
function area()
    public
    virtual
    returns(uint)
{
    return 0;
}
```

Child:

```solidity
function area()
    public
    override
    returns(uint)
{
    return 100;
}
```

---

## 💡 Remember

```text
Parent → virtual

Child  → override
```

---

# 🧩 6. Abstract Contract Syntax

```solidity
abstract contract Parent {

    function functionName()
        public
        virtual
        returns(uint);

}
```

Child:

```solidity
contract Child is Parent {

    function functionName()
        public
        override
        returns(uint)
    {
        return 100;
    }

}
```

---

# 🏗️ 7. Implementing an Abstract Contract

Let's build a simple example.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Animal {

    function sound()
        public
        virtual
        returns(string memory);

}

contract Dog is Animal {

    function sound()
        public
        pure
        override
        returns(string memory)
    {
        return "Woof";
    }

}
```

---

## Flow

```text
Animal
(Abstract Contract)
      │
      │ defines
      ▼
   sound()
      │
      │ implemented by
      ▼
    Dog
      │
      ▼
"Woof"
```

---

# 🧩 8. Abstract Contract with Implemented Function

An abstract contract can contain **both implemented and abstract functions**.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Animal {

    string public name;

    constructor(string memory _name) {

        name = _name;

    }

    function eat()
        public
        pure
        returns(string memory)
    {
        return "Eating";
    }

    function sound()
        public
        virtual
        returns(string memory);

}
```

Here:

```text
name
 ↓
State Variable

eat()
 ↓
Implemented Function

sound()
 ↓
Abstract Function
```

---

## Child Contract

```solidity
contract Dog is Animal {

    constructor()
        Animal("Dog")
    {

    }

    function sound()
        public
        pure
        override
        returns(string memory)
    {
        return "Woof";
    }

}
```

---

# 🧠 9. Complete Example — Shape

This is one of the most important examples to understand abstract contracts.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

abstract contract Shape {

    function area()
        public
        virtual
        returns(uint);

}

contract Square is Shape {

    uint public side;

    constructor(uint _side) {

        side = _side;

    }

    function area()
        public
        view
        override
        returns(uint)
    {
        return side * side;
    }

}
```

---

## Execution

Deploy:

```text
Square(5)
```

State:

```text
side = 5
```

Call:

```text
area()
```

Calculation:

```text
5 × 5

↓

25
```

---

# 🧩 10. Multiple Child Contracts

One abstract contract can have many implementations.

```text
              Shape
                │
       ┌────────┼────────┐
       ▼        ▼        ▼
    Square    Circle   Rectangle
       │        │        │
       ▼        ▼        ▼
    area()    area()   area()
```

Each child can implement the same function differently.

---

## Example

```solidity
abstract contract Shape {

    function area()
        public
        virtual
        returns(uint);

}
```

Square:

```solidity
contract Square is Shape {

    function area()
        public
        pure
        override
        returns(uint)
    {
        return 25;
    }

}
```

Rectangle:

```solidity
contract Rectangle is Shape {

    function area()
        public
        pure
        override
        returns(uint)
    {
        return 50;
    }

}
```

---

# 🔄 11. Function Overriding

**Function overriding** means a child contract provides a new implementation of a parent function.

---

## Parent

```solidity
contract Parent {

    function greet()
        public
        virtual
        returns(string memory)
    {
        return "Hello Parent";
    }

}
```

---

## Child

```solidity
contract Child is Parent {

    function greet()
        public
        override
        returns(string memory)
    {
        return "Hello Child";
    }

}
```

Calling:

```text
Child.greet()

↓

Hello Child
```

---

# 🔗 12. Using `super` with Override

The child can also call the parent implementation using:

```solidity
super.functionName()
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {

    function greet()
        public
        pure
        virtual
        returns(string memory)
    {
        return "Hello Parent";
    }

}

contract Child is Parent {

    function greet()
        public
        pure
        override
        returns(string memory)
    {
        return string.concat(
            super.greet(),
            " + Child"
        );
    }

}
```

Result:

```text
Hello Parent + Child
```

---

# ⚠️ 13. Important Rules of Abstract Contracts

### Rule 1

An abstract contract is declared using:

```solidity
abstract contract
```

---

### Rule 2

An abstract function has no implementation.

```solidity
function test()
    public
    virtual
    returns(uint);
```

---

### Rule 3

A child must implement inherited abstract functions before it can itself be a concrete/deployable contract.

---

### Rule 4

A child uses:

```solidity
override
```

when implementing an inherited virtual function.

---

### Rule 5

A function intended to be overridden must be declared:

```solidity
virtual
```

---

### Rule 6

Abstract contracts can contain normal implemented functions.

---

### Rule 7

Abstract contracts can contain state variables.

---

### Rule 8

Abstract contracts can have constructors.

---

# 🔌 14. Abstract Contract vs Interface

This is a very common interview question.

Both can define functions that a child contract must implement, but they are not the same.

---

# ⚖️ Comparison Table

| Feature                | Abstract Contract                      | Interface                            |
| ---------------------- | -------------------------------------- | ------------------------------------ |
| Purpose                | Base contract + partial implementation | Contract API/specification           |
| State Variables        | ✅ Yes                                 | ❌ No normal state variables         |
| Implemented Functions  | ✅ Yes                                 | ❌ No                                |
| Abstract Functions     | ✅ Yes                                 | ✅ Yes                               |
| Constructor            | ✅ Yes                                 | ❌ No                                |
| Modifiers              | ✅ Yes                                 | ❌ No normal modifier implementation |
| Events                 | ✅ Yes                                 | ✅ Yes                               |
| Custom Errors          | ✅ Yes                                 | ✅ Yes                               |
| Can Have Logic         | ✅ Yes                                 | ❌ No implementation logic           |
| Code Reuse             | ✅ Yes                                 | ❌ Not primary purpose               |
| Contract Communication | Possible                               | ⭐ Main purpose                      |
| Keyword                | `abstract contract`                    | `interface`                          |

---

# 🧠 Simple Difference

## Interface

```text
WHAT?

↓

What functions must exist?
```

Example:

```solidity
interface IShape {

    function area()
        external
        view
        returns(uint);

}
```

---

## Abstract Contract

```text
WHAT + SOME HOW

↓

Common rules
+
Common implementation
+
Functions children must implement
```

Example:

```solidity
abstract contract Shape {

    function description()
        public
        pure
        returns(string memory)
    {
        return "Shape";
    }

    function area()
        public
        virtual
        returns(uint);

}
```

---

# 🧩 15. Same Problem — Interface vs Abstract Contract

Suppose we are creating a payment system.

---

## Interface Approach

```solidity
interface IPayment {

    function pay(uint amount)
        external;

}
```

It only defines:

```text
pay()
```

The implementing contract must provide all logic.

---

## Abstract Contract Approach

```solidity
abstract contract Payment {

    address public owner;

    constructor() {

        owner = msg.sender;

    }

    function getOwner()
        public
        view
        returns(address)
    {
        return owner;
    }

    function pay(uint amount)
        public
        virtual;

}
```

Now the base contract provides:

```text
owner
constructor
getOwner()
```

while requiring the child to implement:

```text
pay()
```

---

# 🔄 Complete Concept Flow

```text
                Abstract Contract
                       │
          ┌────────────┴────────────┐
          ▼                         ▼
    Implemented Code          Abstract Function
          │                         │
          │                         ▼
          │                      virtual
          │                         │
          └────────────┬────────────┘
                       ▼
                 Child Contract
                       │
                       ▼
                    override
                       │
                       ▼
              Complete Implementation
```

---

# 🧠 60-Second Revision

| Topic                | One-Line Summary                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ |
| 🧩 Abstract Contract | Partially implemented base contract.                                                                               |
| 🔲 Abstract Function | Function declaration without implementation.                                                                       |
| 🔄 `virtual`         | Allows a function to be overridden.                                                                                |
| ✅ `override`        | Provides the child implementation of an inherited function.                                                        |
| 🏗️ Child Contract    | Implements inherited abstract functions.                                                                           |
| 🔗 `super`           | Calls the next parent implementation.                                                                              |
| 🔌 Interface         | Defines an external contract API without implementation.                                                           |
| ⚖️ Main Difference   | Abstract contracts can contain state and implemented logic; interfaces cannot contain normal implementation logic. |

---

# 🎯 Golden Rules

- 🧩 **Abstract Contract = Base contract that may be incomplete.**
- 🔲 **Abstract Function = Declaration without function body.**
- 🔄 **`virtual` = This function can be overridden.**
- ✅ **`override` = Child provides the implementation.**
- 🔗 **`super` = Call the next implementation in the inheritance hierarchy.**
- 🏗️ Abstract contracts can contain state variables, constructors, modifiers, and implemented functions.
- 🚫 An abstract contract with unimplemented abstract functions cannot be deployed directly.
- 🔌 Interfaces are more restrictive than abstract contracts.
- 🧬 Use abstract contracts when you want **shared implementation + required child behavior**.
- 🔌 Use interfaces when you mainly need a **standard API for contract interaction**.

---

# 💼 Abstract Contracts — Interview Questions & Answers

## Q1. What is an abstract contract?

**Answer:**

An abstract contract is a contract that is incomplete and is intended to be inherited by another contract. It can contain both implemented and unimplemented functions.

---

## Q2. What is an abstract function?

**Answer:**

An abstract function is a function that has a declaration but no implementation.

Example:

```solidity
function area()
    public
    virtual
    returns(uint);
```

---

## Q3. What does `virtual` mean?

**Answer:**

`virtual` indicates that a function can be overridden by a child contract.

---

## Q4. What does `override` mean?

**Answer:**

`override` indicates that a child contract is providing a new implementation of an inherited virtual function.

---

## Q5. Can an abstract contract have implemented functions?

**Answer:**

Yes.

Example:

```solidity
function hello()
    public
    pure
    returns(string memory)
{
    return "Hello";
}
```

---

## Q6. Can an abstract contract have state variables?

**Answer:**

Yes.

---

## Q7. Can an abstract contract have a constructor?

**Answer:**

Yes.

---

## Q8. Can an abstract contract be deployed directly?

**Answer:**

No, not while it still has unimplemented abstract functions.

---

## Q9. What happens if a child does not implement an abstract function?

**Answer:**

The child contract must also be declared `abstract`; otherwise, it cannot compile as a concrete contract.

---

## Q10. What is the difference between an abstract contract and an interface?

**Answer:**

An abstract contract can contain state variables, constructors, implemented functions, and abstract functions.

An interface is much more restrictive and primarily defines the callable API that another contract must expose.

---

# ⚡ Rapid Fire Interview Questions

### Q11. Which keyword declares an abstract contract?

```solidity
abstract
```

---

### Q12. Which keyword allows overriding?

```solidity
virtual
```

---

### Q13. Which keyword confirms an override?

```solidity
override
```

---

### Q14. Can abstract contracts contain state variables?

✅ Yes.

---

### Q15. Can interfaces contain normal state variables?

❌ No.

---

### Q16. Can abstract contracts contain implemented functions?

✅ Yes.

---

### Q17. Can interfaces contain implemented functions?

❌ No.

---

### Q18. Can abstract contracts have constructors?

✅ Yes.

---

### Q19. Can interfaces have constructors?

❌ No.

---

### Q20. What is the easiest way to remember?

```text
Interface
    ↓
WHAT

Abstract Contract
    ↓
WHAT + SOME HOW

Concrete Contract
    ↓
COMPLETE HOW
```

---

# 🎯 Interview Answer — 30 Seconds

> **"An abstract contract in Solidity is a partially implemented base contract that can contain both implemented and abstract functions. An abstract function has no implementation and usually acts as a requirement for child contracts. The `virtual` keyword allows a function to be overridden, while `override` is used by the child to provide its implementation. Unlike an interface, an abstract contract can contain state variables, constructors, modifiers, and implemented functions."**

---

# 🧠 Final Memory Map

```text
                    ABSTRACT CONTRACT
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
      State Data      Implemented      Abstract
                        Functions       Functions
                                           │
                                           ▼
                                        virtual
                                           │
                                           ▼
                                    Child Contract
                                           │
                                           ▼
                                       override
                                           │
                                           ▼
                                    Implementation
```
