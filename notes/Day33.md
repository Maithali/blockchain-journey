# 💎 Slither Static Analysis & Security — Interactive Revision

> 🎯 **Goal:** Learn the essentials of Slither, from its static analysis pipeline to real vulnerability detectors and CLI workflows. Use the collapsible sections, checklist, and quiz to study interactively.

<div class="slither-interactive">

<style>
  .slither-interactive {
    font-family: Arial, sans-serif;
    color: #e5eefb;
    background: linear-gradient(135deg, #0f172a, #111827 45%, #1f2937);
    border-radius: 18px;
    padding: 18px;
    margin: 20px 0;
    box-shadow: 0 8px 30px rgba(0,0,0,0.25);
  }

  .slither-interactive a {
    color: #7dd3fc;
    text-decoration: none;
  }

  .slither-interactive .nav {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin: 12px 0 18px;
  }

  .slither-interactive .nav a {
    background: rgba(125, 211, 252, 0.12);
    border: 1px solid rgba(125,211,252,0.35);
    border-radius: 999px;
    padding: 7px 12px;
    font-size: 12px;
    font-weight: 600;
  }

  .slither-interactive .stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 12px;
    margin: 18px 0;
  }

  .slither-interactive .stat {
    background: rgba(148, 163, 184, 0.08);
    border: 1px solid rgba(148,163,184,0.2);
    border-radius: 12px;
    padding: 14px;
  }

  .slither-interactive .stat small {
    display: block;
    color: #93c5fd;
    margin-bottom: 6px;
    letter-spacing: 0.08em;
    text-transform: uppercase;
  }

  .slither-interactive details {
    background: rgba(15, 23, 42, 0.78);
    border: 1px solid rgba(148,163,184,0.25);
    border-radius: 12px;
    margin: 12px 0;
    padding: 0 14px 10px;
  }

  .slither-interactive summary {
    cursor: pointer;
    list-style: none;
    font-weight: 700;
    padding: 14px 0;
    color: #e2e8f0;
  }

  .slither-interactive summary::-webkit-details-marker { display: none; }

  .slither-interactive .checklist {
    margin: 18px 0;
    padding: 12px 16px;
    background: rgba(59, 130, 246, 0.06);
    border: 1px solid rgba(59,130,246,0.15);
    border-radius: 10px;
  }

  .slither-interactive .checklist ul {
    margin: 0;
    padding-left: 18px;
  }

  .slither-interactive .cta {
    background: rgba(34, 197, 94, 0.12);
    border: 1px solid rgba(34,197,94,0.25);
    border-radius: 10px;
    padding: 12px 14px;
    margin-top: 16px;
    color: #dcfce7;
  }
</style>

<div class="nav">
  <a href="#overview">Overview</a>
  <a href="#why">Why Slither</a>
  <a href="#pipeline">Pipeline</a>
  <a href="#commands">Commands</a>
  <a href="#triage">Triage</a>
  <a href="#quiz">Quiz</a>
</div>

<div class="stats">
  <div class="stat">
    <small>Type</small>
    Static analysis framework for Solidity
  </div>
  <div class="stat">
    <small>Language</small>
    Python 3
  </div>
  <div class="stat">
    <small>Core idea</small>
    Detect bugs before deployment
  </div>
  <div class="stat">
    <small>Best use</small>
    Security audits + CI checks
  </div>
</div>

<div class="checklist" id="overview">
  <strong>Study checklist</strong>
  <ul>
    <li> [ ] I can explain what Slither does in plain English.</li>
    <li> [ ] I know the pipeline: AST → CFG → SlithIR → detectors.</li>
    <li> [ ] I can run `slither .` and explain common flags.</li>
    <li> [ ] I know how to suppress verified false positives safely.</li>
    <li> [ ] I can describe reentrancy, unchecked calls, and upgrade risks.</li>
  </ul>
</div>

<details open>
  <summary>1. What is Slither?</summary>

**Slither** is a **Python 3 static analysis framework** for **Solidity** smart contracts developed by Trail of Bits.

It reads Solidity source code and looks for security bugs, code smells, gas inefficiencies, and logic risks without deploying to a blockchain.

  <div class="cta">Think of it like a grammar checker for smart contracts.</div>

### Explain Like I'm 10

Imagine a grammar checker for your English essay. Before you submit it, the checker flags spelling mistakes, bad punctuation, and broken sentence structure.

**Slither works the same way for smart contracts.** It scans the code before deployment and catches risky patterns automatically.

### Key features

