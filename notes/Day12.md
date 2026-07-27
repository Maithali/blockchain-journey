# ➕ Solidity Operators & Conditional Statements — One Page Revision

> 🎯 **Goal:** Learn Solidity operators and conditional statements used for calculations, comparisons, logical decisions, and controlling program flow. These are fundamental concepts in every Solidity interview.

---

# ➕ 1. What are Operators?

## 📌 Definition

**Operators** are special symbols that perform operations on variables and values.

They are used to:

- Perform calculations
- Compare values
- Combine conditions
- Make decisions

---

## 🧒 Explain Like I'm 10

Imagine a calculator.

```text
5 + 3 = 8

10 > 5 = true

true && false = false
```

The symbols (`+`, `>`, `&&`) are operators.

---

## Why Operators?

Operators help to:

- Calculate values
- Compare variables
- Make decisions
- Build program logic

---

## 💡 Remember

> **Operator = Symbol that performs an operation.**

---

# 🧮 2. Arithmetic Operators

## 📌 Definition

Arithmetic operators perform mathematical calculations.

---

## Operators

| Operator | Meaning             | Example      |
| -------- | ------------------- | ------------ |
| `+`      | Addition            | `5 + 3 = 8`  |
| `-`      | Subtraction         | `8 - 2 = 6`  |
| `*`      | Multiplication      | `4 * 5 = 20` |
| `/`      | Division            | `10 / 2 = 5` |
| `%`      | Modulus (Remainder) | `10 % 3 = 1` |
| `++`     | Increment           | `a++`        |
| `--`     | Decrement           | `a--`        |

---

## Example

```solidity
uint a = 20;
uint b = 5;

uint sum = a + b;
uint diff = a - b;
uint product = a * b;
uint quotient = a / b;
uint remainder = a % b;
```

---

## Arithmetic Flow

```text
Variables

↓

Arithmetic Operator

↓

Calculation

↓

Result
```

---

## 💡 Remember

> **Arithmetic Operators = Mathematical Operations**

---

# ⚖️ 3. Comparison Operators

## 📌 Definition

Comparison operators compare two values.

They always return a **Boolean (`true` or `false`)**.

---

## Operators

| Operator | Meaning               | Example    |
| -------- | --------------------- | ---------- |
| `==`     | Equal To              | `5 == 5`   |
| `!=`     | Not Equal             | `5 != 3`   |
| `>`      | Greater Than          | `8 > 5`    |
| `<`      | Less Than             | `3 < 6`    |
| `>=`     | Greater Than or Equal | `10 >= 10` |
| `<=`     | Less Than or Equal    | `4 <= 8`   |

---

## Example

```solidity
uint age = 18;

bool eligible = age >= 18;
```

Result

```text
eligible = true
```

---

## Comparison Flow

```text
Value A

↓

Compare

↓

Value B

↓

true / false
```

---

## 💡 Remember

> **Comparison Operators = True or False**

---

# 🔗 4. Logical Operators

## 📌 Definition

Logical operators combine or negate Boolean expressions.

---

## Operators

| Operator | Meaning     |
| -------- | ----------- | --- | ---------- |
| `&&`     | Logical AND |
| `        |             | `   | Logical OR |
| `!`      | Logical NOT |

---

## Logical AND (`&&`)

Returns `true` only if **both conditions** are true.

```solidity
bool result = true && true;
```

```text
true && true

↓

true
```

---

## Logical OR (`||`)

Returns `true` if **at least one condition** is true.

```solidity
bool result = true || false;
```

```text
true || false

↓

true
```

---

## Logical NOT (`!`)

Reverses a Boolean value.

```solidity
bool result = !true;
```

```text
!true

↓

false
```

---

## Truth Table

| A     | B     | A && B | A \|\| B |
| ----- | ----- | ------ | -------- |
| true  | true  | true   | true     |
| true  | false | false  | true     |
| false | true  | false  | true     |
| false | false | false  | false    |

---

## 💡 Remember

> **&& = Both**

> **|| = Either**

> **! = Opposite**

---

# 🔀 5. Conditional Statements

## 📌 Definition

Conditional statements allow a program to make decisions based on conditions.

---

## Types

```text
Conditional Statements

│

├── if

├── if...else

├── else if

└── nested if
```

---

# ✅ 6. if Statement

Executes a block only if the condition is true.

---

## Syntax

```solidity
if(condition){

    // code

}
```

---

## Example

```solidity
uint age = 20;

if(age >= 18){

    eligible = true;

}
```

---

## Flow

```text
Condition

↓

True?

↓

Yes

↓

Execute Code
```

---

## 💡 Remember

> **if = Execute only when true**

---

# 🔄 7. if...else Statement

Executes one block if true and another if false.

---

## Syntax

```solidity
if(condition){

    // code

}
else{

    // code

}
```

---

## Example

```solidity
if(balance > 0){

    active = true;

}
else{

    active = false;

}
```

---

## Flow

```text
Condition

↓

True?

↓

Yes → Block A

No → Block B
```

---

## 💡 Remember

> **if...else = One of two blocks executes**

---

# 🔁 8. else if Statement

Checks multiple conditions in sequence.

---

## Example

```solidity
if(score >= 90){

    grade = "A";

}
else if(score >= 75){

    grade = "B";

}
else{

    grade = "C";

}
```

---

## Flow

```text
Condition 1

↓

True?

↓

No

↓

Condition 2

↓

True?

↓

No

↓

Else
```

