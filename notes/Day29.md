# 💸 Ether Transfer in Solidity — One Page Revision

> 🎯 **Goal:** Understand how Ether is received and sent by Solidity contracts using `transfer()`, `send()`, and `call()`, why `call()` is preferred in modern Solidity, and how Ether transfer syntax works.

---

# 💰 1. Ether Transfer in Solidity

A Solidity smart contract can:

1. 📥 Receive Ether from users
2. 🏦 Hold Ether
3. 📤 Send Ether to users or other addresses

Basic flow:

```text
              ETHER
                │
        ┌───────┴───────┐
        ▼               ▼
    Receive ETH      Send ETH
        │               │
        ▼               ▼
   payable /        transfer()
   receive()        send()
                    call()
```

---

# 🔄 2. Receiving vs Sending Ether

## 📥 Receiving Ether

A contract can receive Ether using:

```solidity
function deposit() external payable {

}
```

or:

```solidity
receive() external payable {

}
```

When Ether is received:

```solidity
msg.value
```

tells us how much Ether was sent.

---

## 📤 Sending Ether

A contract can send Ether using:

```solidity
transfer()
send()
call()
```

Example:

```solidity
payable(user).call{value: amount}("");
```

---

# 🧠 Remember

```text
📥 Receiving
    ↓
payable + msg.value

📤 Sending
    ↓
transfer()
send()
call()
```

---

# 👤 3. Who Can Send Ether?

Ether can be sent from:

```text
User Wallet
     │
     ▼
Smart Contract
```

or:

```text
Smart Contract A
       │
       ▼
Smart Contract B
```

---

# 📤 4. `transfer()`

`transfer()` sends Ether to an address.

Syntax:

```solidity
payable(recipient).transfer(amount);
```

Example:

```solidity
payable(msg.sender).transfer(1 ether);
```

This sends:

```text
1 ETH
```

to:

```solidity
msg.sender
```

---

## Example

```solidity
function withdraw() external {

    payable(msg.sender).transfer(1 ether);

}
```

Flow:

```text
Contract
   │
   │ 1 ETH
   ▼
msg.sender
```

---

# ⚠️ 5. How `transfer()` Works

`transfer()`:

- Sends Ether
- Reverts automatically if the transfer fails
- Historically forwards a fixed **2300 gas stipend**

Conceptually:

```text
transfer()
    │
    ├── Success → Continue
    │
    └── Failure → Revert
```

---

# 🚨 6. Why `transfer()` Is Not Preferred Today

Older Solidity code commonly used:

```solidity
payable(user).transfer(amount);
```

However, relying on the fixed 2300-gas stipend became problematic because gas costs and contract behavior can change.

Therefore, modern Solidity development generally prefers:

```solidity
(bool success, ) = payable(user).call{value: amount}("");
require(success, "Transfer failed");
```

---

# 📤 7. `send()`

`send()` is another way to send Ether.

Syntax:

```solidity
payable(recipient).send(amount);
```

Example:

```solidity
bool success = payable(msg.sender).send(1 ether);
```

---

# ⚠️ 8. Important Difference: `send()` vs `transfer()`

`send()` returns a Boolean:

```solidity
bool success
```

It does **not automatically revert** when the transfer fails.

Example:

```solidity
bool success = payable(msg.sender).send(1 ether);

require(success, "Transfer failed");
```

---

## Flow

```text
send()
  │
  ├── Success → true
  │
  └── Failure → false
```

If you forget to check:

```solidity
success
```

your contract may continue even though the Ether transfer failed.

---

# 🚨 9. `send()` Has the Same Gas-Stipend Problem

Like `transfer()`, `send()` historically forwards only:

```text
2300 gas
```

to the recipient.

Therefore, `send()` is also generally avoided in modern Solidity code for Ether transfers.

---

# 📤 10. `call()`

`call()` is a low-level function that can be used to send Ether.

Modern syntax:

```solidity
(bool success, ) = payable(recipient).call{
    value: amount
}("");
```

Example:

```solidity
(bool success, ) = payable(msg.sender).call{
    value: 1 ether
}("");

require(success, "Transfer failed");
```

---

# 🧩 11. Understanding `call()` Syntax

Consider:

```solidity
(bool success, ) = payable(msg.sender).call{
    value: 1 ether
}("");
```

Let's break it down.

---

## `payable(msg.sender)`

```solidity
payable(msg.sender)
```

Converts the address into a payable address so it can receive Ether.

---

## `{value: 1 ether}`

```solidity
{value: 1 ether}
```

Specifies how much Ether should be sent.

---

## `("")`

```solidity
("")
```

Means no additional calldata is being sent.

---

## `(bool success, )`

`call()` returns:

```text
(bool success, bytes memory returnData)
```

