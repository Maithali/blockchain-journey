# ⚛️ React.js — Complete Learning & Revision Guide

> A practical React learning, revision, and interview cheat sheet based on the official React Learn documentation.
>
> Current React docs list **React 19.2** as the latest major version.

## Table of Contents

1. What is React?
2. React Mental Model
3. Setup
4. JSX
5. Components
6. Props
7. Displaying Data
8. Conditional Rendering
9. Lists and Keys
10. Events
11. State
12. Updating Objects and Arrays
13. State as a Snapshot
14. Functional State Updates
15. Sharing State
16. Lifting State Up
17. Forms
18. Hooks
19. useEffect
20. useRef
21. useContext
22. useReducer
23. useMemo and useCallback
24. Custom Hooks
25. Rules of Hooks
26. Purity
27. Composition and children
28. State Architecture
29. Context API
30. Routing
31. API Calls
32. Loading/Error/Empty States
33. TypeScript
34. Project Structure
35. Performance
36. React Compiler
37. Refs and DOM
38. Effects vs Events
39. Preserving and Resetting State
40. State Management
41. Error Boundaries
42. Suspense
43. Server Components and Frameworks
44. React DOM
45. Testing
46. Security
47. Common Mistakes
48. Interview Questions
49. Coding Practice
50. 60-Second Revision
51. Golden Rules

---

# 1. ⚛️ What is React?

React is a JavaScript library for building user interfaces from reusable components.

React's central idea is:

```text
UI = f(state, props)
```

Instead of manually changing the DOM everywhere, you describe what the UI should look like for the current data and React updates the UI.

## Why React?

- Component-based architecture
- Declarative UI
- Reusable components
- State-driven rendering
- Large ecosystem
- JavaScript/TypeScript support
- Gradual adoption
- Web and native UI development

## React is NOT

React itself is not:

- A backend framework
- A database
- A programming language
- A complete application architecture

React mainly focuses on UI.

---

# 2. 🧠 React Mental Model

Think:

```text
Data
 ↓
Props / State
 ↓
Component
 ↓
Render
 ↓
UI
 ↓
User Event
 ↓
State Update
 ↓
Render Again
```

Example:

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(c => c + 1)}>
      Count: {count}
    </button>
  );
}
```

---

# 3. 🛠️ Setup

For learning a client-side React application, Vite is a common build-tool choice.

```bash
npm create vite@latest my-react-app
cd my-react-app
npm install
npm run dev
```

Typical structure:

```text
my-react-app/
├── public/
├── src/
│   ├── assets/
│   ├── components/
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
├── package.json
└── vite.config.js
```

React's current documentation recommends frameworks for many new production applications, while also documenting building from scratch when a framework is not suitable. Create React App is deprecated.

---

# 4. 🧩 JSX

JSX lets you write markup-like syntax inside JavaScript.

```jsx
function Welcome() {
  return <h1>Hello React</h1>;
}
```

## Rules

### One root

```jsx
return (
  <div>
    <h1>Hello</h1>
    <p>React</p>
  </div>
);
```

Or:

```jsx
return (
  <>
    <h1>Hello</h1>
    <p>React</p>
  </>
);
```

### Close tags

```jsx
<img src="photo.jpg" />
<input />
<br />
```

### Use `className`

```jsx
<div className="card">Hello</div>
```

### JavaScript uses `{}`

```jsx
const name = "Alice";

return <h1>Hello {name}</h1>;
```

### Dynamic attributes

```jsx
<img src={imageUrl} alt={name} />
```

### Inline style

```jsx
<div style={{ color: "red", fontSize: 20 }}>
  Hello
</div>
```

---

# 5. 🧱 Components

Components are reusable UI building blocks.

```jsx
function Welcome() {
  return <h1>Welcome!</h1>;
}
```

Use:

```jsx
function App() {
  return (
    <div>
      <Welcome />
      <Welcome />
    </div>
  );
}
```

Component names start with a capital letter.

```text
<MyButton />     → React component
<button />       → HTML element
```

## Composition

```jsx
function Header() {
  return <header>Header</header>;
}

