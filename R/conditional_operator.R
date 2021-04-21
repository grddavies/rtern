#' Conditional (Ternary) Operator
#'
#' Who has time for if/else?
#'
#' @usage lhs ? rhs
#'
#' @param lhs A logical expression, vector or matrix.
#' @param rhs A pair of values separated by a colon (`:`).
#' @return One of the values in `rhs`, depending on the truthiness of `lhs`.
#'
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

  # If no rhs passed, call help on lhs to restore the natural behaviour of `?`
  if (missing(rexpr)) return(help(as.character(lexpr)))
  else if (rexpr[[1]] != as.name(":")) stop("RHS WRONG")

  # If lexpr an assignment, we evaluate the conditional (3rd element)
  lhs_tree <- as.list(lexpr)
  if (is_assignment(lhs_tree)) lhs <- eval(lexpr[[3]])

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
    lexpr[[3]] <- r
    eval.parent(lexpr)
  } else {
    # otherwise we return the result
    r
  }
}
