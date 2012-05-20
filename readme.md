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
>> load perf_examp
```

This should load three vectors into your workspace:  Two vectors of scores called `scores1` and `scores2`, and a binary vector of labels, called `labels`.  The vectors of scores are the outputs of classifiers.  Each element is a number from 0 to 1 that is higher if the classifier considers it more likely that the example corresponding to that index has the positive (we do not provide the classified examples here, only the results of classification).  The corresponding index in the labels vector is zero if the true label for that example is negative, and one if it is positive.

To compute performance measures, all you need is a vector of scores (where higher value indicate a greater likelihood of the example at a given index belonging to the positive class) and a binary vector of labels (where a value of 1 indicates that the true class of the example at that index is positive).  To compute the measures, type:

```
>> p1 = computeallperf(scores1, labels)
```

The output vector will contain seven performance measures, all from 0 to 1, where higher is better.  They are, in order:

1. The Matthews Correllation Coefficient (or Phi Coefficient)  
2. The F1-Score
3. r-Precision
4. The H-Measure
5. The area under the ROC curve
6. Average Precision
7. The area under the kappa curve

If you type:

```
>> p2 = computeallperf(scores2, labels)
```

You will see that each of the measures is higher for the second set of scores than for the first, indicating that the classifier that gave the vector `scores2` for the same test data is superior to the one that gave `scores1`.

## Replication Usage

To completely replicate the experiments done in the paper, you will need to install [WEKALab](http://www.github.com/charleslparker/wekalab).  This is only required to re-learn and apply classifiers over the test data.  If you have no need for this, the rest of the experiment can be done with Matlab alone.

### Data Explanation

If you navigate to the `data` directory of the repo, you can load all of the data used in these experiments, plus many of the intermediate results.  

```
>> load results.mat
```

There are several important variables in this data file:

* `data` is a 3-by-14 array of cells.  Each column represents a data set.  The first row is the text label for the dataset, used in Table 1 of the paper.  The second is a matrix with the input features for that dataset.  The third is a matrix of binary labels.  Prediction problems are constructed by appending a single column of the labels to the input features.
*  `ldadata` is the original data for the "text" and "enron" datasets.  These datasets were put through the LDA algorithm to reduce their dimensionality prior to their inclusion in `data`.
*  `results` is the result of applying 10-fold cross validation to each of the prediction problems implied by `data`.  See below.
*  `comps` is the result of pair-wise comparing the vectors of scores for each prediciton problem given in `results`.  See below.
*  `classifiers` and `dimred` are the algorithms we used for classification and dimensionality reduction, and are used to generate `results` from `data`.
*  `classifier_labels`, `data_names`, `dr_labels`, `measure_labels`, and `short_m_labs` are text labels for the axes in the generated plots.

### Classification

The first step in the experiments is to generate vectors of scores for each prediction problem in `data`.  You can do this with the command:

```
>> M = classifyalldata(data, classifiers, dimred)
```

For this to work you need:

* The `drtoolbox` and `matlab` directories from this repo on your Matlab path, with all subdirectories.
* You will probably need to [increase your Java heap space](http://www.mathworks.com/support/solutions/en/data/1-18I2C/) to 512m or greater.

This command will take quite a while (hours or possibly days) to run.  It periodically saves its output to `results_temp.mat` so you don't have to go back to the beginning if you have a [pronklem](http://www.youtube.com/watch?v=Jis_CrJ4zUI).  If you get through part of the computation and it is, you may pass in a subset of the columns in `data` to more or less resume where you left off.  The results of my execution are in the variable `results`.

The output matrix is a 1-by-14 array of cells, one for each test dataset.  Each cell is in turn a 5-by-n array of cells.  Each row is for one of the dimensionality reduction algorithms specified in `dimred`, and each column is a possible binary labeling of the instances given by the columns of the matrix in the third row of `data`.  Each entry in this matrix has 11 columns, and each column is a set of scores (generated by cross validation) for each input point in the classification problem, by each of the 10 classifiers given in `classifiers`.  The final 11th column is the true labels. Here, a "classification problem" is a combination of input data, dimensionality reduction algorithm, and binary labeling.

### Comparisons

Once we have the results of the classification, we can make comparisons between pairs of score vectors for each classification problem by executing:

```
>> C = makeallcomp(results)
```

where `results` can either be my `results` or yours generated in the previous step.  This gives a an m-by-11 matrix where each row represents the output of comparing two score vectors (w.r.t. the true labelings, of course).  The output of my execution of this command are in the variable `comps`.

The first seven columns in each row are binary variables telling whether the "first" or the "second" classifier was superior according to each of the seven measures computed by `computeallperf`.  The eighth and ninth columns are the classifiers compared, as zero-based indicies of `classifiers`, so that the classifiers being compared in, e.g., `row` are `classifiers(row(8) + 1)` and `classifiers(row(9) + 1)`.

The tenth column gives probability of the positive class given the data, and the eleventh is one-based index of the dimensionality reduction algorithm used, so the that algorithm used for `row` is `dimred(row(11))`.

### Plots

To regenerate the plots in the paper, you can use the command:

```
>> makeallplots(comps, classifier_labels, dr_labels, measure_labels, short_m_labs)
```

where, again, `comps` can be from my data, or from your execution of the `makeallcomp`.  This should give you several graphics windows containing the plots.

##

That's it?  Please message me on GitHub if you have questions.  I'd love to review pull requests on this work, especially for new measures that "plug in" to what I have here.  Thanks!