function Footer() {
  return <footer>Footer</footer>;
}

function App() {
  return (
    <>
      <Header />
      <main>Content</main>
      <Footer />
    </>
  );
}
```

---

# 6. 📦 Props

Props are data passed from a parent to a child.

```jsx
function User({ name, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{age}</p>
    </div>
  );
}

function App() {
  return <User name="Maithali" age={25} />;
}
```

## Props are read-only

Do not mutate props.

```jsx
// Wrong
props.name = "Bob";
```

Use props to configure components.

## Passing objects

```jsx
const user = {
  name: "Alice",
  age: 25
};

<User user={user} />
```

## Passing functions

```jsx
function Parent() {
  function handleDelete() {
    console.log("Delete");
  }

  return <Child onDelete={handleDelete} />;
}
```

---

# 7. 📊 Displaying Data

Use JSX expressions:

```jsx
const user = {
  name: "Alice",
  age: 25
};

function Profile() {
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.age}</p>
    </div>
  );
}
```

Expressions can contain calculations:

```jsx
<p>{2 + 3}</p>
<p>{user.name.toUpperCase()}</p>
```

---

# 8. 🔀 Conditional Rendering

React uses normal JavaScript conditions.

## if

```jsx
function Dashboard({ isLoggedIn }) {
  if (!isLoggedIn) {
    return <Login />;
  }

  return <DashboardHome />;
}
```

## Ternary

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

## AND

```jsx
{isAdmin && <AdminPanel />}
```

Be careful:

```jsx
{count && <p>Items exist</p>}
```

If `count` is `0`, React can render `0`.

Prefer:

```jsx
{count > 0 && <p>Items exist</p>}
```

---

# 9. 📋 Lists and Keys

Use `map()`:

```jsx
const users = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" }
];

function Users() {
  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

## Why keys?

Keys provide stable identity for list items.

Good:

```jsx
key={user.id}
```

Avoid:

```jsx
key={Math.random()}
```

Avoid indexes when list order can change:

```jsx
key={index}
```

---

# 10. 🖱️ Events

```jsx
function Button() {
  function handleClick() {
    alert("Clicked");
  }

  return (
    <button onClick={handleClick}>
      Click
    </button>
  );
}
```

Do not call the function during render:

```jsx
// Wrong
onClick={handleClick()}
```

Correct:

```jsx
onClick={handleClick}
```

For arguments:

```jsx
<button onClick={() => deleteUser(id)}>
  Delete
</button>
```

Common events:

```text
onClick
onChange
onSubmit
onFocus
onBlur
onMouseEnter
onKeyDown
```

---

# 11. 🧠 State

State is information a component remembers between renders.

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      {count}
    </button>
  );
}
```

`useState()` returns:

```text
[currentState, setterFunction]
```

Example:

```jsx
const [name, setName] = useState("");
```

Each rendered instance of a component has its own state.

---

# 12. 🔄 Updating Objects and Arrays

Do not mutate state directly.

## Object

Wrong:

```jsx
user.name = "Bob";
setUser(user);
```

Correct:

```jsx
setUser({
  ...user,
  name: "Bob"
});
```

## Add to array

```jsx
setItems([
  ...items,
  newItem
]);
```

## Remove

```jsx
setItems(
  items.filter(item => item.id !== id)
);
```

## Update

```jsx
setItems(
  items.map(item =>
    item.id === id
      ? { ...item, completed: true }
      : item
  )
);
```

Remember:

```text
Don't mutate old state
        ↓
Create new value
        ↓
Set new state
```

---

# 13. 📸 State as a Snapshot

State is associated with a particular render.

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
    console.log(count);
  }

  return <button onClick={handleClick}>{count}</button>;
}
```

Calling the setter requests another render. It does not mutate the `count` value already captured by the current render.

