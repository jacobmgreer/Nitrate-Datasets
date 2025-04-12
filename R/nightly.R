lapply(
  c("utils", "readr", "stringr", "jsonlite", "dplyr", "tidyr", "arrow"), 
  require, character.only = TRUE)
options(timeout = 10*60)

source("R/redo-1.R")
source("R/redo-2.R")
source("R/redo-3.R")
source("R/redo-4.R")
source("R/redo-5.R")

unlink("json", recursive = TRUE, force = TRUE)