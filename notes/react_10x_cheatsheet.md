# ⚛️ React 10X Cheat Sheet — The Developer Command Center

> **Goal:** Stop memorizing React. Start recognizing patterns.
>
> Use this file as a **build reference, debugging map, interview weapon, and project shortcut**.

---

## 🧠 0. THE REACT MENTAL MODEL

React is basically:

```text
UI = f(state, props)
```

When state changes:

```text
state changes
   ↓
React schedules an update
   ↓
component renders again
   ↓
React compares the result
   ↓
DOM is updated where needed
```

### The 5 things to master

```text
Components → Props → State → Effects → Data Flow
```

Most React bugs are really one of these:

```text
❌ Wrong state owner
❌ Wrong dependency array
❌ Mutating state
❌ Unstable list keys
❌ Side effect during render
❌ Stale closure
❌ Unnecessary effect
```

---

# 🚀 1. THE 30-SECOND COMPONENT TEMPLATE

```jsx
import { useState } from "react";

export default function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>{count}</h1>
      <button onClick={() => setCount(c => c + 1)}>
        +1
      </button>
    </div>
  );
}
```

### Component naming

```jsx
// ✅
function UserCard() {}
function LoginForm() {}
function ProductList() {}

// ❌
function userCard() {}
```

Components start with an uppercase letter.

---

# 🧩 2. JSX CHEAT CODES

## JavaScript inside JSX

```jsx
<h1>{name}</h1>
<p>{age + 1}</p>
<p>{user?.email}</p>
```

## Conditional rendering

### Ternary

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

### AND

```jsx
{isLoading && <Spinner />}
```

### Multiple conditions

```jsx
{status === "loading" && <Spinner />}
{status === "success" && <Success />}
{status === "error" && <ErrorMessage />}
```

### Avoid this trap

```jsx
{count && <p>Hello</p>}
```

If `count` is `0`, React can render `0`.

Safer:

```jsx
{count > 0 && <p>Hello</p>}
```

---

# 🎁 3. PROPS = DATA IN

Parent:

```jsx
<UserCard name="Maithali" role="Developer" />
```

Child:

```jsx
function UserCard({ name, role }) {
  return <h2>{name} — {role}</h2>;
}
```

## Props with defaults

```jsx
function Button({ text = "Submit" }) {
  return <button>{text}</button>;
}
```

## Passing a function

```jsx
<Child onSave={handleSave} />
```

```jsx
function Child({ onSave }) {
  return <button onClick={onSave}>Save</button>;
}
```

### Golden rule

```text
Props → read-only input
State → component-controlled data
```

Do not modify props:

```jsx
// ❌
props.name = "New";
```

---

# 🔄 4. STATE = DATA THAT CHANGES

```jsx
const [count, setCount] = useState(0);
```

Think:

```text
[count]      = current value
[setCount]   = state updater
```

## Update state

```jsx
setCount(10);
```

## Functional update

Use this when the new value depends on the previous value:

```jsx
setCount(prev => prev + 1);
```

Multiple updates:

```jsx
setCount(c => c + 1);
setCount(c => c + 1);
setCount(c => c + 1);
```

This reliably increments by 3.

---

# 🧠 5. STATE DESIGN CHEAT CODE

Before adding state ask:

```text
Can I calculate it from existing data?
        ↓
      YES → don't store it
      NO  → state may be needed
```

### ❌ Bad duplicated state

```jsx
const [firstName, setFirstName] = useState("A");
const [lastName, setLastName] = useState("B");
const [fullName, setFullName] = useState("A B");
```

### ✅ Derived value

```jsx
const fullName = `${firstName} ${lastName}`;
```

### React rule

> **Store the minimum state necessary. Derive the rest.**

---

# 📝 6. FORMS — THE FAST PATH

## Controlled input

```jsx
const [email, setEmail] = useState("");

<input
  value={email}
  onChange={e => setEmail(e.target.value)}
/>
```

## Checkbox

```jsx
const [checked, setChecked] = useState(false);

<input
  type="checkbox"
  checked={checked}
  onChange={e => setChecked(e.target.checked)}
/>
```

## Form submit

```jsx
function handleSubmit(e) {
  e.preventDefault();
  console.log(email);
}
```

