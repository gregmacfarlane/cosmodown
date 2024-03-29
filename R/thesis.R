#' Creates an R Markdown PDF Thesis Document
#'
#' This is a function called in output in the YAML of the driver Rmd file
#' to specify using the BYU LaTeX template and cls files.
#'
#'
#' @param toc A Boolean (TRUE or FALSE) specifying where table of contents
#'   should be created
#' @param toc_depth A positive integer
#' @param ... arguments to be passed to [bookdown::pdf_book()]
#'
#' @return A modified `pdf_document` based on the BYU thesis class
#'   template
#' @note The arguments highlight, keep_tex, and pandoc_args, are already set.
#' @examples
#' \dontrun{
#'  output: cosmodown::thesis_pdf
#' }
#' @export
thesis_pdf <- function(toc = TRUE, toc_depth = 3, ...) {
  template <- find_resource("byu", "template.tex")
  base <- bookdown::pdf_book(template = template, toc = toc,
    toc_depth = toc_depth, highlight = "pygments", keep_tex = TRUE,
    pandoc_args = "--top-level-division=chapter", ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$out.width <- "80%"
  base$knitr$opts_knit$root.dir <- getwd()
  base$knitr$opts_knit$echo <- FALSE
  base$knitr$opts_knit$warning <- FALSE
  base$knitr$opts_knit$message <- FALSE
  base$knitr$opts_knit$error <- FALSE
  base$knitr$opts_knit$cache <- FALSE
  base$knitr$opts_knit$fig.ext <- "png"
  base$knitr$opts_knit$fig.path <- "figures/"
  base$knitr$opts_knit$fig.retina <- 3
  # nolint end

  base
}

#' Generate a section for the yaml input
#'
#' @param input a file containing markdown text
#' @param sep a separator for each line.
#'
#' @return a string
#'
#' @export
inc <- function(input, sep = "\n\n  ") {
  readLines(input) %>%
    strsplit(split = " ") %>%
    lapply(FUN = function(x) {
      starting <- gsub("$\\", "\\", x, fixed = TRUE)
      ending <- gsub("\\$$", "\\\\", starting)
      ending <- gsub("\\$\\.$", "\\\\\\.", ending)
      paste(ending, collapse = " ")
    }) %>%
    unlist() %>%
    paste(collapse = sep)
}
