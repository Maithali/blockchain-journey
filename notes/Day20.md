# 📢 Events in Solidity — One Page Revision

> 🎯 **Goal:** Learn what Events are, why they are used, how to declare and emit events, understand indexed parameters, and know their advantages with practical Solidity examples. Events are an essential Solidity concept used extensively in DApps, wallets, and blockchain explorers.

---

# 📢 1. What is an Event?

## 📌 Definition

An **Event** is a special mechanism in Solidity used to **log information on the blockchain**.

Events allow smart contracts to **communicate with external applications** (such as DApps, wallets, and blockchain explorers) without storing additional data in contract storage.

Unlike state variables, events are stored in the **transaction logs**.

---

## 🧒 Explain Like I'm 10

Imagine a school notice board.

Whenever something important happens,

the teacher writes a notice.

```text
Student Registered ✅

Fee Paid ✅

Exam Completed ✅
```

Everyone can read the notice,

but nobody changes the original event.

Events work the same way.

They record important actions that happen inside a smart contract.

---

## Flow

```text
User Calls Function

↓

Function Executes

↓

Event Logged

↓

Frontend / Wallet Reads Event
```

---

## 💡 Remember

> **Event = Blockchain Log of Important Actions**

---

# ❓ 2. Why Do We Use Events?

Without events,

external applications would have to constantly read blockchain storage to know what happened.

Events provide an efficient way to notify applications when important actions occur.

---

## Example

User transfers tokens.

Instead of checking balances every second,

the frontend simply listens for:

```text
Transfer Event
```

and immediately updates the UI.

---

## Common Uses

- Token Transfers
- Deposits
- Withdrawals
- NFT Minting
- Ownership Changes
- Voting
- User Registration

---

## 💡 Remember

> **Events notify the outside world that something happened.**

---

# 🏗️ 3. Declaring an Event

## 📌 Syntax

```solidity
event EventName(
    dataType parameter1,
    dataType parameter2
);
```

---

## Example

```solidity
event Deposit(
    address user,
    uint amount
);
```

---

## Representation

```text
Deposit Event

│

├── User Address

└── Amount
```

---

## 💡 Remember

> **Use the `event` keyword to declare an event.**

---

# 🚀 4. Emitting an Event

Declaring an event does **not** record anything.

You must use the **`emit`** keyword to log it.

---

## Syntax

```solidity
emit EventName(values);
```

---

## Example

```solidity
emit Deposit(msg.sender, msg.value);
```

---

## Flow

```text
Function Called

↓

Deposit Happens

↓

emit Deposit()

↓

Event Stored in Transaction Log
```

---

## 💡 Remember

> **`emit` writes the event to the blockchain log.**

---

# 🏷️ 5. Indexed Parameters

## 📌 Definition

The `indexed` keyword allows event parameters to be **searched and filtered efficiently**.

This is especially useful for blockchain explorers like **Etherscan** and frontend libraries like **ethers.js** or **web3.js**.

---

## Syntax

```solidity
event Transfer(
    address indexed from,
    address indexed to,
    uint amount
);
```

---

## Example

```text
Transfer

↓

From: Alice

↓

To: Bob

↓

Amount: 100
```

You can easily search for all transfers involving Alice or Bob.

---

## Rules

- Maximum **3 indexed parameters** per event.
- Indexed values are optimized for filtering.
- Common indexed fields:
  - `address`
  - `uint`
  - `bytes32`

---

## 💡 Remember

> **Indexed = Fast Search and Filtering**

---

# ⭐ 6. Advantages of Events

## Lower Gas Cost

Logging data with events is generally cheaper than storing extra information in contract storage.

---

## Easy Frontend Communication

DApps can listen for events and update automatically.

---

## Blockchain History

Events create a historical record of important actions.

---

## Better Debugging

Developers can inspect emitted events during testing.

---

## Searchable

Indexed parameters make searching efficient.

---

## Common Use Cases

- ERC-20 `Transfer`
- ERC-20 `Approval`
- NFT Minting
- Deposits
- Withdrawals
- Ownership Transfers

---

## 💡 Remember

> **Events = Efficient Communication Between Smart Contracts and the Outside World**

---

# 🧩 Example 1 – Deposit Event

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {

    event Deposit(
        address indexed user,
        uint amount
    );

    function deposit() public payable {

        emit Deposit(
            msg.sender,
            msg.value
        );

    }

}
```

---

### Explanation

When a user deposits Ether,

```text
deposit()

↓

emit Deposit()

↓

Transaction Log

↓

User Address

Amount Deposited
```

The frontend can immediately detect the deposit.

---

# 🧩 Example 2 – Token Transfer Event

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Token {

    event Transfer(
        address indexed from,
        address indexed to,
        uint amount
    );

    function transfer(
        address _to,
        uint _amount
    ) public {

        emit Transfer(
            msg.sender,
            _to,
            _amount
        );

    }

}
```

---

### Explanation

Whenever tokens are transferred,

the event records:

```text
Sender

↓

Receiver

↓

Amount
```