```jsx
<form onSubmit={handleSubmit}>
  ...
</form>
```

---

# 📦 7. ARRAYS & OBJECTS — NEVER MUTATE STATE

## ❌ Wrong

```jsx
user.name = "Alex";
setUser(user);
```

## ✅ Object update

```jsx
setUser(prev => ({
  ...prev,
  name: "Alex"
}));
```

## ✅ Array add

```jsx
setItems(prev => [...prev, newItem]);
```

## ✅ Array remove

```jsx
setItems(prev => prev.filter(item => item.id !== id));
```

## ✅ Array update

```jsx
setItems(prev =>
  prev.map(item =>
    item.id === id
      ? { ...item, completed: true }
      : item
  )
);
```

### Memory trick

```text
Array:
add    → [...old, new]
remove → filter()
update → map()
```

---

# 🔑 8. LISTS + KEYS

```jsx
users.map(user => (
  <UserCard key={user.id} user={user} />
))
```

### ✅ Best key

```jsx
key={user.id}
```

### ⚠️ Avoid

```jsx
key={index}
```

especially when items can be inserted, removed, reordered, or edited.

### Never use random keys

```jsx
// ❌
key={Math.random()}
```

---

# 🪝 9. HOOKS MAP

```text
useState       → local state
useEffect      → synchronize with external systems
useContext     → shared context data
useReducer     → complex state transitions
useRef         → persistent mutable reference / DOM node
useMemo        → memoized calculation
useCallback    → memoized function identity
useId          → stable IDs for accessibility
useTransition  → non-urgent UI updates
useDeferredValue → defer expensive value usage
```

### Hook rule

Hooks must be called:

```text
✅ at the top level
✅ inside React components/custom hooks

❌ inside if
❌ inside loops
❌ inside nested functions
❌ conditionally
```

---

# ⚡ 10. useEffect — THE TRUTH

Basic:

```jsx
useEffect(() => {
  // side effect
}, []);
```

## No dependency array

```jsx
useEffect(() => {
  console.log("after every render");
});
```

## Empty array

```jsx
useEffect(() => {
  console.log("after initial mount");
}, []);
```

## Dependency

```jsx
useEffect(() => {
  console.log(userId);
}, [userId]);
```

## Cleanup

```jsx
useEffect(() => {
  const timer = setInterval(() => {}, 1000);

  return () => clearInterval(timer);
}, []);
```

### Mental model

> `useEffect` is primarily for **synchronizing React with something outside React**.

Examples:

```text
✅ API/network request
✅ subscription
✅ browser event listener
✅ timer
✅ external widget
✅ document title / browser API
```

Do NOT automatically use an effect for simple calculations:

```jsx
// ❌
const [fullName, setFullName] = useState("");
useEffect(() => {
  setFullName(first + " " + last);
}, [first, last]);
```

```jsx
// ✅
const fullName = first + " " + last;
```

---

# 🌐 11. API FETCH PATTERN

```jsx
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadUsers() {
      try {
        setLoading(true);

        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Failed to fetch users");
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

  return users.map(user => (
    <div key={user.id}>{user.name}</div>
  ));
}
```

### API mental model

```text
idle
 ↓
loading
 ↓
 ┌──────────────┐
 ↓              ↓
success       error
```

Keep UI states explicit.

---

# 🧹 12. FETCH CANCELLATION / RACE-SAFE PATTERN

For requests that may outlive the component or be replaced:

```jsx
useEffect(() => {
  const controller = new AbortController();

  async function load() {
    try {
      const res = await fetch(url, {
        signal: controller.signal
      });

      const data = await res.json();
      setData(data);
    } catch (error) {
      if (error.name !== "AbortError") {
        setError(error.message);
      }
    }
  }

  load();

  return () => controller.abort();
}, [url]);
```

---

# 🧱 13. COMPONENT COMPOSITION

Instead of giant components:

```text
App
├── Navbar
├── Sidebar
├── Dashboard
│   ├── StatsCard
│   ├── Chart
│   └── RecentActivity
└── Footer
```

### Children pattern

```jsx
function Card({ children }) {
  return <section className="card">{children}</section>;
}
```

Use:

```jsx
<Card>
  <h2>Hello</h2>
  <p>Inside the card.</p>
</Card>
```

### Think

```text
Props = parameters
children = content slot
```

