# Fine-tune hyper-parameters of Neural Networks

Suppose we use keras model to learn rules
of the problem of California housing dataset.

## Prepare the data

Let's load, split and scale the California housing dataset:

```python
from sklearn.datasets import fetch_california_housing
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

housing = fetch_california_housing()

X_train_full, X_test, y_train_full, y_test = train_test_split(housing.data, housing.target, random_state=42)
X_train, X_valid, y_train, y_valid = train_test_split(X_train_full, y_train_full, random_state=42)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_valid = scaler.transform(X_valid)
X_test = scaler.transform(X_test)
```

## Fine-tune the hyper-parameters

There're many hyper-parameters that can
be fine-tuned by GridSearchCV or RandomizedSearchCV.
To do this, we need to wrap the keras model
in objects that ***mimic regular Scikit-Learn Regressor***.

The first step is to create a function that will
build and compile a Keras model, given a set of
hyper-parameters. And then wrap this keras model
with KerasRegressor. After that, fine-tune the hyper-parameters
with GridSearchCV or RandomizedSearchCV.

```python
from tensorflow import keras

# create a function that will build and compile
# a Keras model, given a set of hyper-parameters
def build_model(n_hidden=1, n_neurons=30, learning_rate=3e-3, input_shape=[8]):
    model = keras.models.Sequential()
    model.add(keras.layers.InputLayer(input_shape=input_shape))
    for layer in range(n_hidden):
        model.add(keras.layers.Dense(n_neurons, activation="relu"))
    model.add(keras.layers.Dense(1))
    optimizer = keras.optimizers.SGD(lr=learning_rate)
    model.compile(loss="mse", optimizer=optimizer)
    return model

# wrap this keras model built using build_model()
keras_reg = keras.wrappers.scikit_learn.KerasRegressor(build_model)

# fine-tune the hyper-parameters:
#        number of hidden layers
#        number of neurons
#        learning rate
from scipy.stats import reciprocal
from sklearn.model_selection import RandomizedSearchCV
import numpy as np

param_distribs = {
    "n_hidden": [0, 1, 2, 3],
    "n_neurons": np.arange(1, 100),
    "learning_rate": reciprocal(3e-4, 3e-2)
}

# Fitting 3 folds for each of 10 candidates, totalling 30 fits
rnd_search_cv = RandomizedSearchCV(keras_reg, param_distribs, n_iter=10, cv=3, verbose=2)

In [7]: rnd_search_cv.get_params
Out[7]:
<bound method BaseEstimator.get_params of RandomizedSearchCV(cv=3,
                   estimator=<tensorflow.python.keras.wrappers.scikit_learn.KerasRegressor object at 0x000001F0C3560550>,
                   param_distributions={'learning_rate': <scipy.stats._distn_infrastructure.rv_frozen object at 0x000001F0C35DA4C0>,
                                        'n_hidden': [0, 1, 2, 3],
                                        'n_neurons': array([ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17,
       18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
       35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
       52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,
       69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85,
       86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99])},
                   verbose=2)>

# note that RandomizedSearchCV uses K-fold cross-validation,
# so it does not use X_valid and y_valid, which are
# only used for early stopping
rnd_search_cv.fit(X_train, y_train, epochs=100,
                  validation_data=(X_valid, y_valid),
                  callbacks=[keras.callbacks.EarlyStopping(patience=10)])

```

The hyper-parameters will get relayed to the underlying
Keras models. (They are passed as arguments to
the constructor of the estimator classes, i.e. build_model().)

## Explore the result

Let's explore the result:

