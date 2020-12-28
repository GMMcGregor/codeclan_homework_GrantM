
library(tidyverse)
library(assertr)
library(janitor)

meteorite_landings <- read_csv("weekend_homework/meteorite_landings.csv") %>% 
  clean_names(meteorite_landings) %>% 
   separate(geo_location, c("latitude", "longitude"), 
           sep = ",",convert = TRUE) %>% 
   separate(latitude, c("remove", "latitude"), sep = "\\(")  %>% 
   separate(longitude, c("longitude", "remove_2"), sep = "\\)") %>% 
  
    mutate(latitude, latitude = as.numeric(latitude)) %>% 
    mutate(longitude, longitude = as.numeric(longitude)) %>% 
  
    select(-"remove", -"remove_2") %>% 
  
    mutate(latitude = coalesce(latitude, latitude, na.rm = TRUE)) %>% 
    mutate(longitude = coalesce(longitude, longitude, na.rm = TRUE)) %>% 
  
    filter(mass_g > 1000) %>% 
    arrange(year) %>% 
    names() %>% 

    filter(between(latitude,-90, 90)) %>% 
    filter(between(longitude,-180, 180)) %>% 

write_csv(longitude_latitude_filter, "tidy_meteorite_landings.csv")


#tidy_meteorite_landings <- read_csv("tidy_meteorite_landings.csv")
#tidy_meteorite_landings