- 💎 Static code analysis
- 🤖 Automated vulnerability detection
- ⚡ Fast execution
- 🔒 SlithIR intermediate representation
- 🧩 Visualization printers
- ⚙️ CI/CD integration

> Remember: **Slither = AST Parsing + SlithIR + Vulnerability Detectors**

</details>

<details id="why">
  <summary>2. Why Slither?</summary>

Slither helps developers and auditors catch issues early, before the code is finalized or deployed to production.

### Common reasons teams use it

- Detect critical bugs early
- Prevent reentrancy and access-control problems
- Enforce coding standards
- Optimize gas usage
- Generate control flow and call graphs
- Automate PR and CI checks

### Security detections covered

- Reentrancy
- Unchecked low-level calls and transfers
- Unprotected admin functions
- Uninitialized storage pointers
- Arbitrary delegatecall patterns
- Weak randomness

> **Slither is to Solidity what ESLint / SonarQube is to JavaScript.**

</details>

<details id="pipeline">
  <summary>3. Where and how does Slither run?</summary>

```text
Solidity Source Code (.sol)
    ↓
Solidity Compiler (solc) AST
    ↓
Slither Analysis Engine
    ↓
SlithIR (Intermediate Representation)
    ↓
Detector & Printer Modules
    ↓
Security Report / JSON / Terminal Output
```

### Core components

- Solidity AST parser
- Control Flow Graph (CFG) generator
- SlithIR converter
- Detector engine
- Visual printers
- CLI / CI interface

### Important fact

Slither does not execute contract bytecode on the EVM. It analyzes source code structure and state logic statically.

</details>

<details>
  <summary>4. Essential Slither setup and commands</summary>

```bash
# Installation
pip3 install slither-analyzer
pip3 install solc-select

# Default analysis on the current project
slither .

# Run selected detectors only
slither . --detect reentrancy-eth,uninitialized-state

# Exclude low- and informational-severity output
slither . --exclude-low --exclude-informational
```

### Command breakdown

  <details>
    <summary>Project analysis</summary>

    ```bash
    slither .
    ```
    This automatically detects frameworks such as Hardhat, Foundry, and Truffle and runs the built-in detectors.

  </details>

  <details>
    <summary>Targeted detectors</summary>

    ```bash
    slither . --detect reentrancy-eth
    ```
    Useful when you want a tight focus during a security review.

  </details>

  <details>
    <summary>Remappings and compiler config</summary>

    ```bash
    slither . --solc-remaps "@openzeppelin/=node_modules/@openzeppelin/"
    ```
    Helps resolve imports when dependencies or remappings are not automatically found.

  </details>

  <details>
    <summary>Export findings</summary>

    ```bash
    slither . --json output.json
    ```
    Stores the report in JSON for dashboards, CI pipelines, or integrations.

  </details>

> **Remember:** Run `slither .` locally on every commit to catch issues early.

</details>

<details id="triage">
  <summary>5. Triage and false-positive suppression</summary>

Slither allows you to hide findings that have been manually reviewed and confirmed as safe.

### Inline suppression

```solidity
// slither-disable-next-line reentrancy-eth
(bool success, ) = msg.sender.call{value: amount}("");
require(success, "Transfer failed");
```

### Multi-line suppression

```solidity
/* slither-disable-start reentrancy-eth */
(bool success, ) = msg.sender.call{value: amount}("");
require(success, "Transfer failed");
/* slither-disable-end reentrancy-eth */
```

### Interactive triage CLI

```bash
slither . --triage
```

This creates and manages a `.slither-triage.json` file to keep a clean review workflow.

### Why suppression matters

- Reduce audit noise
- Focus on real vulnerabilities
- Standardize review pipelines
- Keep CI checks manageable

> **Important:** Document why an alert was suppressed before disabling it.

</details>

<details>
  <summary>6. Slither vs manual code review</summary>

| Area        | Slither                            | Manual review                  |
| ----------- | ---------------------------------- | ------------------------------ |
| Speed       | Seconds                            | Hours or days                  |
| Coverage    | Structural patterns and known bugs | Business logic and edge cases  |
| Cost        | Free and open source               | Expensive and expert-driven    |
| Execution   | Automated via script / CI          | Human inspection               |
| Determinism | Very high                          | Depends on reviewer experience |

Slither finds structural vulnerabilities fast; manual review uncovers deeper protocol-specific issues.

</details>

<details>
  <summary>7. Complete Slither pipeline flow</summary>

