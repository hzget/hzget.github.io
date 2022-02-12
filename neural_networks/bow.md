# Bag of Words (BoW) model

In the [Bag of Words (BoW)][Bag of Words] model, a text
(such as a sentence or a document) is represented as the
bag (multiset) of its words, disregarding grammar and
even word order but keeping multiplicity.

It is commonly used in methods of document classification
where the (frequency of) occurrence of each word is used
as a feature for training a classifier.

Specifically,

* create a dictionary from dataset
* construct a vector, (transform input text into a "bag of words"), where
  * each word in the dictionary corresponds to an index of the vector
  * each elem in the vector is the (frequency of) occurrence of that word in the input text
* take that vector and its label as a "(***features, label***)" sample example

## An Example of BoW

Here are two simple text documents:

1. John likes to watch movies. Mary likes movies too.
2. Mary also likes to watch football games.

We can create a dictionary:

{"John","likes","to","watch","movies","Mary","too","also","football","games"}

Representing each bag-of-words as a JSON object, and
attributing to the respective JavaScript variable:

```javascript
BoW1 = {"John":1,"likes":2,"to":1,"watch":1,"movies":2,"Mary":1,"too":1};
BoW2 = {"Mary":1,"also":1,"likes":1,"to":1,"watch":1,"football":1,"games":1};
```

Create corresponding vectors of these two text docs:

1. [1, 2, 1, 1, 2, 1, 1, 0, 0, 0]
2. [0, 1, 1, 1, 0, 1, 0, 1, 1, 1]

We can then take a vector and its label as a sample for training a classifier

## Text Classification via BoW

Here is an classifier example that gives text docs different classes.
It will take the bow of a text doc as an input.

***dateset***: AG_NEWS

### create a vocabulary from dataset

```python
from torchtext.datasets import AG_NEWS
from torchtext.data.utils import get_tokenizer
from torchtext.vocab import build_vocab_from_iterator

train_iter = AG_NEWS(root="./data", split="train")
tokenizer = get_tokenizer("basic_english")

def yield_tokens(data_iter):
    for _, text in data_iter:
        yield tokenizer(text)

vocab = build_vocab_from_iterator(yield_tokens(train_iter), specials=["<unk>"])
vocab.set_default_index(vocab["<unk>"])

# example
# vocab(["here", "is", "an", "example"])
# output: [475, 21, 30, 5297]
```

### create a func to transform a text doc to a bow (a vector)

```python
text_pipeline = lambda x: vocab(tokenizer(x))
label_pipeline = lambda x: int(x) - 1
encode = text_pipeline

import torch
vocab_size = len(vocab)
def to_bow(text, bow_vocab_size=vocab_size):
    res = torch.zeros(bow_vocab_size, dtype=torch.float32)
    for i in encode(text):
        if i < bow_vocab_size:
            res[i] += 1
    return res

# example
# b = to_bow("how are you")
# print(b, b.shape)
# output: tensor([0., 0., 0.,  ..., 0., 0., 0.]) torch.Size([95811])
```

### train the classifier

```python
from torch.utils.data import DataLoader
import numpy as np 

# this collate function gets list of batch_size tuples, and needs to 
# return a pair of label-feature tensors for the whole minibatch
def bowify(b):
    return (
            torch.LongTensor([t[0]-1 for t in b]),
            torch.stack([to_bow(t[1]) for t in b])
    )

# Because datasets are iterators, if we want to use the
# data multiple times we need to convert it to list
train_dataset, test_dataset = AG_NEWS(root="./data")
train_dataset = list(train_dataset)
test_dataset = list(test_dataset)

# convert our dataset for training in such a way, that
# all positional vector representations are converted to
# bag-of-words representation
train_loader = DataLoader(train_dataset, batch_size=16, collate_fn=bowify, shuffle=True)
test_loader = DataLoader(test_dataset, batch_size=16, collate_fn=bowify, shuffle=True)

net = torch.nn.Sequential(torch.nn.Linear(vocab_size,4),torch.nn.LogSoftmax(dim=1))

def train_epoch(net,dataloader,lr=0.01,optimizer=None,loss_fn = torch.nn.NLLLoss(),epoch_size=None, report_freq=200):
    optimizer = optimizer or torch.optim.Adam(net.parameters(),lr=lr)
    net.train()
    total_loss,acc,count,i = 0,0,0,0
    for labels,features in dataloader:
        optimizer.zero_grad()

        # forward & get loss
        out = net(features)
        loss = loss_fn(out,labels) #cross_entropy(out,labels)

        # backword to get gradient
        loss.backward()

        # update params
        optimizer.step()

        # collect data to print
        total_loss+=loss
        _,predicted = torch.max(out,1)
        acc+=(predicted==labels).sum()
        count+=len(labels)
        i+=1
        if i%report_freq==0:
            print(f"{count}: acc={acc.item()/count}")
        if epoch_size and count>epoch_size:
            break
    return total_loss.item()/count, acc.item()/count

# specify small epoch_size because of low compute power
train_epoch(net,train_loader,epoch_size=15000)

# logs and output
3200: acc=0.811875
6400: acc=0.845
9600: acc=0.8578125
12800: acc=0.863671875
Out[14]: (0.026340738796730285, 0.8640724946695096)
```

Let's examine some examples.
As we know, classes = ['World', 'Sports', 'Business', 'Sci/Tech']

```python
net.eval()
s = torch.stack([to_bow("Let's play football")]); o = net(s); print(o)
# output:
# tensor([[-1.5573, -0.7191, -1.8730, -1.9076]], grad_fn=<LogSoftmaxBackward0>)

s = torch.stack([to_bow("the stock market")]); o = net(s); print(o)
# output:
# tensor([[-2.8083, -2.6868, -0.5916, -1.1453]], grad_fn=<LogSoftmaxBackward0>
```

[Bag of Words]: https://en.wikipedia.org/wiki/Bag-of-words_model
