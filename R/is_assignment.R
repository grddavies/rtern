#' Check if an expression is an assignment
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Takes an expression that has been cast to a list and returns true if using
#' left-assignment with either `<-` or `=`
#'
#' @param parse_tree An un-evaluated expression as a list
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
