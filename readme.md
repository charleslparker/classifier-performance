## Introduction and Preamble

The files in this repo relate to experiments on performance metrics for binary classifiers.  These experiments are detailed in the associated ICDM paper that I have included in this root of this repo.  

There are three directories in the project:

* `matlab`: Code used for evaluating classifier performance and performing experiments.
* `data`: The experimental, results of analysis, and example data.
* `drtoolbox`: A selection of algorithms from the [dimensionality reduction toolbox for matlab](http://homepage.tudelft.nl/19j49/Matlab_Toolbox_for_Dimensionality_Reduction.html)

The core code is all located in the `matlab` directory.  Many of the files in the `matlab` directory are files built for the purposes of analyzing and parsing the results of the large number of classification experiments I did for this research, and so are not directly useful for performance evaluation of classifiers.  The actual code used to compute the performance metrics is (mostly) in `matlab/evaluate`.

The code computing the performance measures comes mostly from my own head and hands, and is the product of various readings and discussions with colleagues.  I've of course had to make several assumptions while writing the code, and if you find any of these amiss, please let me know (a pull request would of course be the best way to correct a mistake!).

One exception is the H-measure itself.  It was sufficiently complex that I resorted to doing a direct port of Dr. Hand's R code at:

http://www2.imperial.ac.uk/~djhand/R%20CODE%20for%20H%20measure%20of%20classification%20performance.txt

I have broken his function into several functions so that I can reuse some of the computations to compute the other measures, but the outline, and even many of the variable names are much the same.

Documentation of the library is currently sketchy at best.  I'll be updating that especially as time goes on, the need arises, and people are interested.

There are two reasons you may want to use this software.  The first is to use the performance metrics to evaluate your own models.  The second is to replicate my experiments in the included paper.  We'll deal with the first, simpler case below, in the "Evaluation Usage" section.  Following that, we'll discuss the more complex second case in the "Replication Usage" section.

## Evaluation Usage

First, add the root directory of the repository and all subdirectories to the matlab path.

The only function you are likely to need is the function `computeallperf(scores, labels)`.  This function takes a vector of scores and a vector of binary labels, and computes the seven performance metrics from the paper above.

As an example of how to use the package to determine the values for the various performance measures, navigate to the `data` directory and type, at the Matlab command prompt:

```
> load perf_examp
```

This should load three vectors into your workspace:  Two vectors of scores called `scores1` and `scores2`, and a binary vector of labels, called `labels`.  The vectors of scores are the outputs of classifiers.  Each element is a number from 0 to 1 that is higher if the classifier considers it more likely that the example corresponding to that index has the positive (we do not provide the classified examples here, only the results of classification).  The corresponding index in the labels vector is zero if the true label for that example is negative, and one if it is positive.

To compute performance measures, all you need is a vector of scores (where higher value indicate a greater likelihood of the example at a given index belonging to the positive class) and a binary vector of labels (where a value of 1 indicates that the true class of the example at that index is positive).  To compute the measures, type:

```
> p1 = computeallperf(scores1, labels)
```

The output vector will contain seven performance measures, all from 0 to 1, where higher is better.  They are, in order:

* The Matthews Correllation Coefficient (or Phi Coefficient)  
* The F1-Score
* r-Precision
* The H-Measure
* The area under the ROC curve
* Average Precision
* The area under the kappa curve

If you type:

```
> p2 = computeallperf(scores2, labels)
```

You will see that each of the measures is higher for the second set of scores than for the first, indicating that the classifier that gave the vector `scores2` for the same test data is superior to the one that gave `scores1`.

## Replication Usage

Coming soon!