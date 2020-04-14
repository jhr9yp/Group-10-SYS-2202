library(DBI)
library(RMySQL)
library(ggplot2)
library(dplyr)


#extracting just state and median household income columns
location <- df_income$State_ab
income <- df_income$Median

#Create a new data frame with 2 columns
income_clean <- data.frame(location, income)

#Omitting rows with null values
income_clean <- na.omit(income_clean)

#remove Puerto Rico and DC as a state
income_clean <- income_clean %>% filter(location != "PR" & location != "DC")

#finding average income by state
income_clean <- aggregate(income_clean$income, by = list(income_clean$location), mean)

View(income_clean)