```text
                Solidity Source File (.sol)
                             │
                             ▼
                     solc Compiler AST
                             │
                             ▼
                   Control Flow Graphs
                             │
                             ▼
                     SlithIR Conversion
                             │
                             ▼
               Slither Analysis Engine
                             │
           ┌─────────────────┼─────────────────┐
           ▼                 ▼                 ▼
    Vulnerability       Gas Optimization     Contract Printers
     Detectors             Checkers            (Graphs / CFG)
           │                 │                 │
           └─────────────────┼─────────────────┘
                             ▼
                      Triage & Filtering
                             │
                             ▼
                   Terminal / JSON / SARIF
```

</details>

<details>
  <summary>8. 60-second revision</summary>

- **Slither** = static analyzer for Solidity smart contracts written in Python.
- **SlithIR** = Slither’s intermediate representation used for analysis.
- **Execution** = static analysis without EVM execution or mainnet state.
- **CLI usage** = `slither .` scans Hardhat, Foundry, and Truffle projects automatically.
- **Suppression** = use inline comments or triage config for validated false positives.
- **Manual review** = good for complex business logic, while Slither is best for structural flaws.
</details>

<details>
  <summary>9. Golden rules</summary>

- ✅ Run Slither before requesting external security audits.
- ✅ Integrate it directly into GitHub Actions or CI pipelines.
- ✅ Keep Solidity compiler dependencies resolved with proper remappings.
- ✅ Do not suppress warnings without checking the actual logic.
- ✅ Treat high-impact issues like reentrancy and uninitialized storage as urgent.
- ✅ Use Slither printers to inspect inheritance and call graphs.
</details>

<details>
  <summary>10. Interview questions and answers</summary>

### Q1. What is Slither?

**Answer:** Slither is a Python-based static analysis framework for Solidity smart contracts that identifies vulnerabilities, gas issues, and code quality problems without executing on-chain transactions.

### Q2. What is SlithIR and why is it used?

**Answer:** It is Slither’s intermediate representation that simplifies the Solidity AST into a form easier to analyze for control flow and dataflow checks.

### Q3. How is Slither different from dynamic analysis tools?

**Answer:** Slither works statically on source code, while tools like fuzzers or symbolic execution engines execute code with generated inputs over longer time periods.

### Q4. What is the difference between `reentrancy-eth` and `reentrancy-no-eth`?

**Answer:** `reentrancy-eth` detects Ether transfer reentrancy before state updates; `reentrancy-no-eth` catches state-change patterns without Ether transfer.

### Q5. What is `slither-check-upgradeability` used for?

**Answer:** It checks proxy upgradeability issues such as storage collision risks between different implementation versions.

### Q6. How do you suppress false positives in Slither?

**Answer:** Use inline comments, block suppression, or the `slither . --triage` workflow.

### Q7. Can Slither catch business logic bugs?

**Answer:** No. It catches structural vulnerabilities and code patterns, but not protocol-specific business intent.

### Q8. What are Slither printers?

**Answer:** Printers generate high-level summaries, inheritance trees, control-flow graphs, and access-control views.

### Q9. Why must `solc` be configured correctly?

**Answer:** Slither relies on `solc` to compile the code and build the AST. If compilation fails, Slither cannot analyze the project.

### Q10. How can Slither be used in GitHub repos?

**Answer:** Run a workflow that produces a SARIF report and uploads it to GitHub Code Scanning alerts.

</details>

<details>
  <summary>11. Rapid-fire questions</summary>

- **Who developed Slither?** Trail of Bits.
- **What language is Slither written in?** Python 3.
- **Does Slither require contract deployment?** No.
- **What tool manages compiler versions for Slither?** `solc-select`.
- **Which flag exports results to JSON?** `--json`.
</details>

<details>
  <summary>12. Security cheat sheet: top vulnerabilities</summary>

### 1) Reentrancy

**Concept:** An external call is triggered before state updates are written, allowing a malicious reentrant call to manipulate state.

```solidity
// VULNERABLE
function withdraw() public {
    uint256 amount = balances[msg.sender];
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success);
    balances[msg.sender] = 0; // Reorder this!
}
```

```solidity
// SECURE (Checks-Effects-Interactions)
function withdraw() public {
    uint256 amount = balances[msg.sender];
    balances[msg.sender] = 0;
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success);
}
```

**Slither detectors:** `reentrancy-eth`, `reentrancy-no-eth`

### 2) Unchecked return values

**Concept:** Ignoring return values from low-level calls can hide failures and make a contract unsafe.

