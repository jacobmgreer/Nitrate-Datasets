required <- c("tidyverse", "magrittr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)

current <- 
  read_csv("~/Documents/GitHub/Nitrate-Actions/ratings/formatted.csv") %>%
  rename(
    tconst = Const,
    IMDbTitle = Title,
    IMDbYear = Year,
    IMDbRuntime = Runtime,
    IMDbType = Title.Type
  ) %>%
  select(-c(Your.Rating,Date.Rated,IMDb.Rating,Num.Votes)) %>%
  filter(!IMDbType %in% c("tvEpisode", "tvMiniSeries", "tvSeries")) %>%
  left_join(wd_imdb_films, by=c("tconst" = "imdb")) %>%
  left_join(wd_letterboxd, by="QID", relationship = "many-to-many") %>%
  left_join(wd_eidr, by="QID", relationship = "many-to-many") %>%
  arrange(desc(IMDbYear), IMDbTitle)

current_missing_lb <-
  current %>%
  filter(is.na(letterboxd))

current_missing_qid <-
  current %>%
  filter(is.na(QID))

current_missing_eidr <-
  current %>%
  filter(is.na(eidr))

current_dupes_qid <-
  current %>%
  dplyr::count(tconst) %>%
  filter(n > 1)

rm(required)
