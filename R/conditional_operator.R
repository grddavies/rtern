#' Conditional (Ternary) Operator
#'
#' Who has time for if/else?
#'
#' @usage lhs ? rhs
#'
#' @param lhs A logical expression  or logical vector.
#' @param rhs Two values separated by a colon (`:`).
#' @return One of the values in `rhs`, depending on truthiness of `lhs`.
#' @examples
#' # Conditional evaluation
#' 4 > 3 ? "it_was_true" : "it_was_false"
#' #> "it_was_true"
#'
#' FALSE ? "it_was_true" : "it_was_false"
#' #> "it_was_false"
#'
#' # Vectorised evaluation
#' c(4, 2) < 3 ? "it_was_true" : "it_was_false"
#' #> "it_was_false" "it_was_true"
#'
#' # Conditional assignment
#' x <- 4 > 3 ? "it_was_true" : "it_was_false"
#' x
#' #> "it_was_true"
#'
#' y = 3 > 4 ? "it_was_true" : "it_was_false"
#' y
#' #> "it_was_false"
#' @export
`?` <- function(lhs, rhs) {
  lexpr <- substitute(lhs, environment())
  rexpr <- substitute(rhs, environment())
  lhs_tree <- as.list(lexpr)

  if (is_assignment(lhs_tree)) {
    lhs <- eval(lhs_tree[[3]])
  }

  rhss <- sapply(
    strsplit(deparse(rexpr), ":"),
    function(e) parse(text = e)
  )

  if (length(lhs) > 1) {
    r <- sapply(lhs, function(x) {
      eval(rhss[[2 - as.numeric(x)]])
    })
  } else {
    r <- eval(rhss[[2 - as.numeric(lhs)]])
  }

  if (is_assignment(lhs_tree)) {
    lhs_tree[[3]] <- r
    eval.parent(as.call(lhs_tree))
  } else {
    r
  }
}
