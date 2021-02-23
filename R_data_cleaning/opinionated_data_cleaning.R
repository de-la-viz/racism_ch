
# Opinionated Data Cleaning:
#   We only keep good data and delete the rest.
#   We group the variables
#   Based on data_exploration.Rmd

library(tidyverse)

data_removals = list() # to store how much data we lose at each cleaning.

## ------- Loading Data ---------


cases <- rio::import("../data/CFR_1995-2019.csv") %>%
  mutate(year = stringr::str_sub(current_case, 1, 4)
  ) %>%
  mutate_if(is.character, list(~na_if(.,""))) # replace empty strings with NAs
glimpse(cases)


## ------- Some Stats ---------

size_before <- dim(cases)[1]


## ------- Cleaning the locations: ---------

# there is one case without location, it is Federal Court.
case_without_location <- cases %>% filter(is.na(location))
# after investigation, I could not find any info to inpute the location...
# -> let's just remove this case as it is a "non-consideration" decision anyway

# one case's location is Suisse, it is the Military Court (Aargau, Basel-Stadt)
case_location_is_CH <- cases %>% filter(location == "Suisse")
# this case happened at the recruit school for grenadiers, which is in Isone in Ticino,
# although, as the case is in German in the database, the accused were probably Swiss germans,
# we will use Tessin as location.

# The 2 military court cases have a cantonal location
military_court_cases_have_a_location <- cases %>% filter(authority == "Tribunal militaire")# %>% View()

# the 4 federal tribunal cases have also a cantonal location (Lucerne, Berne, Genève)...
cases %>% filter(authority == "Tribunal fédéral")# %>% View()

# How to deal with those?
# The authority is most of the time missing, so it could not be used 
# to identify all cases and set there location to"Suisse", for instance.
# in other words:
# When showing/plotting locations, the data will be cantonal and the federal tribunal 
# and military court cases will be included.
# ==> plotting data on a map or just looking at the location might not be so meaningful...

cases <- cases %>% 
  filter(current_case != case_without_location$current_case) %>% # remove non-consideration case without location
  mutate(location = ifelse(current_case == "2007-079N", "Tessin", location))

data_removals <- c(data_removals, 
                   paste0("we removed ", size_before - dim(cases)[1], " (", 
                          round((size_before - dim(cases)[1])/size_before*100, 2), "%) case(s). ",
                          "The new number of cases is ", dim(cases)[1]))
size_before <- dim(cases)[1]


# ------- Removing variable which are mostly empty -----
# those have >60% missing values, we cannot work with them:

perc_missing_values <- cases %>% summarise_all(~sum(is.na(.))/length(.))
# 3 variables have a too large amount of missing values to be used:
print(perc_missing_values$protection_object) # 70% missing
print(perc_missing_values$specific_questions) # 70% missing
print(perc_missing_values$authority) # 76% missing

# thus, we get rid of them, to simplify the dataset:
cases <- cases %>% select(-protection_object, -specific_questions, -authority)
data_removals <- c(data_removals, 
                   paste0("we removed ", size_before - dim(cases)[1], " (", 
                          round((size_before - dim(cases)[1])/size_before*100, 2), "%) case(s). ",
                          "The new number of cases is ", dim(cases)[1]))
size_before <- dim(cases)[1]


# ------- Authors -----

# we do 2 levels of simplification (grouping), of the variable.

cases %>% ggplot(aes(x = authors)) + 
  geom_bar() + coord_flip() + theme_minimal()
# cases$authors %>% unique()

# categories are overlaping.
  # "Jeunes" is not a category that we will keep because it is on a "different level" and overlapping

cases <- cases %>% mutate(authors_complex = # a first simplification
  case_when(
    authors == "Employés du service public; Extrémistes de droite" ~ "Employés du service public",
    authors == "Extrémistes de droite; Jeunes" ~ "Extrémistes de droite",
    authors == "Aucune indication sur l'auteur" ~ "Inconnu",
    authors == "Journalistes / éditeurs; Particuliers" ~ "Journalistes / éditeurs",
    authors == "Acteurs politiques; Particuliers" ~ "Acteurs politiques",
    authors == "Auteurs inconnus" ~ "Inconnu",
    is.na(authors) ~ "Inconnu",
    authors == "Particuliers; Jeunes" ~ "Jeunes",
    authors == "Journalistes / éditeurs; Extrémistes de droite" ~ "Extrémistes de droite", # manually checked, looks more like the latter
    authors == "Particuliers; Extrémistes de droite" ~ "Extrémistes de droite",
    authors == "Acteurs collectifs; Extrémistes de droite" ~ "Extrémistes de droite",
    authors == "Acteurs politiques; Acteurs collectifs" ~ "Acteurs politiques",
    authors == "Particuliers; Aucune indication sur l'auteur" ~ "Particuliers",
    authors == "Acteurs collectifs; Jeunes" ~ "Jeunes",
    authors == "Particuliers; Extrémistes de droite; Jeunes" ~ "Extrémistes de droite",
    authors == "Militaire" ~ "Employés du service public",
    authors == "Acteurs politiques; Particuliers; Extrémistes de droite" ~ "Extrémistes de droite",
    authors == "Acteurs collectifs; Militaire; Particuliers; Jeunes" ~ "Acteurs collectifs",
    authors == "Acteurs collectifs; Auteurs inconnus" ~ "Acteurs collectifs",
    authors == "Acteurs politiques; Employés du service public" ~ "Acteurs politiques",
    TRUE ~ authors
  )
)
cases %>% ggplot(aes(x = authors_complex)) + 
  geom_bar() + coord_flip() + theme_minimal()

cases <- cases %>% mutate(authors_simple = # a second simplification
                            case_when(
                              authors_complex == "Jeunes" ~ "Particuliers",
                              authors_complex == "Acteurs collectifs" ~ "Particuliers",
                              authors_complex == "Extrémistes de droite" ~ "Particuliers",
                              authors_complex == "Journalistes / éditeurs" ~ "Médias, secteur tertiaire",
                              authors_complex == "Acteurs du secteur tertiaire" ~ "Médias, secteur tertiaire",
                              authors_complex == "Employés du service public" ~ "Politique, service public",
                              authors_complex == "Acteurs politiques" ~ "Politique, service public",
                              TRUE ~ authors_complex
                            )
)
cases %>% ggplot(aes(x = authors_simple)) + 
  geom_bar() + coord_flip() + theme_minimal()


print(data_removals)





