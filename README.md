
# rtern

<!-- badges: start -->
[![R-CMD-check](https://github.com/hedscan/rtern/workflows/R-CMD-check/badge.svg)](https://github.com/hedscan/rtern/actions)
[![Codecov test coverage](https://codecov.io/gh/hedscan/rtern/branch/master/graph/badge.svg)](https://codecov.io/gh/hedscan/rtern?branch=master)
<!-- badges: end -->

 `rtern` brings a C-like ternary conditional operator using `?` and `:` to R.
 
 This groundbreaking spoonful of syntactic sugar will supercharge your workflow and see you bubble to the top of Kaggle leaderboards.   
 
 Yes, we know that it is possible to perform conditional assignment in base R multiple ways:   
 ```r
 x <- if(y > 1) 1 else 2
 ```   
 and the vectorized form...   
  ```r
  x <- ifelse(y > 1, 1, 2)
  ```   
 However we're sure you'll agree that once you can do the same using only...   
 ```r
 x <- y > 1 ? 1 : 2
 ```   
 ...your models will converge faster, ROC AUC will approach 1 and Hadley Wickham will be starring your repos.
 
 The only downside is that this masks the base functionality of `?` in R.
 
 _Who needs help files? Not you, champ._

## Installation

You <s>can</s> _can't_ install a released version of rtern from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rtern")
```

...sorry
