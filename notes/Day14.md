# 🏗️ Solidity Struct — One Page Revision

> 🎯 **Goal:** Learn what a `struct` is, why it is used, how to create a struct, declare struct variables, update struct values, and understand a complete Solidity example. Structs are one of the most frequently asked Solidity interview topics.

---

# 🏗️ 1. What is a Struct?

## 📌 Definition

A **Struct** is a **user-defined data type** that allows you to group multiple variables of different data types into a single unit.

Instead of storing related information in separate variables, a struct keeps everything together.

---

## 🧒 Explain Like I'm 10

Imagine a **Student ID Card**.

It contains:

```text
👤 Name

🎂 Age

🆔 Roll Number

🏠 Address
```

Instead of keeping each piece of information separately, everything belongs to **one student**.

A **struct** works exactly the same way.

---

## Without Struct

```solidity
string name;
uint age;
uint rollNo;
address wallet;
```

Many separate variables.

---

## With Struct

```solidity
struct Student {

    string name;

    uint age;

    uint rollNo;

    address wallet;

}
```

Everything is grouped together.

---

## 💡 Remember

> **Struct = Group of Related Variables**

---

# 🎯 2. Why Use Struct?

Structs help to:

- Group related data
- Improve code readability
- Reduce multiple variables
- Represent real-world objects
- Store complex records

---

## Real-Life Examples

```text
👤 Student

🏦 Bank Account

🚗 Car

📦 Product

🏥 Patient

👨 Employee
```

Each object has multiple properties.

---

## 💡 Remember

> **Struct = Real-World Object Representation**

---

# ✍️ 3. Creating a Struct

## 📌 Syntax

```solidity
struct StructName {

    dataType variable1;

    dataType variable2;

}
```

---

## Example

```solidity
struct Student {

    string name;

    uint age;

    uint rollNo;

    bool isActive;

}
```

---

## Structure

```text
Student

│

├── Name

├── Age

├── Roll Number

└── Active Status
```

---

## 💡 Remember

> **Use the `struct` keyword to define a new custom data type.**

---

# 📦 4. Declaring Struct Variables

After defining a struct, you can create variables of that type.

---

## Syntax

```solidity
StructName variableName;
```

---

## Example

```solidity
Student public student1;
```

---

## Multiple Struct Variables

```solidity
Student public student1;

Student public student2;
```

Each variable stores a different student's information.

---

## 💡 Remember

> **Struct Name = Data Type**

---

# ✏️ 5. Updating Struct Values

You can assign values to each member individually.

---

## Example

```solidity
student1.name = "Alice";

student1.age = 20;

student1.rollNo = 101;

student1.isActive = true;
```

---

## Or Initialize All at Once

```solidity
student1 = Student(
    "Alice",
    20,
    101,
    true
);
```

---

## Result

```text
Student

Name      → Alice

Age       → 20

Roll No   → 101

Active    → true
```

---

## 💡 Remember

> **Struct members are accessed using the dot (`.`) operator.**

---

# 🧩 6. Complete Solidity Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRecord {

    // Step 1: Create Struct
    struct Student {
        string name;
        uint age;
        uint rollNo;
        bool isActive;
    }

    // Step 2: Declare Struct Variable
    Student public student;

    // Step 3: Store Student Details
    function setStudent(
        string memory _name,
        uint _age,
        uint _rollNo,
        bool _isActive
    ) public {

        student.name = _name;
        student.age = _age;
        student.rollNo = _rollNo;
        student.isActive = _isActive;
    }

    // Step 4: Read Student Details
    function getStudent()
        public
        view
        returns (
            string memory,
            uint,
            uint,
            bool
        )
    {
        return (
            student.name,
            student.age,
            student.rollNo,
            student.isActive
        );
    }
}
```

---

# 🔍 Code Explanation

### Step 1 – Create the Struct

```solidity
struct Student {
    string name;
    uint age;
    uint rollNo;
    bool isActive;
}
```

Creates a custom data type named `Student` containing four related fields.

---

### Step 2 – Declare a Struct Variable

```solidity
Student public student;
```

Creates one variable named `student` that can store all student information.

---

### Step 3 – Store Data

```solidity
function setStudent(...) public
```

This function updates all fields of the `student` struct using the values passed by the user.

Example call:

```text
Name      = Alice

Age       = 20

Roll No   = 101

Active    = true
```

Stored as:

```text
Student

├── Name      → Alice

├── Age       → 20

├── Roll No   → 101

