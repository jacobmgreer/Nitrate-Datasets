# Wikidata SPARQL queries pulling film-related data

Currently, this repo uses Github Actions or manually run scripts to pull and manipulate various film-related data point from Wikidata.

These datasets help inform my film-related projects.

## Main SPARQL-based datasets

### Film-related Alternate IDs

- Turner Classic Movie (TCM) property (P3056)
- Letterbox property (P6127)
- IMDb property (P345)
- Film Affinity proeprty (P480)
- EIDR (P2704)

### Film-Related Companies

- Companies listed using an IMDb company constant "co-"
- EIDR Party (P12142)

### Film-Related Profession Data

- Actor, Film Actor, and Film Director AKAS (skos:altLabel)
- Actor, Film Actor, and Film Director sex or gender (P21)
- People listed using an IMDb people constant "nm-"

### Film Awards and Events

- FilmFreeway (P6762)
- International Submissions to the Academy Awards dataset
- Events listed using an IMDb event constant "ev-"
- Individual event listings using an IMDb event constant "ev-" and a year "/2022"
