# 🏗️ Solidity Constructor — One Page Revision

> 🎯 **Goal:** Learn what a constructor is, when it is executed, its characteristics, and how it differs from a normal function. Constructors are one of the most common Solidity interview topics.

---

# 🏗️ 1. What is a Constructor?

## 📌 Definition

A **Constructor** is a **special function** that is automatically executed **only once** when a smart contract is deployed.

Its main purpose is to **initialize the contract's state**, such as setting the owner, assigning initial values, or configuring important variables.

After deployment, the constructor **cannot be called again**.

---

## 🧒 Explain Like I'm 10

Imagine buying a new mobile phone.

The first time you turn it on:

- Select language
- Connect Wi-Fi
- Create account
- Set password

These setup steps happen only once.

Similarly,

A **constructor performs the initial setup of a smart contract**.

---

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MyContract {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

}
```

---

## Deployment Flow

```text
Deploy Contract

↓

Constructor Executes

↓

Initialize Variables

↓

Contract Stored on Blockchain

↓

Constructor Removed

↓

Users Interact with Contract
```

---

## 💡 Remember

> **Constructor = Runs Once During Deployment**

---

# 🎯 2. Why Do We Use Constructors?

Constructors initialize important data before users interact with the contract.

---

## Common Uses

- Set contract owner
- Initialize state variables
- Store deployment configuration
- Receive constructor parameters
- Deploy dependent contracts

---

## Example

```solidity
constructor() {

    owner = msg.sender;

    totalSupply = 1000000;

}
```

---

## 💡 Remember

> **Constructor = Initial Setup of the Contract**

---

# ⭐ 3. Characteristics of Constructor

## Runs Only Once

Automatically executes only during deployment.

```text
Deploy

↓

Constructor Runs

↓

Never Runs Again
```

---

## Special Function

Constructor uses the keyword:

```solidity
constructor() {

}
```

It is **not** named after the contract.

---

## No Return Type

Constructors never return values.

```solidity
constructor(){

}
```

✅ Correct

```solidity
constructor() returns(uint){

}
```

❌ Invalid

---

## Optional

A contract may or may not have a constructor.

If omitted, Solidity provides a default constructor.

---

## Initializes State Variables

Example

```solidity
constructor() {

    owner = msg.sender;

    count = 100;

}
```

---

## Accepts Parameters

Constructors can receive deployment-time values.

```solidity
constructor(uint initialValue){

    count = initialValue;

}
```

Deployment

```text
Deploy Contract

↓

Pass 100

↓

count = 100
```

---

## Executes Before Any Function

```text
Deploy

↓

Constructor

↓

Functions Become Available
```

---

## Only One Constructor

A contract can have only **one constructor**.

```solidity
constructor(){}

constructor(uint x){}
```

❌ Invalid

---

## Inheritance Support

Child contracts can call parent constructors.

```solidity
contract Parent {

    constructor(uint x){

    }

}

contract Child is Parent(100){

}
```

---

## 💡 Remember

> **One Contract → One Constructor → One Execution**

---

# 📦 4. Constructor with Parameters

## Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Student {

    string public name;

    uint public age;

    constructor(
        string memory _name,
        uint _age
    ){

        name = _name;

        age = _age;

    }

}
```

Deployment

```text
Deploy

↓

"John"

↓

20

↓

Stored Forever
```

---

# 🔄 Constructor Execution Flow

```text
Developer Writes Contract

↓

Deploy Contract

↓

Constructor Executes

↓

Variables Initialized

↓

Contract Stored

↓

Users Call Functions
```

---

# ⚖️ 5. Constructor vs Function

| Feature             | Constructor                                                    | Function                                    |
| ------------------- | -------------------------------------------------------------- | ------------------------------------------- |
| Purpose             | Initialize Contract                                            | Perform Tasks                               |
| Execution           | Runs Once                                                      | Can Run Multiple Times                      |
| Called By           | Automatically During Deployment                                | User or Contract                            |
| Name                | `constructor`                                                  | Developer-defined                           |
| Return Value        | Not Allowed                                                    | Allowed                                     |
| Lifetime            | Ends After Deployment                                          | Exists Throughout Contract Lifetime         |
| Parameters          | Allowed                                                        | Allowed                                     |
| Visibility          | Can be `public` (older versions) or omitted in modern Solidity | `public`, `private`, `internal`, `external` |
| Can Be Called Again | ❌ No                                                          | ✅ Yes                                      |

> **Note:** In Solidity 0.7.0 and later, constructors **do not use visibility specifiers** (`public` is no longer allowed).

---

# 🧠 Constructor Lifecycle

