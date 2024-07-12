library(utils)
library(readr)
library(jsonlite)
library(stringr)
library(dplyr)
library(tidyr)
options(timeout = 10*60)

dir.create(file.path("json"), showWarnings = FALSE)

source("R/S1 - Alternate IDs.R")
source("R/S2 - IMDb datasets.R")
source("R/S3 - AltID datasets.R")

source("R/S4 - Film-Profession gender.R")
source("R/S5 - Film-Profession AKAS.R")
source("R/S6 - Pull Film Lists.R")

unlink("json", recursive = TRUE, force = TRUE)