└── Active    → true
```

---

### Step 4 – Read Data

```solidity
function getStudent() public view
```

Returns all stored student information.

Output:

```text
Alice

20

101

true
```

---

# 🌍 Real-World Example

## Employee Record

```text
Employee

│

├── Name

├── Employee ID

├── Salary

├── Department

└── Wallet Address
```

Instead of creating five separate variables, create one `Employee` struct.

---

# 📊 Struct vs Multiple Variables

| Multiple Variables      | Struct             |
| ----------------------- | ------------------ |
| Many separate variables | One grouped object |
| Difficult to manage     | Easy to manage     |
| Less organized          | Well organized     |
| Repeated code           | Cleaner code       |
| Hard to scale           | Easy to scale      |

---

# 🔄 Complete Concept Flow

```text
             Struct
                │
        ┌───────┴────────┐
        ▼                ▼
 Create Struct     Declare Variable
        │                │
        ▼                ▼
  Store Values      Update Values
        │                │
        └────────┬───────┘
                 ▼
          Read Struct Data
```

---

# 🧠 60-Second Revision

| Topic               | One-Line Summary                            |
| ------------------- | ------------------------------------------- |
| 🏗️ Struct           | User-defined type that groups related data. |
| ✍️ Create Struct    | Use the `struct` keyword.                   |
| 📦 Declare Variable | Create variables using the struct type.     |
| ✏️ Update Values    | Access members with the dot (`.`) operator. |
| 👀 Read Values      | Return struct members from a function.      |

---

# 🎯 Golden Rules

- 🏗️ A struct groups **different data types** into one object.
- ✍️ Define a struct using the `struct` keyword.
- 📦 A struct name becomes a **new data type**.
- 🔹 Access members using the **dot (`.`)** operator.
- 📝 Structs make code cleaner and easier to maintain.
- 🌍 Structs are ideal for modeling real-world entities like students, employees, products, and bank accounts.

---

# 💼 Solidity Struct — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity struct interview questions.

---

## Q1. What is a struct in Solidity?

**Answer:**

A struct is a user-defined data type that groups multiple related variables, possibly of different data types, into a single unit.

---

## Q2. Why do we use structs?

**Answer:**

Structs organize related data, improve readability, reduce multiple variables, and represent real-world entities.

---

## Q3. How do you create a struct?

**Answer:**

Use the `struct` keyword.

```solidity
struct Student {
    string name;
    uint age;
}
```

---

## Q4. How do you declare a struct variable?

**Answer:**

```solidity
Student public student;
```

---

## Q5. How do you access a struct member?

**Answer:**

Using the dot (`.`) operator.

```solidity
student.name = "Alice";
```

---

## Q6. Can a struct contain different data types?

**Answer:**

Yes. A struct can contain strings, integers, booleans, addresses, arrays, mappings (with restrictions), and other structs.

---

## Q7. Can a struct contain another struct?

**Answer:**

Yes. Nested structs are supported.

---

## Q8. Where can structs be stored?

**Answer:**

Structs can exist in:

- `storage`
- `memory`
- `calldata` (for external function parameters)

---

## Q9. Can we create an array of structs?

**Answer:**

Yes.

Example:

```solidity
Student[] public students;
```

---

## Q10. Can we use a mapping with structs?

**Answer:**

Yes.

Example:

```solidity
mapping(uint => Student) public students;
```

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword creates a struct?

`struct`

---

### Q12. Can a struct contain multiple data types?

Yes.

---

### Q13. Which operator accesses a struct member?

`.` (dot operator)

---

### Q14. Is a struct a built-in data type?

No. It is a user-defined data type.

---

### Q15. Can a struct contain a Boolean?

Yes.

---

### Q16. Can a struct contain an address?

Yes.

---

### Q17. Can you create multiple variables from the same struct?

Yes.

---

### Q18. Can a struct be returned from a function?

Yes, depending on the function signature and data location.

---

### Q19. Can structs be stored in arrays?

Yes.

---

### Q20. What is the main purpose of a struct?

To group related data into a single logical unit.

---

# 🎯 Interview Tips

- Start with: **"A struct is a user-defined data type that groups related variables into one unit."**
- Explain using a real-world example like a **Student**, **Employee**, or **Product**.
- Mention that the **struct name becomes a new data type**.
- Remember to use the **dot (`.`)** operator to access and update members.
- Know that structs are commonly used with **arrays** and **mappings** to build scalable smart contracts.
