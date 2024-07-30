Defer Expensive operations
===

It may be better to defer expensive operations until
they are needed. If some conditions are not met, that
operation will not happen. This mechnism helps to avoid
unnecessary expense.

Expensive Evaluation
---

Say you need to log some expensive value:

```golang
slog.Debug("frobbing", "value", computeExpensiveValue(arg))
```

Even if this line is disabled, computeExpensiveValue will be called.
(***Argments Evaluation*** happens before slog.Debug() is called)

We can avoid such an unnecessary expense by deferring
this operation:

```golang
type expensive struct { arg int }

func (e expensive) LogValue() slog.Value {
    return slog.AnyValue(computeExpensiveValue(e.arg))
}
```

Then use a value of that type in log calls:

```golang
slog.Debug("frobbing", "value", expensive{arg})
```

Now computeExpensiveValue will only be called when the line is enabled.
(It will "resolve" the value only when the line is enabled.)