---

# 🔄 14. LIFTING STATE UP

Two sibling components need the same data?

```text
Sibling A ─┐
           ↓
       Parent State
           ↑
Sibling B ─┘
```

Example:

```jsx
function Parent() {
  const [value, setValue] = useState("");

  return (
    <>
      <Input value={value} onChange={setValue} />
      <Preview value={value} />
    </>
  );
}
```

### Rule

> Put state at the lowest common ancestor that needs to coordinate it.

---

# 🌍 15. CONTEXT — SHARED DATA

Create:

```jsx
import { createContext, useContext, useState } from "react";

const AuthContext = createContext(null);
```

Provider:

```jsx
function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
}
```

Consume:

```jsx
function Profile() {
  const { user } = useContext(AuthContext);

  return <h1>{user?.name}</h1>;
}
```

### Good Context candidates

```text
Theme
Authentication
Locale
App-level preferences
```

### Don't turn Context into a junk drawer.

For complicated or frequently changing global state, consider a dedicated state solution.

---

# 🧠 16. useReducer — STATE MACHINE MODE

```jsx
const initialState = {
  count: 0
};

function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return { ...state, count: state.count + 1 };

    case "decrement":
      return { ...state, count: state.count - 1 };

    default:
      throw new Error("Unknown action");
  }
}
```

```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

Dispatch:

```jsx
dispatch({ type: "increment" });
```

With payload:

```jsx
dispatch({
  type: "setUser",
  payload: user
});
```

### Mental model

```text
state + action → reducer → new state
```

Use reducers when many transitions make `useState` messy.

---

# 🎯 17. useRef — THE "DON'T RERENDER" TOOL

## DOM reference

```jsx
const inputRef = useRef(null);

<input ref={inputRef} />
```

```jsx
inputRef.current?.focus();
```

## Persistent mutable value

```jsx
const renderCount = useRef(0);
renderCount.current += 1;
```

Changing `ref.current` does **not** trigger a render.

### UseRef vs useState

```text
Need UI to update?   → useState
Need value to persist but not render? → useRef
Need DOM node?        → useRef
```

---

# 🧮 18. useMemo

```jsx
const filtered = useMemo(() => {
  return expensiveFilter(items, query);
}, [items, query]);
```

Think:

```text
same dependencies → reuse calculated value
changed dependency → recalculate
```

### Don't use useMemo everywhere.

It is an optimization, not a requirement for correctness.

---

# 🪢 19. useCallback

```jsx
const handleSave = useCallback(() => {
  save(data);
}, [data]);
```

Think:

```text
useMemo    → memoize a value
useCallback → memoize a function
```

Useful when function identity matters, especially with memoized children or hook dependencies.

---

# 🧩 20. React.memo

```jsx
const UserCard = memo(function UserCard({ user }) {
  return <div>{user.name}</div>;
});
```

It can skip rendering when props are considered equal.

### Important

```text
memo ≠ magic performance button
```

Measure before optimizing.

---

# 🧨 21. STALE CLOSURE CHEAT CODE

Problem:

```jsx
setTimeout(() => {
  console.log(count);
}, 1000);
```

The callback sees values from the render in which it was created.

For state updates that depend on previous state:

```jsx
setCount(c => c + 1);
```

For mutable latest values across callbacks, a ref can help:

```jsx
const latestCount = useRef(count);

useEffect(() => {
  latestCount.current = count;
}, [count]);
```

---

# 🚦 22. EVENT HANDLERS

Correct:

```jsx
<button onClick={handleClick}>Save</button>
```

With argument:

```jsx
<button onClick={() => deleteUser(id)}>
  Delete
