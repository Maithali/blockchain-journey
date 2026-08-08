# 🏗️ Constructors + Inheritance in Solidity — One Page Revision

> 🎯 **Goal:** Understand constructors in Solidity, constructor parameters, `msg.sender` inside constructors, constructors with inheritance, constructor execution order, and the `super` keyword.

---

# 🏗️ 1. What is a Constructor?

## 📌 Definition

A **constructor** is a special function that is executed **only once**, when a smart contract is deployed.

It is mainly used to **initialize the contract's state variables**.

---

## 🧒 Explain Like I'm 10

Imagine opening a new bank account.

When the account is created, you immediately set:

```text
Account Owner → Alice

Initial Balance → ₹0

Account Type → Savings
```

These values are initialized when the account is created.

A Solidity constructor works similarly.

```text
Contract Deployment
        ↓
   Constructor
        ↓
Initialize State Variables
        ↓
Contract Created
```

---

## 💡 Remember

> **Constructor = Initialization Code That Runs Once During Deployment**

---

# 🔑 2. Constructor Syntax

## Basic Syntax

```solidity
constructor() {
    // initialization logic
}
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    string public name;

    constructor() {
        name = "Alice";
    }

}
```

When the contract is deployed:

```text
Constructor Executes
        ↓
name = "Alice"
        ↓
Contract Deployment Complete
```

---

# 📌 3. Characteristics of a Constructor

A constructor:

- Executes only once.
- Runs during contract deployment.
- Initializes state variables.
- Can accept parameters.
- Can access `msg.sender`.
- Can contain logic.
- Does not have a function name.
- Does not have a visibility specifier in modern Solidity.
- Cannot be called like a normal function after deployment.

---

## ⚠️ Important

A constructor is **not a normal function**.

You cannot do this:

```solidity
contract Test {

    constructor() {
    }

}
```

and later call:

```text
test.constructor()
```

❌ Not possible.

The constructor executes automatically during deployment.

---

# 🎯 4. Constructor Parameters

A constructor can receive values during deployment.

## Syntax

```solidity
constructor(parameterType parameterName) {

    // initialization

}
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    string public name;
    uint public age;

    constructor(
        string memory _name,
        uint _age
    ) {

        name = _name;
        age = _age;

    }

}
```

---

## Deployment

Suppose we deploy with:

```text
_name = "Alice"

_age = 21
```

The constructor executes:

```text
name = "Alice"

age = 21
```

---

## Flow

```text
Deployment Input

"Alice", 21

        ↓

    Constructor

        ↓

name = "Alice"
age = 21

        ↓

Contract Deployed
```

---

## 💡 Remember

> **Constructor parameters allow the deployer to provide initial contract values.**

---

# 👤 5. Constructor and `msg.sender`

`msg.sender` inside the constructor represents the **address that deploys the contract**.

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Wallet {

    address public owner;

    constructor() {

        owner = msg.sender;

    }

}
```

Suppose:

```text
Alice's Wallet
       ↓
Deploys Contract
       ↓
msg.sender = Alice
       ↓
owner = Alice
```

---

## Why is this useful?

It is commonly used to automatically make the deployer:

- Owner
- Admin
- Creator
- Initial controller

---

## Example

```solidity
constructor() {

    owner = msg.sender;

}
```

This means:

> **Whoever deploys the contract becomes the initial owner.**

---

## 💡 Remember

> **Constructor `msg.sender` = Account/contract that performs the deployment call.**

---

# 🧬 6. Constructor and Inheritance

When a contract inherits another contract, the **parent constructor must also be initialized** if it requires parameters.

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {

    string public message;

    constructor(string memory _message) {

        message = _message;

    }

}

contract Child is Parent {

    constructor()
        Parent("Hello Solidity")
    {

    }

}
```

---

## Explanation

`Child` inherits `Parent`.

But `Parent` requires:

```solidity
string memory _message
```

Therefore, `Child` must provide the value:

```solidity
Parent("Hello Solidity")
```

---

## Flow

```text
Deploy Child
     ↓
Child Constructor
     ↓
Parent Constructor
     ↓
message = "Hello Solidity"
     ↓
Child Deployment Complete
```

