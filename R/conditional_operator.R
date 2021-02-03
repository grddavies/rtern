#' Conditional (Ternary) Operator
#'
#' Who has time for if/else?
#'
`?` <- function(lhs, rhs) {
  xs <- as.list(substitute(lhs, environment()))
  if (xs[[1]] == as.name("<-")) lhs <- eval(xs[[3]])
  r <- eval(sapply(
    strsplit(deparse(substitute(rhs, environment())), ":"),
    function(e) parse(text = e)
  )[[2 - as.logical(lhs)]])
  if (xs[[1]] == as.name("<-")) {
    xs[[3]] <- r
    eval.parent(as.call(xs))
  } else {
    r
  }
}
