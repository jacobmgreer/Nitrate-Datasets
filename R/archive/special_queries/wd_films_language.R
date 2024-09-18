required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: Films with Language Property, P364
# https://w.wiki/A7vm
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_films_language.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_films_with_language.json",
  quiet = FALSE)

wd_films_language <- 
  jsonlite::fromJSON("output/special_queries/json/wd_films_with_language.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    lang = basename(lang$value),
    langLabel = langLabel$value
  ) %T>%
  write.csv(., "output/special_queries/wd_films_with_language.csv", row.names = FALSE)

rm(required, query)