---

# 🧩 7. Constructor Inheritance Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Person {

    string public name;

    constructor(string memory _name) {

        name = _name;

    }

}

contract Student is Person {

    uint public rollNumber;

    constructor(
        string memory _name,
        uint _rollNumber
    )
        Person(_name)
    {

        rollNumber = _rollNumber;

    }

}
```

---

## Deployment

```text
Student(
    "Alice",
    101
)
```

---

## Execution

```text
Student Constructor
       │
       ├── Person("Alice")
       │       ↓
       │   name = "Alice"
       │
       └── rollNumber = 101
```

Final state:

```text
name       = Alice
rollNumber = 101
```

---

# 🔄 8. Constructor Execution Order

Constructor execution order becomes especially important when inheritance is involved.

For a simple inheritance chain:

```text
Parent
   ↓
Child
```

The **parent constructor executes before the child constructor**.

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {

    uint public parentValue;

    constructor() {

        parentValue = 10;

    }

}

contract Child is Parent {

    uint public childValue;

    constructor() {

        childValue = 20;

    }

}
```

---

## Execution Order

```text
Deploy Child
     ↓
Parent Constructor
     ↓
parentValue = 10
     ↓
Child Constructor
     ↓
childValue = 20
     ↓
Deployment Complete
```

---

## 💡 Remember

> **Parent Constructor → Child Constructor**

---

# 🧬 9. Multilevel Inheritance Constructor Order

Consider:

```text
GrandParent
     ↓
 Parent
     ↓
 Child
```

The constructors execute:

```text
GrandParent Constructor
          ↓
Parent Constructor
          ↓
Child Constructor
```

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GrandParent {

    constructor() {
        // 1
    }

}

contract Parent is GrandParent {

    constructor() {
        // 2
    }

}

contract Child is Parent {

    constructor() {
        // 3
    }

}
```

Execution:

```text
1️⃣ GrandParent

        ↓

2️⃣ Parent

        ↓

3️⃣ Child
```

---

# 🧩 10. Constructor with `msg.sender` + Inheritance

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Parent {

    address public parentOwner;

    constructor() {

        parentOwner = msg.sender;

    }

}

contract Child is Parent {

    address public childOwner;

    constructor() {

        childOwner = msg.sender;

    }

}
```

When an EOA deploys `Child`:

```text
EOA
 ↓
Deploy Child
 ↓
Parent Constructor
 ↓
msg.sender = deployer
 ↓
parentOwner = deployer
 ↓
Child Constructor
 ↓
msg.sender = deployer
 ↓
childOwner = deployer
```

For a straightforward direct deployment, both constructors observe the deployment caller.

---

# 🚀 11. `super` in Solidity

## 📌 What is `super`?

`super` is used to access the **next implementation in the inheritance hierarchy**.

It is especially useful when working with **overridden functions** and **multiple inheritance**.

---

## Basic Example

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
        return "Hello from Parent";
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
            " and Child"
        );

    }

}
```

The child calls:

```solidity
super.greet()
```

which invokes the next implementation of `greet()` in the inheritance hierarchy.

---

## Flow

```text
Child.greet()

      ↓

super.greet()

      ↓

Parent.greet()

      ↓

"Hello from Parent"
```

Then the child adds:

```text
" and Child"
```

Final result:

```text
Hello from Parent and Child
```

---

# ⚠️ Important: `super` and Constructors

`super` is **not used to directly call a parent constructor**.

Parent constructors are initialized using the inheritance list:

```solidity
contract Child is Parent {

    constructor()
        Parent(...)
    {

    }

}
```

So:

```solidity
super(...)
```

❌ Not the normal syntax for calling a parent constructor.

Instead:

```solidity
Parent(...)
```

✅ Used to provide constructor arguments to the parent.

---

# 🏛️ 12. Multiple Inheritance and Constructors

Solidity supports multiple inheritance.

```solidity
contract A {

    constructor(uint _x) {
    }

}

contract B {

    constructor(uint _y) {
    }

}