```python
In [10]: rnd_search_cv.best_params_
Out[10]: {'learning_rate': 0.0079252114065049, 'n_hidden': 3, 'n_neurons': 43}

In [11]: rnd_search_cv.best_score_
Out[11]: -0.3226633270581563

In [12]: cvres = rnd_search_cv.cv_results_
In [13]: type(cvres)
Out[13]: dict

In [14]: cvres
Out[14]:
{'mean_fit_time': array([ 6.84825587, 16.77412319, 10.91958268, 12.96842519, 14.81522481,
        19.06050905, 26.6848851 , 15.87632394, 16.78519456, 18.09187937]),
 'std_fit_time': array([ 3.43413206,  7.06661752,  5.2621172 ,  4.92346983, 10.06107659,
         9.05147775,  3.99086202,  7.57796319,  7.79040315,  9.71025604]),
 'mean_score_time': array([0.1753215 , 0.12888471, 0.14409304, 0.1336534 , 0.14104176,
        0.14615417, 0.13889885, 0.13671398, 0.14915792, 0.13523022]),
 'std_score_time': array([0.05133366, 0.00937735, 0.00431088, 0.00307841, 0.00429275,
        0.00626557, 0.01049077, 0.00735075, 0.00676485, 0.00527651]),
 'param_learning_rate': masked_array(data=[0.0015443038442864918, 0.0006684696451280521,
                    0.0079252114065049, 0.0004027172303326246,
                    0.0012243303837020994, 0.0007367307751458874,
                    0.00033276218556829983, 0.003450189880263926,
                    0.0043331613299881985, 0.0013947393211910459],
              mask=[False, False, False, False, False, False, False, False,
                    False, False],
        fill_value='?',
             dtype=object),
 'param_n_hidden': masked_array(data=[0, 0, 3, 2, 2, 3, 2, 3, 2, 2],
              mask=[False, False, False, False, False, False, False, False,
                    False, False],
        fill_value='?',
             dtype=object),
 'param_n_neurons': masked_array(data=[92, 67, 43, 31, 72, 67, 65, 29, 89, 61],
              mask=[False, False, False, False, False, False, False, False,
                    False, False],
        fill_value='?',
             dtype=object),
 'params': [{'learning_rate': 0.0015443038442864918,
   'n_hidden': 0,
   'n_neurons': 92},
  {'learning_rate': 0.0006684696451280521, 'n_hidden': 0, 'n_neurons': 67},
  {'learning_rate': 0.0079252114065049, 'n_hidden': 3, 'n_neurons': 43},
  {'learning_rate': 0.0004027172303326246, 'n_hidden': 2, 'n_neurons': 31},
  {'learning_rate': 0.0012243303837020994, 'n_hidden': 2, 'n_neurons': 72},
  {'learning_rate': 0.0007367307751458874, 'n_hidden': 3, 'n_neurons': 67},
  {'learning_rate': 0.00033276218556829983, 'n_hidden': 2, 'n_neurons': 65},
  {'learning_rate': 0.003450189880263926, 'n_hidden': 3, 'n_neurons': 29},
  {'learning_rate': 0.0043331613299881985, 'n_hidden': 2, 'n_neurons': 89},
  {'learning_rate': 0.0013947393211910459, 'n_hidden': 2, 'n_neurons': 61}],
 'split0_test_score': array([-0.536928  , -0.55405992, -0.32181242, -0.41182315, -0.37615168,
        -0.35356146, -0.38490325, -0.34391928, -0.32527786, -0.37037757]),
 'split1_test_score': array([-1.15798283, -0.99578375, -0.34760901, -0.57444745, -0.49081776,
        -0.38935289, -0.39432892, -0.35426927, -0.37047878, -0.38659301]),
 'split2_test_score': array([-0.53581947, -0.55664188, -0.29856855, -0.4156445 , -0.33376434,
        -0.35337663, -0.38107219, -0.31271717, -0.30895692, -0.33442888]),
 'mean_test_score': array([-0.74357677, -0.70216185, -0.32266333, -0.46730503, -0.40024459,
        -0.36543033, -0.38676812, -0.33696857, -0.33490452, -0.36379982]),
 'std_test_score': array([0.29302969, 0.20762471, 0.02002973, 0.07577719, 0.06634151,
        0.01691597, 0.00557037, 0.01766123, 0.02602229, 0.02179793]),
 'rank_test_score': array([10,  9,  1,  8,  7,  5,  6,  3,  2,  4])}
```

