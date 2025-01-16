Iterate Through a String
===

You can loop through a `String` in Rust using a `for` loop. Since a `String` is a UTF-8 encoded collection of characters, there are several ways to iterate over its content depending on what you want to loop through: **characters**, **bytes**, or **graphemes** (complex characters). Here's how you can do it:

---

### **1. Loop Through Characters**
Use the `.chars()` method to iterate over Unicode scalar values (each "character") in the `String`.

#### Example:
```rust
let s = String::from("hello, 世界");

for c in s.chars() {
    println!("{}", c);
}
```
- Output:
  ```
  h
  e
  l
  l
  o
  ,
   
  世
  界
  ```

---

### **2. Loop Through Bytes**
Use the `.bytes()` method to iterate over the raw bytes of the `String`.

#### Example:
```rust
let s = String::from("hello, 世界");

for b in s.bytes() {
    println!("{}", b);
}
```
- Output (byte values):
  ```
  104
  101
  108
  108
  111
  44
  32
  228
  184
  150
  231
  149
  140
  ```

---

### **3. Loop Through Graphemes (Complex Characters)**
Use the `unicode-segmentation` crate to iterate over extended grapheme clusters (e.g., emojis, accented characters). Add the crate to your `Cargo.toml`:

```toml
[dependencies]
unicode-segmentation = "1.10.0"
```

#### Example:
```rust
use unicode_segmentation::UnicodeSegmentation;

let s = String::from("hello, ??");

// true indicates extended graphemes
for g in s.graphemes(true) {
    println!("{}", g);
}
```
- Output:
  ```
  h
  e
  l
  l
  o
  ,
   
  ??
  ```

---

### **4. Loop Through a `String` with Indices**
If you need the index along with each character, you can combine `.chars()` with `.enumerate()`.

#### Example:
```rust
let s = String::from("hello, 世界");

for (i, c) in s.chars().enumerate() {
    println!("Index: {}, Character: {}", i, c);
}
```
- Output:
  ```
  Index: 0, Character: h
  Index: 1, Character: e
  Index: 2, Character: l
  Index: 3, Character: l
  Index: 4, Character: o
  Index: 5, Character: ,
  Index: 6, Character:  
  Index: 7, Character: 世
  Index: 8, Character: 界
  ```

---

### **5. Loop Through Slices**
You can loop through slices of the string by manually slicing it with valid UTF-8 boundaries.

#### Example:
```rust
let s = String::from("hello, 世界");

for slice in s.chars().collect::<Vec<char>>().chunks(2) {
    println!("{:?}", slice);
}
```

---

### **Which Method to Choose?**
- **Use `.chars()`**: When you want to iterate over Unicode scalar values (basic characters).
- **Use `.bytes()`**: When you need to process raw byte data.
- **Use `.graphemes()`**: When dealing with complex characters (e.g., emojis or accented letters).
- **Use `.enumerate()`**: When you need indices alongside characters. 

This flexibility allows you to choose the best method for your specific use case.
