# 🔐 Solidity Visibility & State Mutability — One Page Revision

> 🎯 **Goal:** Learn Solidity visibility specifiers and state mutability keywords. These determine **who can access functions/variables** and **whether a function can read or modify blockchain state**. This is one of the most frequently asked Solidity interview topics.

---

# 🔐 1. What is Visibility?

## 📌 Definition

**Visibility** defines **who can access a function or state variable**.

It controls whether a function or variable can be accessed:

- Inside the same contract
- By inherited contracts
- By other contracts
- By external users

---

## 🧒 Explain Like I'm 10

Imagine your house.

```text
🏠 House

🚪 Living Room → Everyone can enter

🔒 Bedroom → Only family members

🔐 Locker → Only you

📮 Doorbell → Visitors can ring from outside
```

Visibility works the same way.

It decides **who is allowed to access something**.

---

## Why Visibility?

Visibility helps:

- Improve security
- Restrict access
- Hide internal logic
- Protect sensitive data
- Control contract interactions

---

## 💡 Remember

> **Visibility = Who Can Access?**

---

# 🌍 2. Visibility Specifiers

Solidity provides four visibility specifiers.

```text
Visibility

│

├── public

├── private

├── internal

└── external
```

---

# 🌍 3. Public

## 📌 Definition

A **public** function or variable can be accessed:

- Inside the same contract
- By inherited contracts
- By other contracts
- By external users

It is the most open visibility.

---

## Example

```solidity
contract Demo {

    uint public count;

    function increment() public {

        count++;

    }

}
```

---

## Access

```text
Same Contract      ✅

Inherited Contract ✅

Other Contracts    ✅

Users              ✅
```

---

## Note

Public state variables automatically get a **getter function**.

---

## 💡 Remember

> **public = Accessible Everywhere**

---

# 🔒 4. Private

## 📌 Definition

A **private** member can only be accessed **inside the contract where it is declared**.

It cannot be accessed by:

- Child contracts
- Other contracts
- External users

---

## Example

```solidity
contract Bank {

    uint private balance;

}
```

---

## Access

```text
Same Contract      ✅

Inherited Contract ❌

Other Contracts    ❌

Users              ❌
```

---

## Important

Private does **not** mean secret.

Anyone can still read blockchain storage using explorers.

It only prevents direct access through Solidity code.

---

## 💡 Remember

> **private = Only This Contract**

---

# 🏛️ 5. Internal

## 📌 Definition

An **internal** member is accessible:

- Inside the current contract
- Inside inherited contracts

---

## Example

```solidity
contract Parent {

    uint internal number;

}
```

---

## Access

```text
Same Contract      ✅

Inherited Contract ✅

Other Contracts    ❌

Users              ❌
```

---

## 💡 Remember

> **internal = Family Access**

---

# 🌐 6. External

## 📌 Definition

An **external** function is designed to be called **from outside the contract**.

It cannot be called internally without using `this`.

---

## Example

```solidity
contract Demo {

    function hello()
        external
    {

    }

}
```

---

## Calling

```solidity
this.hello();
```

---

## Access

```text
Same Contract      ❌*

Inherited Contract ❌

Other Contracts    ✅

Users              ✅
```

\*Direct internal calls are not allowed; use `this.hello()` to make an external call.

---

## 💡 Remember

> **external = Outside Access**

---

# 📊 Visibility Comparison Table

| Visibility | Same Contract | Inherited | Other Contracts | Users |
| ---------- | ------------- | --------- | --------------- | ----- |
| public     | ✅            | ✅        | ✅              | ✅    |
| private    | ✅            | ❌        | ❌              | ❌    |
| internal   | ✅            | ✅        | ❌              | ❌    |
| external   | ❌\*          | ❌        | ✅              | ✅    |

> \*Can be called internally only using `this.functionName()`.

---

# ⚡ 7. What is State Mutability?

## 📌 Definition

**State Mutability** specifies **whether a function can read or modify the blockchain state**.

It tells Solidity what the function is allowed to do.

---

## Types

```text
State Mutability

│

├── pure

├── view

└── payable
```

---

## 💡 Remember

> **State Mutability = What Can the Function Do?**

---

# 🟢 8. Pure

## 📌 Definition

A **pure** function:

- Cannot read state variables
- Cannot modify state variables

It only works with its own parameters and local variables.

---

## Example

```solidity
function add(
    uint a,
    uint b
)
    public
    pure
    returns(uint)
{
    return a + b;
}
```

---

## Characteristics

- Reads State ❌
- Modifies State ❌

---

## 💡 Remember

> **pure = No Reading, No Writing**

---

# 👀 9. View

## 📌 Definition

A **view** function can:

- Read state variables
- Cannot modify them

---

## Example

```solidity
uint public count = 10;

function getCount()
    public
    view
    returns(uint)
{
    return count;
}
```

---

## Characteristics

- Reads State ✅
- Modifies State ❌

---

## 💡 Remember

> **view = Read Only**

---

# 💰 10. Payable

## 📌 Definition

A **payable** function can receive Ether.