---

# 14. 🔁 Functional State Updates

When the next value depends on the previous value, use a functional update.

```jsx
setCount(c => c + 1);
setCount(c => c + 1);
setCount(c => c + 1);
```

Mental model:

```text
setState(previous => next)
```

This is especially important when multiple updates are queued.

---

# 15. 🔗 Sharing State

If multiple components need the same changing data, the state usually belongs to their closest common parent.

```text
        Parent
       /         Child A   Child B
       \      /
       Shared State
```

---

# 16. ⬆️ Lifting State Up

```jsx
function Parent() {
  const [value, setValue] = useState("");

  return (
    <>
      <Input value={value} onChange={setValue} />
      <Display value={value} />
    </>
  );
}
```

Child:

```jsx
function Input({ value, onChange }) {
  return (
    <input
      value={value}
      onChange={e => onChange(e.target.value)}
    />
  );
}
```

---

# 17. 📝 Forms

Controlled input:

```jsx
function Form() {
  const [name, setName] = useState("");

  function handleSubmit(e) {
    e.preventDefault();
    console.log(name);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={name}
        onChange={e => setName(e.target.value)}
      />

      <button type="submit">
        Submit
      </button>
    </form>
  );
}
```

Multiple fields:

```jsx
const [form, setForm] = useState({
  name: "",
  email: ""
});

function handleChange(e) {
  setForm({
    ...form,
    [e.target.name]: e.target.value
  });
}
```

---

# 18. 🪝 Hooks

Hooks let function components use React features.

Important Hooks:

```text
useState
useEffect
useContext
useReducer
useRef
useMemo
useCallback
```

Mental model:

```text
useState    → state
useEffect   → synchronization
useRef      → persistent reference
useContext  → shared context
useReducer  → complex state logic
useMemo     → cached calculation
useCallback → cached function reference
```

---

# 19. ⚡ useEffect

`useEffect` is primarily for synchronizing a component with an external system.

Examples:

- Network connections
- Subscriptions
- Timers
- Browser APIs
- Third-party widgets

```jsx
useEffect(() => {
  console.log("Effect ran");
}, []);
```

Dependency example:

```jsx
useEffect(() => {
  console.log(userId);
}, [userId]);
```

Cleanup:

```jsx
useEffect(() => {
  const id = setInterval(() => {
    console.log("tick");
  }, 1000);

  return () => {
    clearInterval(id);
  };
}, []);
```

## Important rule

Do not use an effect just to calculate derived data.

Bad:

```jsx
useEffect(() => {
  setFullName(firstName + " " + lastName);
}, [firstName, lastName]);
```

Better:

```jsx
const fullName = `${firstName} ${lastName}`;
```

---

# 20. 🎯 useRef

`useRef` stores a persistent mutable value without causing a render when `.current` changes.

## DOM access

```jsx
const inputRef = useRef(null);

function focusInput() {
  inputRef.current.focus();
}

return (
  <>
    <input ref={inputRef} />
    <button onClick={focusInput}>
      Focus
    </button>
  </>
);
```

Use refs for:

- Focus
- Scroll
- Measurement
- DOM integration
- Mutable values that should not trigger rendering

---

# 21. 🌐 useContext

Context allows a value to be available to components deeper in the tree.

```jsx
import { createContext, useContext } from "react";

const ThemeContext = createContext("light");
```

Provider:

```jsx
function App() {
  return (
    <ThemeContext value="dark">
      <Page />
    </ThemeContext>
  );
}
```

Consumer:

```jsx
function Button() {
  const theme = useContext(ThemeContext);

  return <button>{theme}</button>;
}
```

Good uses:

- Theme
- Current user
- Locale
- App configuration

Do not automatically put every piece of state into context.

---

# 22. 🧮 useReducer

