# ### SPARQL Query: Film Directors P57
# # https://w.wiki/A7vn
# query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/special_queries/wd_films_directors.sparql"), "[\r\n]" , " ")))
# download.file(
#   url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
#   destfile = "json/wd_films_with_directors.json")
# 
# wd_films_directors <- 
#   jsonlite::fromJSON("json/wd_films_with_directors.json")$results$bindings %>%
#   reframe(
#     QID = basename(item$value),
#     director = basename(value$value),
#     directorLabel = valueLabel$value)
# write_csv(wd_films_directors, "datasets/film/wd_films_with_directors.csv", row.names = FALSE)
