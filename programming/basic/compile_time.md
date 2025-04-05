# Compile-time checks

**Compile-time checks**
are a type of verification that a programming language or compiler performs
before a program runs --- specifically, during the **compilation phase**.

The compiler performs to **catch errors** or **enforce rules**
before the code is executed. If something is wrong, the compiler will
usually stop the build process and show an error message.

## Why Compile-Time Checks Are Useful:

* **Catch bugs early**: Problems are found before the program runs.
* **Improve performance**:
  * Programs can be optimized better when the compiler knows more about the code.
  * There is no impact on runtime performance because all the analysis is completed beforehand.
* **Increase safety**: Languages like Rust and Go use strong compile-time checks to
prevent issues like null pointer dereferencing or data races.

For those reasons, checking the borrowing rules at compile time is
the best choice in the majority of cases, which is why this is Rust's default.

## What Are Run-Time Checks?

**Run-time checks** are validations or safety checks that happen while
the program is running, after it has successfully compiled.

These checks catch errors that cannot be fully detected at compile-time,
because they depend on dynamic factors—like user input, external files,
network responses, or how the program behaves at that moment.

## Comparison

| Feature | Compile-Time Checks | Run-Time Checks |
|:---:|:--:|:--:| 
| **When it happens**    | During compilation (before program runs)                 | During execution (after program starts)                   |
| **Who performs it**    | The **compiler**                                          | The **runtime environment**, **OS**, or hardware          |
| **Purpose**            | Catch errors early; enforce type and syntax rules        | Handle unexpected or dynamic behavior during execution    |
| **Common errors caught**| Syntax errors, type mismatches, missing declarations     | Array out-of-bounds, divide by zero, null pointer access  |
| **Failure result**     | Compilation fails; code doesn't run                      | Program crashes or behaves incorrectly                    |
| **Performance impact** | Slower builds, faster/safe execution                     | Slight overhead at run-time (if checks are present)       |

## Checking the borrowing rules in Rust

The advantages of checking the borrowing rules at compile time are that
errors will be caught sooner in the development process, and
there is no impact on runtime performance because all the analysis is completed beforehand.
For those reasons, checking the borrowing rules at compile time is
the best choice in the majority of cases, which is why this is Rust's default.

The advantage of checking the borrowing rules at runtime instead is that
certain memory-safe scenarios are then allowed,
where they would've been disallowed by the compile-time checks.
Static analysis, like the Rust compiler, is inherently conservative.
Some properties of code are impossible to detect by analyzing the code.

Because some analysis is impossible, if the Rust compiler can't
be sure the code complies with the ownership rules, it might reject a correct program;
in this way, it's conservative.
If Rust accepted an incorrect program, users wouldn't be able to trust in the guarantees Rust makes.
However, if Rust rejects a correct program, the programmer will be inconvenienced,
but nothing catastrophic can occur.
The [`RefCell<T>`][RefCell] type is useful when you're sure your code follows
the borrowing rules but the compiler is unable to understand and guarantee that.

Using [`RefCell<T>`][RefCell] is one way to get the ability to have
interior mutability, but `RefCell<T>` doesn't get around the borrowing rules completely:
the borrow checker in the compiler allows this interior mutability, and
**the borrowing rules are checked at runtime instead**.
If you violate the rules, you'll get a panic! instead of a compiler error.

In a word, the verification is moved from compile-time checks to run-time checks.

[RefCell]: https://doc.rust-lang.org/core/cell/struct.RefCell.html
