# upload libraries 
library(readr)
library(maps)
library(ggplot2)

#upload data as a csv file
df = read_csv("C:\\Users\\student\\Desktop\\FastFoodRestaurants.csv")

# we do not need the websites or keys columns
df$websites <- df$keys <- df$postalCode <- NULL


View(df)






