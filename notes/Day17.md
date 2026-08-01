# 🎯 Enums in Solidity — One Page Revision

> 🎯 **Goal:** Learn what an Enum is, how to create it, declare enum variables, update and read enum values, understand its advantages, and practice with Solidity examples. Enums are commonly used to represent **fixed states** such as Order Status, User Roles, Voting Status, and Admission Status.

---

# 🎯 1. What is an Enum?

## 📌 Definition

An **Enum (Enumeration)** is a **user-defined data type** that allows you to define a **fixed set of named constant values**.

Instead of using numbers or strings to represent states, enums make your code **more readable, safer, and easier to maintain**.

---

## 🧒 Explain Like I'm 10

Imagine a traffic signal.

It can only have three colors.

```text
🔴 Red

🟡 Yellow

🟢 Green
```

It **cannot** become Blue or Purple.

Enums work exactly like this.

They allow **only predefined values**.

---

## Real-Life Examples

```text
Order

↓

Pending

Shipped

Delivered

Cancelled
```

```text
Admission

↓

Applied

Verified

Accepted

Rejected
```

```text
Voting

↓

NotStarted

Started

Ended
```

---

## 💡 Remember

> **Enum = Fixed List of Choices**

---

# 🏗️ 2. Enum Syntax

## 📌 Syntax

```solidity
enum EnumName {

    Value1,

    Value2,

    Value3

}
```

---

## Example

```solidity
enum OrderStatus {

    Pending,

    Shipped,

    Delivered,

    Cancelled

}
```

---

## Representation

```text
OrderStatus

│

├── Pending

├── Shipped

├── Delivered

└── Cancelled
```

---

## 💡 Remember

> **Use the `enum` keyword to create an enumeration.**

---

# 📦 3. Declaring an Enum Variable

After creating an enum, declare a variable using its type.

---

## Syntax

```solidity
EnumName variableName;
```

---

## Example

```solidity
OrderStatus public status;
```

Initially,

```text
status = Pending
```

because the **first enum value is the default**.

---

## 💡 Remember

> **The first enum value has index `0` and is the default value.**

---

# ✏️ 4. Updating an Enum

Assign one of the predefined enum values.

---

## Example

```solidity
status = OrderStatus.Shipped;
```

Later,

```solidity
status = OrderStatus.Delivered;
```

---

## Flow

```text
Pending

↓

Shipped

↓

Delivered
```

---

## 💡 Remember

> **Use `EnumName.Value` to assign an enum value.**

---

# 👀 5. Reading an Enum

Enums can be read directly.

If declared as `public`, Solidity automatically creates a getter function.

---

## Example

```solidity
OrderStatus public status;
```

Calling

```text
status()
```

Returns

```text
0
```

Initially (Pending).

After updating,

```text
1
```

(Shipped)

---

## Enum Index Values

| Enum Value | Numeric Value |
| ---------- | ------------- |
| Pending    | 0             |
| Shipped    | 1             |
| Delivered  | 2             |
| Cancelled  | 3             |

---

## 💡 Remember

> **Enums are stored internally as integers starting from `0`.**

---

# ⭐ 6. Advantages of Enums

## Better Readability

Instead of

```solidity
status = 2;
```

Use

```solidity
status = OrderStatus.Delivered;
```

Much easier to understand.

---

## Prevent Invalid Values

Only predefined values are allowed.

---

## Gas Efficient

Enums are stored as small integers, making them efficient.

---

## Cleaner Code

Enums improve readability and reduce errors.

---

## Common Use Cases

- Order Tracking
- Admission Systems
- Voting Systems
- User Roles
- Payment Status
- Shipment Tracking

---

## 💡 Remember

> **Enums make state management simple and readable.**

---

# ⚠️ Limitations of Enums

- Can only contain predefined values.
- Cannot add new values after deployment.
- Maximum of **256 members**.
- Stored internally as integers.

---

# 🧩 Example 1 – Order Status

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Order {

    enum OrderStatus {

        Pending,
        Shipped,
        Delivered,
        Cancelled

    }

    OrderStatus public status;

    function shipOrder() public {

        status = OrderStatus.Shipped;

    }

    function deliverOrder() public {

        status = OrderStatus.Delivered;

    }

    function cancelOrder() public {

        status = OrderStatus.Cancelled;

    }

}
```

### Explanation

Initially

```text
status = Pending
```

After

```text
shipOrder()

↓

Shipped
```

Then

```text
deliverOrder()

↓

Delivered
```

---

# 🧩 Example 2 – Admission Status

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Admission {

    enum AdmissionStatus {

        Applied,
        Verified,
        Accepted,
        Rejected

    }

    AdmissionStatus public status;

    function verifyStudent() public {

        status = AdmissionStatus.Verified;

    }

    function acceptStudent() public {

        status = AdmissionStatus.Accepted;

    }

    function rejectStudent() public {

        status = AdmissionStatus.Rejected;

    }

}
```

