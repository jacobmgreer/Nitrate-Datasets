required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)
rm(required)

### SPARQL Query: People with Profession: Director (wdt:P106 wd:Q2526255)
# https://w.wiki/AQDJ
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_people_director_AKAS.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "~/Documents/GitHub/Nitrate-Datasets/output/special_queries/json/wd_people_director_AKAS.json",
  quiet = FALSE)
rm(query)

wd_people_directors_AKAS <- 
  jsonlite::fromJSON("~/Documents/GitHub/Nitrate-Datasets/output/special_queries/json/wd_people_director_AKAS.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    name = itemLabel$value,
    imdb_nconst = imdb$value,
    aka = altLabel_list$value
  ) %T>%
  write.csv(., "~/Documents/GitHub/Nitrate-Datasets/output/special_queries/wd_people_director_AKAS.csv", row.names = FALSE)
