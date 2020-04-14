library(DBI)
library(RMySQL)
library(ggplot2)
library(ggmap)
library(maptools)
library(maps)
library(lubridate)
library(dplyr) # def need
library(stringr)
library(stringi)

df = read.csv("C:\\Users\\student\\Desktop\\original_weight_data.csv")


#see how many null values

summary(df$Age.years.)
summary(df$Race.Ethnicity)

# slice the dataframe into the columns and rows we want to analayze
# before c should have tbe year we are using 2015-2016

df2 = df[,c(1,3,11,19)]
df_2015 = df2[(35174:48772),]
df_2016 = df2[(48773:53392),]
df_avg = df2[(35174:53392),]

# Give empty cells NA value

df_2015[df_2015 == ""] <- NA
df_2016[df_2016 == ""] <- NA
df_avg[df_avg == ""] <- NA


# Delete any row that contains an NA value

df_2015 <- na.omit(df_2015)
df_2016 <- na.omit(df_2016)
df_avg <- na.omit(df_avg)


df_2015<- aggregate(df_2015$Data_Value, by = list(df_2015$Age.years.), mean)
df_2016<- aggregate(df_2016$Data_Value, by = list(df_2016$Age.years.), mean)
df_avg<- aggregate(df_avg$Data_Value, by = list(df_avg$Age.years.), mean)


# plot

ggplot(data = df_2015) +
  geom_point(mapping = aes(x = Group.1, y = x)) +
  labs(x = "Age Group", y = "Obesity Level", title = "2015 Obesity and Age Relationship")+
  theme(
    axis.title.x = element_text(size = 14, face = "bold.italic"),
    axis.title.y = element_text(size = 14, face = "bold.italic"),
    title = element_text(size = 20, face = "bold")
  ) 
ggplot(data = df_2016) +
  geom_point(mapping = aes(x = Group.1, y = x)) +
  labs(x = "Age Group", y = "Obesity Level", title = "2016 Obesity and Age Relationship")+
  theme(
    axis.title.x = element_text(size = 14, face = "bold.italic"),
    axis.title.y = element_text(size = 14, face = "bold.italic"),
    title = element_text(size = 20, face = "bold")
  ) 
ggplot(data = df_avg) +
  geom_point(mapping = aes(x = Group.1, y = x)) +
  labs(x = "Age Group", y = "Obesity Level", title = "2015-2016 Obesity and Age Relationship")+
  theme(
    axis.title.x = element_text(size = 14, face = "bold.italic"),
    axis.title.y = element_text(size = 14, face = "bold.italic"),
    title = element_text(size = 20, face = "bold")
  ) 


             

