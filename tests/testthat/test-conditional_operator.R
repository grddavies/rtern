library(rtern)

test_that("`?` evaluates simple TRUE cases correctly", {
  expect_equal(TRUE ? 1 : 2, 1)
  expect_equal(TRUE ? c(1, 2) : c(9, 8), c(1, 2))
  expect_equal(TRUE ? 'this' : 'that', 'this')
  expect_equal(TRUE ? FALSE : TRUE, FALSE)
})

test_that("`?` evaluates simple TRUE expressions correctly", {
  expect_equal(3 > 1 ? 1 : 2, 1)
  expect_equal(1 < 3 ? c(1, 2) : c(9, 8), c(1, 2))
  expect_equal(6 == 6 ? 'this' : 'that', 'this')
  expect_equal(is.character('a') ? FALSE : TRUE , FALSE)
})


test_that("`?` evaluates multi-part TRUE expressions correctly", {
  expect_equal(3 > 1 & is.numeric(1) ? 1 : 2, 1)
  expect_equal(1 < 3 & !FALSE ? c(1, 2) : c(9, 8), c(1, 2))
  expect_equal(6 == 6 & 6 != 9 ? 'this' : 'that', 'this')
  expect_equal(is.character('a') & is.null(NULL) ? FALSE : TRUE , FALSE)
})


test_that("`?` evaluates simple FALSE cases correctly", {
  expect_equal(FALSE ? 1 : 2, 2)
  expect_equal(FALSE ? c(1, 2) : c(9, 8), c(9, 8))
  expect_equal(FALSE ? 'this' : 'that', 'that')
  expect_equal(FALSE ? FALSE : TRUE , TRUE)
})

test_that("`?` evaluates simple FALSE expressions correctly", {
  expect_equal(3 < 1 ? 1 : 2, 2)
  expect_equal(1 > 3 ? c(1, 2) : c(9, 8), c(9, 8))
  expect_equal(6 != 6 ? 'this' : 'that', 'that')
  expect_equal(is.character(1) ? FALSE : TRUE , TRUE)
})

test_that("`?` evaluates multi-part FALSE expressions correctly", {
  expect_equal(3 > 1 & is.numeric('a') ? 1 : 2, 2)
  expect_equal(1 < 3 & FALSE ? c(1, 2) : c(9, 8), c(9, 8))
  expect_equal(6 > 6 | 6 == 9 ? 'this' : 'that', 'that')
  expect_equal(is.character('a') & is.call(NULL) ? FALSE : TRUE , TRUE)
})

test_that("`?` can be used in `<-` assignment when fed truthy expressions", {
  x <- TRUE ? 1 : 2
  expect_equal(x, 1)
  y <- 1 ? 2 : 3
  expect_equal(y, 2)
  # TRUE == 1 is truthy
  z <- TRUE == 1 ? "foo" : NULL
  expect_equal(z, "foo")
})

test_that("`?` can be used in `<-` assignment when fed falsy expressions", {
  x <- FALSE ? 1 : 2
  expect_equal(x, 2)
  y <- 0 ? 2 : 3
  expect_equal(y, 3)
  z <- TRUE == !1 ? "foo" : "bar"
  expect_equal(z, "bar")
})

test_that("`?` can be used in `=` assignment when fed truthy expressions", {
  # skip('not yet implemented')
  x = TRUE ? 1 : 2
  expect_equal(x, 1)
  y = 1 ? 2 : 3
  expect_equal(y, 2)
  # TRUE == 1 is truthy
  z = TRUE == 1 ? "foo" : NULL
  expect_equal(z, "foo")
})

test_that("`?` can be used in `=` assignment when fed falsy expressions", {
  # skip('not yet implemented')
  x = FALSE ? 1 : 2
  expect_equal(x, 2)
  y = 0 ? 2 : 3
  expect_equal(y, 3)
  z = TRUE == !1 ? "foo" : "bar"
  expect_equal(z, "bar")
})
