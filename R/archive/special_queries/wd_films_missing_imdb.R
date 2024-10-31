required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: Instance of Film without IMDb
# https://w.wiki/A7vo
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_films_missing_imdb.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_films_missing_imdb.json",
  quiet = FALSE)

wd_films_missing_imdb <- 
  jsonlite::fromJSON("output/special_queries/json/wd_films_missing_imdb.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    itemLabel = itemLabel$value,
    itemDescription = itemDescription$value
  ) %T>%
  write.csv(., "output/special_queries/wd_films_missing_imdb.csv", row.names = FALSE)

rm(required, query)
