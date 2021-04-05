# Data Prepare

Before we feed data to the training process,
we need to preprocess the data to make it be "a good teacher".
The works includes:

* collect data (discussed in previous lessons)
* transform data in a required form
* resolve challenges in the data process

Suppose we're going to predict the median house value
and the census data is provided for analysis.

## Quick Overview

We can use pandas for a quick overview.

```python
import os
import pandas as pd

HOUSING_PATH = os.path.join("datasets", "housing")

def load_housing_data(housing_path=HOUSING_PATH):
    csv_path = os.path.join(housing_path, "housing.csv")
    return pd.read_csv(csv_path)

housing = load_housing_data()

In [2]: housing.head()
Out[2]:
   longitude  latitude  housing_median_age  total_rooms  ...  households  median_income  median_house_value  ocean_proximity
0    -122.23     37.88                41.0        880.0  ...       126.0         8.3252            452600.0         NEAR BAY
1    -122.22     37.86                21.0       7099.0  ...      1138.0         8.3014            358500.0         NEAR BAY
2    -122.24     37.85                52.0       1467.0  ...       177.0         7.2574            352100.0         NEAR BAY
3    -122.25     37.85                52.0       1274.0  ...       219.0         5.6431            341300.0         NEAR BAY
4    -122.25     37.85                52.0       1627.0  ...       259.0         3.8462            342200.0         NEAR BAY

[5 rows x 10 columns]
```

## Split data

We need to exclude test data from the data set before
further investigation. Otherwise, our brain will detect patterns
from all data (including test data) and lead
to select a particular kind of ML model. In a word,
it is highly prone to overfitting. The page [split data set][split data set page]
tells related topics.

Suppose we split it and get the training data set and
test data set: strat_train_set and strat_test_set.

We also need to seperate the labels from training data.

```python
housing = strat_train_set.drop("median_house_value", axis=1) # drop labels for training set
housing_labels = strat_train_set["median_house_value"].copy()
```

## Investigation

We'll discuss the following topics:

* feature engineering
* feature scaling
* poor data quality
* representative data (discussed in [split data set][split data set page])
* text attributes

All the steps can be packed in one [pipeline](./data_prepare_pipeline.md)
and run automatically.

### correlations

We can check the relationship between the goal "median house value"
and each feature. And then decide whether to remove or
even combine some features. One of the method is to make use of pandas.corr().

```python
# make a copy to investigate correlations
housing = strat_train_set.copy()

corr_matrix = housing.corr()
corr_matrix["median_house_value"].sort_values(ascending=False)
Out[16]:
median_house_value    1.000000
median_income         0.687160
total_rooms           0.135097
housing_median_age    0.114110
households            0.064506
total_bedrooms        0.047689
population           -0.026920
longitude            -0.047432
latitude             -0.142724
Name: median_house_value, dtype: float64
```

The "median_income" feature has strong correlation while
"total_rooms" and "total_bedrooms" have weak correlation.
We can try some other feature for analysis.

```python
housing["rooms_per_household"] = housing["total_rooms"]/housing["households"]
housing["bedrooms_per_room"] = housing["total_bedrooms"]/housing["total_rooms"]
housing["population_per_household"]=housing["population"]/housing["households"]

corr_matrix = housing.corr()
corr_matrix["median_house_value"].sort_values(ascending=False)

Out[17]:
median_house_value          1.000000
median_income               0.687160
rooms_per_household         0.146285
total_rooms                 0.135097
housing_median_age          0.114110
households                  0.064506
total_bedrooms              0.047689
population_per_household   -0.021985
population                 -0.026920
longitude                  -0.047432
latitude                   -0.142724
bedrooms_per_room          -0.259984
Name: median_house_value, dtype: float64
```

The new features have strong correlation.

### check poor quality data

Poor data lead to poor model. We need to handle
it before training the model. One of the poor quality is
data missing.

```python
# make a copy for investigation
housing = strat_train_set.copy()

housing.info()
<class 'pandas.core.frame.DataFrame'>
Int64Index: 16512 entries, 17606 to 15775
Data columns (total 10 columns):
longitude             16512 non-null float64
latitude              16512 non-null float64
housing_median_age    16512 non-null float64
total_rooms           16512 non-null float64
total_bedrooms        16354 non-null float64
population            16512 non-null float64
households            16512 non-null float64
median_income         16512 non-null float64
median_house_value    16512 non-null float64
ocean_proximity       16512 non-null object
dtypes: float64(9), object(1)
memory usage: 1.4+ MB
```

There're missing data in the total_bedrooms column.
We can remove rows missing the data, remove
this feature or give it some value (e.g., median value).
We'll make use of the scikit-learn tool SimpleImputer
to give each missing entry a median value.

```python
# Remove the text attribute because median can
# only be calculated on numerical attributes:
housing_num = housing.drop("ocean_proximity", axis=1)

from sklearn.impute import SimpleImputer
imputer = SimpleImputer(strategy="median")

# median value will be saved in imputer.statistics_
imputer.fit(housing_num)

# transfrom the dataframe to a numpy array X
# that filled with median value 
X = imputer.transform(housing_num)

# get the DataFrame data type
housing_tr = pd.DataFrame(X, columns=housing_num.columns,
                          index=housing.index)

housing_tr.info()

<class 'pandas.core.frame.DataFrame'>
Int64Index: 16512 entries, 17606 to 15775
Data columns (total 9 columns):
longitude             16512 non-null float64
latitude              16512 non-null float64
housing_median_age    16512 non-null float64
total_rooms           16512 non-null float64
total_bedrooms        16512 non-null float64
population            16512 non-null float64
households            16512 non-null float64
median_income         16512 non-null float64
median_house_value    16512 non-null float64
dtypes: float64(9)
memory usage: 1.3 MB
```

The "total_bedrooms" column does not miss values now.

### handle text and categorical attributes

Most ML algorithms prefer to work with numbers,
so we need to convert text attribute (categories)
to numerical attributes.

Even a ML algorithm can handle text attributes,
it may detect text patterns by chance, which is unexpected.

```python
# make a copy for investigation
housing = strat_train_set.copy()

housing["ocean_proximity"].value_counts()
Out[42]:
<1H OCEAN     7276
INLAND        5263
NEAR OCEAN    2124
NEAR BAY      1847
ISLAND           2
Name: ocean_proximity, dtype: int64
```

There're five catogaries. If we just give five
numbers [0, 1, 2, 3, 4] accordingly, there will be new issue:
ML algorithms will assume ***two nearby values
are more similar than two distant values***.
It is not case for our situation.

To fix the issue, we can add a binary attribute for each catogory.
It is called one-hot encoding: one and only one of the attribute
is 1 (hot), while other attributes are 0 (cold).

```python
housing_cat = housing[["ocean_proximity"]]

from sklearn.preprocessing import OneHotEncoder

cat_encoder = OneHotEncoder()
housing_cat_1hot = cat_encoder.fit_transform(housing_cat)
```

### Feature Scaling

The feature scaling discussion will be added in the future.

[split data set page]: ./split_data_set.md