Useful for complex state transitions.

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return { count: state.count + 1 };

    case "decrement":
      return { count: state.count - 1 };

    default:
      throw new Error("Unknown action");
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, {
    count: 0
  });

  return (
    <>
      <p>{state.count}</p>

      <button onClick={() => dispatch({ type: "increment" })}>
        +
      </button>

      <button onClick={() => dispatch({ type: "decrement" })}>
        -
      </button>
    </>
  );
}
```

Flow:

```text
UI
 ↓
dispatch(action)
 ↓
reducer(state, action)
 ↓
new state
 ↓
render
```

---

# 23. 🚀 useMemo and useCallback

## useMemo

Caches a calculated value.

```jsx
const filteredUsers = useMemo(() => {
  return users.filter(user => user.active);
}, [users]);
```

## useCallback

Caches a function reference.

```jsx
const handleDelete = useCallback((id) => {
  deleteUser(id);
}, []);
```

## Important

Do not use memoization everywhere.

Better:

```text
Measure
 ↓
Find bottleneck
 ↓
Optimize
 ↓
Measure again
```

---

# 24. 🧪 Custom Hooks

Custom Hooks reuse stateful logic.

```jsx
function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(true);

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
```

Use:

```jsx
function Status() {
  const isOnline = useOnlineStatus();

  return <p>{isOnline ? "Online" : "Offline"}</p>;
}
```

Custom Hooks share **logic**, not the same state instance.

---

# 25. 📏 Rules of Hooks

## Rule 1

Call Hooks only at the top level.

Wrong:

```jsx
if (isLoggedIn) {
  useState(0);
}
```

Correct:

```jsx
const [count, setCount] = useState(0);

if (isLoggedIn) {
  // use count
}
```

## Rule 2

Call Hooks only from:

- React function components
- Custom Hooks

Not arbitrary functions.

---

# 26. 🧼 Purity

A React component should behave predictably during rendering.

```text
Same inputs
    ↓
Same UI result
```

Avoid side effects during render.

Bad:

```jsx
function App() {
  localStorage.setItem("x", "1");

  return <h1>Hello</h1>;
}
```

Use event handlers or appropriate effects when interacting with external systems.

---

# 27. 🧩 Composition and children

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

Use:

```jsx
<Card>
  <h2>Hello</h2>
  <p>Content</p>
</Card>
```

Composition creates flexible reusable components.

---

# 28. 🏗️ State Architecture

Before creating state, ask:

```text
Can I calculate it from existing data?
        ↓
Yes → Don't store it separately
No
 ↓
Who needs it?
 ↓
One component → local state
Several siblings → lift state
Many distant components → consider context/state management
```

Avoid redundant state:

```jsx
const [firstName, setFirstName] = useState("Alice");
const [lastName, setLastName] = useState("Smith");
```

Derive:

```jsx
const fullName = `${firstName} ${lastName}`;
```

---

# 29. 🌍 Context API

Context can reduce prop drilling.

Without context:

```text
App
 ↓
Header
 ↓
UserMenu
 ↓
Avatar
```

With context:

```text
Provider
   ↓
Avatar reads context
```

Context is not automatically a complete global-state solution.

---

# 30. 🛣️ Routing

A common ecosystem solution is React Router.

Typical concepts:

```text
BrowserRouter
Routes
Route
Link
NavLink
useNavigate
useParams
```

Example:

```jsx
import {
  BrowserRouter,
  Routes,
  Route,
  Link
} from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">Home</Link>
        <Link to="/about">About</Link>
      </nav>

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </BrowserRouter>
  );
}
```

Dynamic route:

```jsx
<Route path="/users/:id" element={<User />} />
```

Read it:

```jsx
const { id } = useParams();
```

---

# 31. 🌐 API Calls

Basic pattern:

```jsx
function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Request failed");
        }

        const data = await response.json();
        setUsers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

Production considerations:

```text
Cancellation
Retry
Caching
Authentication
Pagination
Race conditions
Optimistic updates
Refetching
```

---

