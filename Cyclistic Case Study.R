---
title: "Cyclistic Case Study"
author: "Oscar"
date: "2023-03-24"
output: html_document
---

# **CYCLISTIC CASE STUDY ANALYSIS**

This analysis is based on the Divyy case study "'Sophisticated, Clear, and Polished’: Divvy and Data Visualization" written by Kevin Hartman (found here: https://artscience.blog/home/divvy-dataviz-case-study). The purpose of this script is to consolidate downloaded Divvy data into a single dataframe and then conduct simple analysis to help answer the key question: “In what ways do members and casual riders use Divvy bikes differently?”

#### Install required packages:
```{r setup}
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(tidyverse)
library(lubridate)
library(ggplot2)
```

# **Step 1: Collect Data**
### Load Cyclistic datasets (csv files)
```{r message=FALSE}
x202203_cyclistic_tripdata <- read_csv("cyclistic/csv files/202203-cyclistic-tripdata.csv")
x202204_cyclistic_tripdata <- read_csv("cyclistic/csv files/202204-cyclistic-tripdata.csv")
x202205_cyclistic_tripdata <- read_csv("cyclistic/csv files/202205-cyclistic-tripdata.csv")
x202206_cyclistic_tripdata <- read_csv("cyclistic/csv files/202206-cyclistic-tripdata.csv")
x202207_cyclistic_tripdata <- read_csv("cyclistic/csv files/202207-cyclistic-tripdata.csv")
x202208_cyclistic_tripdata <- read_csv("cyclistic/csv files/202208-cyclistic-tripdata.csv")
x202209_cyclistic_tripdata <- read_csv("cyclistic/csv files/202209-cyclistic-tripdata.csv")
x202210_cyclistic_tripdata <- read_csv("cyclistic/csv files/202210-cyclistic-tripdata.csv")
x202211_cyclistic_tripdata <- read_csv("cyclistic/csv files/202211-cyclistic-tripdata.csv")
x202212_cyclistic_tripdata <- read_csv("cyclistic/csv files/202212-cyclistic-tripdata.csv")
x202301_cyclistic_tripdata <- read_csv("cyclistic/csv files/202301-cyclistic-tripdata.csv")
x202302_cyclistic_tripdata <- read_csv("cyclistic/csv files/202302-cyclistic-tripdata.csv")
```

# **Step 2: Wrangle Data and Combine into a Single File**
## Compare column names for each file
#### While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
```{r}
colnames(x202203_cyclistic_tripdata)
colnames(x202204_cyclistic_tripdata)
colnames(x202205_cyclistic_tripdata)
colnames(x202206_cyclistic_tripdata)
colnames(x202207_cyclistic_tripdata)
colnames(x202208_cyclistic_tripdata)
colnames(x202209_cyclistic_tripdata)
colnames(x202210_cyclistic_tripdata)
colnames(x202211_cyclistic_tripdata)
colnames(x202212_cyclistic_tripdata)
colnames(x202301_cyclistic_tripdata)
colnames(x202302_cyclistic_tripdata)
```

## Stack individual data frames into one big data frame
```{r}
all_trips <- bind_rows(x202203_cyclistic_tripdata, x202204_cyclistic_tripdata, x202205_cyclistic_tripdata, x202206_cyclistic_tripdata, x202207_cyclistic_tripdata, x202208_cyclistic_tripdata, x202209_cyclistic_tripdata, x202210_cyclistic_tripdata, x202211_cyclistic_tripdata, x202212_cyclistic_tripdata, x202301_cyclistic_tripdata, x202301_cyclistic_tripdata)
```

## Inspect the dataframe and look for incongruencies
```{r}
str(all_trips)
```
## Remove latitude and longitude related variables
```{r}
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng))
```

# **Step 3: Clean Up and Add Data to Prepare for Analysis**
## Inspect the new table that has been created
```{r}
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame.
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data.
```

### There are a few problems we will need to fix:
#### (1) The data can only be aggregated at the ride-level, which is too granular. We will want to add some additional columns of data such as day, month and year, that provide additional opportunities to aggregate the data.
#### (2) We will want to add a calculated field for length of ride. We will add "ride_length" to the entire dataframe for consistency.
#### (3) There are some rides where tripduration shows up as negative, including several hundred rides where Cyclistic took bikes out of circulation for Quality Control reasons. We will want to delete these rides.

## Add columns that list the date, month, day, and year of each ride
#### This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
```{r}
all_trips$date <- as.Date(all_trips$started_at) #The default format is yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")
```

## Add a "ride_length" calculation to all_trips (in seconds)
```{r}
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)
```

## Inspect the structure of the columns
```{r}
str(all_trips)
```

## Convert "ride_length" from factor to numeric so we can run calculations on the data
```{r}
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)
```

## Remove "bad" data
#### The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy where ride_length was negative
#### We will create a new version of the dataframe (v2) since data is being removed
```{r}
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]
```

# **Step 4: Conduct Descriptive Analysis**
## Descriptive analysis on ride_length (all figures in seconds)
```{r}
mean(all_trips_v2$ride_length, na.rm=TRUE) #straight average (total ride length / rides)
median(all_trips_v2$ride_length, na.rm=TRUE) #midpoint number in the ascending array of ride lengths
max(all_trips_v2$ride_length, na.rm=TRUE) #longest ride
min(all_trips_v2$ride_length, na.rm=TRUE) #shortest ride
```

## Condense the lines above to one line using summary()
```{r}
summary(all_trips_v2$ride_length, na.rm=TRUE)
```

## Compare members and casual users ride length
```{r}
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)
```

## See the average ride time by each day for members vs casual users
```{r}
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
```


## Analyze ridership data by type and weekday
```{r}
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
  ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts
```

## Visualize the number of rides by rider type
```{r}
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")
```

## Create a visualization for average duration
```{r message=FALSE, warning=FALSE}
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")
```

# **Step 5: Export Summary File for Further Analysis**
## Create a csv file that we will visualize in Excel, Tableau, or any presentation software
```{r}
counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = 'cyclistic/avg_ride_length.csv')
```