contract C is A, B {

    constructor(
        uint _x,
        uint _y
    )
        A(_x)
        B(_y)
    {

    }

}
```

The child constructor supplies the required arguments for both parent constructors.

---

## Structure

```text
        A
       /
      /
     C
      \
       \
        B
```

Deployment:

```text
C(10, 20)

↓

A(10)

+

B(20)

↓

C Constructor
```

---

# 🔢 13. Constructor Execution Order in Multiple Inheritance

Do **not** assume that simply changing the order in the constructor argument list changes the execution order.

Solidity determines constructor execution according to the **inheritance linearization order**.

Example:

```solidity
contract A {

    constructor() {
        // A
    }

}

contract B {

    constructor() {
        // B
    }

}

contract C is A, B {

    constructor()
        A()
        B()
    {

        // C

    }

}
```

Conceptually:

```text
A Constructor
      ↓
B Constructor
      ↓
C Constructor
```

The exact order becomes especially important with more complex inheritance graphs because Solidity uses **C3 linearization**.

---

# ⚖️ 14. Constructor vs Normal Function

| Feature                        | Constructor    | Normal Function       |
| ------------------------------ | -------------- | --------------------- |
| Runs Automatically             | ✅ Yes         | ❌ No                 |
| Runs During Deployment         | ✅ Yes         | ❌ Not necessarily    |
| Runs Only Once                 | ✅ Yes         | ❌ Can run many times |
| Has Name                       | ❌ No          | ✅ Yes                |
| Can Have Parameters            | ✅ Yes         | ✅ Yes                |
| Can Modify State               | ✅ Yes         | ✅ Yes                |
| Can Be Called After Deployment | ❌ No          | ✅ Yes                |
| Main Purpose                   | Initialization | Contract Operations   |

---

# 🧠 15. Constructor vs Modifier

Don't confuse these two.

### Constructor

Used to **initialize the contract**.

```solidity
constructor() {

    owner = msg.sender;

}
```

### Modifier

Used to **control or validate function execution**.

```solidity
modifier onlyOwner() {

    require(msg.sender == owner);

    _;

}
```

---

# 🔥 16. Complete Coding Example

Here is a practical example combining:

- Constructor
- Constructor parameters
- `msg.sender`
- Inheritance
- Parent constructor
- Modifier
- Child functionality

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Person {

    string public name;
    address public creator;

    constructor(string memory _name) {

        name = _name;
        creator = msg.sender;

    }

}

contract Student is Person {

    uint public rollNumber;

    constructor(
        string memory _name,
        uint _rollNumber
    )
        Person(_name)
    {

        rollNumber = _rollNumber;

    }

}
```

---

## Deployment

```text
Student(
    "Alice",
    101
)
```

---

## Result

```text
name

↓

Alice


creator

↓

Deployer Address


rollNumber

↓

101
```

---

## Execution Flow

```text
Deploy Student
       │
       ▼
Student Constructor
       │
       ▼
Person(_name)
       │
       ▼
Person Constructor
       │
       ├── name = "Alice"
       │
       └── creator = msg.sender
       │
       ▼
Student Constructor Continues
       │
       └── rollNumber = 101
       │
       ▼
Deployment Complete
```

---

# 🔄 Complete Concept Flow

```text
                  Constructor
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
   Initialize      Parameters     msg.sender
     State
        │              │              │
        └──────────────┼──────────────┘
                       ▼
                  Inheritance
                       │
                       ▼
               Parent Constructor
                       │
                       ▼
                Child Constructor
                       │
                       ▼
                  Deployment
                       │
                       ▼
                  Contract Live
```

---

# 🧠 60-Second Revision

| Topic                    | One-Line Summary                                                    |
| ------------------------ | ------------------------------------------------------------------- |
| 🏗️ Constructor           | Runs once during contract deployment.                               |
| 📥 Parameters            | Allow initial values to be supplied during deployment.              |
| 👤 `msg.sender`          | Identifies the deployment caller in the constructor context.        |
| 🧬 Inheritance           | Child contracts must initialize parent constructors when required.  |
| 🔄 Execution Order       | Parent constructors execute before child constructors.              |
| 🧬 Multilevel            | Grandparent → Parent → Child.                                       |
| 🔗 `super`               | Calls the next implementation in the inheritance hierarchy.         |
| ⚠️ Constructor + `super` | `super` is not used to pass parent constructor arguments.           |
| 🏛️ Multiple Inheritance  | Constructor execution follows Solidity's inheritance linearization. |

