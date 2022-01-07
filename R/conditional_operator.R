#' Succinct conditional evaluation and assignment
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' \code{?} is an in-line if/else operator
#'
#' @details
#' The syntax for ? is as follows:
#'
#' \code{condition ? value_if_true : value_if_false}
#'
#' The condition is evaluated TRUE or FALSE as a Boolean expression.
#' On the basis of the evaluation of the Boolean condition, the entire expression
#' returns `value_if_true` if `condition` is true, but `value_if_false` otherwise.
#' In the case where the condition is a vector/matrix of Boolean values, the
#' function returns a vector/matrix where each element is either `value_if_true`
#' or `value_if_false` based on the truthiness of the elements of the object on
#' the left-hand side. In these cases the behaviour of `?` mimics \link[base]{ifelse}.
#'
#' Who has time for if/else?
#'
#' @usage lhs ? rhs
#'
#' @param lhs A logical expression, vector or matrix.
#' @param rhs A pair of values separated by a colon i.e. `value_if_true : value_if_false`.
#' @return One of the values in `rhs`, depending on the truthiness of `lhs`.
#'
#' @examples
#' # Conditional evaluation
#' 4 > 3 ? "it_was_true":"it_was_false"
#' # > "it_was_true"
#'
#' FALSE ? "it_was_true":"it_was_false"
#' # > "it_was_false"
#'
#' # Vectorised evaluation
#' c(4, 2) < 3 ? "it_was_true":"it_was_false"
#' # > "it_was_false" "it_was_true"
#'
#' # Conditional assignment with `<-`
#' x <- 4 > 3 ? "it_was_true":"it_was_false"
#' x
#' # > "it_was_true"
#'
#' # Conditional assignment with `=`
#' y <- 3 > 4 ? "it_was_true":"it_was_false"
#' y
#' # > "it_was_false"
#'
#' # Chaining `?` statements
#' z <- FALSE ? "true":(FALSE ? "false,true":(TRUE ? "false,false,true":"all false"))
#' z
#' # > "false,false,true"
#' @export
`?` <- function(lhs, rhs) {
  lhs <- rlang::enquo(lhs)
  rhs <- rlang::enquo(rhs)
  lexpr <- rlang::quo_get_expr(lhs)
  lenv <- rlang::quo_get_env(lhs)
  rexpr <- rlang::quo_get_expr(rhs)
  renv <- rlang::quo_get_env(rhs)

  # If no rhs passed, call help on lhs to restore the natural behaviour of `?`
  if (missing(rexpr)) {
    return(utils::help(rlang::as_string(lexpr)))
  } else if (rexpr[[1L]] != rlang::as_name(":")) {
    stop(
      "Colon `:` operator missing from right hand of expression"
    )
  }

  lhs_tree <- as.list(lexpr)
  test <- if (is_assignment(lhs_tree)) {
    # If lexpr an assignment, we evaluate the conditional (3rd element)
    rlang::eval_tidy(lexpr[[3L]], env = lenv)
  } else {
    rlang::eval_tidy(lhs)
  }

  # We extract the arguments to `:` in rhs and use as true/false cases
  case_t <- rlang::as_quosure(rexpr[[2L]], renv)
  case_f <- rlang::as_quosure(rexpr[[3L]], renv)

  # If `lhs` is scalar, and `rhs` values are vector `ifelse` will only return
  # the first elements of the value vectors. If given a scalar condition, we
  # want to be able to return the entire value.
  if (length(test) > 1L) {
    r <- ifelse(test, rlang::eval_tidy(case_t), rlang::eval_tidy(case_f))
  } else {
    r <- if (test) rlang::eval_tidy(case_t) else rlang::eval_tidy(case_f)
  }

  # If `lhs` was assignment we replace the conditions with the result `r` in the
  # lhs syntax tree, and evaluate in the parent environment
  if (is_assignment(lhs_tree)) {
    # FIXME: this only works when wrapping nested calls to ? in brackets
    lexpr[[3]] <- r
    eval.parent(lexpr)
  } else {
    # otherwise we return the result
    r
  }
}