We only need `success`.

Therefore:

```solidity
(bool success, ) = ...
```

The second return value is ignored.

---

# 🧠 12. Complete `call()` Example

```solidity
function withdraw(uint256 amount) external {

    require(
        address(this).balance >= amount,
        "Insufficient contract balance"
    );

    (bool success, ) = payable(msg.sender).call{
        value: amount
    }("");

    require(success, "Ether transfer failed");

}
```

---

# 🔄 13. `call()` Flow

```text
Contract
   │
   │ call{value: amount}
   ▼
Recipient
   │
   ├── Success
   │      ↓
   │    true
   │
   └── Failure
          ↓
        false
```

We then check:

```solidity
require(success, "Ether transfer failed");
```

---

# ⭐ 14. Why Is `call()` Preferred?

Modern Solidity commonly prefers:

```solidity
call()
```

for sending Ether because it:

- ✅ Does not impose the old fixed 2300-gas stipend
- ✅ Gives explicit success/failure information
- ✅ Can send Ether and calldata
- ✅ Is more flexible
- ✅ Works better with modern contract patterns

But:

> ⚠️ `call()` is powerful and must be used carefully because it creates an external call.

---

# ⚠️ 15. `call()` and Reentrancy

Because `call()` can execute code in the recipient contract, it can introduce **reentrancy risk**.

For example:

```solidity
(bool success, ) = payable(msg.sender).call{
    value: amount
}("");
```

The recipient may be a smart contract.

That contract can execute its own code when receiving Ether.

Therefore, follow the:

```text
Checks
   ↓
Effects
   ↓
Interactions
```

pattern.

---

# 🔐 16. Checks-Effects-Interactions Pattern

A safer withdrawal structure is:

```solidity
function withdraw(uint256 amount) external {

    // 1. CHECK
    require(
        balances[msg.sender] >= amount,
        "Insufficient balance"
    );

    // 2. EFFECT
    balances[msg.sender] -= amount;

    // 3. INTERACTION
    (bool success, ) = payable(msg.sender).call{
        value: amount
    }("");

    require(success, "Transfer failed");

}
```

---

## Why?

```text
CHECK
  ↓
Is user allowed to withdraw?

EFFECT
  ↓
Update balance

INTERACTION
  ↓
Send ETH
```

The user's internal balance is reduced **before** the external call.

---

# ⚖️ 17. `transfer()` vs `send()` vs `call()`

| Feature                          | `transfer()`      | `send()`          | `call()` |
| -------------------------------- | ----------------- | ----------------- | -------- |
| Sends ETH                        | ✅                | ✅                | ✅       |
| Returns success value            | ❌                | ✅                | ✅       |
| Automatically reverts on failure | ✅                | ❌                | ❌       |
| Fixed 2300 gas stipend           | Yes               | Yes               | No       |
| Can send calldata                | ❌                | ❌                | ✅       |
| Modern preferred approach        | ❌                | ❌                | ✅       |
| Flexibility                      | Low               | Low               | High     |
| Requires checking result         | ❌                | ✅                | ✅       |
| External call risk               | Lower flexibility | Lower flexibility | ⚠️ Yes   |

---

# 🧠 18. Easy Comparison

```text
transfer()
    │
    ├── Fixed gas stipend
    ├── Failure → revert
    └── Older approach


send()
    │
    ├── Fixed gas stipend
    ├── Failure → false
    └── Must check result


call()
    │
    ├── Flexible gas forwarding
    ├── Failure → false
    ├── Can return data
    ├── Can send calldata
    └── Modern preferred approach
```

---

# 📊 19. Error Handling Comparison

## `transfer()`

```solidity
payable(user).transfer(amount);
```

If transfer fails:

```text
❌ Transaction reverts
```

---

## `send()`

```solidity
bool success = payable(user).send(amount);
```

If transfer fails:

```text
success = false
```

You must check it:

```solidity
require(success);
```

---

## `call()`

```solidity
(bool success, ) = payable(user).call{
    value: amount
}("");
```

If transfer fails:

```text
success = false
```

Check it:

```solidity
require(success);
```

---

# 💡 20. Why Does `call()` Return Two Values?

This:

```solidity
(bool success, bytes memory data)
```

contains:

### `success`

```text
true / false
```

Tells whether the call succeeded.

### `data`

```text
bytes
```

Contains return data from the called contract.

Example:

```solidity
(bool success, bytes memory data) =
    payable(user).call{value: amount}("");
```

---

# 🧩 21. `call()` Can Also Send Data

One powerful feature of `call()` is that it can send calldata.

Syntax:

```solidity
target.call{value: amount}(data);
```

Example:

```solidity
(bool success, bytes memory data) =
    target.call{value: 1 ether}(someData);
```

