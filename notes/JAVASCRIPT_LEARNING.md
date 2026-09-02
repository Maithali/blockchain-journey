# 🟨 JAVASCRIPT — COMPLETE LEARNING & REVISION GUIDE

> 🎯 **Goal:** Learn JavaScript from fundamentals to advanced concepts, build strong frontend foundations, and prepare for React/Web3 interviews.

---

# 📚 Table of Contents

1. What is JavaScript?
2. JavaScript Runtime
3. How JavaScript Executes
4. Variables
5. Data Types
6. Primitive vs Reference Types
7. Type Conversion
8. Operators
9. Conditionals
10. Loops
11. Functions
12. Scope
13. Hoisting
14. Closures
15. Arrays
16. Array Methods
17. Objects
18. Object Methods
19. Destructuring
20. Spread & Rest
21. Strings
22. Numbers & Math
23. Date & Time
24. Map, Set, WeakMap, WeakSet
25. Optional Chaining & Nullish Coalescing
26. `this`
27. call, apply, bind
28. Prototypes
29. Classes & OOP
30. Modules
31. Error Handling
32. JSON
33. DOM
34. Events
35. Event Propagation
36. Forms
37. Browser Storage
38. BOM & Browser APIs
39. Asynchronous JavaScript
40. Callbacks
41. Promises
42. async/await
43. Event Loop
44. Fetch API
45. HTTP & APIs
46. Debouncing & Throttling
47. Functional Programming
48. Immutability
49. Higher-Order Functions
50. Generators & Iterators
51. Symbols
52. BigInt
53. Regular Expressions
54. Memory Management
55. Performance
56. Security
57. Modern JavaScript
58. Common Mistakes
59. Interview Questions
60. Coding Practice
61. Learning Roadmap
62. 60-Second Revision
63. Golden Rules

---

# 1. 🟨 What is JavaScript?

JavaScript is a high-level programming language primarily used to create dynamic and interactive applications.

It runs in:

```text
Browser
Node.js
Deno
Bun
Other JavaScript runtimes
```

JavaScript can be used for:

- Web applications
- Frontend development
- Backend development
- APIs
- Automation
- Desktop applications
- Mobile applications
- Serverless applications
- Blockchain/Web3 applications

---

# 2. ⚙️ JavaScript Runtime

JavaScript itself is a language.

A runtime provides the environment in which JavaScript executes.

## Browser

```text
Browser
 ├── JavaScript Engine
 ├── DOM
 ├── Web APIs
 └── Event Loop
```

Examples of browser APIs:

```text
document
fetch()
localStorage
setTimeout()
WebSocket
Geolocation
```

## Node.js

```text
Node.js
 ├── V8
 ├── Node APIs
 └── Event Loop
```

Node provides APIs such as:

```text
fs
http
path
process
Buffer
```

---

# 3. 🧠 How JavaScript Executes

Basic model:

```text
JavaScript Code
      ↓
Parser
      ↓
Execution Context
      ↓
Call Stack
      ↓
JavaScript Engine
      ↓
Result
```

For asynchronous work:

```text
Call Stack
    ↓
Web/Runtime APIs
    ↓
Task/Microtask Queues
    ↓
Event Loop
    ↓
Call Stack
```

---

# 4. 📦 Variables

Variables create bindings to values.

Three declarations:

```js
var
let
const
```

## `let`

```js
let age = 25;
age = 26;
```

Can be reassigned.

## `const`

```js
const name = "Alice";
```

The binding cannot be reassigned.

```js
// Error
name = "Bob";
```

But object contents can still be changed:

```js
const user = {
  name: "Alice",
};

user.name = "Bob";
```

## `var`

```js
var x = 10;
```

`var` is function-scoped and has older hoisting behavior.

Prefer:

```text
const by default
let when reassignment is needed
avoid var in modern code
```

---

# 5. 🧬 Data Types

JavaScript has primitive and object values.

## Primitive types

```text
string
number
bigint
boolean
undefined
symbol
null
```

Example:

```js
const name = "Alice";
const age = 25;
const active = true;
const value = undefined;
const empty = null;
const id = Symbol("id");
const huge = 12345678901234567890n;
```

## Object

```js
const user = {
  name: "Alice",
  age: 25,
};
```

Arrays and functions are objects in JavaScript's object model.

---

# 6. 🔀 Primitive vs Reference Values

## Primitive

Primitives are immutable values.

```js
let a = 10;
let b = a;

b = 20;

console.log(a); // 10
```

## Object/reference

Variables holding objects contain references to those objects.

```js
const user1 = {
  name: "Alice",
};

const user2 = user1;

user2.name = "Bob";

console.log(user1.name); // Bob
```

Mental model:

```text
Primitive
variable → value

Object
variable → reference → object
```

---

# 7. 🔄 Type Conversion

## Explicit conversion

```js
Number("123"); // 123
String(123); // "123"
Boolean(1); // true
```

## String to number

```js
const value = "42";

Number(value);
parseInt(value, 10);
parseFloat("42.5");
```

## Truthy and falsy

Falsy values include:

```text
false
0
-0
0n
""
null
undefined
NaN
```

Almost everything else is truthy.

---

# 8. ➕ Operators

## Arithmetic

```js
+
-
*
/
%
**
```

Example:

```js
10 % 3; // 1
2 ** 3; // 8
```

## Assignment

```js
=
+=
-=
*=
/=
%=
```

## Comparison

```js
===
!==
>
<
>=
<=
```

Prefer strict equality in most application code.

## Logical

```js
&&
||
!
```

Example:

```js
isLoggedIn && showDashboard();
```

## Nullish coalescing

```js
const name = user.name ?? "Guest";
```

`??` uses the fallback only when the left side is `null` or `undefined`.

---

# 9. 🔀 Conditionals

## if

```js
if (age >= 18) {
  console.log("Adult");
}
```

## if/else

```js
if (score >= 50) {
  console.log("Pass");
} else {
  console.log("Fail");
}
```

## else if

```js
if (score >= 90) {
  grade = "A";
} else if (score >= 75) {
  grade = "B";
} else {
  grade = "C";
}
```

## Ternary

```js
const result = age >= 18 ? "Adult" : "Minor";
```

