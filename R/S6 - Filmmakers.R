query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_filmmaking.sparql"), "[\r\n]" , " ")))
download.file(
  url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
  destfile = "json/wd_people_filmmaking.json")

wd_filmmakers <- 
  jsonlite::fromJSON("json/wd_people_filmmaking.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    updated = date$value)

saveRDS(wd_filmmakers, file = "datasets/people/wd_filmmakers.rds")