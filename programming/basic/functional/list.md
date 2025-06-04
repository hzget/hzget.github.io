# Why Is `enum` More Functional Than `struct`

| Feature | `enum` (`Cons/Nil`) | `struct` (`Option<Node<T>>`) |
|---------|---------------------|----------------------------|
| **Recursion** | Natural fit ✅ | Requires `Option` ❌ |
| **Immutability** | Encouraged ✅ | Often mutable ❌ |
| **Pattern Matching** | Built-in ✅ | Requires extra checks ❌ |
| **Functional Style** | More idiomatic ✅ | Feels imperative ❌ |

- `enum` **mimics FP-style lists** (`Nil` is the base case, `Cons` is the recursion).
- `struct` **feels more imperative** (explicitly managing `Option` instead of using pattern matching).

Here are two implementations of a **linked list** in Rust:

1. Using a **struct**
2. Using an **enum**  

---

## **1️⃣ Implementation Using `struct`**

In this approach, we explicitly define `Node` and `LinkedList` structs.

```rust
use std::rc::Rc;
use std::cell::RefCell;

struct Node<T: std::fmt::Debug> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>,
}

struct LinkedList<T: std::fmt::Debug> {
    head: Option<Rc<RefCell<Node<T>>>>,
}

impl<T: std::fmt::Debug> LinkedList<T> {
    fn new() -> Self {
        LinkedList { head: None }
    }

    fn push_front(&mut self, value: T) {
        let new_node = Rc::new(RefCell::new(Node {
            value,
            next: self.head.clone(),
        }));
        self.head = Some(new_node);
    }

    fn print(&self) {
        let mut current = self.head.clone();
        while let Some(node) = current {
            print!("{#?} -> ", node.borrow().value);
            current = node.borrow().next.clone();
        }
        println!("None");
    }
}

fn main() {
    let mut list = LinkedList::new();
    list.push_front(1);
    list.push_front(2);
    list.push_front(3);

    list.print(); // Output: 3 -> 2 -> 1 -> None
}
```
### **Explanation**
- `Node<T>` holds a `value` and a `next` pointer.
- `LinkedList<T>` holds a pointer to the `head`.
- `Rc<RefCell<Node<T>>>` enables **shared ownership** and **mutability**.
- **Operations**:
  - `new()` initializes an empty list.
  - `push_front()` inserts elements at the front.
  - `print()` traverses the list.

---

## **2️⃣ Implementation Using `enum`**
This approach leverages `enum` for recursive data structures.

```rust
use std::rc::Rc;

enum List<T> {
    Cons(T, Rc<List<T>>),
    Nil,
}

impl<T: std::fmt::Debug> List<T> {
    fn new() -> Rc<Self> {
        Rc::new(List::Nil)
    }

    fn prepend(value: T, next: Rc<List<T>>) -> Rc<List<T>> {
        Rc::new(List::Cons(value, next))
    }

    fn print(&self) {
        match self {
            List::Cons(value, next) => {
                print!("{:?} -> ", value);
                next.print();
            }
            List::Nil => println!("None"),
        }
    }
}

fn main() {
    let list = List::new();
    let list = List::prepend(1, list);
    let list = List::prepend(2, list);
    let list = List::prepend(3, list);

    list.print(); // Output: 3 -> 2 -> 1 -> None
}
```
### **Explanation**
- `List<T>` uses an `enum`:
  - `Cons(T, Rc<List<T>>)` for nodes.
  - `Nil` for the empty list.
- **Operations**:
  - `new()` creates an empty list.
  - `prepend()` adds elements in **O(1)** time.
  - `print()` recursively traverses the list.

---

## **Comparison: `struct` vs `enum`**

| Feature | `struct` Implementation | `enum` Implementation |
|---------|------------------|----------------|
| **Flexibility** | More explicit, more control | More concise, more idiomatic |
| **Mutability** | `RefCell<T>` for internal mutability | Immutable structure |
| **Ease of Use** | Requires explicit struct definitions | More natural for functional programming |
| **Memory Overhead** | More control over memory layout | Slightly more memory usage due to enum tagging |

---

### **Which one should you use?**
- Use **`struct`** if you need **mutable** lists.
- Use **`enum`** if you prefer **immutable, recursive** lists.

---

## usage of `Option`

Why does list via struct use Option while list via enum does not use Option ?

Great question! The difference comes from **how Rust handles recursive data structures** and the way `Option<T>` interacts with them. Let's break it down.

---

## **1️⃣ Why `Option` in `struct` Implementation?**
In the `struct` implementation:
```rust
struct Node<T> {
    value: T,
    next: Option<Rc<RefCell<Node<T>>>>,
}
```
- The `next` field is **an `Option`**, meaning it can be `None` (end of the list) or `Some(Rc<Node<T>>)` (pointing to the next node).
- This makes `Node<T>` **self-contained**—each node explicitly says whether it has a next node or not.

### **Why is `Option` needed here?**
- A `struct` **must know all of its fields at compile time**.
- Without `Option`, Rust wouldn’t know how to represent the absence of a `next` node.

---

## **2️⃣ Why No `Option` in `enum` Implementation?**
In the `enum` version:
```rust
enum List<T> {
    Cons(T, Rc<List<T>>),
    Nil,
}
```
- We use `List<T>::Nil` **instead of `Option`** to represent the end of the list.
- Since `Nil` is already a **variant** of `List<T>`, it naturally encodes an **empty list**.

### **Why is `Option` unnecessary here?**
- `List<T>` is **already recursive by design**.
- `Nil` **plays the same role as `None`** in the `Option` version.
- Adding `Option` would be redundant, creating unnecessary nesting:
  ```rust
  struct Node<T> {
      value: T,
      next: Option<Box<Option<Node<T>>>>, // Too much nesting!
  }
  ```

---

## **3️⃣ Key Differences**

| Feature        | `struct` + `Option` | `enum` (`Cons/Nil`) |
|---------------|--------------------|---------------------|
| **Explicitness** | Uses `Option` for `None` | `Nil` is built into the enum |
| **Flexibility** | Can be used in multiple contexts | More specialized for linked lists |
| **Redundancy** | `None` is separate from `struct` | `Nil` is directly part of `List<T>` |

---

## **4️⃣ Which One Should You Use?**

- Use `struct` + `Option` when you want **more flexibility** (e.g., using `Node<T>` in different structures).
- Use `enum` when defining **recursive lists**, as it avoids redundancy and feels more **idiomatic in functional programming**.