```text
Write Contract

↓

Compile

↓

Deploy

↓

Constructor Runs

↓

State Variables Initialized

↓

Constructor Finished

↓

Removed from Runtime Code

↓

Contract Ready
```

---

# 🌍 Real-World Example

### Bank Account

When opening a bank account:

- Set account holder
- Generate account number
- Assign opening balance

These actions happen only once.

The constructor works exactly the same way.

---

# 🔄 Complete Concept Flow

```text
                 Constructor
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
      Deploy      Initialize   Parameters
          │           │
          ▼           ▼
     State Variables Set
          │
          ▼
   Constructor Ends
          │
          ▼
   Contract Ready
```

---

# 🧠 60-Second Revision

| Topic                      | One-Line Summary                                                        |
| -------------------------- | ----------------------------------------------------------------------- |
| 🏗️ Constructor             | Special function executed once during deployment.                       |
| 🎯 Purpose                 | Initializes contract state.                                             |
| ⭐ Characteristics         | Runs once, no return value, optional, can accept parameters.            |
| 📦 Parameters              | Passed only during deployment.                                          |
| ⚖️ Constructor vs Function | Constructor initializes; functions perform operations after deployment. |

---

# 🎯 Golden Rules

- 🏗️ A constructor runs **only once**.
- 🚀 It executes automatically during deployment.
- 📦 Constructors initialize state variables.
- 🔄 Constructors can accept deployment parameters.
- ❌ Constructors cannot return values.
- 📋 A contract can have **only one constructor**.
- 🔒 After deployment, the constructor cannot be called again.
- 🧩 In Solidity 0.7.0+, constructors **do not have visibility specifiers**.

---

# 💼 Solidity Constructor — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked constructor interview questions.

---

## Q1. What is a constructor in Solidity?

**Answer:**

A constructor is a special function that executes automatically once when the contract is deployed. It is used to initialize the contract's state.

---

## Q2. When is a constructor executed?

**Answer:**

Only once, during contract deployment.

---

## Q3. Can a constructor be called after deployment?

**Answer:**

No. It runs automatically during deployment and cannot be called again.

---

## Q4. What is the main purpose of a constructor?

**Answer:**

To initialize state variables and perform setup tasks such as assigning the contract owner.

---

## Q5. Can a constructor accept parameters?

**Answer:**

Yes. Parameters are provided during contract deployment.

Example:

```solidity
constructor(uint initialValue) {
    count = initialValue;
}
```

---

## Q6. Can a contract have multiple constructors?

**Answer:**

No. A Solidity contract can have only one constructor.

---

## Q7. Can a constructor return a value?

**Answer:**

No. Constructors cannot have a return type or return values.

---

## Q8. Is a constructor mandatory?

**Answer:**

No. If you don't define one, Solidity provides a default constructor.

---

## Q9. Can a child contract call a parent constructor?

**Answer:**

Yes. Parent constructors can be invoked during inheritance.

---

## Q10. Does a constructor remain in the deployed runtime code?

**Answer:**

No. After deployment, the constructor code is not part of the runtime bytecode.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword defines a constructor?

`constructor`

---

### Q12. How many times does a constructor execute?

Once.

---

### Q13. When is a constructor executed?

During contract deployment.

---

### Q14. Can constructors return values?

No.

---

### Q15. Can constructors have parameters?

Yes.

---

### Q16. Can a contract have two constructors?

No.

---

### Q17. What is the most common use of a constructor?

Initializing state variables.

---

### Q18. Can users call a constructor later?

No.

---

### Q19. Is a constructor inherited?

Yes, parent constructors can be invoked by child contracts.

---

### Q20. Are visibility specifiers used with constructors in Solidity 0.8.x?

No.

---

# 🎯 Interview Tips

- Always start with: **"A constructor is a special function that executes once during deployment."**
- Mention that constructors are primarily used to **initialize contract state**.
- Remember that constructors **cannot return values** and **cannot be called after deployment**.
- Be aware that **modern Solidity (0.7.0+) does not allow visibility specifiers on constructors**.
- Know the key difference:

  - **Constructor → Initialization**
  - **Function → Ongoing contract operations**

  ```solidity
  //SPDX-License-Identifier: MIT
  pragma solidity ^0.8.20;
  ```

contract EmployeeProfile{
string public employeeName;
uint public employeeId;
string public employeeDepartment;

    constructor(string memory _employeeName, uint _employeeId, string memory _employeeDeparment){
        employeeName = _employeeName;
        employeeId = _employeeId;
        employeeDepartment = _employeeDeparment;
    }

}

```

```
