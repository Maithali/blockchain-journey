# 💎 Solidity Fundamentals — One Page Revision

> 🎯 **Goal:** Learn the basics of Solidity, understand its file structure, comments, and how smart contracts are written. These are among the first Solidity interview questions.

---

# 💎 1. What is Solidity?

**Solidity** is a **high-level, object-oriented programming language** used to write **Smart Contracts** that run on the **Ethereum Virtual Machine (EVM)**.

It is the primary programming language for developing decentralized applications (**DApps**) on Ethereum and other EVM-compatible blockchains.

---

## 🧒 Explain Like I'm 10

Imagine a vending machine.

You insert money.

Choose a snack.

The machine automatically checks your payment and gives you the snack.

Nobody controls it manually.

A **Smart Contract** works the same way.

**Solidity is the language used to write the vending machine's rules.**

---

## Key Features

- 💎 High-Level Language
- 🤖 Smart Contract Language
- ⛓️ Runs on Ethereum Blockchain
- ⚡ Compiled Language
- 🔒 Secure & Deterministic
- 🧩 Object-Oriented

---

## 💡 Remember

> **Solidity = JavaScript + C++ + Blockchain**

---

# ⚙️ 2. Why Solidity?

Solidity allows developers to create programs that automatically execute agreements without requiring a trusted third party.

---

## Why Developers Use Solidity

- Build Smart Contracts
- Create Tokens
- Build NFTs
- Develop DeFi Applications
- DAO Governance
- Web3 Applications

---

## Examples

- ERC-20 Tokens
- ERC-721 NFTs
- Voting Systems
- Crowdfunding
- Staking
- Marketplaces

---

## 💡 Remember

> **Solidity is to Ethereum what Java is to Android.**

---

# 🖥️ 3. Where Does Solidity Run?

## Flow

```text
Developer

↓

Solidity Code (.sol)

↓

Compiler (solc)

↓

Bytecode

↓

Ethereum Virtual Machine (EVM)

↓

Blockchain
```

---

## Components

- Solidity Source Code
- Solidity Compiler
- Bytecode
- ABI
- EVM
- Blockchain

---

## 💡 Remember

> Solidity never runs directly.
>
> It is compiled into bytecode that runs on the EVM.

---

# 📁 4. Solidity File Structure

Every Solidity file follows a common structure.

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyContract {

}
```

---

## Structure Breakdown

### 1️⃣ SPDX License

```solidity
// SPDX-License-Identifier: MIT
```

Defines the software license.

Common licenses:

- MIT
- GPL-3.0
- Apache-2.0
- UNLICENSED

---

### 2️⃣ Pragma Directive

```solidity
pragma solidity ^0.8.30;
```

Specifies which compiler versions can compile the contract.

Example

```text
^0.8.30

Minimum → 0.8.30

Maximum → below 0.9.0
```

---

### 3️⃣ Import Statements

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

Imports code from another Solidity file.

Similar to

- include (C)
- import (Java)
- import (Python)

---

### 4️⃣ Contract Declaration

```solidity
contract MyContract {

}
```

Every Solidity program is written inside a contract.

A contract is similar to a class in OOP.

---

## Complete Flow

```text
SPDX

↓

Pragma

↓

Imports

↓

Contract

↓

State Variables

↓

Constructor

↓

Functions

↓

Events

↓

Modifiers
```

---

## 💡 Remember

> Every Solidity file starts with License → Pragma → Imports → Contract

---

# 💬 5. Comments in Solidity

Comments improve readability and documentation.

---

## Single Line Comment

```solidity
// This is a comment
```

---

## Multi-line Comment

```solidity
/*
This is a
multi-line comment.
*/
```

---

## Documentation Comment

```solidity
/// Returns total balance
function balance() public {}
```

or

```solidity
/**
 * @notice Transfers tokens
 * @param to Receiver address
 * @param amount Number of tokens
 */
