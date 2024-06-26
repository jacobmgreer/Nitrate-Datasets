required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: Film Directors P57
# https://w.wiki/A7vn
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_films_directors.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_films_with_directors.json",
  quiet = FALSE)

wd_films_directors <- 
  jsonlite::fromJSON("output/special_queries/json/wd_films_with_directors.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    director = basename(value$value),
    directorLabel = valueLabel$value
  ) %T>%
  write.csv(., "output/special_queries/wd_films_with_directors.csv", row.names = FALSE)

rm(required, query)

