required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)
rm(required)

### SPARQL Query: People with Profession: Director (wdt:P106 wd:Q2526255)
# https://w.wiki/AT6c
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_people_director_gender.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/special_queries/json/wd_people_director_gender.json",
  quiet = FALSE)
rm(query)

wd_people_director_gender <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/special_queries/json/wd_people_director_gender.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    label = itemLabel$value,
    imdb_nconst = imdb$value,
    gender = genderLabel$value
  ) %T>%
  write.csv(., "~/Documents/GitHub/Nitrate-Datasets/output/special_queries/wd_people_director_gender.csv", row.names = FALSE)

wd_dir_genders <-
  wd_people_director_gender %>%
  dplyr::group_by(QID, imdb_nconst, label) %>%
  summarize(
    gender_count = n_distinct(gender),
    genders = paste(unique(gender), collapse = " || ")) %>%
  filter(gender_count > 1) %>%
  reframe(QID, label, genders)

wd_dir_female <-
  wd_people_director_gender %>%
  filter(gender == "female")

wd_dir_nonbinary <-
  wd_people_director_gender %>%
  filter(!gender %in% c("female", "male"))
