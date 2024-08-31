Trait Object VS Trait Bound
===

Trait bound
---

The `impl Trait` syntax works for straightforward cases but is
actually syntax sugar for a longer form known as a `trait bound`;
it looks like this:

```rust
pub trait Summary {
    fn summarize(&self) -> String;
}

// option 1: impl Trait syntax 
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

// option 2: trait bound syntax
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
```

The `impl Trait` looks like to take trait as parameters
but in fact it is `trait bound` -- generic function
with type constraint.

Trait as Parameter (Generics)
---

When you use a trait as a parameter with generics,
the function is monomorphized at compile time, meaning
it generates a specific version of the function for
each type that you use.

In the following example, `draw_shape` is a generic function
that can accept any type that implements the Draw trait. The compiler
**generates separate versions** of `draw_shape` for Circle and Square.

```rust
trait Draw {
    fn draw(&self);
}

struct Circle;
struct Square;

impl Draw for Circle {
    fn draw(&self) {
        println!("Drawing a Circle");
    }
}

impl Draw for Square {
    fn draw(&self) {
        println!("Drawing a Square");
    }
}

fn draw_shape(shape: impl Draw) {
    shape.draw();
}

// the same thing with:
/*
fn draw_shape<T: Draw>(shape: T) {
    shape.draw();
} */

fn main() {
    let circle = Circle;
    let square = Square;

    draw_shape(circle);
    draw_shape(square);
}
```

Trait Object as Parameter
---

When you use a `trait object` as a parameter, the function can accept
any type that implements the trait, but it uses dynamic dispatch at runtime.

In this example, `draw_shape` takes a reference to a trait object
(&dyn Draw). This allows the function to accept any type that
implements the Draw trait, but it uses **dynamic dispatch** to
call the draw method at runtime.

```rust
trait Draw {
    fn draw(&self);
}

struct Circle;
struct Square;

impl Draw for Circle {
    fn draw(&self) {
        println!("Drawing a Circle");
    }
}

impl Draw for Square {
    fn draw(&self) {
        println!("Drawing a Square");
    }
}

fn draw_shape(shape: &dyn Draw) {
    shape.draw();
}

fn main() {
    let circle = Circle;
    let square = Square;

    draw_shape(&circle);
    draw_shape(&square);
}
```

Key Differences
---

* Trait as Parameter (Generics): The function is monomorphized
***at compile time, creating a specific version for each type***.
This can lead to better performance but more code bloat.
* Trait Objects as Parameter: The function uses ***dynamic dispatch at runtime***,
allowing for more flexibility but potentially less performance
due to the overhead of dynamic dispatch.