We can print the mean_test_score and params
on the same line for comparison.

```python
cvres = rnd_search_cv.cv_results_
for mean_score, params in zip(cvres["mean_test_score"], cvres["params"]):
    print(np.sqrt(-mean_score), params)
```

From the result we can find the best params on
the 3rd line which are the same with `rnd_search_cv.best_params_`.

```python
0.8623089730835606 {'learning_rate': 0.0015443038442864918, 'n_hidden': 0, 'n_neurons': 92}
0.8379509821851601 {'learning_rate': 0.0006684696451280521, 'n_hidden': 0, 'n_neurons': 67}
0.5680346178342974 {'learning_rate': 0.0079252114065049, 'n_hidden': 3, 'n_neurons': 43}
0.683597128723514 {'learning_rate': 0.0004027172303326246, 'n_hidden': 2, 'n_neurons': 31}
0.6326488707176361 {'learning_rate': 0.0012243303837020994, 'n_hidden': 2, 'n_neurons': 72}
0.6045083334989676 {'learning_rate': 0.0007367307751458874, 'n_hidden': 3, 'n_neurons': 67}
0.6219068439196411 {'learning_rate': 0.00033276218556829983, 'n_hidden': 2, 'n_neurons': 65}
0.5804899404362207 {'learning_rate': 0.003450189880263926, 'n_hidden': 3, 'n_neurons': 29}
0.5787093585762374 {'learning_rate': 0.0043331613299881985, 'n_hidden': 2, 'n_neurons': 89}
0.6031582050703227 {'learning_rate': 0.0013947393211910459, 'n_hidden': 2, 'n_neurons': 61}
```

### Explore the model

Let's examine the model:

```python
In [18]: model = rnd_search_cv.best_estimator_.model

In [19]: type(model)
Out[19]: tensorflow.python.keras.engine.sequential.Sequential

In [20]: model.summary()
Model: "sequential_30"
_________________________________________________________________
Layer (type)                 Output Shape              Param #
=================================================================
dense_87 (Dense)             (None, 43)                387
_________________________________________________________________
dense_88 (Dense)             (None, 43)                1892
_________________________________________________________________
dense_89 (Dense)             (None, 43)                1892
_________________________________________________________________
dense_90 (Dense)             (None, 1)                 44
=================================================================
Total params: 4,215
Trainable params: 4,215
Non-trainable params: 0
_________________________________________________________________

# check params of the output layer: weights and bias
In [22]: output_layer = model.get_layer('dense_90')

In [23]: weights, biases = output_layer.get_weights()

In [29]: weights.shape, biases.shape
Out[29]: ((43, 1), (1,))

In [31]: weights.reshape(-1)
Out[31]:
array([ 0.2536146 , -0.12727292, -0.00113954, -0.2839334 , -0.46649176,
       -0.08921697,  0.71929944, -0.14670205,  0.4841758 ,  0.255453  ,
       -0.6487076 , -0.32898036,  0.73409355,  0.30633914, -0.21992989,
        0.94723094, -0.07166384, -0.18649486, -0.5474177 , -0.42196763,
       -0.0736759 ,  0.08634806, -0.24261409, -0.00222751, -0.33308125,
       -0.17996483,  0.3911426 , -0.15252355, -0.17358361, -0.05518119,
        0.3156427 ,  0.07272388, -0.31402165, -0.12687036, -0.05101475,
       -0.38453922, -0.51448375,  0.33569083,  0.75310624,  0.43272355,
        0.54590577, -0.07734332,  0.2931337 ], dtype=float32)

In [32]: biases
Out[32]: array([0.87713665], dtype=float32)
```