```solidity
// VULNERABLE
function sendTokens(IERC20 token, address to, uint256 amount) public {
    token.transfer(to, amount); // Return value ignored
}
```

```solidity
// SECURE
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

using SafeERC20 for IERC20;

function sendTokens(IERC20 token, address to, uint256 amount) public {
    token.safeTransfer(to, amount);
}
```

**Slither detectors:** `unchecked-transfer`, `unchecked-lowlevel`

</details>

<details id="quiz">
  <summary>13. Mini quiz</summary>

  <details>
    <summary>Q1. What does Slither analyze?</summary>
    <p>It analyzes Solidity source code, not deployed runtime state.</p>
  </details>

  <details>
    <summary>Q2. Why is SlithIR useful?</summary>
    <p>It simplifies code into a lower-level representation that makes static analysis easier and more accurate.</p>
  </details>

  <details>
    <summary>Q3. What is the standard first command to run?</summary>
    <p><code>slither .</code></p>
  </details>

  <details>
    <summary>Q4. What is the main reentrancy fix pattern?</summary>
    <p>Checks-Effects-Interactions: update state before making the external call.</p>
  </details>

  <details>
    <summary>Q5. Why should you not suppress issues casually?</summary>
    <p>Because suppressed warnings may hide real vulnerabilities if the logic was not reviewed carefully.</p>
  </details>
</details>

<div class="cta">Final memory line: <strong>Slither is the fastest way to catch common Solidity security flaws before deployment.</strong></div>

</div>

---

## Quick summary

- Slither is a static analysis tool for Solidity.
- It uses AST + SlithIR + detectors to flag unsafe code patterns.
- It helps find vulnerabilities before deployment.
- It is especially useful for reentrancy, unchecked calls, and upgradeability risks.
- CLI: `slither .`, `--detect`, `--json`, and `--triage` are the key workflow commands.
- Always review and document suppressions before disabling a finding.

3. Access Control & Authorization Failure
   Concept
   Exposing critical state-changing functions publicly without validation modifiers (onlyOwner, roles).

Vulnerable Code
Solidity
// VULNERABLE
function setOwner(address newOwner) public {
owner = newOwner; // Missing access restriction!
}
Remediation
Solidity
// SECURE
function setOwner(address newOwner) public onlyOwner {
owner = newOwner;
}
Slither Detector
unprotected-upgrade

tx-origin

4. Uninitialized Storage Pointers
   Concept
   Local storage reference variables that default to pointing at storage slot 0, overwriting critical state variables.

Vulnerable Code
Solidity
// VULNERABLE
struct User {
uint256 id;
}

function update() public {
User user; // Points to storage slot 0!
user.id = 1;
}
Remediation
Solidity
// SECURE
function update() public {
User memory user = User(1); // Explicit memory allocation
}
Slither Detector
uninitialized-state

uninitialized-local

5. Controlled Delegatecall
   Concept
   Executing delegatecall to an address controlled by user inputs allows attackers to execute arbitrary instructions in caller context.

Vulnerable Code
Solidity
// VULNERABLE
function execute(address target, bytes memory data) public {
(bool success, ) = target.delegatecall(data); // Target controlled by user!
require(success);
}
Remediation
Restrict delegatecall target addresses strictly to whitelisted implementation contracts.

Slither Detector
controlled-delegatecall

6. Weak Randomness (On-Chain Entropy)
   Concept
   Using predictable chain attributes like block.timestamp, blockhash, or block.prevrandao for high-value decisions.

Vulnerable Code
Solidity
// VULNERABLE
uint256 winner = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100;
Remediation
Use verifiable off-chain random generation like Chainlink VRF.

Slither Detector
weak-prng

🛠️ Practical Slither Commands Reference
Bash

# Print Contract Summary

slither . --print summary

# Print Human-Readable Access Control Summary

slither . --print human-summary

# Generate Inheritance Graph

slither . --print inheritance-graph

# Print Contract Call Graph

slither . --print call-graph

# Run Slither with SARIF Output for Code Scanning

slither . --sarif results.sarif
🔄 Complete Analysis Flow
Plaintext
Developer Writes Contract (.sol)
│
▼
Run Slither Static Analysis (`slither .`)
│
▼
Slither Parses AST & Builds SlithIR
│
▼
Vulnerabilities Flagged (Reentrancy, Access Control, etc.)
│
▼
Developer Fixes Vulnerabilities / Suppresses False Positives
│
▼
Re-test with Slither + Unit Tests + Fuzzing
│
▼
Safe Contract Deployment

```

```