# 32. ⏳ Loading, Error and Empty States

A complete UI should handle:

```text
Loading
   ↓
Success
   ↓
Empty
   ↓
Error
```

Example:

```jsx
if (loading) return <Spinner />;
if (error) return <ErrorMessage />;
if (users.length === 0) return <EmptyState />;

return <UserList users={users} />;
```

Never design only the happy path.

---

# 33. 🟦 React + TypeScript

Props:

```tsx
type UserProps = {
  name: string;
  age: number;
};

function User({ name, age }: UserProps) {
  return (
    <div>
      {name} - {age}
    </div>
  );
}
```

State:

```tsx
const [count, setCount] = useState<number>(0);
```

Often inference is enough:

```tsx
const [count, setCount] = useState(0);
```

Event:

```tsx
function handleChange(
  e: React.ChangeEvent<HTMLInputElement>
) {
  console.log(e.target.value);
}
```

Children:

```tsx
import type { ReactNode } from "react";

type CardProps = {
  children: ReactNode;
};
```

---

# 34. 📁 Project Structure

A scalable example:

```text
src/
├── assets/
├── components/
│   ├── Button/
│   ├── Card/
│   └── Navbar/
├── features/
│   ├── auth/
│   ├── users/
│   └── dashboard/
├── hooks/
├── pages/
├── routes/
├── services/
├── utils/
├── types/
├── App.tsx
└── main.tsx
```

Start simple. Add architecture when complexity requires it.

---

# 35. ⚡ Performance

Common causes:

- Unnecessary renders
- Expensive calculations
- Huge lists
- Large bundles
- Unnecessary effects
- Broad context updates
- Unoptimized images
- Network bottlenecks

Tools:

```text
React DevTools
React Profiler
Browser Performance tools
```

Optimization techniques:

### Keep state local

Do not lift state higher than necessary.

### Avoid unnecessary effects

Effects can add synchronization complexity.

### Memoize when useful

```jsx
memo(Component)
useMemo(...)
useCallback(...)
```

### Code splitting

```jsx
const Settings = lazy(() => import("./Settings"));
```

### Large lists

Consider virtualization for very large datasets.

---

# 36. 🤖 React Compiler

The current React documentation includes React Compiler as an optimization tool.

Core learning principle:

```text
Write correct React
      ↓
Measure
      ↓
Find bottleneck
      ↓
Optimize
      ↓
Measure again
```

Do not treat manual memoization as mandatory advanced React.

---

# 37. 🎯 Refs and DOM

Refs are useful for imperative operations:

- Focus
- Scroll
- Measure
- DOM integration
- Mutable values that should not trigger rendering

```jsx
const inputRef = useRef(null);

function focus() {
  inputRef.current?.focus();
}

return (
  <>
    <input ref={inputRef} />
    <button onClick={focus}>Focus</button>
  </>
);
```

Don't use refs as a replacement for normal state.

---

# 38. 🔄 Effects vs Events

Very important interview concept.

## Event

```text
User does something
      ↓
Run logic
```

Example:

```jsx
function handleSubmit() {
  saveUser();
}
```

## Effect

```text
Rendered state changes
      ↓
Synchronize external system
```

Example:

```jsx
useEffect(() => {
  document.title = `Count: ${count}`;
}, [count]);
```

Remember:

```text
Event  → caused by interaction
Effect → caused by rendering/state synchronization
```

---

# 39. 🔁 Preserving and Resetting State

React associates state with a component's identity and position in the rendered tree.

You can reset state by changing a key:

```jsx
<Counter key={playerId} />
```

Changing the key tells React to treat it as a different component identity.

Useful for:

- Resetting forms
- Resetting local state
- Switching entities

---

# 40. 🗂️ State Management

## Local state

```jsx
useState()
```

Use for:

- Form values
- Modal state
- Selected tab
- Local UI state

## Reducer

```jsx
useReducer()
```

Use for complex transitions.

## Context

