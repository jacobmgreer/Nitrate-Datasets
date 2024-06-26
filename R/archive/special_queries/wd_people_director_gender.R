

wd_dir_genders <-
  wd_people_director_gender %>%
  dplyr::group_by(QID, imdb_nconst, label) %>%
  summarize(
    gender_count = n_distinct(gender),
    genders = paste(unique(gender), collapse = " || ")) %>%
  filter(gender_count > 1) %>%
  reframe(QID, label, genders)

wd_dir_female <-
  wd_people_director_gender %>%
  filter(gender == "female")

wd_dir_nonbinary <-
  wd_people_director_gender %>%
  filter(!gender %in% c("female", "male"))