So `call()` can conceptually do:

```text
ETH
 +
Calldata
 +
Gas
 ↓
Target Contract
```

---

# 💰 22. Sending Ether to an EOA

An EOA is a normal Ethereum wallet address.

Example:

```solidity
address payable user;

(bool success, ) = user.call{
    value: 1 ether
}("");

require(success, "Transfer failed");
```

---

# 🏗️ 23. Sending Ether to Another Contract

The recipient can also be a smart contract.

```solidity
address payable contractAddress;

(bool success, ) = contractAddress.call{
    value: 1 ether
}("");

require(success, "Transfer failed");
```

The recipient contract may execute:

```solidity
receive()
```

or:

```solidity
fallback()
```

depending on the calldata and its implementation.

---

# 🔄 24. Ether Transfer + `receive()`

Suppose:

```solidity
contract Receiver {

    receive() external payable {

    }

}
```

And another contract executes:

```solidity
(bool success, ) = payable(receiver).call{
    value: 1 ether
}("");
```

Because:

```text
value = 1 ETH
data = empty
```

the receiver can execute:

```solidity
receive()
```

---

# 🔄 25. Ether Transfer + `fallback()`

Suppose the recipient receives non-empty calldata:

```solidity
(bool success, ) =
    target.call{value: 1 ether}(data);
```

If the calldata doesn't match an existing function, the target may execute:

```solidity
fallback()
```

if available and appropriate.

---

# 🏦 26. Complete Bank Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherBank {

    mapping(address => uint256) public balances;

    // 📥 Deposit ETH
    function deposit() external payable {

        require(
            msg.value > 0,
            "Send some ETH"
        );

        balances[msg.sender] += msg.value;
    }

    // 📤 Withdraw ETH
    function withdraw(uint256 amount) external {

        require(
            balances[msg.sender] >= amount,
            "Insufficient balance"
        );

        // Effects
        balances[msg.sender] -= amount;

        // Interaction
        (bool success, ) = payable(msg.sender).call{
            value: amount
        }("");

        require(
            success,
            "ETH transfer failed"
        );
    }

    // 🏦 Contract ETH balance
    function getContractBalance()
        external
        view
        returns(uint256)
    {
        return address(this).balance;
    }

    // 👤 User's recorded balance
    function getMyBalance()
        external
        view
        returns(uint256)
    {
        return balances[msg.sender];
    }

}
```

---

# 🔍 27. Complete Bank Flow

```text
                    USER
                     │
                     │
                  deposit()
                     │
                     │ ETH
                     ▼
             ┌───────────────┐
             │ EtherBank     │
             │               │
             │ balances[user]│
             └───────┬───────┘
                     │
                     │ withdraw()
                     ▼
                 Check Balance
                     │
                     ▼
              Reduce Balance
                     │
                     ▼
                   call()
                     │
                     │ ETH
                     ▼
                    USER
```

---

# 🚨 28. Important Security Rule

Never blindly do:

```solidity
(bool success, ) = payable(user).call{
    value: amount
}("");
```

without considering:

- Reentrancy
- Balance checks
- State updates
- Access control
- Failure handling

At minimum:

```text
CHECK
  ↓
UPDATE STATE
  ↓
CALL
  ↓
CHECK SUCCESS
```

For more complex contracts, a reentrancy guard may also be appropriate.

---

# 🧠 29. When Should You Use Each?

## `transfer()`

Understand it for:

- Legacy Solidity code
- Interviews
- Learning historical Ether transfer methods

Generally avoid relying on it in new production code.

---

## `send()`

Understand it for:

- Legacy Solidity code
- Interviews
- Understanding low-level Ether transfer behavior

Generally avoid it in new production code.

---

## `call()`

Common modern choice:

```solidity
(bool success, ) = payable(user).call{
    value: amount
}("");