---

# 🎯 Golden Rules

- 🏗️ **Constructor = Runs once during deployment.**
- 📥 Constructor parameters initialize the contract with deployment-time values.
- 👤 `msg.sender` can be used to identify the deployment caller.
- 🧬 A child contract must provide arguments required by a parent constructor.
- 🔄 **Parent constructors execute before child constructors.**
- 🏛️ In multiple inheritance, Solidity uses **C3 linearization** to determine the order.
- 🔗 `super` calls the next implementation in the inheritance hierarchy.
- ⚠️ Use `Parent(...)` in the inheritance list to pass arguments to a parent constructor.
- 🚫 A constructor cannot be called again after deployment.

---

# 💼 Constructors + Inheritance — Interview Questions

## Q1. What is a constructor in Solidity?

**Answer:**

A constructor is a special function that executes once during contract deployment and is primarily used to initialize state variables.

---

## Q2. Can a constructor accept parameters?

**Answer:**

Yes.

```solidity
constructor(string memory _name) {

    name = _name;

}
```

The values are supplied during deployment.

---

## Q3. What does `msg.sender` represent inside a constructor?

**Answer:**

It represents the address that is performing the deployment call in the constructor's execution context.

---

## Q4. Does a constructor execute every time a function is called?

**Answer:**

No.

It executes only once during deployment.

---

## Q5. How do you pass arguments to a parent constructor?

**Answer:**

Use the parent contract in the inheritance specification:

```solidity
contract Child is Parent {

    constructor(string memory _name)
        Parent(_name)
    {

    }

}
```

---

## Q6. Which constructor executes first: parent or child?

**Answer:**

The parent constructor executes before the child constructor.

---

## Q7. What is the constructor order in multilevel inheritance?

**Answer:**

```text
Grandparent
    ↓
Parent
    ↓
Child
```

---

## Q8. What is `super`?

**Answer:**

`super` refers to the next implementation in Solidity's inheritance hierarchy and is commonly used when calling overridden parent implementations.

---

## Q9. Can `super` be used to pass arguments to a parent constructor?

**Answer:**

No.

Use:

```solidity
Parent(...)
```

in the inheritance specification.

---

## Q10. What happens if a parent constructor requires parameters but the child does not provide them?

**Answer:**

The child contract will fail to compile until the required parent constructor arguments are supplied.

---

# ⚡ Rapid Fire Interview Questions

### Q11. How many times does a constructor execute?

**Once.**

---

### Q12. When does it execute?

**During deployment.**

---

### Q13. Can a constructor modify state variables?

**Yes.**

---

### Q14. Can a constructor accept parameters?

**Yes.**

---

### Q15. Can a constructor be called after deployment?

**No.**

---

### Q16. Which keyword is used for inheritance?

`is`

---

### Q17. How do you initialize a parent constructor?

```solidity
Parent(...)
```

---

### Q18. Which constructor runs first?

**Parent constructor.**

---

### Q19. What does `_` mean in a modifier?

It represents the modified function's execution point; it is unrelated to constructors.

---

### Q20. What determines constructor order in complex multiple inheritance?

**Solidity's C3 linearization.**

---

# 🎯 Interview Tips

When asked about **constructors + inheritance**, explain it in this order:

```text
Constructor
    ↓
Runs once at deployment
    ↓
Can accept parameters
    ↓
msg.sender = deployment caller
    ↓
Inheritance
    ↓
Parent constructor initialized first
    ↓
Child constructor executes
    ↓
Multiple inheritance → C3 linearization
    ↓
super → next implementation in inheritance hierarchy
```

> ⭐ **Best interview sentence:**
>
> **"A Solidity constructor runs once during deployment to initialize contract state. When inheritance is involved, parent constructors are initialized before child constructors, and required parent constructor arguments are passed using `Parent(...)`. The `super` keyword is used to call the next implementation in the inheritance hierarchy, especially for overridden functions."**
