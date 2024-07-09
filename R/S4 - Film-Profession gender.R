tryCatch({
  ## Actor Genders
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_actor_gender.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_actor_gender.json")

  ## Film Actor Genders
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/actors/wd_people_filmactor_gender.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_filmactor_gender.json")

  ### SPARQL Query: People with Profession: Director (wdt:P106 wd:Q2526255)
  # https://w.wiki/AT6c
  query <- URLencode(str_squish(str_replace_all(read_file("SPARQL/directors/wd_people_director_gender.sparql"), "[\r\n]" , " ")))
  download.file(
    url = paste0("https://query.wikidata.org/sparql?query=", query, "&format=json"),
    destfile = "json/wd_people_director_gender.json")

  ## Gender datasets
  
  wd_people_actors_gender <- 
    jsonlite::fromJSON("json/wd_people_actor_gender.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      gender = genderLabel$value, 
      profession = "actor")
  
  wd_people_director_gender <- 
    jsonlite::fromJSON("json/wd_people_director_gender.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      gender = genderLabel$value,
      profession = "director")
  
  wd_people_filmactors_gender <- 
    jsonlite::fromJSON("json/wd_people_filmactor_gender.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      gender = genderLabel$value,
      profession = "actor")
  
  wd_filmprof_genders <-
    bind_rows(wd_people_actors_gender, wd_people_filmactors_gender) %>%
    bind_rows(wd_people_director_gender) %>%
    filter(!grepl("^http://www.wikidata.org/.well-known", gender)) %>%
    distinct()
  
  wd_filmprof_gender_sum <-
    wd_filmprof_genders %>%
    group_by(profession, gender) %>%
    summarize(n = n_distinct(QID)) %>%
    pivot_wider(names_from = profession, values_from = n) %>%
    arrange(desc(actor))
  
  # write_csv(wd_filmprof_gender_sum, "datasets/people/wd_film_profession_gender_summary.csv")
  saveRDS(
    wd_filmprof_gender_sum, 
    file = "datasets/people/wd_film_profession_gender_summary.rds"
  )
  
  wd_film_profession_gender_match <-
    wd_filmprof_genders %>%
    group_by(QID) %>%
    summarize(
      wd_gendern = n_distinct(gender),
      wd_gender = paste(unique(gender), collapse = " | ")) %>%
    reframe(
      QID, 
      wd_gendern,
      wd_gender, 
      wd_gender_match = case_when(
        wd_gender == "male" ~ "male",
        wd_gender == "female" ~ "female",
        TRUE ~ "non-binary"
      )) %>%
    arrange(desc(wd_gendern))
}, error = function(err){})