Use for values shared across a component subtree.

## External state

Consider when many unrelated components need complex shared client state.

## Server state

Remote API data has different requirements:

```text
Fetching
Caching
Refetching
Invalidation
Retries
Pagination
Synchronization
```

Do not automatically treat server state like local UI state.

---

# 41. 🛡️ Error Boundaries

Error boundaries allow a portion of a UI tree to show fallback UI when rendering errors occur.

Conceptually:

```text
App
 │
 ├── Header
 │
 ├── Error Boundary
 │      └── Risky Component
 │
 └── Footer
```

Fallback:

```text
Something went wrong.
Please try again.
```

Error boundaries are different from wrapping ordinary JSX in `try/catch`.

---

# 42. ⏸️ Suspense

Suspense provides a mechanism for fallback UI around components that suspend.

```jsx
<Suspense fallback={<Loading />}>
  <SomeComponent />
</Suspense>
```

Frameworks can integrate Suspense with data fetching, streaming, and route-level loading.

---

# 43. 🌍 Server Components and Frameworks

Modern React can be used with frameworks supporting:

- Server-side rendering
- Static generation
- Server Components
- Streaming
- Route-level loading
- Server-side data access

Mental model:

```text
React
 ↓
UI library

Framework
 ↓
React + routing + data + rendering +
deployment architecture
```

React Server Components are React features, but practical implementation depends on framework and bundler support.

---

# 44. 🌐 React DOM

`react-dom` contains browser DOM-specific APIs.

Common entry point:

```jsx
import { createRoot } from "react-dom/client";

createRoot(document.getElementById("root"))
  .render(<App />);
```

---

# 45. 🧪 Testing

Testing levels:

```text
Unit
Integration
End-to-End
```

Common ecosystem tools:

```text
Vitest
Jest
React Testing Library
Playwright
Cypress
```

Prefer testing user-visible behavior.

Good:

```text
User clicks button
 ↓
UI changes
```

Less useful:

```text
Internal function X was called
```

---

# 46. 🔐 Security

React escapes text content by default, but dangerous HTML APIs require care.

Be careful with:

```jsx
dangerouslySetInnerHTML
```

Never blindly inject untrusted HTML.

Also:

- Validate on the server
- Never put secrets in frontend code
- Don't trust client-side authorization
- Use HTTPS
- Handle authentication securely
- Sanitize untrusted HTML when required

Critical rule:

```text
Frontend authorization ≠ real authorization
```

---

# 47. 🚨 Common Mistakes

## 1. Mutating state

Wrong:

```jsx
items.push(item);
setItems(items);
```

Correct:

```jsx
setItems([...items, item]);
```

## 2. Calling event handlers

Wrong:

```jsx
onClick={handleClick()}
```

Correct:

```jsx
onClick={handleClick}
```

## 3. Missing keys

Wrong:

```jsx
users.map(user => <li>{user.name}</li>)
```

Correct:

```jsx
users.map(user => (
  <li key={user.id}>{user.name}</li>
))
```

## 4. Index keys everywhere

Indexes can cause identity problems when lists reorder.

## 5. Too much state

Don't store derived values unnecessarily.

## 6. useEffect for calculations

Wrong:

```jsx
useEffect(() => {
  setTotal(price * quantity);
}, [price, quantity]);
```

Better:

```jsx
const total = price * quantity;
```

## 7. useEffect for event logic

If a user clicks "Buy", put purchase logic in the click handler.

## 8. Giant components

Split components when one component has too many unrelated responsibilities.

## 9. Premature optimization

Don't use memoization everywhere without a performance reason.

## 10. Trusting frontend security

Client-side checks are not a security boundary.

---

# 48. 🎯 Interview Questions

## Beginner

### What is React?

A JavaScript library for building component-based user interfaces.

### What is JSX?

Markup-like syntax used inside JavaScript to describe UI.

### What is a component?

A reusable UI building block.

### What are props?

