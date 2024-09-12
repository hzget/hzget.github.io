Confidentiality, Integrity, and Authentication
===

Reference:

[CS406: Information Security][cs406]

Cryptographic methods protect for confidentiality, authentication,
and integrity. Authentication is proving who you are, and
integrity is protecting the data from unauthorized changes.

Confidentiality
---

> Suppose we have two friends, Alice and Bob, and their nosy neighbor, Eve.
> Alice can encrypt a message like "Eve is annoying", send it to Bob,
> and never have to worry about Eve snooping on her.

The intuitively obvious purpose of cryptography is confidentiality:
a message can be transmitted without prying eyes learning its contents.
For ***confidentiality***, we encrypt a message: given a message,
we pair it with a key and produce a meaningless jumble that can only
be made useful again by reversing the process using the same key
(thereby decrypting it).

Integrity
---

> Suppose Eve gathered enough of Alice and Bob's messages to figure out
> that the word "Eve" is encrypted as "Xyzzy". Furthermore, Eve knows
> Alice and Bob are planning a party and Alice will be sending Bob the guest list.
> If Eve **intercepts the message and adds** "Xyzzy" to the end of the list,
> she's managed to crash the party.

For truly secure communication, we need more than confidentiality.
Alice and Bob need their communication to provide ***integrity***:
a message should be immune to **tampering**.

Authentication
---

> Suppose Eve watches Bob open an envelope marked "From Alice" with
> a message inside from Alice reading "Buy another gallon of ice cream."
> Eve sees Bob go out and come back with ice cream, so she has a general
> idea of the message's contents even if the exact wording is unknown to her.
> Bob throws the message away, Eve recovers it, and then every day for
> the next week drops an envelope marked "From Alice" with a copy of
> the message in Bob's mailbox. Now the party has too much ice cream and
> Eve goes home with free ice cream when Bob gives it away at the end of the night.

The extra messages are confidential, and their integrity is intact,
but Bob has been misled as to the true identity of the sender.
***Authentication*** is the property of knowing that the person you are
communicating with is in fact who they claim to be.

[cs406]: https://learn.saylor.org/mod/book/view.php?id=29682&chapterid=5263
