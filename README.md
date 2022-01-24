# rtern

<!-- badges: start -->

[![R-CMD-check](https://github.com/grddavies/rtern/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/grddavies/rtern/actions/workflows/check-standard.yaml)
[![Codecov test coverage](https://codecov.io/gh/grddavies/rtern/branch/master/graph/badge.svg)](https://app.codecov.io/gh/grddavies/rtern?branch=master)

<!-- badges: end -->

## Overview

`rtern` brings a [conditional ternary operator](https://en.wikipedia.org/wiki/%3F:) using `?` and `:` to R.

This groundbreaking spoonful of syntactic sugar will supercharge your workflow and see you bubble to the top of Kaggle leaderboards.

Yes, we know that it is possible to perform conditional assignment in base R multiple ways:

```r
# Using a one-line if/else:
x <- if (y > 1) 1 else 2
# vectorized form:
x <- ifelse(y > 1, 1, 2)
```

However we're sure you'll agree that once you can do the same using only...

```r
x <- y > 1 ? 1 : 2
```

...your models will converge faster, ROC AUC will approach 1 and Hadley Wickham will be starring your repos.

The only downsides are that your linter won't like it <s> and that this masks the base functionality of `?` in R </s>.  
As of v0.1 help files can still be accessed by the `?` operator whilst `rtern` is attached!

_Who needs help files? Not you, champ._

## Why?

`rtern` is a lighthearted project for practicing package development and nonstandard evaluation in R. The `?` operator implementation borrows heavily from [this Stack Exchange answer](https://stackoverflow.com/a/8790269).

## Installation

You can install the latest released version of rtern from [CRAN](https://CRAN.R-project.org) with:

```r
install.packages("rtern")
```

Or install the development version from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("grddavies/rtern")
```
