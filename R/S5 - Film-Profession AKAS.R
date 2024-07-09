tryCatch({
  ### SPARQL Query: People with Profession: Actor (wdt:P106 wd:Q33999) or related profession
  # https://w.wiki/AVJH
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_AKAS.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_actor_AKAS.json")
  
  ### Actor Labels
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_itemLabel.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_actor_itemLabel.json")
  
  ### Film Actor Labels
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_filmactor_itemLabel.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_filmactor_itemLabel.json")
  
  ### Film director AKAS
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/directors/wd_people_director_AKAS.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_director_AKAS.json")
  
  wd_people_directors_AKAS <- 
    jsonlite::fromJSON("json/wd_people_director_AKAS.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      label = altLabel_list$value
    )
  
  wd_people_directors_label <- 
    jsonlite::fromJSON("json/wd_people_director_AKAS.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      label = itemLabel$value)
  
  ## Actors Labels
  wd_people_actors_label <- 
    jsonlite::fromJSON("json/wd_people_actor_itemLabel.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      label = label_lexical$value)
  
  ## Film Actors Labels
  wd_people_filmactors_label <- 
    jsonlite::fromJSON("json/wd_people_filmactor_itemLabel.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      label = label_lexical$value)
  
  ## Actor AKAS
  wd_people_actors_AKAS <- 
    jsonlite::fromJSON("json/wd_people_actor_AKAS.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      label = altLabel$value
    )
  
  wd_imdb_people <- readRDS("datasets/people/wd_imdb_people.rds")
  
  wd_film_profession_AKAS <-
    bind_rows(wd_people_actors_AKAS, wd_people_actors_label) %>%
    bind_rows(wd_people_filmactors_label) %>%
    bind_rows(wd_people_directors_AKAS) %>%
    bind_rows(wd_people_directors_label) %>%
    distinct() %>%
    group_by(QID) %>%
    summarize(
      akas = paste(unique(na.omit(label)), collapse = " || ")
    ) %>%
    left_join(wd_film_profession_gender_match, by = "QID") %>%
    left_join(wd_imdb_people, by = "QID") %>%
    group_by(QID) %>%
      mutate(P345_dupe = ifelse(length(unique(imdb)) > 1, "multiple nconst", NA)) %>%
    ungroup() %>%
    group_by(imdb) %>%
      mutate(record_dupe = ifelse(!is.na(imdb) & length(unique(QID)) > 1, "multiple records", NA)) %>%
    ungroup() %>%
    filter(!is.na(akas)) %>%
    separate_longer_delim(akas, delim = " || ") %>%
    distinct()
  
  saveRDS(
    wd_film_profession_AKAS, 
    file = "datasets/people/wd_film_profession_AKAS.rds"
  )
}, error = function(err){})