---

## 💡 Remember

> **else if = Multiple Conditions**

---

# 🪆 9. Nested if Statement

An `if` statement inside another `if`.

---

## Example

```solidity
if(age >= 18){

    if(citizen){

        eligible = true;

    }

}
```

---

## Flow

```text
Condition 1

↓

True?

↓

Condition 2

↓

True?

↓

Execute
```

---

## 💡 Remember

> **Nested if = Decision inside another decision**

---

# ⚖️ Operators Comparison

| Category   | Purpose            | Result  |
| ---------- | ------------------ | ------- |
| Arithmetic | Calculate          | Number  |
| Comparison | Compare            | Boolean |
| Logical    | Combine Conditions | Boolean |

---

# 🔄 Complete Concept Flow

```text
                 Operators
                     │
      ┌──────────────┼──────────────┐
      ▼              ▼              ▼
 Arithmetic     Comparison      Logical
      │              │              │
      └──────────────┼──────────────┘
                     ▼
            Conditional Statements
                     │
      ┌──────────────┼──────────────┐
      ▼              ▼              ▼
      if         if...else      else if
                     │
                     ▼
                Nested if
```

---

# 🧠 60-Second Revision

| Topic                     | One-Line Summary                             |
| ------------------------- | -------------------------------------------- |
| ➕ Operators              | Symbols used to perform operations.          |
| 🧮 Arithmetic             | Perform mathematical calculations.           |
| ⚖️ Comparison             | Compare values and return `true` or `false`. |
| 🔗 Logical                | Combine or negate Boolean conditions.        |
| 🔀 Conditional Statements | Control program flow based on conditions.    |
| ✅ if                     | Executes when condition is true.             |
| 🔄 if...else              | Chooses between two blocks.                  |
| 🔁 else if                | Checks multiple conditions.                  |
| 🪆 Nested if              | Places one `if` inside another.              |

---

# 🎯 Golden Rules

- ➕ Operators perform actions on values.
- 🧮 Arithmetic operators return numeric results.
- ⚖️ Comparison operators always return a Boolean.
- 🔗 Logical operators work with Boolean values.
- ✅ `if` executes only when the condition is true.
- 🔄 `if...else` chooses between two paths.
- 🔁 `else if` handles multiple conditions.
- 🪆 Nested `if` allows layered decision-making.

---

# 💼 Solidity Operators & Conditional Statements — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked interview questions.

---

## Q1. What are operators in Solidity?

**Answer:**

Operators are symbols used to perform mathematical, comparison, logical, and assignment operations on variables and values.

---

## Q2. What are arithmetic operators?

**Answer:**

Arithmetic operators perform mathematical calculations.

Examples:

- `+`
- `-`
- `*`
- `/`
- `%`
- `++`
- `--`

---

## Q3. What are comparison operators?

**Answer:**

Comparison operators compare two values and return either `true` or `false`.

Examples:

- `==`
- `!=`
- `>`
- `<`
- `>=`
- `<=`

---

## Q4. What are logical operators?

**Answer:**

Logical operators combine or negate Boolean expressions.

- `&&` (AND)
- `||` (OR)
- `!` (NOT)

---

## Q5. What is a conditional statement?

**Answer:**

A conditional statement executes different blocks of code depending on whether a condition evaluates to `true` or `false`.

---

## Q6. What is an `if` statement?

**Answer:**

It executes a block of code only if its condition is `true`.

---

## Q7. What is the difference between `if` and `if...else`?

**Answer:**

- `if` executes a block only when the condition is true.
- `if...else` executes one block when the condition is true and another when it is false.

---

## Q8. What is an `else if` statement?

**Answer:**

It allows multiple conditions to be checked sequentially until one evaluates to `true`.

---

## Q9. What is a nested `if` statement?

**Answer:**

A nested `if` is an `if` statement placed inside another `if` statement.

---

## Q10. What is the result of comparison operators?

**Answer:**

They always return a Boolean value: `true` or `false`.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which operator calculates the remainder?

`%`

---

### Q12. Which operator checks equality?

`==`

---

### Q13. Which operator means "not equal"?

`!=`

---

### Q14. Which operator means logical AND?

`&&`

---

### Q15. Which operator means logical OR?

`||`

---

### Q16. Which operator reverses a Boolean value?

`!`

---

### Q17. Which statement executes only when a condition is true?

`if`

---

### Q18. Which statement checks multiple conditions?

`else if`

---

### Q19. Which statement has two execution paths?

`if...else`

---

### Q20. What data type do comparison operators return?

`bool`

---

# 🎯 Interview Tips

- Start by defining **operators** before explaining each category.
- Remember:
  - **Arithmetic → Numbers**
  - **Comparison → `bool`**
  - **Logical → `bool`**
- Explain conditional statements as **decision-making structures**.
- Distinguish clearly between **`if`**, **`if...else`**, and **`else if`**.
- Mention that Solidity also supports the **ternary operator (`condition ? value1 : value2`)**, which is useful for simple conditional expressions and is occasionally asked in interviews.

```solidity
//SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

contract LoanEligibility{

    function checkLoanEligibility(uint _age, uint _monthlyIncome) public pure  returns (string memory){

        if(_age >= 21 &&  _monthlyIncome >=30000){
            return "You are eligible for loan";
        }
        else{
            return "You are not eligible for loan";
        }
    }
}
```
