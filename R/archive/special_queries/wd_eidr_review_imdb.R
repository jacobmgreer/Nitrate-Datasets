required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query EIDR properties with/without associated IMDb properties
# https://w.wiki/ABBD
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_eidr_review_imdb.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_eidr_review_imdb.json",
  quiet = FALSE)

wd_eidr_review_imdb <- 
  jsonlite::fromJSON("output/special_queries/json/wd_eidr_review_imdb.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    wdEIDR = eidr$value,
    wdIMDb = imdb$value
  ) %T>%
  write.csv(., "output/special_queries/wd_eidr_review_imdb.csv", row.names = FALSE)

rm(required, query)