</button>
```

### ❌ Wrong

```jsx
<button onClick={handleClick()}>
```

That calls it during render instead of passing it as the event handler.

---

# 🖱️ 23. COMMON EVENTS

```jsx
onClick
onChange
onSubmit
onFocus
onBlur
onKeyDown
onKeyUp
onMouseEnter
onMouseLeave
```

Input value:

```jsx
e.target.value
```

Checkbox:

```jsx
e.target.checked
```

Form submit:

```jsx
e.preventDefault()
```

---

# 🧪 24. CUSTOM HOOKS

If logic repeats, extract it.

```jsx
function useOnlineStatus() {
  const [online, setOnline] = useState(navigator.onLine);

  useEffect(() => {
    const onOnline = () => setOnline(true);
    const onOffline = () => setOnline(false);

    window.addEventListener("online", onOnline);
    window.addEventListener("offline", onOffline);

    return () => {
      window.removeEventListener("online", onOnline);
      window.removeEventListener("offline", onOffline);
    };
  }, []);

  return online;
}
```

Use:

```jsx
const online = useOnlineStatus();
```

### Custom hook rule

A reusable hook should encapsulate **behavior**, not just arbitrary JSX.

---

# 🧭 25. ROUTING PATTERN

With React Router:

```jsx
import { BrowserRouter, Routes, Route } from "react-router-dom";

<BrowserRouter>
  <Routes>
    <Route path="/" element={<Home />} />
    <Route path="/about" element={<About />} />
    <Route path="/users/:id" element={<User />} />
  </Routes>
</BrowserRouter>
```

Navigate:

```jsx
import { Link, useNavigate } from "react-router-dom";

<Link to="/about">About</Link>
```

```jsx
const navigate = useNavigate();
navigate("/dashboard");
```

Route parameter:

```jsx
const { id } = useParams();
```

---

# 🔐 26. PROTECTED ROUTE MENTAL MODEL

```text
User requests /dashboard
        ↓
Is user authenticated?
   ↓             ↓
  yes            no
   ↓              ↓
Dashboard      Login
```

Example:

```jsx
function ProtectedRoute({ children }) {
  const { user } = useAuth();

  if (!user) {
    return <Navigate to="/login" replace />;
  }

  return children;
}
```

---

# 🌐 27. REACT + BLOCKCHAIN CHEAT CODE

For a Solidity/DApp project:

```text
React UI
   ↓
Wallet connection
   ↓
Provider / Signer
   ↓
Contract instance
   ↓
Read / Write
   ↓
Ethereum network
```

Typical Ethers v6 style:

```jsx
import { BrowserProvider, Contract } from "ethers";
```

Connect wallet:

```jsx
const provider = new BrowserProvider(window.ethereum);
await provider.send("eth_requestAccounts", []);

const signer = await provider.getSigner();
```

Contract:

```jsx
const contract = new Contract(
  CONTRACT_ADDRESS,
  ABI,
  signer
);
```

Read:

```jsx
const value = await contract.someViewFunction();
```

Write:

```jsx
const tx = await contract.updateValue(newValue);
await tx.wait();
```

### DApp state to track

```text
walletAddress
chainId
isConnected
isCorrectNetwork
contract
loading
transactionHash
error
```

---

# 💰 28. ETHEREUM PAYMENT UI PATTERN

```jsx
const tx = await signer.sendTransaction({
  to: recipient,
  value: parseEther("0.01")
});

await tx.wait();
```

UI state:

```text
Idle
 ↓
Wallet popup
 ↓
Submitted
 ↓
Pending
 ↓
Confirmed / Failed
```

Never treat a submitted transaction as automatically confirmed.

---

# 🧾 29. ABI + ADDRESS ORGANIZATION

Do not scatter addresses everywhere.

```js
export const CONTRACT_ADDRESS = "0x...";
export const CONTRACT_ABI = [...];
```

Better project structure:

```text
src/
├── contracts/
│   ├── token.js
│   └── staking.js
├── hooks/
├── components/
├── pages/
├── context/
├── services/
└── utils/
```

---

# 🗃️ 30. ENV VARIABLES

Typical Vite frontend:

```env
VITE_API_URL=https://example.com
VITE_CONTRACT_ADDRESS=0x...
```

Read:

```js
import.meta.env.VITE_API_URL
```

### NEVER put secrets in the frontend

```text
❌ private keys
❌ API secrets
❌ server credentials
❌ seed phrases
```

Frontend code is public.

---

# 🧱 31. REACT PROJECT ARCHITECTURE

A scalable starter layout:

```text
src/
├── assets/
├── components/
│   ├── Button/
│   ├── Modal/
│   └── Card/
├── features/
│   ├── auth/
│   ├── wallet/
│   └── staking/
├── hooks/
├── layouts/
├── pages/
├── routes/
├── services/
├── context/
├── contracts/
├── utils/
├── App.jsx
└── main.jsx
```

### Feature-first alternative

For larger apps:

```text
features/
├── auth/
│   ├── components/
│   ├── hooks/
│   ├── api/
│   └── utils/
└── staking/
    ├── components/
    ├── hooks/
    └── api/
