grapheme cluster
===

A grapheme cluster is a concept used in Unicode to represent what a user perceives as a single character, even though it might be composed of multiple Unicode code points. In simpler terms, it’s the smallest unit of a writing system that represents a single, visible character to the end user.

Examples of Grapheme Clusters
---

1. Single Code Point Characters:
    * Many grapheme clusters consist of just one Unicode code point. For example, the letter "a" (U+0061) is both a single code point and a single grapheme cluster.
2. Combining Characters:
    * Some characters, such as accented letters, are formed by a base character followed by one or more combining characters. For example:
        * "á" can be represented by two code points: the letter "a" (U+0061) and the combining acute accent (U+0301). Together, they form a single grapheme cluster.
    * Even though this sequence consists of two code points, users typically perceive it as one character.
3. Emoji Sequences:
    * Some emoji are formed by combining multiple code points. For example:
The "family" emoji 👨‍👩‍👧 (U+1F468 U+200D U+1F469 U+200D U+1F467) is a grapheme cluster made up of several code points, including "man" (U+1F468), "woman" (U+1F469), and "girl" (U+1F467), joined by zero-width joiners (U+200D).

Why Are Grapheme Clusters Important?
---

* Text Processing: When working with text, especially in contexts like text editing, rendering, or searching, it’s important to operate on grapheme clusters rather than individual code points. This ensures that operations treat what the user sees as a single character consistently, even if it is composed of multiple code points.

* String Length: The length of a string in terms of grapheme clusters can differ from its length in code points. For example, "á" contains two code points but represents one grapheme cluster.

* Cursor Movement and Deletion: In a text editor, moving the cursor or deleting characters by grapheme clusters ensures that user-visible characters are handled properly, even when composed of multiple code points.

Grapheme Clusters in Programming
---

* In programming languages like Rust, handling grapheme clusters typically requires specialized libraries because the standard string and character types (&str and char) work at the code point level.
* Libraries like unicode-segmentation provide utilities to iterate over grapheme clusters, ensuring text is processed in a way that aligns with user expectations.

Example in Rust:
---

```rust
use unicode_segmentation::UnicodeSegmentation;

fn main() {
    let s = "á"; // "a" + "́" (combining acute accent)

    // Counting grapheme clusters
    let grapheme_count = s.graphemes(true).count();

    println!("Number of grapheme clusters: {}", grapheme_count); // Output: 1
}
```

In this example, even though the string s contains two Unicode code points, it is counted as one grapheme cluster, reflecting what a user would perceive as a single character.
