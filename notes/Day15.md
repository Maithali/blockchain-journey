# 🔁 Loops in Solidity — One Page Revision

> 🎯 **Goal:** Learn what loops are, understand `for` and `while` loops, compare them, learn gas optimization techniques, gas considerations, and practice with Solidity examples. Loops are a common Solidity interview topic, especially regarding **gas efficiency**.

---

# 🔁 1. What is a Loop?

## 📌 Definition

A **Loop** is a programming construct that allows a block of code to execute **repeatedly** until a specified condition becomes false.

Instead of writing the same code multiple times, a loop automates repetition.

---

## 🧒 Explain Like I'm 10

Imagine your teacher asks you to write:

```text
I will practice Solidity.
```

10 times.

Without a loop:

```text
Write

Write

Write

...

10 times
```

With a loop:

```text
Repeat 10 Times

↓

Done!
```

---

## Why Use Loops?

Loops help to:

- Avoid repetitive code
- Process arrays
- Count values
- Search data
- Perform repeated calculations

---

## 💡 Remember

> **Loop = Repeat Until Condition Becomes False**

---

# 🔄 2. Types of Loops

Solidity mainly supports:

```text
Loops

│

├── for Loop

└── while Loop
```

> **Note:** Solidity also supports `do...while`, but it is rarely used in smart contracts and is generally avoided because it executes at least once before checking the condition.

---

# 🔢 3. for Loop

## 📌 Definition

A **for loop** is used when the **number of iterations is known** before the loop starts.

---

## Syntax

```solidity
for (
    initialization;
    condition;
    increment
) {

    // code

}
```

---

## Flow

```text
Initialize

↓

Check Condition

↓

Execute Code

↓

Increment

↓

Repeat
```

---

## Example 1 – Print Numbers

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ForLoopExample {

    uint[] public numbers;

    function generateNumbers() public {

        delete numbers;

        for (uint i = 1; i <= 5; i++) {

            numbers.push(i);

        }
    }
}
```

### Output

```text
[1, 2, 3, 4, 5]
```

### Explanation

- `i = 1` → Push 1
- `i = 2` → Push 2
- `i = 3` → Push 3
- `i = 4` → Push 4
- `i = 5` → Push 5
- `i = 6` → Condition becomes false → Stop

---

## 💡 Remember

> **for Loop = Known Number of Iterations**

---

# 🔄 4. while Loop

## 📌 Definition

A **while loop** executes as long as its condition remains `true`.

It is useful when the number of iterations is **not known in advance**.

---

## Syntax

```solidity
while (condition) {

    // code

}
```

---

## Flow

```text
Condition

↓

True?

↓

Execute Code

↓

Repeat

↓

False

↓

Stop
```

---

## Example 2 – Using while Loop

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WhileLoopExample {

    uint[] public numbers;

    function generateNumbers() public {

        delete numbers;

        uint i = 1;

        while (i <= 5) {

            numbers.push(i);

            i++;

        }
    }
}
```

### Output

```text
[1, 2, 3, 4, 5]
```

### Explanation

The loop starts with `i = 1`.

It keeps adding numbers until `i` becomes 6.

---

## 💡 Remember

> **while Loop = Repeat Until Condition Becomes False**

---

# 📊 5. for Loop vs while Loop

| Feature            | for Loop         | while Loop         |
| ------------------ | ---------------- | ------------------ |
| Best Use           | Known iterations | Unknown iterations |
| Initialization     | Inside loop      | Outside loop       |
| Increment          | Inside loop      | Manual             |
| Readability        | Cleaner          | Flexible           |
| Infinite Loop Risk | Lower            | Higher             |
| Common in Solidity | ✅ Very Common   | ⚠️ Less Common     |

---

# ⛽ 6. Gas Considerations

## 📌 Why Are Loops Expensive?

Every iteration consumes **gas**.

More iterations = More gas.

```text
1 Iteration

↓

Low Gas

-----------------

1000 Iterations

↓

High Gas

-----------------

100000 Iterations

↓

May Run Out of Gas
```

---

## Example

```solidity
for (uint i = 0; i < 10000; i++) {

    // expensive operation

}
```

This may exceed the block gas limit and cause the transaction to revert.

---

## 💡 Remember

> **More Loop Iterations = More Gas Consumption**

---

# 🚀 7. Gas Optimization Tips

## ✅ Keep Loops Small

Prefer:

```solidity
for(uint i = 0; i < 10; i++){}
```

Instead of:

```solidity
for(uint i = 0; i < 100000; i++){}
```

---

## ✅ Avoid Unnecessary Storage Writes

Storage writes are expensive.

Better:

```solidity
uint temp = total;
```

Instead of repeatedly writing to storage inside the loop.

---

## ✅ Cache Array Length

Instead of:

```solidity
for(uint i = 0; i < numbers.length; i++)
```

Use:

```solidity
uint length = numbers.length;

for(uint i = 0; i < length; i++) {

}
```

This avoids reading storage on every iteration.

---

## ✅ Avoid Infinite Loops

Bad

```solidity
while(true){

}
```

This will never finish and always run out of gas.

---

## ✅ Use `unchecked` When Safe

In Solidity 0.8+, arithmetic overflow checks consume gas.

