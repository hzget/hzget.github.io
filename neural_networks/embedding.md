# Represent words with embeddings

The Bag of words model operates on high-dimentional BoW vectors
and does not express any semantic similarity between words.
Thus we'll turn to the embedding model.

The embedding layer would take a word as an input,
and produce an output vector of specified embedding_size.

In embedding bag model,

* convert each word in our text into corresponding embedding (a vector with length embedding_size)
* compute some aggregate function over all those embeddings, such as sum, average or max.

Note: the input is not the literal word but the word number (its index in the vocab)

## An Example

![embedding example](https://docs.microsoft.com/en-us/learn/modules/intro-natural-language-processing-pytorch/images/embedding-classifier-example.png)