```

Used by documentation generators like NatSpec.

---

## Why Use Comments?

- Explain logic
- Improve readability
- Documentation
- Easier maintenance
- Team collaboration

---

## 💡 Remember

> Good code tells.
>
> Good comments explain **why**.

---

# ⚖️ Solidity vs JavaScript

| Feature   | Solidity        | JavaScript        |
| --------- | --------------- | ----------------- |
| Runs On   | EVM             | Browser / Node.js |
| Purpose   | Smart Contracts | Web Applications  |
| Execution | Blockchain      | Local / Server    |
| Gas Cost  | Yes             | No                |
| Immutable | Yes             | No                |

---

# 🧠 Complete Solidity Flow

```text
          Solidity Source Code
                   │
                   ▼
           SPDX License
                   │
                   ▼
         Pragma Version
                   │
                   ▼
              Imports
                   │
                   ▼
             Contract
                   │
      ┌────────────┼────────────┐
      ▼            ▼            ▼
 Variables    Constructor    Functions
                   │
                   ▼
              Compilation
                   │
                   ▼
               Bytecode
                   │
                   ▼
                  EVM
                   │
                   ▼
              Blockchain
```

---

# 🧠 60-Second Revision

| Topic             | One-Line Summary                                                  |
| ----------------- | ----------------------------------------------------------------- |
| 💎 Solidity       | Programming language for Smart Contracts.                         |
| ⚙️ Why Solidity   | Used to build DApps, Tokens, NFTs, and DeFi.                      |
| 🖥️ EVM            | Executes Solidity bytecode.                                       |
| 📁 File Structure | License → Pragma → Imports → Contract                             |
| 💬 Comments       | Single-line, Multi-line, Documentation                            |
| ⚖️ Solidity vs JS | Solidity runs on blockchain; JavaScript runs on browsers/servers. |

---

# 🎯 Golden Rules

- 💎 Solidity writes Smart Contracts.
- ⚙️ Smart Contracts run on the EVM.
- 📁 Every Solidity file starts with SPDX and pragma.
- 💬 Use comments to explain intent, not obvious code.
- 🔒 Solidity contracts become immutable once deployed (unless designed to be upgradeable).
- ⛽ Executing Solidity code on-chain consumes gas.

---

# 💼 Solidity Fundamentals — Interview Questions & Answers

> 🎯 **Goal:** Frequently asked Solidity interview questions for freshers.

---

## Q1. What is Solidity?

**Answer:**

Solidity is a high-level programming language used to develop Smart Contracts that run on the Ethereum Virtual Machine (EVM).

---

## Q2. Why is Solidity used?

**Answer:**

It is used to build decentralized applications, tokens, NFTs, DAOs, DeFi protocols, and other blockchain-based applications.

---

## Q3. What is the EVM?

**Answer:**

The Ethereum Virtual Machine is the runtime environment that executes compiled Solidity bytecode on Ethereum and compatible blockchains.

---

## Q4. What is the purpose of `pragma`?

**Answer:**

It specifies the Solidity compiler version(s) compatible with the contract.

Example:

```solidity
pragma solidity ^0.8.30;
```

---

## Q5. What does `^` mean in `pragma solidity ^0.8.30;`?

**Answer:**

It allows compilation with version **0.8.30** and any newer **0.8.x** version, but **not 0.9.0** or higher.

---

## Q6. Why is the SPDX license included?

**Answer:**

It declares the software license for the source code, making licensing clear for users and tools.

---

## Q7. What is a contract in Solidity?

**Answer:**

A contract is the basic building block in Solidity. It contains state variables, functions, events, modifiers, and constructors, similar to a class in object-oriented programming.

---

## Q8. What types of comments are available?

**Answer:**

- Single-line (`//`)
- Multi-line (`/* */`)
- Documentation comments (`///` and `/** */`)

---

## Q9. Does Solidity run directly on Ethereum?

**Answer:**

No. Solidity source code is compiled into bytecode, which is then executed by the Ethereum Virtual Machine (EVM).

---

## Q10. What is a `.sol` file?

**Answer:**

A `.sol` file is a Solidity source file that contains one or more smart contract definitions.

---

# ⚡ Rapid Fire Interview Questions

### Q11. Which extension is used for Solidity files?

`.sol`

---

### Q12. Which compiler compiles Solidity?

`solc`

---

### Q13. What executes Solidity bytecode?

The Ethereum Virtual Machine (EVM).

---

### Q14. Can one Solidity file contain multiple contracts?

Yes.

---

### Q15. Which line usually comes first in a Solidity file?

`// SPDX-License-Identifier`

---

# 🎯 Interview Tips

- Define Solidity in one sentence before explaining details.
- Mention the EVM whenever discussing Solidity.
- Remember the standard file order: **SPDX → Pragma → Imports → Contract**.
- Explain the purpose of `pragma` and the `^` version operator.
- Distinguish between source code, bytecode, and the EVM during interviews.

