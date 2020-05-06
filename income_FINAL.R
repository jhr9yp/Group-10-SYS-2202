# this code was written by Alice Warner

library(DBI)
library(RMySQL)
library(ggplot2)
library(dplyr)

income = read.csv2("household-median-income-2017.csv", sep=",")
income = as.data.frame(income)
income_clean = mutate(income, income_2015 = X2015*1000, income_2016 = X2016*1000) %>% 
  select(State, income_2015, income_2016) %>% filter(income_2015 != "NA")


#removing all non-states
income_clean <- income_clean %>% filter(State != "United States")
View(income_clean)

# finding the percent change between the years and rounding
income_clean <- income_clean %>%
  arrange(State, .by_group = TRUE) %>%
  mutate(pct_change = ((income_2016-income_2015)/income_2015)*100)
income_clean$pct_change <- round(income_clean$pct_change,digits=5)

#finding the average income between 2015 and 2016
#income_clean$income2015 = as.numeric(income_clean$income2015)
#income_clean$income2016 = as.numeric(income_clean$income2016)
income_clean$incomeAvg <- rowMeans(income_clean[c('income_2015', 'income_2016')], na.rm=TRUE, dims = 1)

#renaming columns
names(income_clean) <- c("Location", "Avg Income (2015)", "Avg Income (2016)", "Income Rate Change", "Average Income")

View(income_clean)



