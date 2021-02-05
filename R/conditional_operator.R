#' Conditional (Ternary) Operator
#'
#' Who has time for if/else?
#'
#' @param lhs A logical expression, vector or matrix.
#' @param rhs A pair of values separated by a colon (`:`).
#' @return One of the values passed to the rhs, depending on truthiness of the lhs
#' @examples
#' # Conditional evaluation
#' 4 > 3 ? "it_was_true" : "it_was_false"
#' # > "it_was_true"
#'
#' FALSE ? "it_was_true" : "it_was_false"
#' # > "it_was_false"
#'
#' # Vectorised evaluation
#' c(4, 2) < 3 ? "it_was_true" : "it_was_false"
#' # > "it_was_false" "it_was_true"
#'
#' # Conditional assignment
#' x <- 4 > 3 ? "it_was_true" : "it_was_false"
#' x
#' # > "it_was_true"
#'
#' y = 3 > 4 ? "it_was_true" : "it_was_false"
#' y
#' # > "it_was_false"
#' @export
`?` <- function(lhs, rhs) {
  lexpr <- substitute(lhs, environment())
  rexpr <- substitute(rhs, environment())
  # We listify `lexpr` to inspect the syntax tree
  # If it is an assignment, we evluate the conditional (3rd list element)
  lhs_tree <- as.list(lexpr)
  if (is_assignment(lhs_tree)) {
    lhs <- eval(lhs_tree[[3]])
  }

  # We split the rhs on ":" and parse the values either side
  # TODO: use RE to separate only on colon between values
  rhss <- sapply(
    strsplit(deparse(rexpr), ":"),
    function(e) parse(text = e)
  )

  # If `lhs` is scalar, and `rhs` values are vector `ifelse` will only return
  # the first elements of the value vectors. If given a scalar condition, we
  # want to be able to return the entire value.
  if (length(lhs) > 1) {
    r <- ifelse(lhs, eval(rhss[[1]]), eval(rhss[2]))
  } else {
    r <- eval(rhss[[2 - as.numeric(lhs)]])
  }

  # If `lhs` was assignment we replace the condition with the result `r` in the
  # original lhs syntax tree, and call in the parent environment
  if (is_assignment(lhs_tree)) {
    lhs_tree[[3]] <- r
    eval.parent(as.call(lhs_tree))
  } else {
    # otherwise we return the result
    r
  }
}
