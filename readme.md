The files in this directory are related to experiments I have performed regarding measuring the performance of binary classifiers.  These experiments are detailed in the associated ICDM paper that I have included in this directory.

Many of the files in the "Matlab Files" directory are files built for the purposes of analyzing and parsing the results of the large number of classification experiments I did for this research.  They are thus superfluous for anyone who simply wishes to use the performance measures analyzed here on their own classifiers.

As an example of how to use the package to determine the values for the various performance measures, navigate to the `matlab` directory and type, at the Matlab command prompt:

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