# 📚 Arrays in Solidity — One Page Revision

> 🎯 **Goal:** Learn what arrays are, the types of arrays, array operations, and the difference between fixed and dynamic arrays with Solidity examples. Arrays are one of the most commonly asked Solidity interview topics.

---

# 📚 1. What is an Array?

## 📌 Definition

An **Array** is a **collection of elements of the same data type** stored in sequential order.

Instead of creating multiple variables, you can store multiple values in a single array.

---

## 🧒 Explain Like I'm 10

Imagine a row of lockers.

```text
Locker 0 → 📘

Locker 1 → 📙

Locker 2 → 📗

Locker 3 → 📕
```

Each locker stores one book.

Similarly,

An array stores multiple values using **indexes**.

---

## Example

```solidity
uint[] public numbers = [10, 20, 30, 40];
```

Memory Representation

```text
Index

0 → 10

1 → 20

2 → 30

3 → 40
```

---

## Why Use Arrays?

Arrays help to:

- Store multiple values
- Organize data
- Reduce repetitive variables
- Iterate through collections

---

## 💡 Remember

> **Array = Collection of Same Data Type**

---

# 🗂️ 2. Types of Arrays

There are two main types of arrays in Solidity.

```text
             Arrays
                │
      ┌─────────┴─────────┐
      ▼                   ▼
 Fixed Size Array    Dynamic Array
```

---

# 📏 3. Fixed Size Array

## 📌 Definition

A **Fixed Size Array** has a size that is defined when the array is created.

The size **cannot be changed** later.

---

## Syntax

```solidity
dataType[size] arrayName;
```

---

## Example

```solidity
uint[5] public marks = [10, 20, 30, 40, 50];
```

---

## Representation

```text
Index

0 → 10

1 → 20

2 → 30

3 → 40

4 → 50
```

Maximum Size = 5

---

## Characteristics

- Fixed length
- Cannot grow
- Cannot shrink
- Gas efficient

---

## 💡 Remember

> **Fixed Array = Fixed Number of Elements**

---

# 🔄 4. Dynamic Array

## 📌 Definition

A **Dynamic Array** does not have a fixed size.

Elements can be added or removed.

---

## Syntax

```solidity
dataType[] arrayName;
```

---

## Example

```solidity
uint[] public numbers;
```

Adding Elements

```solidity
numbers.push(10);

numbers.push(20);

numbers.push(30);
```

---

## Representation

```text
Initially

[]

↓

push(10)

[10]

↓

push(20)

[10,20]

↓

push(30)

[10,20,30]
```

---

## Characteristics

- Flexible size
- Can grow
- Can shrink
- More commonly used

---

## 💡 Remember

> **Dynamic Array = Variable Size**

---

# ⚙️ 5. Array Operations

## 📌 Access Element

Use the index.

```solidity
uint value = numbers[1];
```

Result

```text
20
```

---

## 📌 Update Element

```solidity
numbers[0] = 100;
```

Before

```text
10 20 30
```

After

```text
100 20 30
```

---

## 📌 Add Element

Using `push()`.

```solidity
numbers.push(40);
```

---

## 📌 Remove Last Element

Using `pop()`.

```solidity
numbers.pop();
```

Before

```text
10 20 30
```

After

```text
10 20
```

> `pop()` only removes the **last element**.

---

## 📌 Get Length

```solidity
uint size = numbers.length;
```

Result

```text
3
```

---

## 📌 Delete Element

```solidity
delete numbers[1];
```

Before

```text
10 20 30
```

After

```text
10 0 30
```

**Note:** `delete` resets the element to its default value. It **does not reduce** the array length.

---

# 🔄 Array Operations Flow

```text
Create Array

↓

Add (push)

↓

Access

↓

Update

↓

Delete / Pop

↓

Length
```

---

# ⚖️ 6. Fixed Array vs Dynamic Array

| Feature      | Fixed Array | Dynamic Array |
| ------------ | ----------- | ------------- |
| Size         | Fixed       | Variable      |
| Grow         | ❌ No       | ✅ Yes        |
| Shrink       | ❌ No       | ✅ Yes        |
| `push()`     | ❌ No       | ✅ Yes        |
| `pop()`      | ❌ No       | ✅ Yes        |
| Memory Usage | Predictable | Flexible      |
| Common Usage | Rare        | Very Common   |

---

# 📦 Arrays of Different Data Types

## Integer Array

```solidity
uint[] public numbers;
```

