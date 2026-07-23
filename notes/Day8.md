````md
# ⚡ Solidity Functions — One Page Revision

> 🎯 **Goal:** Learn what functions are, how they are declared, how parameters and return values work, and how functions are called. Functions are one of the most frequently asked Solidity interview topics.

---

# ⚡ 1. What is a Function?

## 📌 Definition

A **Function** is a reusable block of code that performs a specific task.

Instead of writing the same code multiple times, you write it once inside a function and call it whenever needed.

Functions can:

- Accept inputs (parameters)
- Process data
- Return outputs
- Read or modify blockchain data

---

## 🧒 Explain Like I'm 10

Imagine a juice machine.

You put fruits in.

The machine processes them.

It gives you juice.

```text
🍎 + 🍌

↓

Juice Machine

↓

🥤 Juice
```

A Solidity function works exactly like this.

Input → Processing → Output

---

## Example

```solidity
function sayHello() public pure returns(string memory){

    return "Hello Solidity";

}
```

---

## Why Use Functions?

Functions help to:

- Reuse code
- Organize logic
- Improve readability
- Reduce duplicate code
- Simplify maintenance

---

## 💡 Remember

> **Function = A reusable block of code that performs a task.**

---

# 🏗️ 2. Function Syntax

Every Solidity function follows this general syntax.

```solidity
function functionName(parameters)
    visibility
    stateMutability
    returns(returnType)
{

    // Code

}
```

---

## Example

```solidity
function add(
    uint256 a,
    uint256 b
)
    public
    pure
    returns(uint256)
{
    return a + b;
}
```

---

## Syntax Breakdown

```text
function

↓

Function Name

↓

Parameters

↓

Visibility

↓

State Mutability

↓

Returns

↓

Function Body
```

---

## 💡 Remember

> **Function → Name → Parameters → Visibility → Mutability → Returns → Body**

---

# 📥 3. Function Parameters

## 📌 Definition

Parameters are the **input values** passed into a function.

They allow one function to work with different data.

---

## Example

```solidity
function multiply(
    uint256 a,
    uint256 b
)
    public
    pure
    returns(uint256)
{
    return a * b;
}
```

Calling

```text
multiply(5,4)

↓

20
```

---

## Multiple Parameters

```solidity
function register(
    string memory name,
    uint256 age,
    bool verified
)
    public
{

}
```

---

## Parameter Flow

```text
Input Values

↓

Parameters

↓

Function Executes

↓

Output
```

---

## 💡 Remember

> **Parameters = Input to a function.**

---

# 📤 4. Return Values

## 📌 Definition

Return values are the **output** produced by a function.

A function may return:

- One value
- Multiple values
- No value

---

## Single Return

```solidity
function square(uint256 x)
    public
    pure
    returns(uint256)
{
    return x * x;
}
```

---

## Multiple Returns

```solidity
function getData()
    public
    pure
    returns(
        uint256,
        bool
    )
{
    return (100, true);
}
```

---

## Named Returns

```solidity
function add(
    uint256 a,
    uint256 b
)
    public
    pure
    returns(uint256 sum)
{
    sum = a + b;
}
```

---

## Return Flow

```text
Input

↓

Function

↓

Calculation

↓

Return Value
```

---

## 💡 Remember

> **Returns = Output of a function.**

---

# 📞 5. Calling Functions

Functions can be called in different ways.

---

## Calling from Inside the Same Contract

```solidity
contract Calculator{

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

    function calculate()
        public
        pure
        returns(uint)
    {
        return add(5,10);
    }

}
```

---

## Calling Using `this`

```solidity
this.add(5,10);
```

Uses an external call.

Consumes more gas.

---

## Calling Another Contract

```solidity
Calculator calculator = new Calculator();

calculator.add(5,10);
```

---

## Function Call Flow

```text
User

↓

Calls Function

↓

Parameters Passed

↓

Execution

↓

Return Value
```

---

## 💡 Remember

> **A function runs only when it is called.**

---

# 🔄 Functions with Different Behaviors

## No Parameters, No Return

```solidity
function hello() public{

}
```

