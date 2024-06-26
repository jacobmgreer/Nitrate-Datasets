required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
rm(required)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

R_files = list.files("R/properties", pattern="*.R", full.names = TRUE)
sapply(R_files, source, .GlobalEnv)

R_files = list.files("R/special_queries", pattern="*.R", full.names = TRUE)
sapply(R_files, source, .GlobalEnv)

rm(R_files)
