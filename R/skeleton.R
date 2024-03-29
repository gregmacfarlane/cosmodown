cosmodown_skeleton <- function(path) {
  # copy 'cosmodown_resources' folder to path
  resources <- cosmodown_file("rstudio", "templates", "project", "resources")

  sub_dirs <- list.dirs(resources, recursive = TRUE,  full.names = FALSE)
  sub_dirs <- sub_dirs[-which(sub_dirs == "")]
  sub_dirs <- unique(c(sub_dirs, "data", "figures"))
  files <- list.files(resources, recursive = TRUE, include.dirs = TRUE)

  # ensure directories exists
  new_path <- c(path, file.path(path, sub_dirs))
  fs::dir_create(new_path)

  source <- file.path(resources, files)
  target <- file.path(path, files)
  file.copy(source, target)

  # add book_filename to _bookdown.yml and to the base path name
  f <- file.path(path, "_bookdown.yml")
  x <- read_utf8(f)
  write_utf8(c(sprintf('book_filename: "thesis"'), x), f)

  TRUE
}
