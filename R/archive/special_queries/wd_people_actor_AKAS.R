required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)
rm(required)

### SPARQL Query: People with Profession: Actor (wdt:P106 wd:Q33999) or related profession
# https://w.wiki/AVJH
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_AKAS.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_AKAS.json",
  quiet = FALSE)
rm(query)

### Actor Labels
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_itemLabel.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_itemLabel.json",
  quiet = FALSE)
rm(query)

### Film Actor Labels
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_filmactor_itemLabel.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_filmactor_itemLabel.json",
  quiet = FALSE)
rm(query)

## Actor Genders
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_gender.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_gender.json",
  quiet = FALSE)
rm(query)

## Film Actor Genders
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_filmactor_gender.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_filmactor_gender.json",
  quiet = FALSE)
rm(query)

## Actors Labels
wd_people_actors_label <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_itemLabel.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    label = label_lexical$value
  ) %>%
  distinct()

## Film Actors Labels
wd_people_filmactors_label <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_filmactor_itemLabel.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    label = label_lexical$value
  ) %>%
  distinct()

## Actor AKAS
wd_people_actors_AKAS <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_AKAS.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    label = altLabel$value
  ) %>%
  distinct() 

## Actors Gender
wd_people_actors_gender <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_actor_gender.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    gender = genderLabel$value
  ) %>%
  distinct() 


## Film Actors Gender
wd_people_filmactors_gender <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/actors/json/wd_people_filmactor_gender.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    gender = genderLabel$value
  ) %>%
  distinct() 

wd_actors_gender <-
  bind_rows(wd_people_actors_gender, wd_people_filmactors_gender) %>%
  filter(!grepl("^http://www.wikidata.org/.well-known", gender)) %>%
  distinct()

wd_actors_gender_sum <-
  wd_actors_gender %>%
  dplyr::count(gender) %T>%
  write.csv(., "~/Documents/GitHub/Nitrate-Datasets/output/actors/wd_people_actors_gender_summary.csv", row.names = FALSE)

wd_actors_gender_match <-
  wd_actors_gender %>%
  group_by(QID) %>%
  summarize(wd_gender = paste(unique(gender), collapse = " | ")) %>%
  reframe(
    QID, 
    wd_gender, 
    wd_gender_match = case_when(
      wd_gender == "male" ~ "male",
      wd_gender == "female" ~ "female",
      TRUE ~ "non-binary"
    ))

wd_actors <-
  bind_rows(wd_people_actors_AKAS, wd_people_actors_label) %>%
  bind_rows(wd_people_filmactors_label) %>%
  distinct() %>%
  group_by(QID) %>%
  summarize(
    akas = paste(unique(label), collapse = " || ")
  ) %>%
  left_join(wd_actors_gender_match, by = "QID") %>%
  left_join(read_csv("datasets/people/wd_imdb_people.csv"), by = "QID") %>%
  group_by(QID) %>%
    mutate(P345_dupe = ifelse(length(unique(imdb)) > 1, "multiple nconst", NA)) %>%
  ungroup() %>%
  group_by(imdb) %>%
    mutate(record_dupe = ifelse(!is.na(imdb) & length(unique(QID)) > 1, "multiple records", NA)) %>%
  ungroup() %T>%
  write.csv(., "~/Documents/GitHub/Nitrate-Datasets/output/actors/wd_people_actors.csv", row.names = FALSE)

rm(wd_actors_gender, wd_actors_gender_match)
rm(wd_people_actors_AKAS, wd_people_actors_label, wd_people_actors_gender)
rm(wd_people_filmactors_gender, wd_people_filmactors_label)
