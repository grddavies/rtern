
# rtern

<!-- badges: start -->
[![R-CMD-check](https://github.com/hedscan/rtern/workflows/R-CMD-check/badge.svg)](https://github.com/hedscan/rtern/actions)
[![Codecov test coverage](https://codecov.io/gh/hedscan/rtern/branch/master/graph/badge.svg)](https://codecov.io/gh/hedscan/rtern?branch=master)
<!-- badges: end -->

## Overview

 `rtern` brings a C-like ternary conditional operator using `?` and `:` to R.
 
 This groundbreaking spoonful of syntactic sugar will supercharge your workflow and see you bubble to the top of Kaggle leaderboards.   
 
 Yes, we know that it is possible to perform conditional assignment in base R multiple ways:   
 ```r
 x <- if(y > 1) 1 else 2
 # vectorized form:
 x <- ifelse(y > 1, 1, 2)
 ```   
 However we're sure you'll agree that once you can do the same using only...   
 ```r
 x <- y > 1 ? 1 : 2
 ```   
 ...your models will converge faster, ROC AUC will approach 1 and Hadley Wickham will be starring your repos.
 
 The only downsides are that your linter won't like it and that this masks the base functionality of `?` in R.
 
 _Who needs help files? Not you, champ._

## Why?

`rtern` is a lighthearted project for practicing package development and nonstandard evaluation in R. The `?` operator implementation borrows heavily from [this stackexchange answer](https://stackoverflow.com/a/8790269).

## Installation

You <s>can</s> _can't_ install a released version of rtern from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rtern")
```

...sorry

Instead you can install from github with:

```r
# install.packages("devtools")
devtools::install_github("hedscan/rtern")
```