## switch

```js
switch (role) {
  case "admin":
    console.log("Admin");
    break;

  case "user":
    console.log("User");
    break;

  default:
    console.log("Unknown");
}
```

---

# 10. 🔁 Loops

## for

```js
for (let i = 0; i < 5; i++) {
  console.log(i);
}
```

## while

```js
let i = 0;

while (i < 5) {
  console.log(i);
  i++;
}
```

## do...while

```js
let i = 0;

do {
  console.log(i);
  i++;
} while (i < 5);
```

## for...of

Use for iterable values:

```js
const numbers = [10, 20, 30];

for (const number of numbers) {
  console.log(number);
}
```

## for...in

Use for enumerable object keys:

```js
const user = {
  name: "Alice",
  age: 25,
};

for (const key in user) {
  console.log(key, user[key]);
}
```

Avoid using `for...in` as your normal array iteration tool.

---

# 11. 🧩 Functions

Functions are reusable blocks of logic.

## Function declaration

```js
function add(a, b) {
  return a + b;
}
```

## Function expression

```js
const add = function (a, b) {
  return a + b;
};
```

## Arrow function

```js
const add = (a, b) => {
  return a + b;
};
```

Short form:

```js
const add = (a, b) => a + b;
```

## Default parameters

```js
function greet(name = "Guest") {
  return `Hello ${name}`;
}
```

## Rest parameters

```js
function sum(...numbers) {
  return numbers.reduce((total, n) => total + n, 0);
}
```

---

# 12. 🔭 Scope

Scope determines where a variable can be accessed.

Types:

```text
Global Scope
Function Scope
Block Scope
Module Scope
```

## Block scope

```js
{
  let x = 10;
  const y = 20;
}

// x and y unavailable here
```

`let` and `const` are block-scoped.

`var` is function-scoped.

---

# 13. 🚀 Hoisting

JavaScript processes declarations as part of setting up an execution environment.

## `var`

```js
console.log(x); // undefined

var x = 10;
```

Conceptually:

```js
var x;
console.log(x);
x = 10;
```

## `let` and `const`

They cannot be accessed before initialization because of the Temporal Dead Zone.

```js
console.log(x); // ReferenceError

let x = 10;
```

## Function declaration

```js
sayHello();

function sayHello() {
  console.log("Hello");
}
```

Function declarations can be called before their declaration.

---

# 14. 🔒 Closures

A closure occurs when a function retains access to variables from its surrounding lexical scope.

```js
function createCounter() {
  let count = 0;

  return function () {
    count++;
    return count;
  };
}

const counter = createCounter();

console.log(counter()); // 1
console.log(counter()); // 2
```

Mental model:

```text
Outer Function
     ↓
Local Variable
     ↓
Returned Function
     ↓
Still remembers variable
```

Closures are important for:

- Data privacy patterns
- Callbacks
- Event handlers
- Function factories
- React Hooks concepts

---

# 15. 📚 Arrays

Arrays store ordered collections.

```js
const fruits = ["apple", "banana", "orange"];
```

Access:

```js
fruits[0];
```

Length:

```js
fruits.length;
```

Modify:

```js
fruits.push("mango");
fruits.pop();
fruits.shift();
fruits.unshift("grape");
```

---

# 16. 🛠️ Array Methods

## map

Creates a new array.

```js
const numbers = [1, 2, 3];

const doubled = numbers.map((n) => n * 2);
```

## filter

```js
const adults = users.filter((user) => user.age >= 18);
```

## find

```js
const user = users.find((user) => user.id === 10);
```

## findIndex

```js
const index = users.findIndex((user) => user.id === 10);
```

## some

```js
const hasAdmin = users.some((user) => user.role === "admin");
```

## every

```js
const allAdults = users.every((user) => user.age >= 18);
```

## reduce

```js
const total = numbers.reduce((sum, n) => sum + n, 0);
```

## includes

```js
numbers.includes(5);
```

## slice

Does not mutate the original array.

```js
const copy = numbers.slice(1, 3);
```

## splice

Mutates the original array.

```js
numbers.splice(1, 1);
```

Remember:

```text
map      → transform
filter   → select
find     → first matching item
some     → at least one?
every    → all?
reduce   → accumulate
```

---

# 17. 🧱 Objects

Objects store key-value properties.

```js
const user = {
  name: "Alice",
  age: 25,
  active: true,
};
```

Read:

```js
user.name;
user["age"];
```

Update:

```js
user.age = 26;
```

Add:

```js
user.email = "alice@example.com";
```

Delete:

```js
delete user.active;
```

Computed property:

```js
const key = "name";

const user = {
  [key]: "Alice",
};
```

---

# 18. 🛠️ Object Methods

```js
Object.keys(user);
Object.values(user);
Object.entries(user);
```

Example:

```js
const user = {
  name: "Alice",
  age: 25,
};

console.log(Object.keys(user));
// ["name", "age"]
```

Convert entries:

```js
Object.fromEntries([
  ["name", "Alice"],
  ["age", 25],
]);
```

Copy/merge:

```js
const copy = { ...user };

const merged = {
  ...user,
  active: true,
};
```

---

# 19. 📦 Destructuring

## Array

```js
const numbers = [10, 20];

const [a, b] = numbers;
```

## Object

```js
const user = {
  name: "Alice",
  age: 25,
};

const { name, age } = user;
```

Rename:

```js
const { name: userName } = user;
```

Default:

```js
const { role = "user" } = user;
```

Function parameter:

```js
function printUser({ name, age }) {
  console.log(name, age);
}
```

---

# 20. 📦 Spread & Rest

## Spread

Expands values.

Array:

```js
const a = [1, 2];
const b = [...a, 3, 4];
```

Object:

```js
const user2 = {
  ...user1,
  active: true,
};
```

## Rest

Collects values.

```js
function sum(...numbers) {
  return numbers.reduce((a, b) => a + b, 0);
}
```

Remember:

```text
... when expanding → Spread
... when collecting → Rest
```

---

# 21. 🔤 Strings

```js
const name = "JavaScript";
```

Useful methods:

