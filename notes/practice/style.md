# Style

> Programs are read not only by computers but also
> by programmers. A well-written program is easier
> to understand and to modify than a poorly-written
> one.

## Names

A name should be informative, concise, ***memorable***,
and pronounceable if possible.

* use descriptive names for globals, short names for locals
* give related things related names that show their
relationship and highlight their difference
* use active names for functions

## Expressions and Statements

> Write clean code, not clever code.

* indent to ***show structure***
* use ***natural form*** for expression
* break up complex expressions or functions

## Consistency and Idioms

Like natural languages, programming languages have
***idioms***, **conventional ways** that experienced
programmers write common piece of code. For examlple,
the idiomatic form of a loop or indent.

A central part of learning any language is developing a
familiarity with its idioms.

## Magic Numbers

Give names to magic numbers and define numbers as
constants, not macros.

The macros are a dangerous way to program because
they change the lexical structure of the program underfoot.

A macro is handled by pre-processor and replaced
in the source code.

A const value is a variable that handled by
the complier. Further more, it give more info
when debugging the program.

## Comments

Comments are meant to help the reader of a program.
