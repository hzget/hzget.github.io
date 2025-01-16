What is trait object ?
===

A **trait object** in Rust is a way to achieve **dynamic polymorphism**, where the exact type implementing a trait is determined at runtime rather than compile time. A trait object allows you to work with types that implement a specific trait without knowing the concrete type. It is typically represented as `dyn Trait`.

### Definition of a Trait Object
A **trait object** is a pointer to an instance of a type that implements a given trait. Common examples include:
- `&dyn Trait` (a reference to a trait object)
- `Box<dyn Trait>` (an owned heap-allocated trait object)
- `Rc<dyn Trait>` (a reference-counted trait object)

### Key Characteristics of Trait Objects
1. They use **dynamic dispatch** to call methods (as opposed to static dispatch with generics).
2. They only work for traits marked with `dyn`, meaning they are explicitly treated as a trait object.
3. The trait must not include methods with a generic type parameter or `Self` in method signatures, as these cannot be represented in a trait object.

---

### How to Use Trait Objects in a Function Call

Here's how to define and use a trait object in function calls:

---

#### Example 1: Using `&dyn Trait` (Borrowed Trait Object)
```rust
trait Animal {
    fn make_sound(&self);
}

struct Dog;
struct Cat;

impl Animal for Dog {
    fn make_sound(&self) {
        println!("Woof!");
    }
}

impl Animal for Cat {
    fn make_sound(&self) {
        println!("Meow!");
    }
}

fn process_animal(animal: &dyn Animal) {
    animal.make_sound(); // Dynamic dispatch
}

fn main() {
    let dog = Dog;
    let cat = Cat;

    process_animal(&dog); // Pass a reference to a Dog
    process_animal(&cat); // Pass a reference to a Cat
}
```

Here, the `process_animal` function accepts a reference to a trait object (`&dyn Animal`), and the appropriate implementation of `make_sound` is called dynamically at runtime.

---

#### Example 2: Using `Box<dyn Trait>` (Owned Trait Object)
```rust
trait Animal {
    fn make_sound(&self);
}

struct Dog;
struct Cat;

impl Animal for Dog {
    fn make_sound(&self) {
        println!("Woof!");
    }
}

impl Animal for Cat {
    fn make_sound(&self) {
        println!("Meow!");
    }
}

fn process_animal(animal: Box<dyn Animal>) {
    animal.make_sound(); // Dynamic dispatch
}

fn main() {
    let dog = Dog;
    let cat = Cat;

    process_animal(Box::new(dog)); // Pass a Dog wrapped in a Box
    process_animal(Box::new(cat)); // Pass a Cat wrapped in a Box
}
```

Here, `Box<dyn Animal>` owns the object, so it manages the heap-allocated instance of the type. The trait object's methods are dynamically dispatched at runtime.

---

#### Example 3: Using `Rc<dyn Trait>` (Shared Ownership)
```rust
use std::rc::Rc;

trait Animal {
    fn make_sound(&self);
}

struct Dog;

impl Animal for Dog {
    fn make_sound(&self) {
        println!("Woof!");
    }
}

fn process_animal(animal: Rc<dyn Animal>) {
    animal.make_sound();
}

fn main() {
    let dog = Rc::new(Dog); // Wrap Dog in an Rc
    process_animal(dog.clone()); // Pass a cloned Rc<dyn Animal>
}
```

In this case, `Rc<dyn Animal>` allows multiple references to the same heap-allocated instance of `Dog`.

---

### Key Considerations When Using Trait Objects
1. **Dynamic Dispatch vs. Static Dispatch**:
   - Trait objects use **dynamic dispatch** (method calls are resolved at runtime using a vtable).
   - Generics use **static dispatch** (method calls are resolved at compile time).

2. **Ownership**:
   - Use `&dyn Trait` if you only need a reference.
   - Use `Box<dyn Trait>` or `Rc<dyn Trait>` if you need ownership or shared ownership.

3. **Trait Object Safety**:
   A trait can only be used as a trait object if all of its methods:
   - Do not use `Self` in the method signature.
   - Do not have generic parameters.

   For example, the following trait **cannot** be used as a trait object:
   ```rust
   trait Invalid {
       fn do_something<T>(&self, value: T); // Not object-safe (uses generics)
   }
   ```

---

### Summary: How to Use Trait Objects in a Function Call
1. Define a trait and its implementation for multiple types.
2. Use a trait object (`&dyn Trait`, `Box<dyn Trait>`, or `Rc<dyn Trait>`) as a function parameter.
3. Pass instances of types that implement the trait into the function.

Trait objects are ideal when you need **dynamic polymorphism** or when the type implementing the trait isn't known at compile time.