```js
name.length;
name.toUpperCase();
name.toLowerCase();
name.includes("Script");
name.startsWith("Java");
name.endsWith("Script");
name.slice(0, 4);
name.substring(0, 4);
name.replace("Java", "Type");
name.split("");
```

Template literals:

```js
const name = "Alice";

console.log(`Hello ${name}`);
```

Multiline:

```js
const message = `
Hello
World
`;
```

---

# 22. 🔢 Numbers & Math

JavaScript's normal `number` type uses IEEE 754 double-precision floating point.

```js
const price = 99.99;
```

Useful:

```js
Math.round(4.6);
Math.floor(4.9);
Math.ceil(4.1);
Math.max(1, 5, 3);
Math.min(1, 5, 3);
Math.random();
Math.abs(-10);
Math.pow(2, 3);
```

Important:

```js
0.1 + 0.2 !== 0.3;
```

For financial applications, use appropriate integer/fixed-point or decimal strategies rather than assuming binary floating point is exact.

---

# 23. 📅 Date & Time

```js
const now = new Date();
```

Examples:

```js
now.getFullYear();
now.getMonth();
now.getDate();
now.getHours();
now.getMinutes();
```

Timestamp:

```js
Date.now();
```

ISO:

```js
now.toISOString();
```

Remember:

```text
getMonth() → 0-based
January → 0
December → 11
```

For complex timezone/date work, use well-designed date/time libraries or modern platform APIs where appropriate.

---

# 24. 🗺️ Map, Set, WeakMap, WeakSet

## Map

Stores key-value pairs.

```js
const users = new Map();

users.set(1, "Alice");
users.set(2, "Bob");

users.get(1);
users.has(2);
users.delete(2);
```

Map keys can be values of any type.

## Set

Stores unique values.

```js
const numbers = new Set([1, 2, 2, 3]);

console.log(numbers);
// Set {1, 2, 3}
```

Convert:

```js
const unique = [...new Set(numbersArray)];
```

## WeakMap / WeakSet

Designed for object-keyed weak references and specialized memory-management use cases.

They are not iterable like Map/Set.

---

# 25. ❓ Optional Chaining & Nullish Coalescing

## Optional chaining

```js
user?.profile?.address?.city;
```

Prevents errors when an intermediate value is `null` or `undefined`.

## Nullish coalescing

```js
const name = user.name ?? "Guest";
```

Difference:

```js
0 ?? 10; // 0
0 || 10; // 10
```

Use `??` when only null/undefined should trigger the fallback.

---

# 26. 🎯 `this`

`this` is a context value whose behavior depends on how a function is called, with special rules for arrow functions.

Object method:

```js
const user = {
  name: "Alice",

  greet() {
    console.log(this.name);
  },
};

user.greet();
```

Regular function:

```js
function show() {
  console.log(this);
}
```

Its value depends on the invocation form and strict-mode rules.

Arrow functions do not create their own `this`; they capture it lexically from the surrounding scope.

---

# 27. 📞 call, apply, bind

They control `this` for ordinary functions.

```js
function greet(city) {
  console.log(this.name, city);
}

const user = {
  name: "Alice",
};
```

## call

```js
greet.call(user, "Nagpur");
```

## apply

```js
greet.apply(user, ["Nagpur"]);
```

## bind

Returns a new function.

```js
const boundGreet = greet.bind(user);

boundGreet("Nagpur");
```

Remember:

```text
call  → invoke now, arguments separately
apply → invoke now, arguments as array-like
bind  → return new bound function
```

---

# 28. 🧬 Prototypes

JavaScript objects can inherit behavior through the prototype chain.

```text
object
  ↓
prototype
  ↓
prototype
  ↓
null
```

Property lookup can continue through the object's prototype chain if the property is not found directly on the object.

Check:

```js
Object.getPrototypeOf(user);
```

---

# 29. 🏛️ Classes & OOP

Classes provide syntax for creating objects and defining prototype-based behavior.

```js
class User {
  constructor(name) {
    this.name = name;
  }

  greet() {
    return `Hello ${this.name}`;
  }
}

const user = new User("Alice");

console.log(user.greet());
```

## Inheritance

```js
class Admin extends User {
  constructor(name, role) {
    super(name);
    this.role = role;
  }

  deleteUser() {
    console.log("Deleting user");
  }
}
```

Core OOP ideas:

```text
Encapsulation
Abstraction
Inheritance
Polymorphism
```

Private class fields:

```js
class Account {
  #balance = 0;

  deposit(amount) {
    this.#balance += amount;
  }

  getBalance() {
    return this.#balance;
  }
}
```

---

# 30. 📦 Modules

Modules allow code to be split into files.

## Export

```js
export function add(a, b) {
  return a + b;
}
```

## Import

```js
import { add } from "./math.js";
```

## Default export

```js
export default function greet() {
  console.log("Hello");
}
```

Import:

```js
import greet from "./greet.js";
```

## Namespace import

```js
import * as math from "./math.js";

math.add(1, 2);
```

Benefits:

- Organization
- Reusability
- Encapsulation
- Dependency management
- Maintainability

---

# 31. 🚨 Error Handling

## try/catch

```js
try {
  riskyOperation();
} catch (error) {
  console.error(error);
}
```

## finally

```js
try {
  connect();
} catch (error) {
  console.error(error);
} finally {
  cleanup();
}
```

## throw

```js
if (age < 18) {
  throw new Error("Age must be 18+");
}
```

Custom error:

```js
class ValidationError extends Error {
  constructor(message) {
    super(message);
    this.name = "ValidationError";
  }
}
```

---

# 32. 📄 JSON

JSON is a text format commonly used for data exchange.

Object:

```js
const user = {
  name: "Alice",
  age: 25,
};
```

Convert to JSON:

```js
const json = JSON.stringify(user);
```

Convert JSON to object:

```js
const object = JSON.parse(json);
```

Important:

```text
JSON is text.
JavaScript object is a JavaScript value.
```

---

# 33. 🌐 DOM

DOM = Document Object Model.

The browser represents HTML as a tree.

```text
Document
   │
   └── html
       ├── head
       └── body
           ├── h1
           └── button
```

Select elements:

```js
document.getElementById("title");

document.querySelector(".card");

document.querySelectorAll(".item");
```