```

---

# ⚙️ 32. NPM COMMAND CHEAT SHEET

Create Vite React app:

```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

Build:

```bash
npm run build
```

Preview production build locally:

```bash
npm run preview
```

Install package:

```bash
npm install package-name
```

Dev dependency:

```bash
npm install -D package-name
```

Remove package:

```bash
npm uninstall package-name
```

---

# 🎨 33. TAILWIND + REACT PATTERN

```jsx
<button className="rounded-lg px-4 py-2 font-semibold">
  Connect Wallet
</button>
```

Dynamic classes:

```jsx
<button
  className={`px-4 py-2 ${
    active ? "bg-blue-600" : "bg-gray-400"
  }`}
>
  Button
</button>
```

For complex conditional classes, consider a helper instead of enormous template strings.

---

# 🧩 34. CONDITIONAL COMPONENT PATTERN

```jsx
function Status({ status }) {
  switch (status) {
    case "loading":
      return <Spinner />;
    case "success":
      return <Success />;
    case "error":
      return <Error />;
    default:
      return null;
  }
}
```

Useful for:

```text
network states
API states
wallet states
transaction states
form states
```

---

# 🛡️ 35. ERROR BOUNDARY CONCEPT

Render-time errors in a component tree can be isolated with an Error Boundary.

Conceptually:

```text
App
 ├── Header
 ├── Main ← crash
 └── Footer

Boundary around Main
        ↓
Fallback UI
```

Important:

```text
Error Boundary ≠ try/catch for every async error
```

Use appropriate error handling for async operations too.

---

# 🚀 36. PERFORMANCE 10X RULES

### Rule 1 — Don't optimize by instinct

Measure first.

### Rule 2 — Keep state local

Global state can increase unnecessary coupling and rerenders.

### Rule 3 — Don't create giant components

Split by responsibility.

### Rule 4 — Avoid unnecessary effects

Derived data usually does not need an effect.

### Rule 5 — Stable list keys

Prefer real IDs.

### Rule 6 — Memoization is targeted

```text
useMemo/useCallback/memo
       ↓
use when they solve a measured problem
```

### Rule 7 — Lazy-load heavy routes/components

```jsx
const Dashboard = lazy(() => import("./Dashboard"));
```

```jsx
<Suspense fallback={<Spinner />}>
  <Dashboard />
</Suspense>
```

---

# 🧊 37. LOADING UI CHEAT SHEET

Every async operation should answer:

```text
What do I show before data?
What do I show while loading?
What do I show on success?
What do I show on failure?
What do I show when empty?
```

Example:

```jsx
if (loading) return <Loader />;
if (error) return <ErrorMessage />;
if (items.length === 0) return <EmptyState />;
return <List items={items} />;
```

This simple pattern makes apps feel dramatically more professional.

---

# 🔍 38. DEBUGGING MATRIX

## "My component doesn't update"

Check:

```text
Did state actually change?
Did you mutate the object/array?
Is the new value equal to the old one?
Is the component actually using that state?
```

## "useEffect runs too much"

Check:

```text
Dependency array
Object/function dependencies
Effect causing state update
Whether the effect is needed at all
```

## "List behaves strangely"

Check:

```text
key prop
Stable IDs
Index keys
Item reordering
```

## "Input won't type"

Check:

```jsx
value={state}
onChange={e => setState(e.target.value)}
```

## "Maximum update depth"

Look for:

```jsx
// ❌
setState(...)
```

called during render or inside an effect that continuously triggers itself.

---

# 💀 39. TOP 20 REACT MISTAKES

```text
1. Mutating state
2. Using index as a dynamic key
3. Using random keys
4. Calling handlers during render
5. Missing effect dependencies
6. Adding unnecessary effects
7. Putting everything in global state
8. Giant components
9. Giant context providers
10. Storing derived data unnecessarily
11. Ignoring loading states
12. Ignoring empty states
13. Ignoring error states
14. Leaking event listeners/timers
15. Exposing frontend secrets
16. Overusing useMemo
17. Overusing useCallback
18. Fetching the same data everywhere
19. Mixing server/state concerns with UI concerns
20. Copy-pasting business logic instead of creating hooks/services
```

