required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: Language List
# https://w.wiki/A7vW
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_lang_list.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_wikidata_language_list.json",
  quiet = FALSE)

wd_lang_list <- 
  jsonlite::fromJSON( "output/special_queries/json/wd_wikidata_language_list.json")$results$bindings %>%
  reframe(
    lang_QID = basename(item$value),
    language = wdlabelen$value,
    code = c$value
  ) %T>%
  write.csv(., "output/special_queries/wd_wikidata_language_list.csv", row.names = FALSE)

rm(required, query)