Change content:

```js
element.textContent = "Hello";
```

Change HTML:

```js
element.innerHTML = "<strong>Hello</strong>";
```

Be careful with `innerHTML` when content is untrusted.

Change class:

```js
element.classList.add("active");
element.classList.remove("active");
element.classList.toggle("active");
```

---

# 34. 🖱️ Events

```js
button.addEventListener("click", () => {
  console.log("Clicked");
});
```

Common events:

```text
click
input
change
submit
keydown
keyup
focus
blur
mouseover
scroll
```

Event object:

```js
button.addEventListener("click", (event) => {
  console.log(event.target);
});
```

---

# 35. 🔄 Event Propagation

Event flow:

```text
Capturing
    ↓
Target
    ↓
Bubbling
```

Default listeners normally participate in bubbling.

Stop propagation:

```js
event.stopPropagation();
```

## Event delegation

Attach one listener to a parent.

```js
list.addEventListener("click", (event) => {
  if (event.target.matches("button")) {
    console.log("Button clicked");
  }
});
```

Useful for dynamic lists.

---

# 36. 📝 Forms

```js
form.addEventListener("submit", (event) => {
  event.preventDefault();

  const formData = new FormData(form);

  console.log(formData.get("email"));
});
```

Always validate input.

Client validation improves UX.

Server validation is still required for security.

---

# 37. 💾 Browser Storage

## localStorage

Persists until explicitly cleared.

```js
localStorage.setItem("name", "Alice");

const name = localStorage.getItem("name");

localStorage.removeItem("name");
```

Objects:

```js
localStorage.setItem("user", JSON.stringify(user));

const user = JSON.parse(localStorage.getItem("user"));
```

## sessionStorage

Usually persists for the lifetime of the page session.

## Cookies

Cookies can be sent with HTTP requests depending on configuration.

Security-sensitive cookies should use appropriate flags such as:

```text
HttpOnly
Secure
SameSite
```

Do not store sensitive secrets in ordinary web storage without understanding the security consequences.

---

# 38. 🌍 BOM & Browser APIs

BOM = Browser Object Model.

Examples:

```js
window;
location;
history;
navigator;
screen;
```

Navigation:

```js
window.location.href = "/home";
```

History:

```js
history.back();
history.forward();
```

Timers:

```js
setTimeout(() => {
  console.log("Later");
}, 1000);
```

```js
const id = setInterval(() => {
  console.log("Tick");
}, 1000);

clearInterval(id);
```

---

# 39. ⏳ Asynchronous JavaScript

JavaScript execution is synchronous by default, but runtimes provide asynchronous APIs.

Common asynchronous operations:

```text
Timers
Network requests
File operations
User events
Database operations
```

Mental model:

```text
Start operation
      ↓
Continue executing
      ↓
Operation completes later
      ↓
Callback / Promise continuation
```

---

# 40. 📞 Callbacks

A callback is a function passed to another function.

```js
function processUser(user, callback) {
  callback(user);
}

processUser({ name: "Alice" }, (user) => console.log(user.name));
```

Problem:

Nested callbacks can become difficult to maintain.

```text
Callback
   ↓
Callback
   ↓
Callback
   ↓
Callback
```

Promises help structure asynchronous operations.

---

# 41. 🤝 Promises

A Promise represents the eventual result of an asynchronous operation.

States:

```text
pending
fulfilled
rejected
```

Example:

```js
const promise = new Promise((resolve, reject) => {
  const success = true;

  if (success) {
    resolve("Success");
  } else {
    reject(new Error("Failed"));
  }
});
```

Consume:

```js
promise
  .then((result) => {
    console.log(result);
  })
  .catch((error) => {
    console.error(error);
  })
  .finally(() => {
    console.log("Done");
  });
```

Useful Promise combinators:

```js
Promise.all([...]);
Promise.allSettled([...]);
Promise.race([...]);
Promise.any([...]);
```

---

# 42. 🧹 async/await

`async` functions always return a Promise.

```js
async function getUser() {
  return { name: "Alice" };
}
```

`await` pauses the async function until the awaited Promise settles.

```js
async function loadUser() {
  const response = await fetch("/api/user");
  const user = await response.json();

  return user;
}
```

Error handling:

```js
async function loadUser() {
  try {
    const response = await fetch("/api/user");

    if (!response.ok) {
      throw new Error("Request failed");
    }

    return await response.json();
  } catch (error) {
    console.error(error);
  }
}
```

---

# 43. 🔁 Event Loop

Critical interview topic.

Consider:

```js
console.log("A");

setTimeout(() => {
  console.log("B");
}, 0);

Promise.resolve().then(() => {
  console.log("C");
});

console.log("D");
```

Output:

```text
A
D
C
B
```

Simplified model:

```text
Call Stack
    ↓
Synchronous code
    ↓
Microtask Queue
    ↓
Task Queue
    ↓
Next event-loop turn
```

Promise reactions run as microtasks.

Timer callbacks are tasks.

---

# 44. 🌐 Fetch API

Basic:

```js
const response = await fetch("https://example.com/api/users");

const data = await response.json();
```

POST:

```js
const response = await fetch("/api/users", {
  method: "POST",

  headers: {
    "Content-Type": "application/json",
  },

  body: JSON.stringify({
    name: "Alice",
  }),
});
```

Always check:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

Important:

```text
fetch() does not reject merely because the server returns
an HTTP error status such as 404 or 500.
```

---

# 45. 🌐 HTTP & APIs

Common methods:

```text
GET
POST
PUT
PATCH
DELETE
```

Common status codes:

```text
200 → OK
201 → Created
204 → No Content
400 → Bad Request
401 → Authentication required
403 → Forbidden
404 → Not Found
409 → Conflict
429 → Too Many Requests
500 → Server Error
```

Typical frontend flow:

```text
UI
 ↓
Function
 ↓
fetch()
 ↓
API
 ↓
Server
 ↓
Database
 ↓
Response
 ↓
Update UI
```

---

# 46. ⏱️ Debouncing & Throttling

## Debouncing

Wait until activity stops.

Useful for:

```text
Search input
Validation
Autosave
```

Example:

```js
function debounce(fn, delay) {
  let timer;

  return (...args) => {
    clearTimeout(timer);

    timer = setTimeout(() => {
      fn(...args);
    }, delay);
  };
}
```

## Throttling

Limit execution to at most once per interval.

Useful for:

```text
Scroll
Resize
Mouse movement
```

Remember:

```text
Debounce → after activity stops
Throttle → at controlled intervals
```

---

# 47. 🧠 Functional Programming

Important concepts:

```text
Pure functions
Immutability
Composition
Higher-order functions
Declarative transformations
```

Pure function:

```js
function add(a, b) {
  return a + b;
}
```

Same inputs:

```text
Same inputs → Same output
```

Avoid unnecessary side effects.

---

# 48. 🧊 Immutability

Instead of changing existing data:

```js
const user = {
  name: "Alice",
  age: 25,
};
```

When an immutable update is appropriate:

```js
const updatedUser = {
  ...user,
  age: 26,
};
```

Array:

```js
const updated = [...items, newItem];
```

Remove:

```js
const updated = items.filter((item) => item.id !== id);
```

---

# 49. 🔁 Higher-Order Functions

A higher-order function:

- accepts a function
- returns a function
- or both

Example:

```js
function multiplyBy(x) {
  return function (y) {
    return x * y;
  };
}

const double = multiplyBy(2);

console.log(double(5)); // 10
```

Array methods such as:

```text
map
filter
reduce
some
every
find
```

use functions as arguments.

---

# 50. 🔄 Iterators & Generators

Iterable values can be consumed by constructs such as:

```js
for...of
```

Examples:

```text
Array
String
Map
Set
```

Generator:

```js
function* numbers() {
  yield 1;
  yield 2;
  yield 3;
}

const generator = numbers();

console.log(generator.next());
console.log(generator.next());
```

Generator result:

```js
{
  value: 1,
  done: false
}
```

Generators pause and resume execution.

---

# 51. 🔣 Symbols

Symbol creates unique primitive values.

```js
const id = Symbol("id");
```

Two Symbols are unique:

```js
Symbol("id") === Symbol("id");
// false
```

Can be used as object keys:

```js
const id = Symbol("id");

const user = {
  [id]: 123,
};
```

Symbols are also used by the language for well-known protocols.

---

# 52. 🧮 BigInt

BigInt represents integers larger than the safe integer range of `number`.

```js
const big = 123456789012345678901234567890n;
```

Operations:

```js
const a = 10n;
const b = 20n;

console.log(a + b);
```

Do not mix BigInt and Number directly:

```js
1n + 1; // TypeError
```

Use appropriate conversion.

---

# 53. 🔍 Regular Expressions

Regex performs pattern matching.

```js
const pattern = /^[A-Z][a-z]+$/;

pattern.test("Alice");
```

Common symbols:

```text
^ → beginning
$ → end
. → any character
* → zero or more
+ → one or more
? → optional
\d → digit
\w → word character
\s → whitespace
```

Regex is useful, but complex validation should be designed carefully.

---

# 54. 🧠 Memory Management

JavaScript uses automatic garbage collection.

Simplified:

```text
Create object
    ↓
Object reachable
    ↓
Used
    ↓
No longer reachable
    ↓
Eligible for garbage collection
```

Common memory leak causes:

- Unremoved event listeners
- Long-lived timers
- Global references
- Large caches
- Closures retaining unnecessary data
- Subscriptions not cleaned up

---

# 55. ⚡ Performance

Improve performance by:

```text
Avoid unnecessary work
Use appropriate data structures
Avoid accidental repeated calculations
Virtualize huge lists
Debounce expensive input operations
Lazy-load expensive resources
Optimize network requests
Cache carefully
Profile before optimizing
```

Measure first:

```text
Problem
 ↓
Profile
 ↓
Identify bottleneck
 ↓
Optimize
 ↓
Measure again
```

---

# 56. 🔐 Security

Important JavaScript/web security concepts:

```text
XSS
CSRF
CORS
Injection
Authentication
Authorization
Content Security Policy
Secure cookies
Input validation
```

## XSS

Never blindly inject untrusted HTML:

```js
element.innerHTML = userInput;
```

Prefer:

```js
element.textContent = userInput;
```

## Authentication vs Authorization

```text
Authentication
→ Who are you?

Authorization
→ What are you allowed to do?
```

Frontend checks are not sufficient security boundaries.

---

# 57. 🆕 Modern JavaScript

Know these features:

```text
let / const
Arrow functions
Template literals
Destructuring
Spread / Rest
Default parameters
Modules
Classes
Promises
async/await
Optional chaining
Nullish coalescing
Map / Set
Private class fields
BigInt
Symbols
```

Also understand newer language features as they become relevant to your runtime and project.

---

# 58. 🚨 Common Mistakes

## 1. Using `==` everywhere

Prefer:

```js
===
!==
```

## 2. Mutating objects unexpectedly

Avoid accidental shared-reference mutation.

## 3. Confusing `map()` and `forEach()`

```text
map     → returns a new transformed array
forEach → executes side effects, returns undefined
```

## 4. Forgetting `return`

```js
const double = numbers.map((n) => {
  n * 2;
});
```

Wrong.

Correct:

```js
const double = numbers.map((n) => {
  return n * 2;
});
```

Or:

```js
const double = numbers.map((n) => n * 2);
```

## 5. Misunderstanding async

```js
const data = fetch("/api");
```

`data` is a Promise, not the response body.

## 6. Forgetting `await`

```js
const response = await fetch(url);
```

## 7. Not checking HTTP errors

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

## 8. Using arrow functions when dynamic `this` is required

Understand lexical `this`.

## 9. Overusing global variables

Prefer modules and controlled state.

## 10. Trusting client-side validation

Always validate security-sensitive data on the server.

---

# 59. 🎯 JavaScript Interview Questions

## What is JavaScript?

A programming language used extensively for interactive web applications and also available in server and other runtime environments.

## JavaScript vs Java?

They are different languages.

```text
JavaScript → dynamically typed scripting/programming language
Java       → statically typed general-purpose language
```

## `var` vs `let` vs `const`?

```text
var   → function-scoped, legacy behavior
let   → block-scoped, reassignable
const → block-scoped, binding not reassignable
```