---

# 🎯 40. INTERVIEW RAPID FIRE

### What is React?

A UI library built around declarative components and state-driven rendering.

### Props vs state?

```text
Props → passed into component
State → owned/managed by component
```

### Why keys?

Keys help React identify list items across renders.

### What is lifting state up?

Move shared state to the nearest common ancestor that coordinates the components.

### What does useEffect do?

Synchronizes a component with an external system after render, with cleanup when necessary.

### useMemo vs useCallback?

```text
useMemo → memoized value
useCallback → memoized function
```

### useRef vs useState?

```text
useRef → persistent value without rerender
useState → state that drives rendering
```

### Controlled vs uncontrolled input?

```text
Controlled → React owns value
Uncontrolled → DOM owns value
```

### Why shouldn't state be mutated?

React relies on state updates and identity comparisons to determine when work is needed. Immutable updates make changes explicit and predictable.

---

# 🧠 41. REACT "IF YOU SEE THIS, THINK THIS" TABLE

| Problem | First thought |
|---|---|
| Parent → child data | Props |
| Child → parent event | Callback prop |
| Same state for siblings | Lift state |
| App-wide data | Context / external store |
| Complex state transitions | useReducer |
| DOM access | useRef |
| External synchronization | useEffect |
| Expensive calculation | useMemo |
| Stable callback identity | useCallback |
| Reusable behavior | Custom hook |
| Reusable layout | children/composition |
| URL-based UI state | Router / URL params |
| Async state | loading/error/success model |
| Web3 wallet | provider + signer + contract |
| Secret key | Backend, never frontend |

---

# 🧪 42. TESTING CHEAT CODE

Test behavior, not implementation details.

Example mindset:

```text
❌ "Did setCount get called?"
✅ "Does clicking +1 show the new count?"
```

Typical tools:

```text
Vitest / Jest
React Testing Library
Cypress / Playwright for end-to-end tests
```

Basic component test idea:

```jsx
render(<Counter />);

expect(screen.getByText("0")).toBeInTheDocument();

await user.click(screen.getByRole("button", { name: /\+1/i }));

expect(screen.getByText("1")).toBeInTheDocument();
```

---

# 🔐 43. SECURITY CHEAT SHEET

React itself is not your complete security layer.

Remember:

```text
Frontend = untrusted environment
Backend/API = enforce authorization
Smart contract = enforce blockchain rules
```

### Never trust:

```text
button visibility
hidden fields
frontend role checks
client-side validation alone
```

A hidden admin button does not make an endpoint or contract admin-only.

---

# 🧠 44. REACT + API + BLOCKCHAIN ARCHITECTURE

For a serious Web3 application:

```text
                 ┌──────────────┐
                 │   React UI   │
                 └──────┬───────┘
                        │
              ┌─────────┴──────────┐
              ↓                    ↓
        REST/GraphQL API      Wallet Provider
              ↓                    ↓
          Backend            Ethers / viem
              ↓                    ↓
           Database           Smart Contract
                                    ↓
                               Blockchain
```

Do not force everything into the browser.

---

# 🧭 45. PROJECT BUILD RECIPE

When building a React project:

```text
1. Identify screens
2. Identify reusable components
3. Identify server data
4. Identify local UI state
5. Identify shared state
6. Identify actions/events
7. Design loading/error/empty states
8. Define routes
9. Create API/blockchain service layer
10. Build UI
11. Add validation
12. Add tests
13. Optimize measured bottlenecks
14. Deploy
```

---

# ⚡ 46. 10X COMPONENT DESIGN FORMULA

For every component ask:

```text
INPUTS       → What props does it accept?
STATE        → What does it own?
OUTPUT       → What does it render?
EVENTS       → What can the user do?
DEPENDENCIES → What external systems does it sync with?
COMPOSITION  → What children/slots does it accept?
ERRORS       → What can go wrong?
LOADING      → What happens while waiting?
EMPTY        → What happens with no data?
TEST         → What observable behavior matters?
```

This turns vague UI work into engineering.

---

# 🧰 47. "I DON'T KNOW WHAT HOOK TO USE" CHEAT CODE

