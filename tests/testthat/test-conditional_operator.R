# !diagnostics style=false

test_that("`?` evaluates simple TRUE cases correctly", {
  expect_equal(TRUE ? 1 : 2, 1)
  expect_equal(TRUE ? c(1, 2) : c(9, 8, 7), c(1, 2))
  expect_equal(TRUE ? "this" : "that", "this")
  expect_equal(TRUE ? FALSE : TRUE, FALSE)
})

test_that("`?` evaluates simple TRUE expressions correctly", {
  expect_equal(3 > 1 ? 1 : 2, 1)
  expect_equal(1 < 3 ? c(1, 2) : c(9, 8, 7), c(1, 2))
  expect_equal(6 == 6 ? "this" : "that", "this")
  expect_equal(is.character("a") ? FALSE:TRUE, FALSE)
})


test_that("`?` evaluates multi-part TRUE expressions correctly", {
  expect_equal(3 > 1 & is.numeric(1) ? 1 : 2, 1)
  expect_equal(1 < 3 & !FALSE ? c(1, 2) : c(9, 8, 7), c(1, 2))
  expect_equal(6 == 6 & 6 != 9 ? "this" : "that", "this")
  expect_equal(is.character("a") & is.null(NULL) ? FALSE : TRUE, FALSE)
})


test_that("`?` evaluates simple FALSE cases correctly", {
  expect_equal(FALSE ? 1 : 2, 2)
  expect_equal(FALSE ? c(1, 2) : c(9, 8, 7), c(9, 8, 7))
  expect_equal(FALSE ? "this" : "that", "that")
  expect_equal(FALSE ? FALSE : TRUE, TRUE)
})

test_that("`?` evaluates simple FALSE expressions correctly", {
  expect_equal(3 < 1 ? 1 : 2, 2)
  expect_equal(1 > 3 ? c(1, 2) : c(9, 8, 7), c(9, 8, 7))
  expect_equal(6 != 6 ? "this" : "that", "that")
  expect_equal(is.character(1) ? FALSE : TRUE, TRUE)
})

test_that("`?` evaluates multi-part FALSE expressions correctly", {
  expect_equal(3 > 1 & is.numeric("a") ? 1 : 2, 2)
  expect_equal(1 < 3 & FALSE ? c(1, 2) : c(9, 8, 7), c(9, 8, 7))
  expect_equal(6 > 6 | 6 == 9 ? "this" : "that", "that")
  expect_equal(is.character("a") & is.call(NULL) ? FALSE : TRUE, TRUE)
})

test_that("`?` can be used in `<-` assignment when fed truthy expressions", {
  x <- TRUE ? 1 : 2
  expect_equal(x, 1)
  y <- 1 ? 2 : 3
  expect_equal(y, 2)
  z <- TRUE == 1 ? "foo":NULL
  expect_equal(z, "foo")
})

test_that("`?` can be used in `<-` assignment when fed falsy expressions", {
  x <- FALSE ? 1 : 2
  expect_equal(x, 2)
  y <- 0 ? 2 : 3
  expect_equal(y, 3)
  z <- TRUE == !1 ? "foo":"bar"
  expect_equal(z, "bar")
})

test_that("`?` can be used in `=` assignment when fed truthy expressions", {
  x <- TRUE ? 1 : 2
  expect_equal(x, 1)
  y <- 1 ? 2 : 3
  expect_equal(y, 2)
  z <- TRUE == 1 ? "foo" : NULL
  expect_equal(z, "foo")
})

test_that("`?` can be used in `=` assignment when fed falsy expressions", {
  x <- FALSE ? 1 : 2
  expect_equal(x, 2)
  y <- 0 ? 2 : 3
  expect_equal(y, 3)
  z <- TRUE == !1 ? "foo" : "bar"
  expect_equal(z, "bar")
})

test_that("`?` can be passed a logical vector", {
  expect_equal(
    c(3, 5, 3, 5) > 4 ? "boof" : "foob",
    c("foob", "boof", "foob", "boof")
  )
  expect_equal(
    c(TRUE, FALSE, TRUE, FALSE) ? "true" : "fales",
    c("true", "fales", "true", "fales")
  )
  expect_equal(
    c("this", "that", "this", "that") == "this" ? "true" : "fales",
    c("true", "fales", "true", "fales")
  )
})

test_that("`?` can be passed a logical matrix", {
  X <- matrix(rep(c(TRUE, FALSE, TRUE), 3), ncol = 3, byrow = TRUE)
  Y <- matrix(rep(c("boof", "foob", "boof"), 3), ncol = 3, byrow = TRUE)
  expect_equal(X ? "boof" : "foob", Y)
})

test_that("`?` statements can be chained with brackets", {
  expect_equal(FALSE ? 1 : (FALSE ? 2 : (TRUE ? 3 : 4)), 3)
  x <- FALSE ? 1 : (FALSE ? 2 : (TRUE ? 3 : 4))
  expect_equal(x, 3)
  z <- (FALSE ?
          "true-first" :
          FALSE ? "false,true" :
                  TRUE ? "false,false,true" :
                         "all false")
  expect_equal(z, "false,false,true")
})

test_that("`?` statements can be chained without brackets", {
  testthat::skip("Not yet implemented")
  expect_equal(FALSE ? 1 : FALSE ? 2 : TRUE ? 3 : 4, 3)
  z <- FALSE ? "true-first" : FALSE ? "false,true" : TRUE ? "false,false,true" : "all false"
  expect_equal(z, "false,false,true")
})

test_that("`?` can handle string values with colons in", {
  x <- FALSE ? "value:1" : "value:2"
  expect_equal(x, "value:2")
  y <- TRUE ? "value:1" : "value:2"
  expect_equal(y, "value:1")
})

test_that("`?` can handle function calls with colons in", {
  x <- FALSE ? base::mean(c(1, 2, 3)) : base::mean(c(4, 5, 6))
  expect_equal(x, 5)
  y <- TRUE ? base::mean(c(1, 2, 3)) : base::mean(c(4, 5, 6))
  expect_equal(y, 2)
})

test_that("`?` throws an error in the absence of a colon in RHS", {
  expect_error(
    6 < 3 ? TRUE,
    regexp = "Colon `:` operator missing from right hand of expression"
  )
  expect_error(
    {
      myvar <- c(TRUE, FALSE) ? base::mean(c(1, 2, 3))
    },
    regexp = "Colon `:` operator missing from right hand of expression"
  )
})

test_that("`?` can be used on function arguments in function body", {
  foo <- function(param) {
    param ? "yes" : "no"
  }
  expect_equal(foo(TRUE), "yes")
  expect_equal(foo(FALSE), "no")
})

test_that("`?` can be used in assignments in function body", {
  foo <- function(param) {
    out <- param ? "yes" : "no"
    out
  }
  expect_equal(foo(TRUE), "yes")
  expect_equal(foo(FALSE), "no")
})

test_that("`?` can be used to call utils::help while rtern is loaded", {
  actual <- ?data.frame
  expect_s3_class(actual, "help_files_with_topic")
  expect_equal(attr(actual, "topic"), "data.frame")
  expect_s3_class(?`for`, "help_files_with_topic")
})