### Explanation

Student moves through different admission stages.

```text
Applied

↓

Verified

↓

Accepted
```

or

```text
Applied

↓

Rejected
```

---

# 🧩 Example 3 – Traffic Signal

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TrafficSignal {

    enum Light {

        Red,
        Yellow,
        Green

    }

    Light public currentLight;

    function setGreen() public {

        currentLight = Light.Green;

    }

    function setYellow() public {

        currentLight = Light.Yellow;

    }

    function setRed() public {

        currentLight = Light.Red;

    }

}
```

### Explanation

The enum ensures the signal can only be:

- Red
- Yellow
- Green

No other value is allowed.

---

# ⚖️ Enum vs String

| Feature        | Enum        | String  |
| -------------- | ----------- | ------- |
| Storage        | Integer     | Text    |
| Gas Cost       | Low         | High    |
| Fixed Values   | ✅ Yes      | ❌ No   |
| Readability    | High        | Medium  |
| Invalid Values | Not Allowed | Allowed |

---

# 🔄 Complete Concept Flow

```text
                  Enum
                    │
         ┌──────────┴──────────┐
         ▼                     ▼
    Define Values       Declare Variable
         │                     │
         ▼                     ▼
      Update State       Read Current State
         │
         ▼
  Better State Management
```

---

# 🧠 60-Second Revision

| Topic         | One-Line Summary                       |
| ------------- | -------------------------------------- |
| 🎯 Enum       | User-defined type for fixed values.    |
| 🏗️ Syntax     | `enum Name { Value1, Value2 }`         |
| 📦 Variable   | `Name public variable;`                |
| ✏️ Update     | `variable = Name.Value;`               |
| 👀 Read       | Public enums have an automatic getter. |
| ⭐ Advantages | Readable, safe, gas efficient.         |

---

# 🎯 Golden Rules

- 🎯 An enum represents a **fixed set of predefined values**.
- 🏗️ Create an enum using the `enum` keyword.
- 📦 Declare variables using the enum type.
- ✏️ Assign values with `EnumName.Value`.
- 🔢 Enum values start at **0** by default.
- 🚫 Enums cannot contain arbitrary values.
- ⚡ Enums are more gas efficient than storing state as strings.
- 🌍 Enums are ideal for workflows and status management.

---

# 💼 Solidity Enums — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity enum interview questions.

---

## Q1. What is an enum in Solidity?

**Answer:**

An enum is a user-defined data type that defines a fixed set of named constant values.

---

## Q2. Why do we use enums?

**Answer:**

Enums improve readability, reduce errors, represent states clearly, and are more gas efficient than strings.

---

## Q3. How do you create an enum?

**Answer:**

```solidity
enum Status {
    Pending,
    Approved,
    Rejected
}
```

---

## Q4. How do you declare an enum variable?

**Answer:**

```solidity
Status public status;
```

---

## Q5. How do you update an enum value?

**Answer:**

```solidity
status = Status.Approved;
```

---

## Q6. What is the default value of an enum?

**Answer:**

The **first value** in the enum (index `0`).

---

## Q7. How are enums stored internally?

**Answer:**

As unsigned integers starting from `0`.

---

## Q8. Can enums contain duplicate values?

**Answer:**

No. Each member is unique.

---

## Q9. Can you add new enum values after deployment?

**Answer:**

No. The enum definition is fixed once the contract is deployed.

---

## Q10. Where are enums commonly used?

**Answer:**

- Order Status
- Voting Status
- User Roles
- Admission Status
- Payment Status
- Shipment Tracking

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword creates an enum?

`enum`

---

### Q12. What is the default enum value?

The first declared value.

---

### Q13. Are enums stored as strings?

No.

---

### Q14. What numeric value does the first enum member have?

`0`

---

### Q15. Can enums improve gas efficiency?

Yes.

---

### Q16. Can an enum hold arbitrary text?

No.

---

### Q17. Can a contract have multiple enums?

Yes.

---

### Q18. Can enums be returned from functions?

Yes.

---

### Q19. Are enums user-defined data types?

Yes.

---

### Q20. Which is better for representing states: enum or string?

**Enum**, because it is safer, more readable, and more gas efficient.

---

# 🎯 Interview Tips

- Start with: **"An enum is a user-defined data type used to represent a fixed set of named values."**
- Mention that enums are **internally stored as integers starting from `0`**.
- Explain that **the first enum value is the default** if no value is assigned.
- Use practical examples like **Order Status**, **Admission Status**, or **Traffic Signal** to demonstrate state transitions.
- Emphasize that enums are commonly used in smart contracts to model **workflows and finite states**.