Ask what you are trying to store/do:

```text
Need changing UI data?
→ useState

Need complex transitions?
→ useReducer

Need shared app data?
→ Context / external store

Need DOM node?
→ useRef

Need persistent mutable value without render?
→ useRef

Need external synchronization?
→ useEffect

Need expensive calculation optimization?
→ useMemo

Need callback identity optimization?
→ useCallback

Need reusable stateful behavior?
→ Custom Hook
```

---

# 🧨 48. "DON'T USE useEffect YET" CHECKLIST

Before writing:

```jsx
useEffect(...)
```

ask:

```text
Can this be calculated during render?
Can an event handler do it instead?
Can I derive the value?
Can state be moved to the correct owner?
Am I syncing with something external?
```

If no external synchronization exists, an effect may be the wrong tool.

---

# 📡 49. EVENT → STATE → UI PATTERN

Most interactive React code can be understood as:

```text
USER ACTION
    ↓
EVENT HANDLER
    ↓
STATE UPDATE
    ↓
RENDER
    ↓
NEW UI
```

Example:

```text
Click "Stake"
     ↓
handleStake()
     ↓
setStatus("pending")
     ↓
React renders
     ↓
Show transaction spinner
```

This is one of the most useful debugging models.

---

# 🧠 50. DATA-FLOW RULE OF THUMB

React data usually flows:

```text
Parent
  ↓
Props
  ↓
Child
```

Events flow back through callbacks:

```text
Child
  ↓ callback
Parent
```

For broader sharing:

```text
Context / State Store
```

For persistent server data:

```text
API / cache / server-state layer
```

For blockchain truth:

```text
Smart contract
```

---

# 🏆 51. REACT MASTER CHEAT CODES

### Cheat Code #1

> **State should represent facts, not every value you can calculate.**

### Cheat Code #2

> **If siblings need coordination, move state up.**

### Cheat Code #3

> **If logic repeats, extract behavior into a custom hook.**

### Cheat Code #4

> **If UI depends on async work, model loading + success + error + empty.**

### Cheat Code #5

> **Keys identify items; they are not just warnings to silence.**

### Cheat Code #6

> **Effects are for synchronization, not general-purpose calculations.**

### Cheat Code #7

> **The browser is public. Never put secrets in React.**

### Cheat Code #8

> **For Web3, separate UI state from transaction/network state.**

### Cheat Code #9

> **Make components easy to compose rather than making them infinitely configurable.**

### Cheat Code #10

> **Optimize after measuring, not because a hook exists.**

---

# 🧪 52. MINI PATTERNS TO MEMORIZE

## Toggle

```jsx
setOpen(v => !v);
```

## Increment

```jsx
setCount(v => v + 1);
```

## Add item

```jsx
setItems(v => [...v, item]);
```

## Remove item

```jsx
setItems(v => v.filter(x => x.id !== id));
```

## Update item

```jsx
setItems(v =>
  v.map(x => x.id === id ? { ...x, done: !x.done } : x)
);
```

## Merge object

```jsx
setUser(v => ({ ...v, name }));
```

## Input

```jsx
onChange={e => setValue(e.target.value)}
```

## Checkbox

```jsx
onChange={e => setChecked(e.target.checked)}
```

## Conditional

```jsx
{condition && <Component />}
```

## Ternary

```jsx
{condition ? <A /> : <B />}
```

## List

```jsx
items.map(item => <Item key={item.id} item={item} />)
```

---

# 🚨 53. FINAL DEBUGGING FLOW

When something breaks, do **not** randomly change code.

Run this:

```text
1. What should happen?
2. What actually happens?
3. Where does the data originate?
4. Which component owns it?
5. What event/action changes it?
6. Did the handler run?
7. Did state change?
8. Did the component render?
9. Did the effect run?
10. Did the API/contract respond?
11. Is the UI reading the expected value?
12. Is there a race/async timing issue?
13. Is there a stale closure?
14. Is a key causing identity problems?
15. Is the browser/network console telling you the real error?
```

---

# 🥷 54. THE ONE-PAGE POCKET CHEAT SHEET