Read-only inputs passed into a component.

### What is state?

Data a component remembers and can update.

### Props vs State?

```text
Props → passed into component
State → managed by component
```

### What is a key?

A stable identifier used to track list items.

### Why capitalized components?

Capitalized JSX tags represent user-defined React components.

---

## Intermediate

### Why shouldn't state be mutated?

React state should be updated through its setter/reducer patterns. Direct mutation can preserve object identity and create incorrect or difficult-to-reason-about UI behavior.

### What is lifting state?

Moving shared state to the closest common parent.

### What is prop drilling?

Passing props through intermediate components only to reach a deeper component.

### What is Context?

A way to provide values to a subtree without manually passing props through every level.

### What is a Hook?

A function beginning with `use` that provides React functionality to components/custom Hooks.

### Why can't Hooks be conditional?

React depends on consistent Hook call order across renders.

### What is useEffect?

A Hook for synchronizing with external systems.

### What is useRef?

A persistent mutable reference that does not cause a re-render when changed.

---

## Advanced

### Why is state a snapshot?

Each render receives its own state values. Updating state schedules a new render instead of changing the current render's captured value.

### Why functional state updates?

When new state depends on previous state:

```jsx
setCount(c => c + 1);
```

### useMemo vs useCallback?

```text
useMemo
→ cached value

useCallback
→ cached function reference
```

### What is component purity?

Rendering should be predictable from inputs and should not perform uncontrolled side effects.

### Controlled vs uncontrolled components?

```text
Controlled
→ React state controls value

Uncontrolled
→ DOM primarily owns value
```

### Why can indexes be bad keys?

After insertion, deletion, or reordering, an index may identify a different logical item.

### Event vs Effect?

```text
Event
→ specific user interaction

Effect
→ synchronization after rendering
```

---

# 49. 💻 Coding Practice

## Problem 1 — Counter

Requirements:

- Increment
- Decrement
- Reset

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>{count}</h1>

      <button onClick={() => setCount(c => c + 1)}>
        +
      </button>

      <button onClick={() => setCount(c => c - 1)}>
        -
      </button>

      <button onClick={() => setCount(0)}>
        Reset
      </button>
    </div>
  );
}
```

## Problem 2 — Todo

Build:

```text
Add
Delete
Complete
Remaining count
```

## Problem 3 — Search

```jsx
const filtered = users.filter(user =>
  user.name
    .toLowerCase()
    .includes(query.toLowerCase())
);
```

## Problem 4 — Modal

Build:

```text
Open
Close
Overlay
Escape key
```

## Problem 5 — API Dashboard

Build:

```text
Fetch
Loading
Error
Empty
Search
Refresh
```

## Problem 6 — Shopping Cart

Build:

```text
Add
Remove
Increase quantity
Decrease quantity
Total
```

Derived total:

```jsx
const total = cart.reduce(
  (sum, item) => sum + item.price * item.quantity,
  0
);
```

---

# 🧭 React Learning Roadmap

## Level 1 — JavaScript

Master:

```text
Variables
Functions
Arrow functions
Objects
Arrays
map
filter
reduce
Destructuring
Spread
Modules
Promises
async/await
ES6+
```

## Level 2 — React Fundamentals

```text
JSX
Components
Props
State
Events
Conditional rendering
Lists
Keys
Forms
```

## Level 3 — Hooks

```text
useState
useEffect
useRef
useContext
useReducer
useMemo
useCallback
Custom Hooks
```

## Level 4 — Application Development

```text
Routing
API integration
Authentication
State management
Error handling
Loading states
Project structure
TypeScript
```

## Level 5 — Production

```text
Performance
Testing
Accessibility
Security
Code splitting
Caching
SSR
SSG
Server Components
Frameworks
Deployment
```

---

# 🧠 React Concept Map

```text
                         ⚛️ REACT
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
      Components           JSX              State
          │                 │                 │
          ▼                 ▼                 ▼
        Props          Expressions        useState
          │                                   │
          └───────────────┐       ┌───────────┘
                          ▼       ▼
                        Events  Rendering
                           │       │
                           ▼       ▼
                         Update   Lists
                           │       │
                           └───┬───┘
                               ▼
                             Hooks
                               │
        ┌──────────────┬───────┼────────┬───────────┐
        ▼              ▼       ▼        ▼           ▼
     useEffect      useRef  Context  Reducer    Custom Hooks
        │
        ▼
 External Systems