require(success, "Transfer failed");
```

Use it carefully because it performs an external call.

---

# 🎯 30. Golden Rules

- 📥 **Receiving Ether → `payable`, `receive()`, or `fallback()`**
- 📤 **Sending Ether → `transfer()`, `send()`, or `call()`**
- ⚠️ **`transfer()` and `send()` rely on the old 2300-gas stipend model.**
- ⭐ **`call()` is generally preferred for modern Ether transfers.**
- 🔍 **Always check the success value returned by `call()`.**
- 🔐 **External calls can introduce reentrancy risk.**
- 🛡️ **Use Checks-Effects-Interactions and/or appropriate reentrancy protection.**
- 💰 **`{value: amount}` specifies how much Ether is sent.**
- 📦 **`("")` means no calldata is being sent.**
- 🔄 **`call()` can send both Ether and calldata.**

---

# 🧠 60-Second Revision

| Topic              | One-Line Summary                                                                  |
| ------------------ | --------------------------------------------------------------------------------- |
| 📥 Receiving Ether | Use `payable`, `receive()`, or `fallback()`.                                      |
| 📤 Sending Ether   | Use `transfer()`, `send()`, or `call()`.                                          |
| `transfer()`       | Sends ETH and reverts on failure; uses 2300 gas stipend.                          |
| `send()`           | Sends ETH and returns `false` on failure; uses 2300 gas stipend.                  |
| `call()`           | Flexible low-level call; returns success and return data.                         |
| ⭐ Why `call()`?   | Modern, flexible Ether transfer mechanism without the fixed 2300-gas restriction. |
| `msg.value`        | ETH attached to the current call.                                                 |
| `{value: amount}`  | Amount of ETH sent by `call()`.                                                   |
| `success`          | Whether the low-level call succeeded.                                             |
| `data`             | Return data from the called contract.                                             |
| ⚠️ Security        | External calls can create reentrancy risks.                                       |

---

# 💼 Interview Questions & Answers

## Q1. How can Solidity send Ether?

**Answer:**

Traditionally Solidity provides:

```solidity
transfer()
send()
```

and modern contracts commonly use:

```solidity
call()
```

for Ether transfers.

---

## Q2. What is the syntax of `call()` for sending Ether?

```solidity
(bool success, ) = payable(user).call{
    value: amount
}("");

require(success, "Transfer failed");
```

---

## Q3. Why is `call()` preferred over `transfer()`?

**Answer:**

`call()` does not impose the old fixed 2300-gas stipend and provides explicit success/failure information. It is therefore more flexible for modern Solidity contracts.

---

## Q4. What happens if `transfer()` fails?

**Answer:**

The transaction reverts.

---

## Q5. What happens if `send()` fails?

**Answer:**

`send()` returns:

```solidity
false
```

It does not automatically revert.

---

## Q6. What does `call()` return?

```solidity
(bool success, bytes memory returnData)
```

---

## Q7. Why do we check `success`?

Because `call()` does not automatically revert the caller when the low-level call fails.

```solidity
require(success, "Transfer failed");
```

---

## Q8. What does this mean?

```solidity
{value: amount}
```

**Answer:**

It specifies the amount of Ether to send with the call.

---

## Q9. What does this mean?

```solidity
("")
```

**Answer:**

No calldata is being sent.

---

## Q10. What is the major security risk of `call()`?

**Answer:**

Because `call()` performs an external call and can execute code in the recipient contract, it can introduce **reentrancy risk**.

---

# ⚡ Rapid Fire

### Q11. Old Ether transfer method that reverts on failure?

```solidity
transfer()
```

### Q12. Old Ether transfer method that returns `bool`?

```solidity
send()
```

### Q13. Modern flexible Ether transfer mechanism?

```solidity
call()
```

### Q14. How much ETH does `call()` send?

```solidity
{value: amount}
```

### Q15. How do you check whether `call()` succeeded?

```solidity
require(success);
```

### Q16. Can `call()` send calldata?

✅ Yes.

```solidity
target.call{value: amount}(data);
```

### Q17. Can `transfer()` send arbitrary calldata?

❌ No.

### Q18. Can `send()` send arbitrary calldata?

❌ No.

### Q19. What gas stipend is associated with `transfer()` and `send()`?

```text
2300 gas
```

### Q20. Main security principle when using `call()` for withdrawals?

```text
Checks
   ↓
Effects
   ↓
Interactions
```

---

# 🎯 Interview Answer — 30 Seconds

> **"Solidity provides `transfer()`, `send()`, and `call()` for sending Ether. `transfer()` reverts automatically when the transfer fails, while `send()` returns a Boolean that must be checked. Both use the old 2300-gas stipend model. Modern Solidity contracts generally use `call()` because it is more flexible and does not impose that fixed stipend. The common syntax is `(bool success, ) = payable(user).call{value: amount}("");`, followed by checking `success`. Because `call()` makes an external call, it must be designed carefully to prevent reentrancy."**

---

# 🧠 Final Memory Map

```text
                    ETHER TRANSFER
                          │
             ┌────────────┼────────────┐
             ▼            ▼            ▼
         transfer()     send()       call()
             │            │            │
             ▼            ▼            ▼
          Revert        bool        bool + data
          on fail      on fail       on fail
             │            │            │
             └────────────┼────────────┘
                          │
                          ▼
                  Modern Preferred
                          │
                          ▼
                        call()
                          │
                ┌─────────┴─────────┐
                ▼                   ▼
             ETH value           Calldata
          {value: amount}         (data)
```

> ⭐ **Ultimate memory line:**
>
> **`transfer()` = send + revert on failure; `send()` = send + return false; `call()` = flexible modern low-level call + check `success`.**
