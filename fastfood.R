library(readr)
library(maps)
library(ggplot2)
library(dplyr)

#upload data as a csv file
df_food = read_csv("C:\\Users\\student\\Desktop\\FastFoodRestaurants.csv")

#using only the province and fast food name columns
location <- df_food$province
name <- df_food$name

#Creating a new data table with just the two columns
food_clean <- data.frame(location, name)

#removing Co Spgs as a state
food_clean <- food_clean %>% filter(location != "Co Spgs")

#omitting empty rows
food_clean <- na.omit(food_clean)

#counting number of fast food restaurants and grouping by state
food_clean <- count(food_clean, vars = location)

#updating data table to new variables
location <- food_clean$vars
f_count <- food_clean$n
food_clean <- data.frame(location, f_count)

View(food_clean)