Wallets and DApps can listen for this event.

---

# 🧩 Example 3 – Student Registration

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistry {

    event StudentRegistered(
        uint indexed studentId,
        string name
    );

    function registerStudent(
        uint _id,
        string memory _name
    ) public {

        emit StudentRegistered(
            _id,
            _name
        );

    }

}
```

---

### Explanation

Whenever a student registers,

an event is emitted.

Example Log

```text
Student ID : 101

Name : Alice
```

Applications can search for a specific student ID because it is indexed.

---

# ⚖️ Events vs State Variables

| Feature               | Event                   | State Variable      |
| --------------------- | ----------------------- | ------------------- |
| Purpose               | Log information         | Store contract data |
| Storage Location      | Transaction Logs        | Blockchain Storage  |
| Can Be Modified       | ❌ No                   | ✅ Yes              |
| Read Inside Contract  | ❌ No                   | ✅ Yes              |
| Read Outside Contract | ✅ Yes                  | ✅ Yes              |
| Gas Cost              | Lower                   | Higher              |
| Best Use              | Notifications & History | Persistent Data     |

---

# 🔄 Complete Concept Flow

```text
             Smart Contract
                    │
            Function Called
                    │
                    ▼
               emit Event
                    │
                    ▼
         Transaction Log Created
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
     DApp      Blockchain    Wallet
                Explorer
```

---

# 🧠 60-Second Revision

| Topic         | One-Line Summary                                         |
| ------------- | -------------------------------------------------------- |
| 📢 Event      | Logs important actions on the blockchain.                |
| ❓ Why Use    | Notify external applications efficiently.                |
| 🏗️ Declare    | Use the `event` keyword.                                 |
| 🚀 Emit       | Use the `emit` keyword to log an event.                  |
| 🏷️ Indexed    | Makes event parameters searchable.                       |
| ⭐ Advantages | Low gas, searchable, frontend-friendly, historical logs. |

---

# 🎯 Golden Rules

- 📢 Events are used to **log important actions**, not to store persistent contract state.
- 🚀 Declaring an event is not enough—you must use **`emit`**.
- 🏷️ Use **`indexed`** for parameters you want to filter or search.
- 🔍 Maximum **3 indexed parameters** are allowed.
- ⚡ Events are cheaper than storing unnecessary data in state variables.
- 🌍 Frontends, wallets, and blockchain explorers rely heavily on events.

---

# 💼 Solidity Events — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity event interview questions.

---

## Q1. What is an event in Solidity?

**Answer:**

An event is a logging mechanism that records important contract activities in the transaction logs, allowing external applications to monitor contract activity.

---

## Q2. Why do we use events?

**Answer:**

Events allow DApps, wallets, and blockchain explorers to detect and react to important contract actions without continuously reading contract storage.

---

## Q3. How do you declare an event?

**Answer:**

```solidity
event Deposit(
    address user,
    uint amount
);
```

---

## Q4. How do you emit an event?

**Answer:**

```solidity
emit Deposit(
    msg.sender,
    msg.value
);
```

---

## Q5. What is the purpose of `emit`?

**Answer:**

The `emit` keyword records the event in the transaction log.

---

## Q6. What is an indexed parameter?

**Answer:**

An indexed parameter allows efficient filtering and searching of event logs.

---

## Q7. How many indexed parameters can an event have?

**Answer:**

A maximum of **3 indexed parameters**.

---

## Q8. Are events stored in contract storage?

**Answer:**

No.

They are stored in the transaction logs.

---

## Q9. Can a smart contract read its own past events?

**Answer:**

No.

Events are intended for off-chain consumers. Smart contracts cannot query historical event logs.

---

## Q10. Where are events commonly used?

**Answer:**

- ERC-20 Transfers
- ERC-20 Approvals
- NFT Minting
- Deposits
- Withdrawals
- Ownership Changes

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword declares an event?

`event`

---

### Q12. Which keyword logs an event?

`emit`

---

### Q13. What is the main purpose of an event?

To log important actions for off-chain applications.

---

### Q14. Can events replace state variables?

No.

---

### Q15. Are events cheaper than storage?

Yes.

---

### Q16. Can events be modified after being emitted?

No.

---

### Q17. What does `indexed` do?

Makes event parameters searchable.

---

### Q18. Which applications listen to events?

DApps, wallets, blockchain explorers, and backend services.

---

### Q19. Are events part of the blockchain transaction receipt?

Yes.

---

### Q20. Why are events important in ERC-20 tokens?

They allow wallets and applications to detect transfers and approvals efficiently.

---

# 🎯 Interview Tips

- Start with: **"An event is a logging mechanism that records important smart contract activities in the transaction logs."**
- Remember the difference:
  - **State Variables** → Store contract data.
  - **Events** → Notify the outside world.
- Explain that **`emit`** is required to actually log an event.
- Mention that **`indexed`** parameters make searching event logs efficient.
- Use real-world examples like **ERC-20 `Transfer`**, **ERC-20 `Approval`**, or **bank deposits** to demonstrate practical usage.
