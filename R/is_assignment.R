#' Check if an expression is an assignment
#'
#' @param parse_tree An unevaluated expression as a list
#' @return A logical
#' @keywords internal
is_assignment <- function(parse_tree) {
  any(
    vapply(c("<-", "="),
           function(x) {
             as.name(x) == parse_tree[[1]]
           },
           FUN.VALUE = logical(1)
    )
  )
}
