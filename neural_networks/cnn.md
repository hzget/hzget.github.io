# Convolutional neural networks

We will learn about Convolutional Neural Networks (CNNs),
which are specifically designed for computer vision tasks.

When we are trying to find a certain object in
the picture, we are scanning the image looking for
some specific patterns and their combinations.
Relative position and presence of certain patterns
is important, and not their exact position on the image.

## Convolutional filters

Convolutional filters are small windows that run over
each pixel of the image and compute weighted average
of the neighboring pixels. Thus it can detect patterns

1. along the row
2. along the column
3. along other directions
4. kinds of conbinations of the above

In a word, it can detect patterns around this pixel.

The filters are defined by matrices of weight coefficients.
Different filters extract different features.