## `null` vs `undefined`?

```text
undefined → commonly means missing/uninitialized value
null      → intentional absence of a value
```

## `==` vs `===`?

```text
==  → allows type coercion
=== → strict equality
```

## What is closure?

A function retaining access to variables from its lexical environment after the outer function has returned.

## What is hoisting?

Declaration processing that affects when declarations can be referenced, with different behavior for `var`, `let`, `const`, and functions.

## What is the event loop?

A runtime mechanism that coordinates synchronous execution with asynchronous callbacks/tasks and microtasks.

## What is a Promise?

An object representing the eventual completion or failure of an asynchronous operation.

## Promise vs async/await?

`async/await` is syntax built around Promises that often makes asynchronous control flow easier to read.

## What is a callback?

A function passed to another function to be invoked later or under a particular condition.

## What is `this`?

A context value whose behavior depends on the invocation form and function type.

## What is prototype inheritance?

Objects can delegate property/method lookup through a prototype chain.

## What is event delegation?

Handling events at a parent element instead of attaching separate listeners to every child.

## What is debouncing?

Delaying execution until a burst of activity stops.

## What is throttling?

Limiting how often a function executes during repeated activity.

## What is shallow copy?

A new top-level container whose nested object references may still point to the original objects.

```js
const copy = { ...user };
```

## Deep copy?

A copy where nested data is independently copied according to the cloning method.

Modern platform option:

```js
const copy = structuredClone(original);
```

Not every value is cloneable, so understand the API's limitations.

## What is the temporal dead zone?

The temporal dead zone (TDZ) is the period between entering a scope and the point where a `let`, `const`, or `class` declaration is initialized. Accessing the binding during this period throws a `ReferenceError`.

## Why does a closure in a loop sometimes produce unexpected results?

`var` creates one function-scoped binding, so callbacks can observe the final value after the loop ends. `let` creates a new block-scoped binding for each iteration.

```js
for (let index = 0; index < 3; index++) {
  setTimeout(() => console.log(index), 0);
}

// 0 1 2
```

## What is the difference between lexical scope and dynamic scope?

JavaScript uses lexical scope: variable lookup is determined by where code is written, not by which function calls it. Closures work because they preserve access to that lexical environment.

## What is the difference between an arrow function and a regular function?

Arrow functions have lexical `this`, do not have their own `arguments`, and cannot be used as constructors. Regular functions receive `this` from their call site and can be called with `new`.

## How is `this` determined?

For a regular function, `this` depends on the call form: `obj.method()` uses `obj`, `call` and `apply` explicitly set it, `new` creates a new instance context, and a bare call uses `undefined` in strict mode. Arrow functions inherit `this` from their surrounding scope.

## What is the difference between a class and a prototype?

Classes provide syntax for creating objects and setting up inheritance. Under the hood, method lookup still uses the prototype chain, and class methods are stored on the prototype rather than copied to every instance.

## What is the difference between `Object.create()` and `new`?

`Object.create(proto)` creates an object with the supplied prototype. `new Constructor()` creates an object linked to `Constructor.prototype`, binds `this` inside the constructor, and returns the constructed object unless the constructor returns another object.

## What is the difference between `map()`, `forEach()`, and `reduce()`?

```text
map()     -> creates an array from transformed elements
forEach() -> runs a callback for side effects and returns undefined
reduce()  -> combines elements into one accumulated result
```

## Why can `0.1 + 0.2` be inaccurate?

JavaScript numbers use IEEE 754 double-precision floating-point representation. Some decimal fractions cannot be represented exactly in binary, so calculations can produce values such as `0.30000000000000004`.

## What is the difference between `||` and `??`?

`||` falls back for every falsy value, including `0`, `false`, and `""`. `??` falls back only for `null` or `undefined`.

```js
0 || 10; // 10
0 ?? 10; // 0
```

## What does an `async` function return?

It always returns a Promise. A returned value becomes a fulfilled Promise, while a thrown error becomes a rejected Promise.

## How do you handle multiple independent asynchronous operations?

Use `Promise.all()` when every operation must succeed and results are needed together. It rejects as soon as one Promise rejects. Use `Promise.allSettled()` when each outcome should be inspected independently.

## What is the difference between microtasks and tasks?

Promise reactions and `queueMicrotask()` use the microtask queue. Timers, DOM events, and many I/O callbacks are tasks. After the current stack completes, the runtime drains microtasks before taking another task.

## Does `fetch()` reject for a 404 response?

No. A 404 or 500 is still a completed HTTP response. Check `response.ok` or `response.status`, then throw an error when the application considers the response unsuccessful.

## What is event bubbling and how can it be stopped?

After an event targets an element, it can propagate from that element toward ancestors. Call `event.stopPropagation()` to stop propagation. Use `event.preventDefault()` separately when you want to cancel the browser's default action.

## What is the difference between `preventDefault()` and `stopPropagation()`?

`preventDefault()` cancels a default browser behavior, such as form submission. `stopPropagation()` prevents the event from moving through the capture or bubble path; it does not cancel the default behavior.

## How do memory leaks happen in browser JavaScript?

Common causes include forgotten event listeners, active timers, subscriptions, detached DOM nodes still referenced by JavaScript, and unbounded caches. Remove listeners and cancel timers or subscriptions when their owning component is destroyed.

## What is the difference between debounce and throttle in an input search?

Debounce waits until typing pauses before sending a request, reducing requests during a burst. Throttle allows requests at a controlled maximum frequency, which is more useful for continuous events such as scrolling.

## What is XSS and how can JavaScript code reduce its risk?

Cross-site scripting (XSS) occurs when untrusted content is executed as code in a user's browser. Prefer `textContent` over `innerHTML` for plain text, sanitize unavoidable HTML, validate server-side, and use an appropriate Content Security Policy.

## What is the difference between a module and a script?

Modules have their own scope, support `import` and `export`, are deferred by default in browsers, and run in strict mode. A classic script shares more global scope and does not support static module imports.

## Output question: what is logged?

```js
console.log(typeof null);
console.log([] == false);
console.log([] === false);
```

```text
object
true
false
```

