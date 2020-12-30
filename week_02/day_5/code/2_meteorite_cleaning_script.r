
library(tidyverse)
library(assertr)
library(janitor)

meteorite_landings <- read_csv("data/raw_data/meteorite_landings.csv")

clean_names(meteorite_landings) %>% 
  separate(geo_location, c("latitude", "longitude"), sep = ",",convert = TRUE) %>%
  separate(latitude, c("remove", "latitude"), sep = "\\(")  %>% 
  separate(longitude, c("longitude", "remove_2"), sep = "\\)") %>% 
  
  mutate(latitude, latitude = as.numeric(latitude)) %>% 
  mutate(longitude, longitude = as.numeric(longitude)) %>% 
  
  select(-"remove", -"remove_2") %>% 
  
  mutate(latitude = coalesce(latitude, latitude, na.rm = TRUE)) %>% 
  mutate(longitude = coalesce(longitude, longitude, na.rm = TRUE)) %>% 
  
  filter(mass_g > 1000) %>% 
  arrange(year) %>% 
  
  #assertive programming: check for all names
  #names() %>% 
  
  filter(latitude >= -90 & latitude <= 90) %>% 
  filter(longitude >= -180 & longitude <= 180) %>% 
  
  write_csv("data/clean_data/tidy_meteorite_landings.csv")