---

## Boolean Array

```solidity
bool[] public status;
```

---

## Address Array

```solidity
address[] public users;
```

---

## String Array

```solidity
string[] public names;
```

---

## Bytes32 Array

```solidity
bytes32[] public hashes;
```

---

# 🔄 Complete Concept Flow

```text
                   Arrays
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
   Fixed Array               Dynamic Array
        │                           │
        └─────────────┬─────────────┘
                      ▼
              Array Operations
                      │
      ┌───────────────┼────────────────┐
      ▼               ▼                ▼
    Access         Update           Delete
      │               │                │
      └───────────────┼────────────────┘
                      ▼
              Push • Pop • Length
```

---

# 🧠 60-Second Revision

| Topic            | One-Line Summary                        |
| ---------------- | --------------------------------------- |
| 📚 Array         | Collection of same data type.           |
| 📏 Fixed Array   | Size cannot change.                     |
| 🔄 Dynamic Array | Size can grow or shrink.                |
| ➕ `push()`      | Adds an element to the end.             |
| ➖ `pop()`       | Removes the last element.               |
| 📐 `length`      | Returns the number of elements.         |
| 🗑️ `delete`      | Resets an element to its default value. |

---

# 🎯 Golden Rules

- 📚 Arrays store multiple values of the **same type**.
- 📍 Array indexing starts at **0**.
- 📏 Fixed arrays cannot change size.
- 🔄 Dynamic arrays can grow and shrink.
- ➕ `push()` adds a new element.
- ➖ `pop()` removes the last element.
- 📐 `length` gives the array size.
- 🗑️ `delete` resets an element but **does not remove it**.

---

# 💼 Solidity Arrays — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity array interview questions.

---

## Q1. What is an array in Solidity?

**Answer:**

An array is a collection of elements of the same data type stored in sequential order and accessed using indexes.

---

## Q2. What are the types of arrays in Solidity?

**Answer:**

- Fixed Size Array
- Dynamic Array

---

## Q3. What is a fixed-size array?

**Answer:**

A fixed-size array has a predefined length that cannot be changed after creation.

Example:

```solidity
uint[3] public values = [1, 2, 3];
```

---

## Q4. What is a dynamic array?

**Answer:**

A dynamic array has no fixed length and can grow or shrink during execution.

Example:

```solidity
uint[] public values;
```

---

## Q5. How do you add an element to a dynamic array?

**Answer:**

Using the `push()` function.

```solidity
values.push(100);
```

---

## Q6. How do you remove the last element?

**Answer:**

Using the `pop()` function.

```solidity
values.pop();
```

---

## Q7. How do you access an array element?

**Answer:**

By using its index.

```solidity
values[0];
```

---

## Q8. How do you find the length of an array?

**Answer:**

Using the `.length` property.

```solidity
values.length;
```

---

## Q9. What does `delete` do to an array element?

**Answer:**

It resets the element to its default value but does not reduce the array's length.

---

## Q10. What is the first index of an array?

**Answer:**

`0`

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which array can grow?

Dynamic array.

---

### Q12. Which function adds an element?

`push()`

---

### Q13. Which function removes the last element?

`pop()`

---

### Q14. Which property returns array size?

`length`

---

### Q15. What is the index of the first element?

`0`

---

### Q16. Can a fixed array change its size?

No.

---

### Q17. Does `delete` remove an element completely?

No. It resets it to the default value.

---

### Q18. Can arrays store addresses?

Yes.

---

### Q19. Can arrays store strings?

Yes.

---

### Q20. Which array type is most commonly used in smart contracts?

Dynamic arrays.

---

# 🎯 Interview Tips

- Begin with: **"An array is a collection of elements of the same data type."**
- Remember that **array indexes start at `0`**.
- Clearly explain the difference between **fixed** and **dynamic** arrays.
- Know the common array operations: **`push()`**, **`pop()`**, **`length`**, indexing, and **`delete`**.
- Mention that **`push()`** and **`pop()`** work only with **dynamic storage arrays**, not fixed-size arrays or memory arrays.
- Don't confuse **`delete`** (resets a value) with **`pop()`** (removes the last element and reduces the array length).

```solidity
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FavoriteMovies{

    string[] public movies;

    function addMovieName(string memory _movieName) public {
            movies.push(_movieName);
    }

    function removeLastMovie() public{
        movies.pop();
    }

    function totalMovies() public view returns (uint){
        return movies.length;
    }




}
```
