#' Conditional (Ternary) Operator
#'
#' Who has time for if/else?
#'
#' @param lhs An expression that returns a logical value, or an assignment to an
#'     expression which returns a logical.
#' @param rhs A pair of expressions separated by a colon (`:`).
#'
#' @export
`?` <- function(lhs, rhs) {
  lexpr <- substitute(lhs, environment())
  rexpr <- substitute(rhs, environment())
  lhs_tree <- as.list(lexpr)

  if (is_assignment(lhs_tree)) {
    lexpr <- eval(lhs_tree[[3]])
  }


  r <- eval(sapply(
    strsplit(deparse(rexpr), ":"),
    function(e) parse(text = e)
  )[[2 - as.logical(lhs)]])

  if (is_assignment(lhs_tree)) {
    lhs_tree[[3]] <- r
    eval.parent(as.call(lhs_tree))
  } else {
    r
  }
}
