library(tidyverse)
library(primer.data)
library(lubridate)
library(dbplyr)
library(janitor)
library(skimr)
library(tibble)
library(rvest)


covid_table <- read_csv("countries-aggregated_csv.csv")

recent_covid <- covid_table %>% 
  select(Date, Country, Confirmed) %>%
  filter(str_detect(Date, pattern = "2021-06-19")) %>% 
  mutate(Country = str_replace(Country, pattern = "US", replacement = "United States"))

write_rds(recent_covid, "recent_covid.rds")


raw_pop <- read_csv("population_by_country_2020.csv")

tidy_pop <- raw_pop %>% 
  select(`Country (or dependency)`, `Population (2020)`) %>% 
  rename(Country = `Country (or dependency)`) %>% 
  rename(Population = `Population (2020)`)

write_csv(tidy_pop, "pop.csv")

gdp_raw <- read_csv("gdp-per-capita-worldbank.csv")

gdp_clean <- gdp_raw %>% 
  rename(Country = Entity) %>% 
  rename(GDP = `GDP per capita, PPP (constant 2011 international $)`) %>% 
  filter(str_detect(Year, pattern = "2017")) %>% 
  drop_na() %>% 
  select(Country, GDP)

write_rds(gdp_clean, "gdp.rds")

pop <- read_csv("pop.csv")

write_rds(pop, "pop.rds")