Without `payable`, sending Ether to the function causes the transaction to fail.

---

## Example

```solidity
function deposit()
    public
    payable
{

}
```

---

## Sending Ether

```text
User

↓

1 ETH

↓

Payable Function

↓

Contract Balance
```

---

## Characteristics

- Receives Ether ✅
- May modify state ✅

---

## 💡 Remember

> **payable = Accepts Ether**

---

# 📊 State Mutability Comparison

| Mutability | Read State | Modify State | Receive Ether |
| ---------- | ---------- | ------------ | ------------- |
| pure       | ❌         | ❌           | ❌            |
| view       | ✅         | ❌           | ❌            |
| payable    | ✅\*       | ✅           | ✅            |

> \*A payable function may read state if needed.

---

# 🔄 Complete Concept Flow

```text
              Solidity Functions
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
   Visibility                 State Mutability
        │                           │
 ┌──────┼────────┐          ┌────────┼────────┐
 ▼      ▼        ▼          ▼        ▼        ▼
Public Private Internal   Pure     View   Payable
        │
        ▼
Who Can Access?
        │
        ▼
Same Contract
Inherited Contract
Other Contracts
Users
```

---

# 🧠 60-Second Revision

| Topic               | One-Line Summary                                        |
| ------------------- | ------------------------------------------------------- |
| 🔐 Visibility       | Controls who can access functions and variables.        |
| 🌍 public           | Accessible from anywhere.                               |
| 🔒 private          | Accessible only within the same contract.               |
| 🏛️ internal         | Accessible within the contract and inherited contracts. |
| 🌐 external         | Intended for calls from outside the contract.           |
| ⚡ State Mutability | Defines whether a function reads or modifies state.     |
| 🟢 pure             | Cannot read or modify state.                            |
| 👀 view             | Can read state but cannot modify it.                    |
| 💰 payable          | Can receive Ether and may modify state.                 |

---

# 🎯 Golden Rules

- 🔐 Visibility answers **"Who can access this?"**
- ⚡ State mutability answers **"What can this function do?"**
- 🌍 `public` is accessible everywhere.
- 🔒 `private` is only accessible inside its own contract.
- 🏛️ `internal` is accessible to the contract and its children.
- 🌐 `external` is intended for outside callers.
- 🟢 `pure` cannot read or modify state.
- 👀 `view` can read state but cannot change it.
- 💰 `payable` allows Ether to be sent to the contract.

---

# 💼 Visibility & State Mutability — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity visibility and mutability interview questions.

---

## Q1. What is visibility in Solidity?

**Answer:**

Visibility defines who can access a function or state variable inside or outside a contract.

---

## Q2. What are the four visibility specifiers?

**Answer:**

- `public`
- `private`
- `internal`
- `external`

---

## Q3. What is the difference between `private` and `internal`?

**Answer:**

- `private`: Accessible only inside the contract where it is declared.
- `internal`: Accessible inside the contract and in inherited contracts.

---

## Q4. What is the difference between `public` and `external`?

**Answer:**

- `public` functions can be called internally and externally.
- `external` functions are intended for external calls and require `this.functionName()` for an internal-style external call.

---

## Q5. Does `private` hide blockchain data?

**Answer:**

No. It only restricts access in Solidity code. Blockchain storage remains publicly visible.

---

## Q6. What is state mutability?

**Answer:**

State mutability specifies whether a function can read state variables, modify state variables, or receive Ether.

---

## Q7. What is a `pure` function?

**Answer:**

A `pure` function cannot read or modify state variables. It only works with its parameters and local variables.

---

## Q8. What is a `view` function?

**Answer:**

A `view` function can read state variables but cannot modify them.

---

## Q9. What is a `payable` function?

**Answer:**

A `payable` function can receive Ether as part of a transaction.

---

## Q10. Which function type is used for calculations only?

**Answer:**

`pure`

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which visibility is the most restrictive?

`private`

---

### Q12. Which visibility allows inheritance?

`internal`

---

### Q13. Which visibility is accessible from anywhere?

`public`

---

### Q14. Which visibility is intended for outside callers?

`external`

---

### Q15. Which mutability keyword cannot read state variables?

`pure`

---

### Q16. Which mutability keyword can read but not modify state?

`view`

---

### Q17. Which keyword allows Ether to be received?

`payable`

---

### Q18. Can a `view` function modify state?

No.

---

### Q19. Can a `pure` function access state variables?

No.

---

### Q20. Does `payable` automatically modify state?

No. It only allows the function to receive Ether; whether it modifies state depends on the function's logic.

---

# 🎯 Interview Tips

- Separate the concepts clearly:
  - **Visibility = Who can access?**
  - **State Mutability = What can the function do?**
- Remember the visibility order from most open to most restricted:
  **public → external → internal → private** (by accessibility scope).
- Don't say **`private` means secret**—it only restricts Solidity access, not blockchain visibility.
- Distinguish **`pure`** (no reading, no writing) from **`view`** (read only).
- Mention that **`payable`** is required for functions that receive Ether.