# 💼 Solidity Basics — Interview Questions & Answers

> 🎯 **Goal:** Master the fundamentals of Solidity, compiler versions, SPDX License Identifier, and Pragma Directive. These are among the first questions asked in Solidity interviews.

---

# 🟢 Topic 1 — What is Solidity?

### Q1. What is Solidity?

**Answer:**

**Solidity** is a **high-level, object-oriented programming language** used to write **Smart Contracts** that run on the **Ethereum Virtual Machine (EVM).**

It is similar to JavaScript, C++, and Python in syntax and is specifically designed for blockchain development.

---

### Q2. Why was Solidity created?

**Answer:**

Solidity was created to enable developers to write programs (Smart Contracts) that can:

- Automate agreements
- Store blockchain data
- Transfer digital assets
- Build DApps
- Create tokens (ERC20, ERC721)

---

### Q3. Where does Solidity code run?

**Answer:**

Solidity code runs on the **Ethereum Virtual Machine (EVM)** after it is compiled into **bytecode**.

```text
Solidity Code (.sol)
        │
        ▼
Compiler (solc)
        │
        ▼
Bytecode
        │
        ▼
Ethereum Virtual Machine (EVM)
```

---

### Q4. What are the main features of Solidity?

**Answer:**

- Smart Contract Programming
- Object-Oriented
- Statically Typed
- Supports Inheritance
- Libraries
- Interfaces
- Events
- Modifiers
- Error Handling

---

### Q5. Which file extension is used for Solidity?

**Answer:**

```
.sol
```

Example:

```
MyToken.sol
```

---

# 🚀 Topic 2 — Why Do We Need Solidity?

### Q6. Why do we need Solidity?

**Answer:**

Solidity is needed to build decentralized applications (DApps) and Smart Contracts on Ethereum and other EVM-compatible blockchains.

It allows developers to create trustless applications without intermediaries.

---

### Q7. What can we build using Solidity?

**Answer:**

- ERC20 Tokens
- NFTs (ERC721)
- DeFi Applications
- DAOs
- Voting Systems
- Crowdfunding Platforms
- Staking Contracts
- Escrow Systems
- Games

---

### Q8. Why can't Java or Python be used directly on Ethereum?

**Answer:**

Ethereum's EVM understands only **EVM bytecode**.

Solidity is designed to compile into EVM bytecode, making it the native language for Ethereum Smart Contracts.

---

### Q9. What blockchains support Solidity?

**Answer:**

All EVM-compatible blockchains, such as:

- Ethereum
- Polygon
- BNB Chain
- Avalanche C-Chain
- Arbitrum
- Optimism
- Base

---

# 📜 Topic 3 — SPDX License Identifier

### Q10. What is the SPDX License Identifier?

**Answer:**

The **SPDX License Identifier** specifies the **license** under which the Smart Contract's source code is distributed.

Example:

```solidity
// SPDX-License-Identifier: MIT
```

---

### Q11. Why do we use the SPDX License Identifier?

**Answer:**

It tells users and tools:

- How the code can be used
- Whether it is open source
- The legal license of the project

It also removes compiler warnings about missing license information.

---

### Q12. Is the SPDX License Identifier mandatory?

**Answer:**

No.

However, it is **strongly recommended**. Without it, the compiler usually shows a warning.

---

### Q13. What are common SPDX license identifiers?

**Answer:**

| License      | Identifier     |
| ------------ | -------------- |
| MIT          | `MIT`          |
| GPL v3       | `GPL-3.0`      |
| Apache 2.0   | `Apache-2.0`   |
| BSD 3-Clause | `BSD-3-Clause` |
| Unlicensed   | `UNLICENSED`   |

---

### Q14. Does the SPDX License affect contract execution?

**Answer:**

❌ No.

It only specifies the **legal licensing** of the source code. It has no effect on how the contract runs.

---

# ⚙️ Topic 4 — Pragma Directive

### Q15. What is the Pragma Directive?

**Answer:**

The **pragma directive** tells the Solidity compiler **which compiler version(s)** are compatible with the source code.

Example:

```solidity
pragma solidity ^0.8.20;
```

---

### Q16. Why is the pragma directive important?

**Answer:**

It prevents the contract from being compiled with incompatible compiler versions that may introduce errors or unexpected behavior.

---

### Q17. What does `^0.8.20` mean?