`typeof null` is a historical language quirk. Loose equality performs coercion; strict equality does not.

## Output question: what is logged?

```js
console.log("A");

setTimeout(() => console.log("B"), 0);

Promise.resolve().then(() => console.log("C"));

console.log("D");
```

```text
A
D
C
B
```

Synchronous code runs first, then microtasks, then timer tasks.

## Rapid-Fire Questions

1. **Is JavaScript single-threaded?** Yes, its main execution model uses one call stack; runtimes can provide workers and other background threads.
2. **Is JavaScript interpreted or compiled?** Modern engines use a mix of interpretation, JIT compilation, and optimization.
3. **What does `use strict` do?** It enables stricter parsing and runtime rules, including preventing accidental globals.
4. **Does `const` make an object immutable?** No, it prevents reassignment of the binding; object properties can still change.
5. **Does `map()` mutate the original array?** No, unless the callback explicitly mutates an element or another referenced object.
6. **What does `filter()` return?** A new array containing elements whose callback result is truthy.
7. **What does `find()` return when there is no match?** `undefined`.
8. **What does `includes()` return?** A boolean indicating whether a value exists in an array or string.
9. **What is `NaN`?** A number value representing an invalid numeric result; use `Number.isNaN()` to test it.
10. **Is `NaN === NaN` true?** No. `Number.isNaN(NaN)` is true.
11. **What is `Object.is()` useful for?** Precise sameness checks, including distinguishing `-0` from `0` and treating `NaN` as equal to itself.
12. **What does `...` do?** It is spread syntax in values and rest syntax in parameters or destructuring.
13. **What does optional chaining return on a missing link?** `undefined`.
14. **What does `??=` do?** Assigns a fallback only when the left side is `null` or `undefined`.
15. **What is an IIFE?** An immediately invoked function expression.
16. **What is currying?** Transforming a function with multiple arguments into a sequence of one-argument functions.
17. **What is memoization?** Caching function results for previously seen inputs.
18. **What is a generator?** A function that can pause and resume with `yield` and returns an iterator.
19. **What is an iterable?** A value that exposes `[Symbol.iterator]()` and can be consumed by `for...of`.
20. **What does `for...in` iterate?** Enumerable property keys, including inherited enumerable keys.
21. **What does `for...of` iterate?** Values produced by an iterable.
22. **What is a `Symbol`?** A unique primitive commonly used for non-colliding property keys.
23. **What is a `BigInt`?** An integer primitive for values larger than the safe integer range; it cannot be mixed directly with Number.
24. **What is `AbortController` used for?** Cancelling abortable operations such as fetch requests.
25. **What is CORS?** A browser security mechanism controlling cross-origin requests through server-provided headers.
26. **What is localStorage's main limitation?** It is synchronous, string-only, origin-scoped, and unsuitable for secrets.
27. **What is a Web Worker?** A background JavaScript execution context that communicates with the main thread by messages.
28. **What is tree shaking?** Removing unused statically analyzable module exports during bundling.
29. **What is code splitting?** Dividing a bundle into smaller chunks loaded when needed.
30. **What is progressive enhancement?** Starting with a functional baseline and adding richer behavior where supported.

---

# 60. 💻 Coding Practice

## Problem 1 — Reverse a String

```js
function reverseString(str) {
  return [...str].reverse().join("");
}
```

## Problem 2 — Check Palindrome

```js
function isPalindrome(str) {
  const reversed = [...str].reverse().join("");

  return str === reversed;
}
```

## Problem 3 — Find Maximum

```js
function findMax(numbers) {
  return Math.max(...numbers);
}
```

## Problem 4 — Remove Duplicates

```js
function removeDuplicates(numbers) {
  return [...new Set(numbers)];
}
```

## Problem 5 — Count Frequencies

```js
function frequency(arr) {
  return arr.reduce((result, item) => {
    result[item] = (result[item] || 0) + 1;
    return result;
  }, {});
}
```

## Problem 6 — Sum Array

```js
function sum(numbers) {
  return numbers.reduce((total, n) => total + n, 0);
}
```

## Problem 7 — Filter Adults

```js
function adults(users) {
  return users.filter((user) => user.age >= 18);
}
```

## Problem 8 — Find User

```js
function findUser(users, id) {
  return users.find((user) => user.id === id);
}
```

## Problem 9 — Debounce

```js
function debounce(fn, delay) {
  let timer;

  return (...args) => {
    clearTimeout(timer);

    timer = setTimeout(() => {
      fn(...args);
    }, delay);
  };
}
```

## Problem 10 — Promise Delay

```js
function delay(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

async function main() {
  await delay(1000);
  console.log("Done");
}
```

---

# 🧭 61. JavaScript Learning Roadmap

## LEVEL 1 — Fundamentals

```text
Variables
Data Types
Operators
Conditionals
Loops
Functions
Scope
```

## LEVEL 2 — Core JavaScript

```text
Arrays
Objects
Array methods
Destructuring
Spread
Rest
Strings
Dates
Map
Set
```

## LEVEL 3 — Deep JavaScript

```text
Closures
Hoisting
this
Prototypes
Classes
Inheritance
Modules
Error handling
```

## LEVEL 4 — Browser

```text
DOM
Events
Forms
Storage
Browser APIs
Event propagation
```

## LEVEL 5 — Async

```text
Callbacks
Promises
async/await
Event loop
Fetch
HTTP
APIs
```

## LEVEL 6 — Advanced

```text
Functional programming
Iterators
Generators
Symbols
BigInt
Memory
Performance
Security
```

## LEVEL 7 — React

```text
React
JSX
Components
Props
State
Hooks
Effects
Context
Routing
TypeScript
```

## LEVEL 8 — Full Stack

```text
Node.js
Express/Fastify
Databases
Authentication
APIs
Testing
Deployment
```

## LEVEL 9 — Web3

For blockchain development:

```text
JavaScript
 ↓
TypeScript
 ↓
React
 ↓
Ethers.js
 ↓
Wallet Integration
 ↓
Smart Contracts
 ↓
Full-Stack DApps
```

---

# 🧠 62. 60-Second Revision

