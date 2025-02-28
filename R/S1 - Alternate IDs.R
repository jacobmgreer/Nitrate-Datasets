tryCatch({
  ### SPARQL Query all P345 // IMDb Property
  # https://w.wiki/A7vP
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_imdb.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_imdb.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query P4985 // TMDb Person
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/person/TMDBperson.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_tmdb_person.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query P4947 // TMDb Movie
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_tmdb.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_tmdb_movie.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query // EIDR Property P2704
  # https://w.wiki/A7v4
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_eidr.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_eidr.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query, Film Affinity property P480
  # https://w.wiki/A7v6 
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_filmaffinity.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_filmaffinity.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query: Letterboxd P6127
  # https://w.wiki/A7uv 
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_letterboxd.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_letterboxd.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query, TCM Property P3056
  # https://w.wiki/A7uz
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/films/alternate IDs/wd_tcm.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_tcm.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query, EIDR Party id P12142
  # https://w.wiki/A7vD
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/companies/wd_eidrparty.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_eidrparty.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query, Film Freeway property P6762
  # https://w.wiki/A7vA 
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/events/wd_filmfreeway.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_filmfreeway.json")
}, error = function(err){})

tryCatch({
  ### SPARQL Query, TMDb Company ID P11806
  # https://w.wiki/DEfo
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/companies/wd_tmdbparty.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_tmdb_companies.json")
}, error = function(err){})