**Answer:**

```solidity
pragma solidity ^0.8.20;
```

means:

- Minimum version → **0.8.20**
- Maximum version → **less than 0.9.0**

Compatible versions include:

- 0.8.20
- 0.8.21
- 0.8.22
- 0.8.28

Not compatible:

- 0.7.x
- 0.9.x

---

### Q18. What does `>=0.8.0 <0.9.0` mean?

**Answer:**

It allows any compiler version from **0.8.0 (inclusive)** up to **0.9.0 (exclusive)**.

---

### Q19. Can a Solidity file have multiple pragma directives?

**Answer:**

No.

A Solidity source file should have one effective version pragma that defines its compatible compiler version(s).

---

# 📂 Topic 5 — Different Solidity Versions in One Project

### Q20. Can two contracts in the same project have different Solidity versions?

**Answer:**

✅ Yes.

Each contract can specify its own compatible compiler version.

Example:

```solidity
// A.sol
pragma solidity ^0.8.20;
```

```solidity
// B.sol
pragma solidity ^0.7.6;
```

---

### Q21. Is it recommended to use different versions in one project?

**Answer:**

Generally, **No**.

Using multiple compiler versions can increase build complexity and compatibility issues. Most projects standardize on a single version.

---

### Q22. How do frameworks like Hardhat or Foundry handle multiple versions?

**Answer:**

They can download and use multiple Solidity compilers automatically based on each file's `pragma` directive (if configured).

---

# ❌ Topic 6 — Incompatible Compiler Version

### Q23. What happens if the Solidity version is incompatible with the compiler version?

**Answer:**

Compilation fails, and the compiler reports a version mismatch error.

Example:

```solidity
pragma solidity ^0.8.20;
```

Trying to compile with:

```
0.7.6
```

Results in a compiler error because `0.7.6` does not satisfy `^0.8.20`.

---

### Q24. Why do compiler incompatibilities occur?

**Answer:**

Different Solidity versions introduce:

- New language features
- Syntax changes
- Bug fixes
- Security improvements
- Breaking changes

Older compilers may not understand newer syntax.

---

### Q25. How can you fix a compiler version mismatch?

**Answer:**

- Install the required Solidity compiler version.
- Update the project's compiler configuration (e.g., Hardhat, Foundry, Remix).
- Adjust the `pragma` directive if appropriate.

---

### Q26. What if the compiler version is newer but still compatible?

**Answer:**

If the version satisfies the `pragma` range, the contract compiles successfully.

Example:

```solidity
pragma solidity ^0.8.20;
```

Compiler:

```
0.8.28
```

✅ Works because `0.8.28` falls within the allowed range.

---

# ⭐ Rapid Fire Interview Questions

### Q27. What is Solidity?

A programming language for writing Smart Contracts on the EVM.

---

### Q28. Which virtual machine executes Solidity code?

Ethereum Virtual Machine (EVM).

---

### Q29. Which file extension does Solidity use?

`.sol`

---

### Q30. What does `solc` do?

It compiles Solidity source code into EVM bytecode.

---

### Q31. What is the purpose of the SPDX License Identifier?

To specify the legal license of the source code.

---

### Q32. Does SPDX affect contract execution?

No.

---

### Q33. What is the purpose of the pragma directive?

To specify compatible Solidity compiler version(s).

---

### Q34. Can different contracts use different Solidity versions?

Yes, but keeping one version across a project is generally recommended.

---

### Q35. What happens if the compiler version is incompatible?

Compilation fails with a version mismatch error.

---

### Q36. What does `^0.8.20` mean?

Compile with version **0.8.20 or later**, but **less than 0.9.0**.

---

# 🎯 Interview Tips

- **Solidity = Language → Smart Contracts**
- **solc = Compiler → Bytecode**
- **EVM = Executes Bytecode**
- **SPDX = Legal license information**
- **Pragma = Compiler version requirement**
- **`^0.8.20` = ≥ 0.8.20 and < 0.9.0**
- **Compiler version mismatch = Compilation error, not a runtime error**

### 🔄 Complete Flow

```text
Developer Writes Solidity (.sol)
             │
             ▼
SPDX License Declared
             │
             ▼
Pragma Version Checked
             │
             ▼
solc Compiler
             │
             ▼
EVM Bytecode
             │
             ▼
Deploy to Ethereum
             │
             ▼
Smart Contract Runs on EVM
```