---

## Parameters, No Return

```solidity
function setAge(
    uint age
)
    public
{

}
```

---

## No Parameters, Return Value

```solidity
function getNumber()
    public
    pure
    returns(uint)
{
    return 100;
}
```

---

## Parameters and Return

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

# ⚖️ Parameters vs Return Values

| Parameters       | Return Values          |
| ---------------- | ---------------------- |
| Input            | Output                 |
| Sent to function | Returned from function |
| Optional         | Optional               |
| Can be multiple  | Can be multiple        |

---

# 🔄 Complete Concept Flow

```text
                 Function
                     │
         ┌───────────┼───────────┐
         ▼           ▼           ▼
     Parameters   Processing   Returns
         │                       │
         └───────────┬───────────┘
                     ▼
             Function Execution
                     │
                     ▼
             Calling Function
         ┌───────────┼───────────┐
         ▼           ▼           ▼
    Same Contract   this      Another Contract
```

---

# 🧠 60-Second Revision

| Topic                | One-Line Summary                                                            |
| -------------------- | --------------------------------------------------------------------------- |
| ⚡ Function          | Reusable block of code that performs a task.                                |
| 🏗️ Syntax            | Function name, parameters, visibility, mutability, returns, body.           |
| 📥 Parameters        | Inputs passed to a function.                                                |
| 📤 Return Values     | Outputs returned by a function.                                             |
| 📞 Calling Functions | Functions can be called internally, using `this`, or from another contract. |

---

# 🎯 Golden Rules

- ⚡ A function performs one specific task.
- 📥 Parameters provide input.
- 📤 Return values provide output.
- 🔁 Functions promote code reuse.
- 📞 Functions execute only when called.
- 🚀 Internal calls are cheaper than external calls using `this`.

---

# 💼 Solidity Functions — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity function interview questions.

---

## Q1. What is a function in Solidity?

**Answer:**

A function is a reusable block of code that performs a specific task. It can accept inputs, execute logic, and optionally return outputs.

---

## Q2. What is the general syntax of a Solidity function?

**Answer:**

```solidity
function functionName(parameters)
    visibility
    stateMutability
    returns(returnType)
{

}
```

---

## Q3. What are function parameters?

**Answer:**

Parameters are input values passed into a function when it is called.

---

## Q4. What are return values?

**Answer:**

Return values are the outputs produced by a function after execution.

---

## Q5. Can a function return multiple values?

**Answer:**

Yes.

Example:

```solidity
returns(uint256,bool)
```

---

## Q6. Can a function have no parameters?

**Answer:**

Yes.

```solidity
function hello() public{

}
```

---

## Q7. Can a function have no return value?

**Answer:**

Yes.

Functions that only update state often don't return anything.

---

## Q8. How do you call a function in the same contract?

**Answer:**

Call it directly using its name.

```solidity
add(5,10);
```

---

## Q9. What does `this.functionName()` do?

**Answer:**

It performs an **external call** to the current contract, which consumes more gas than an internal function call.

---

## Q10. Can one contract call another contract's function?

**Answer:**

Yes. Create or reference an instance of the other contract and call its public or external functions.

---

## ⚡ Rapid Fire Interview Questions

### Q11. Which keyword starts every function?

`function`

---

### Q12. Which part receives input?

Parameters.

---

### Q13. Which part specifies output?

`returns`

---

### Q14. Can a function return multiple values?

Yes.

---

### Q15. Are parameters mandatory?

No.

---

### Q16. Are return values mandatory?

No.

---

### Q17. Which is cheaper: internal call or `this` call?

Internal function call.

---

### Q18. Can functions call other functions?

Yes.

---

# 🎯 Interview Tips

- Always explain a function as **Input → Processing → Output**.
- Know the complete function syntax: **function → parameters → visibility → state mutability → returns → body**.
- Understand the difference between **parameters (inputs)** and **return values (outputs)**.
- Remember that calling a function with `this` creates an external call and usually costs more gas.
- In interviews, distinguish between **calling a function within the same contract** and **calling a function on another contract**.
````