| Topic         | One-Line Summary                                              |
| ------------- | ------------------------------------------------------------- |
| JavaScript    | Dynamic programming language widely used for web applications |
| Variable      | Named binding to a value                                      |
| `let`         | Block-scoped, reassignable binding                            |
| `const`       | Block-scoped, non-reassignable binding                        |
| Primitive     | Immutable language-level value                                |
| Object        | Mutable collection of properties                              |
| Function      | Reusable block of behavior                                    |
| Scope         | Determines where bindings are accessible                      |
| Closure       | Function + retained lexical environment                       |
| Hoisting      | Declaration behavior during scope setup                       |
| Array         | Ordered collection                                            |
| Object        | Key-value property collection                                 |
| Destructuring | Extract values from arrays/objects                            |
| Spread        | Expands iterable/object values                                |
| Rest          | Collects remaining values                                     |
| `this`        | Call-context value for ordinary functions                     |
| Prototype     | Object used in prototype-chain lookup                         |
| Class         | Syntax for prototype-based object construction                |
| Module        | File-level unit for imports/exports                           |
| DOM           | JavaScript representation of an HTML document                 |
| Event         | Browser/runtime notification of something happening           |
| Promise       | Representation of eventual async result                       |
| async/await   | Syntax for working with Promises                              |
| Event Loop    | Coordinates synchronous work and async queues                 |
| Fetch         | API for HTTP requests                                         |
| Debounce      | Run after activity settles                                    |
| Throttle      | Limit execution frequency                                     |
| Map           | Key-value collection                                          |
| Set           | Unique-value collection                                       |
| Symbol        | Unique primitive value                                        |
| BigInt        | Arbitrary-precision integer                                   |
| JSON          | Text format for structured data                               |

---

# 🗺️ Complete Concept Map

```text
                         🟨 JAVASCRIPT
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
   Fundamentals           Functions             Objects
        │                     │                     │
   ┌────┼────┐          ┌─────┼─────┐        ┌──────┼──────┐
   ▼    ▼    ▼          ▼     ▼     ▼        ▼      ▼      ▼
Variables Types Operators Scope Closure   Prototype Class Methods
   │
   ▼
Conditionals
   │
   ▼
Loops
   │
   ▼
Arrays ─────────────── Objects
   │                     │
   ▼                     ▼
map/filter/reduce    Destructuring
   │                     │
   └──────────┬──────────┘
              ▼
        Modern JavaScript
              │
       ┌──────┼────────┐
       ▼      ▼        ▼
    Modules Promises async/await
                         │
                         ▼
                    Event Loop
                         │
                         ▼
                   Browser / Node
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
         DOM           Fetch          Storage
          │              │              │
          ▼              ▼              ▼
       Events          APIs          Web Apps
                         │
                         ▼
                       React
                         │
                         ▼
                     Full Stack
                         │
                         ▼
                       Web3
```

---

# 🔥 JavaScript Mental Model

When solving a JavaScript problem, ask:

```text
1. What data do I have?
          ↓
2. What type is it?
          ↓
3. Is it primitive or object?
          ↓
4. What scope is the variable in?
          ↓
5. Is this synchronous or asynchronous?
          ↓
6. If asynchronous, what Promise/event-loop behavior applies?
          ↓
7. Am I mutating shared data?
          ↓
8. Can map/filter/reduce simplify the transformation?
          ↓
9. What does `this` mean here?
          ↓
10. Could closure/prototype behavior affect the result?
          ↓
11. Is browser API interaction involved?
          ↓
12. What happens on errors?
          ↓
13. Is the code secure?
          ↓
14. Is there a measurable performance problem?
```

---

# 🎯 63. Golden Rules

1. 🟨 Learn JavaScript deeply before relying on frameworks.
2. 📦 Prefer `const`; use `let` when reassignment is necessary.
3. 🚫 Avoid `var` in modern code unless you specifically need its semantics.
4. 🔍 Prefer `===` and `!==`.
5. 🧠 Understand scope and closures.
6. 🔗 Understand references before mutating objects/arrays.
7. 🔄 Use array methods intentionally.
8. 🧊 Prefer immutable updates when working with state.
9. 🎯 Understand `this` from the call site.
10. 🧬 Understand prototypes even if you mainly use classes.
11. 📦 Use modules to organize applications.
12. ⚡ Understand Promises before mastering `async/await`.
13. 🔁 Learn the event loop for asynchronous interview questions.
14. 🌐 Always handle API errors.
15. 🔐 Never trust frontend validation as a security boundary.
16. 🚨 Avoid injecting untrusted HTML.
17. ⏱️ Use debounce/throttle for appropriate high-frequency operations.
18. 📈 Profile before making performance optimizations.
19. 🧪 Test behavior, not implementation details.
20. ⚛️ React becomes much easier after strong JavaScript fundamentals.
21. ⛓️ Web3 frontend development relies heavily on JavaScript/TypeScript concepts.

---

# 🏆 Final JavaScript Interview Formula

```text
                    JAVASCRIPT
                        │
        ┌───────────────┼────────────────┐
        ▼               ▼                ▼
      TYPES          FUNCTIONS         OBJECTS
        │               │                │
        ▼               ▼                ▼
     Scope           Closure          Prototype
        │               │                │
        └───────────────┼────────────────┘
                        ▼
                   ASYNCHRONOUS
                        │
             ┌──────────┼──────────┐
             ▼          ▼          ▼
          Promise    async/await  Event Loop
             │
             ▼
          Fetch/API
             │
             ▼
          Browser
             │
      ┌──────┼──────┐
      ▼      ▼      ▼
     DOM   Events Storage
      │
      ▼
    React
      │
      ▼
 Full-Stack Apps
      │
      ▼
    Web3 DApps
```

> 💡 **If you understand variables → types → scope → functions → closures → objects → prototypes → async JavaScript → Promises → event loop → DOM → modules, you have the foundation needed to learn React, Node.js, TypeScript, and Web3 much faster.**

---

# 📖 Recommended References

- MDN JavaScript Guide: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide
- MDN JavaScript Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
- ECMAScript Specification: https://tc39.es/ecma262/
- MDN Web APIs: https://developer.mozilla.org/en-US/docs/Web/API
- Node.js Documentation: https://nodejs.org/docs/latest/api/
