
# Machine Learning Tutorial

It's a quick guide of Machine Learning.
I learned from a video ***Machine Learning Recipes with Josh Gordon***
and write what I got & thought. I will write something new
after reading other materials.

From this blog, We'll learn the basic concept of Machine Learning and get some intuition via examples.

Lession 1 gives the basic concept of ML and shows how it resolves a problem.  
[Lession 2](./02.md) shows what a ML classifier looks like and how it classifies an input.  
[Lession 3](./03.md) shows what makes a good feature.  
[Lession 4](./04.md) shows how a classifier is trained -- how params are adjusted for the model.  
[Lession 5](./05.md) shows how to code a classifier -- implement the interface fit() and predict()  
[Lession 6](./06.md) code another classifier from scratch -- a decision tree classifier  
[Summary](./summary.md) review the knowledge

## 01 hello world

### what is machine learning

we can take ML as subfield of Artificial Intelligence:

* early AI program: one AI program resolves one problem - Example: Deep Blue
* today AI program: one AI program resolves many problems without even to be written - Example: Alpha Go

ML makes that possible. It's the study of algorithms that ***learn from examples and experience automatically*** instead of relying on hard-coded rules.

### An example

how to tell the differece between an apple and an orange?

![apple orange issue](./pic/apple_orange.png)

#### Traditional method

The programmer writes hard code rules - ratio of green and yellow pixels. The drawbacks:

* have to find rules and write code manually
* can not handle new situations: grey image; images do not contain apples or oranges in them at all
* can not handle new problems (need to re-write the code -- new rules)

![hard coded rules](./pic/hard_coded_rules.png)

To solve this, we need an algorithm that can figure out the rules for us
instead of writing them by hand. That is what ML does.

#### ML method

The ML program finds patterns (rules) from examples **automatically** - it
is the process of training the classifier (in other words, creating a function).
And then, the classifier takes the input (the problem), analyzes it (run the function) and then gives an output (type of the fruit).

![ml classify apple](./pic/apple_classifier.png)

advantages:

1. no need to write hard-coded rules (ML algorithm trains the classifier)
2. can resolve new situations of this problem (just update the training data)
3. can resolve different problems (no need to be rewritten, just only re-train the classifier with new examples)
4. can resolve problems that cannot be resolved with traditional way

steps for ML:

1. collect training data (examples of the problem to be resolved)
2. train the classifier (it is what ML does)
3. predict the result via classifier

The training data are examples of the problem to be resolved.
Each example contains features and a label (a piece of description).
The ML algorithm trains the classifier with these examples.
To train a classifier is to create a function that contains
"rules" of the "examples". The function then takes
descriptions(measurement, features) of the problem as input
and gives the result - the label.

```python
# training data:
#
#      feature
#  Weight |  Texture  |  Label
#   150g  |   Bumpy   |  Orange
#   170g  |   Bumpy   |  Orange
#   140g  |   Smooth  |  Apple
#   130g  |   Smooth  |  Apple
```

### programming

```python
from sklearn import tree
# feature : smooth: 0; bumpy: 1;
# label:    orange: 0; apple: 1;
features = [[140, 1], [130, 1], [150, 0], [170, 0]]
labels = [0, 0, 1, 1]
clf = tree.DecisionTreeClassifier()
clf = clf.fit(features, labels)
print(clf.predict([[150, 0]]))

# the following is to run the program
(base) D:\learning\machine learning\ML recipes\codes>python hello-world.py
[1]
```

[video of this episode](https://www.yxgapp.com/hello-world-machine-learning-recipes-1/ "click here to watch the video")
