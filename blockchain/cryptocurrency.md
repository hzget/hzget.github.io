# Cryptocurrency

With ***transactions***, we go from a “general purpose”
blockchain to a [cryptocurrency][cryptocurrency].

A transaction contains the following info:

* where the coins come (wallet of the sender)
* where the coins go (wallet of the receiver)
* amount of the coins

## Workflow

A transaction (object) is stored in a transaction pool which will
broadcast to the network.

Any node on the network can take it from the pool, verify the transaction,
mine a block, get rewords, and then add it to the blockchain.
The "data" region of the block contains that transaction.

The node broadcasts this new block to the network and other nodes
verify this block and update their local blockchain.

In this way, the blockchain contains all verified transactions.

## Transaction

The seller may collect coins from several places
for the deal. And the buyer may cut the overall coins
into several pieces. Each of the "piece" or "place"
is a unit of an asset. It consists of:

* the address (public-key)
* the amount

The address tells who owns this piece of asset.
A TxOut (transaction output) is the structure for this info.
When you own some coins in the blockchain, what you actually
have is a list of unspent transaction outputs (uTxOuts) whose
public key matches the private key you own.

The bellow picture shows the workflow of a transaction:

![workflow](./pic/transaction.png)

Three uTxOuts of the owner are spent and two TxOut are generated.
The unspent transaction outputs list will be updated.

## Wallet

From the user's point of view, he does not care how
the transaction works. He only needs to know how to:

* check the balance in his wallet
* send some coins to others
* recv some coins from others

The balance info can be obtained from the blockchain.
It is the sum of a list of unspent transaction outputs (uTxOuts)
that belongs to him.

## Signature

How to verify that a uTxOut belongs to someone?
How to verify that the transaction indeed triggered
by the owner of the specific uTxOut?

The ***address*** of a uTxOut is in fact a public-key.
It corresponds to a private-key owned by the owner of this uTxOut.

A TxIn object contains:

* a reference to an uTxOut
* signature of the transaction id (TxId)

TxId is a hash from the content of the transaction. It makes
sure that the content of the transaction is not tampered.
The owner just signs the transaction Id with his private-key
and generates a signature. Anyone else can verify this signature
with the public-key. Successful verification means that
the transaction is valid.

In a word, only the owner of this uTxOut can trigger the transaction.
Anyone else's signature will not be verified and thus
the transaction will fail.

[cryptocurrency]: https://en.wikipedia.org/wiki/Cryptocurrency