```

---

# ⚡ 50. 60-Second Revision

| Topic | One-Line Summary |
|---|---|
| React | Library for building component-based UIs |
| Component | Reusable UI building block |
| JSX | Markup syntax inside JavaScript |
| Props | Read-only inputs from parent |
| State | Data a component remembers |
| Event | User interaction handler |
| Key | Stable identity for list items |
| Hook | Function beginning with `use` |
| useState | Local component state |
| useEffect | External-system synchronization |
| useRef | Persistent mutable reference / DOM access |
| useContext | Read shared context |
| useReducer | Complex state transitions |
| useMemo | Cache a calculated value |
| useCallback | Cache a function reference |
| Custom Hook | Reusable stateful logic |
| Context | Share values through a component subtree |
| Controlled Input | React controls input value |
| Lifting State | Move shared state to common parent |
| Composition | Build components by combining/nesting |
| Suspense | Fallback UI for supported suspending work |
| React DOM | Browser-specific React APIs |
| Framework | Broader application architecture around React |

---

# 🎯 51. Golden Rules

1. ⚛️ Think in components.
2. 📦 Props flow from parent to child.
3. 🧠 State drives changing UI.
4. 🔄 State updates cause another render.
5. 🚫 Never mutate state directly.
6. 🔑 Use stable keys.
7. 🪝 Follow the Rules of Hooks.
8. ⚡ Use effects for synchronization, not ordinary calculations.
9. 📈 Derive data instead of duplicating it in state.
10. 🧩 Prefer composition for reusable UI.
11. 🎯 Keep state as local as practical.
12. 🧪 Test user-visible behavior.
13. 🚀 Optimize after finding real bottlenecks.
14. 🔐 Never trust the frontend for security authorization.
15. 🌐 Treat server state differently from local UI state.
16. 🧼 Keep rendering pure.
17. 📚 Learn JavaScript deeply.
18. 🏗️ Start simple and add architecture when complexity demands it.

---

# 🏆 Final React Mental Model

When building any feature, ask:

```text
1. What UI am I building?
          ↓
2. What components should exist?
          ↓
3. What data does each component need?
          ↓
4. Which data is props?
          ↓
5. What actually changes?
          ↓
6. Does it need state?
          ↓
7. Where should state live?
          ↓
8. Can displayed values be calculated instead?
          ↓
9. What events change state?
          ↓
10. Do I really need an Effect?
          ↓
11. Is there an external system?
          ↓
12. Are list keys stable?
          ↓
13. Are loading/error/empty states handled?
          ↓
14. Is the component too large?
          ↓
15. Is there a measured performance problem?
          ↓
16. Test the user-visible behavior.
```

## The Core Formula

```text
              PROPS + STATE
                    │
                    ▼
                COMPONENT
                    │
                    ▼
                     UI
                    │
                    ▼
                   EVENT
                    │
                    ▼
               STATE UPDATE
                    │
                    ▼
                  RENDER
                    │
                    └──────────► UI
```

> **React becomes much easier when you stop thinking about manually changing the DOM and start thinking about describing the UI as a function of props and state.**

---

# 📖 Official Resources

- React Learn: https://react.dev/learn
- React Reference: https://react.dev/reference/react
- React DOM Reference: https://react.dev/reference/react-dom
- React Installation: https://react.dev/learn/installation
- Creating a React App: https://react.dev/learn/creating-a-react-app
- React Versions: https://react.dev/versions

