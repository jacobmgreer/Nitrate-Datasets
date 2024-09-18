required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: Films with Origin P495
# https://w.wiki/A7ve 
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_films_origin.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_films_with_origin.json",
  quiet = FALSE)

wd_films_origin <- 
  jsonlite::fromJSON("output/special_queries/json/wd_films_with_origin.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    origin = basename(origin$value),
    originLabel = originLabel$value
  ) %T>%
  write.csv(., "output/special_queries/wd_films_with_origin.csv", row.names = FALSE)

rm(required, query)