If overflow is impossible:

```solidity
for (uint i = 0; i < 10;) {

    // code

    unchecked {
        i++;
    }
}
```

Only use this when you're certain overflow cannot occur.

---

## 💡 Remember

> **Efficient Loops Save Gas and Reduce Transaction Costs**

---

# 🧩 8. Example 3 – Sum of Array Elements

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SumArray {

    uint[] public numbers = [5, 10, 15, 20];

    function getSum()
        public
        view
        returns(uint)
    {

        uint total = 0;

        for(uint i = 0; i < numbers.length; i++){

            total += numbers[i];

        }

        return total;
    }

}
```

### Output

```text
5 + 10 + 15 + 20

↓

50
```

### Explanation

- Start with `total = 0`
- Add each array element
- Return the final sum (`50`)

---

# 🔄 Complete Concept Flow

```text
                  Loops
                     │
         ┌───────────┴───────────┐
         ▼                       ▼
      for Loop             while Loop
         │                       │
         └───────────┬───────────┘
                     ▼
             Repeat Statements
                     │
                     ▼
              Consume Gas
                     │
                     ▼
            Gas Optimization
```

---

# 🧠 60-Second Revision

| Topic                | One-Line Summary                                                                  |
| -------------------- | --------------------------------------------------------------------------------- |
| 🔁 Loop              | Repeats code until a condition becomes false.                                     |
| 🔢 for Loop          | Best when the number of iterations is known.                                      |
| 🔄 while Loop        | Best when iterations depend on a condition.                                       |
| ⚖️ for vs while      | `for` is cleaner; `while` is more flexible.                                       |
| ⛽ Gas Consideration | Every iteration costs gas.                                                        |
| 🚀 Gas Optimization  | Keep loops small, cache array length, avoid storage writes, avoid infinite loops. |

---

# 🎯 Golden Rules

- 🔁 Loops repeat code automatically.
- 🔢 Use a **`for` loop** when the number of iterations is known.
- 🔄 Use a **`while` loop** when the stopping condition is dynamic.
- ⛽ Every loop iteration consumes gas.
- 🚫 Avoid very large or infinite loops in transactions.
- 📦 Cache array length when iterating over storage arrays.
- ⚡ Minimize storage reads and writes inside loops.
- 🛡️ Use `unchecked` only when overflow is impossible.

---

# 💼 Solidity Loops — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity loop interview questions.

---

## Q1. What is a loop in Solidity?

**Answer:**

A loop repeatedly executes a block of code until a specified condition becomes false.

---

## Q2. Which loops are commonly used in Solidity?

**Answer:**

- `for`
- `while`

(`do...while` exists but is rarely used.)

---

## Q3. When should you use a `for` loop?

**Answer:**

Use a `for` loop when the number of iterations is known before execution.

---

## Q4. When should you use a `while` loop?

**Answer:**

Use a `while` loop when the number of iterations depends on a condition evaluated during execution.

---

## Q5. Why are loops expensive in Solidity?

**Answer:**

Each iteration consumes gas. Large loops can exceed the block gas limit and cause the transaction to revert.

---

## Q6. How can you optimize loops for gas?

**Answer:**

- Keep loops short.
- Cache array length.
- Reduce storage reads and writes.
- Avoid unnecessary computations.
- Use `unchecked` only when safe.

---

## Q7. What happens if a loop never ends?

**Answer:**

The transaction eventually runs out of gas and reverts.

---

## Q8. What is the difference between `for` and `while`?

**Answer:**

- `for` combines initialization, condition, and increment in one statement.
- `while` checks only the condition, so initialization and increment are handled separately.

---

## Q9. Can loops modify blockchain state?

**Answer:**

Yes. If the loop writes to storage, it modifies the blockchain state and consumes additional gas.

---

## Q10. Why should large loops over storage arrays be avoided?

**Answer:**

Because every storage read/write costs gas, large arrays can make transactions too expensive or impossible to execute within the gas limit.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which loop is most commonly used in Solidity?

`for`

---

### Q12. Which loop is best for unknown iterations?

`while`

---

### Q13. Does every loop iteration consume gas?

Yes.

---

### Q14. Which function gets an array's size?

`.length`

---

### Q15. Why cache `array.length`?

To avoid repeated storage reads and reduce gas usage.

---

### Q16. What happens when gas runs out?

The transaction reverts.

---

### Q17. Are infinite loops allowed?

They compile, but transactions using them will fail due to running out of gas.

---

### Q18. Should you loop through very large storage arrays in one transaction?

Generally, no.

---

### Q19. What keyword can reduce gas in safe arithmetic loops?

`unchecked`

---

### Q20. Which loop is generally easier to read?

`for`

---

# 🎯 Interview Tips

- Start with: **"A loop repeatedly executes a block of code until a condition becomes false."**
- Mention that **gas consumption is a major consideration** when using loops in Solidity.
- Explain why **large loops can cause out-of-gas errors**.
- Remember practical optimizations:
  - Cache `array.length`
  - Minimize storage operations
  - Keep loops bounded
  - Use `unchecked` only when it's provably safe
- In interviews, emphasize that **loop design affects both correctness and gas efficiency**.
