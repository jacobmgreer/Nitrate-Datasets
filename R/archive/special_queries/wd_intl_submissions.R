required <- c("tidyverse", "magrittr", "httr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

### SPARQL Query: International Submissions to AMPAS
# https://w.wiki/A7vZ
query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_intl_submissions.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "output/special_queries/json/wd_international_submissions.json",
  quiet = FALSE)

wd_intl_submissions <- 
  jsonlite::fromJSON("output/special_queries/json/wd_international_submissions.json")$results$bindings %>%
  reframe(
    QID = basename(film$value),
    filmLabel = basename(filmLabel$value),
    submissionTitle = submission_title$value,
    year = year$value,
    countryQID = basename(country$value),
    countryLabel = countryLabel$value,
    ceremonyQID = basename(ceremony$value),
    ceremonyLabel = ceremonyLabel$value,
    imdb = imdb$value,
    letterboxd = letterboxd$value,
    eidr = eidr$value
  ) %T>%
  write.csv(., "output/special_queries/wd_international_submissions.csv", row.names = FALSE)

rm(required, query)