```text
COMPONENT
function Card({ title }) {
  return <div>{title}</div>;
}

STATE
const [value, setValue] = useState(initial);

UPDATE FROM PREVIOUS
setValue(v => v + 1);

OBJECT
setUser(v => ({ ...v, name: "A" }));

ARRAY ADD
setItems(v => [...v, item]);

ARRAY REMOVE
setItems(v => v.filter(x => x.id !== id));

ARRAY UPDATE
setItems(v => v.map(x => x.id === id ? { ...x, done: true } : x));

INPUT
<input value={value} onChange={e => setValue(e.target.value)} />

FORM
<form onSubmit={handleSubmit}>

EFFECT
useEffect(() => {
  // synchronize with external system
  return () => {};
}, [deps]);

REF
const ref = useRef(null);

MEMO VALUE
const result = useMemo(() => calc(data), [data]);

MEMO CALLBACK
const fn = useCallback(() => doThing(id), [id]);

LIST
items.map(item => <Item key={item.id} item={item} />)

CONTEXT
const value = useContext(AppContext);

REDUCER
const [state, dispatch] = useReducer(reducer, initialState);

eVENT
<button onClick={handleClick}>Save</button>

ROUTE
<Route path="/users/:id" element={<User />} />

PARAM
const { id } = useParams();

NAVIGATE
navigate("/dashboard");

LAZY
const Page = lazy(() => import("./Page"));

SUSPENSE
<Suspense fallback={<Loader />}><Page /></Suspense>
```

---

# 🎓 55. LEARNING ORDER — FROM BEGINNER → JOB READY

```text
LEVEL 1
JavaScript fundamentals
↓
JSX
↓
Components
↓
Props
↓
State

LEVEL 2
Events
↓
Forms
↓
Lists + keys
↓
Conditional rendering
↓
useEffect
↓
API fetching

LEVEL 3
Context
↓
useReducer
↓
useRef
↓
Custom hooks
↓
React Router
↓
Testing

LEVEL 4
Performance
↓
Architecture
↓
Error handling
↓
Accessibility
↓
Authentication
↓
Deployment

LEVEL 5 — WEB3
Wallet connection
↓
Provider / signer
↓
Contract reads
↓
Transactions
↓
Events
↓
Network switching
↓
Transaction UX
↓
Production DApp architecture
```

---

# 🔥 56. PROJECT IDEAS TO MASTER THE PATTERNS

### Beginner

```text
1. Counter
2. Todo App
3. Calculator
4. Notes App
5. Password generator
6. Expense tracker
```

### Intermediate

```text
7. Weather dashboard
8. Movie search
9. Authentication UI
10. E-commerce cart
11. Admin dashboard
12. Kanban board
13. Chat UI
```

### Advanced

```text
14. SaaS dashboard
15. Realtime collaborative app
16. NFT dashboard
17. Token portfolio
18. Staking DApp
19. DAO voting DApp
20. Creator funding DApp
```

### Expert-level practice

```text
Build the same app three ways:

1. Local state
2. Context + reducer
3. External/server-state architecture
```

Then compare:

```text
complexity
performance
testability
maintainability
developer experience
```

---

# 🧠 57. FINAL MINDSET

Don't memorize 100 React APIs.

Memorize the decision tree:

```text
What is changing?
      ↓
Does it affect UI?
      ↓
     YES
      ↓
State?
      ↓
Where should that state live?
      ↓
Who needs the data?
      ↓
Props / Context / Store
      ↓
Does something external need synchronization?
      ↓
     YES → Effect / external integration
      ↓
Is the logic repeated?
      ↓
     YES → Custom Hook
      ↓
Is rendering expensive?
      ↓
     Measure → then optimize
```

> **React becomes much easier when you stop asking “Which syntax do I memorize?” and start asking “Where does this data belong, who owns it, and what event changes it?”**

---

## ⚡ 10-SECOND REACT RECALL

```text
Props       = input
State       = changing data
Render      = UI from current data
Event       = user action
Callback    = send action/data upward
Effect      = external synchronization
Ref         = persistent non-rendering value / DOM handle
Context     = shared data channel
Reducer     = state transition machine
Memo        = optimization
Hook        = reusable React behavior
Key         = list item identity
Component   = reusable UI + behavior boundary
```

# ✅ DONE

Keep this file beside your React project.

When stuck, search this document for the concept instead of searching the entire internet.
