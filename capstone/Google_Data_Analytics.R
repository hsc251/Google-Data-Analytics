# Package Loading
library(tidyverse)
library(lubridate)
library(ggplot2)
library(stats)
library(dplyr)

# Load csv file into individual data frame
Oct_2020 <- read_csv("202010-divvy-tripdata.csv")
Nov_2020 <- read_csv("202011-divvy-tripdata.csv")
Dec_2020 <- read_csv("202012-divvy-tripdata.csv")
Jan_2021 <- read_csv("202101-divvy-tripdata.csv")
Feb_2021 <- read_csv("202102-divvy-tripdata.csv")
Mar_2021 <- read_csv("202103-divvy-tripdata.csv")
Apr_2021 <- read_csv("202104-divvy-tripdata.csv")
May_2021 <- read_csv("202105-divvy-tripdata.csv")
Jun_2021 <- read_csv("202106-divvy-tripdata.csv")
Jul_2021 <- read_csv("202107-divvy-tripdata.csv")
Aug_2021 <- read_csv("202108-divvy-tripdata.csv")
Sep_2021 <- read_csv("202109-divvy-tripdata.csv")
Oct_2021 <- read_csv("202110-divvy-tripdata.csv")

# Verify column names at each data frame
colnames(Oct_2020)
colnames(Nov_2020)
colnames(Dec_2020)
colnames(Jan_2021)
colnames(Feb_2021)
colnames(Mar_2021)
colnames(Apr_2021)
colnames(May_2021)
colnames(Jun_2021)
colnames(Jul_2021)
colnames(Aug_2021)
colnames(Sep_2021)
colnames(Oct_2021)

## Verify the Structure of each data frame
str(Oct_2020)
str(Nov_2020)
str(Dec_2020)
str(Jan_2021)
str(Feb_2021)
str(Mar_2021)
str(Apr_2021)
str(May_2021)
str(Jun_2021)
str(Jul_2021)
str(Aug_2021)
str(Sep_2021)
str(Oct_2021)

# Rename the conflicted variables as character variables
Oct_2020 <- mutate(Oct_2020, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Nov_2020 <- mutate(Nov_2020, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Dec_2020 <- mutate(Dec_2020, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Jan_2021 <- mutate(Jan_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Feb_2021 <- mutate(Feb_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Mar_2021 <- mutate(Mar_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Apr_2021 <- mutate(Apr_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
May_2021 <- mutate(May_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Jun_2021 <- mutate(Jun_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Jul_2021 <- mutate(Jul_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Aug_2021 <- mutate(Aug_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Sep_2021 <- mutate(Sep_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))
Oct_2021 <- mutate(Oct_2021, ride_id = as.character(ride_id), rideable_type = as.character(rideable_type), start_station_id = as.character(start_station_id),end_station_id = as.character(end_station_id))

# Stack all data as one data frame
alltrips <- bind_rows(Oct_2020, Nov_2020, Dec_2020, Jan_2021, Feb_2021, Mar_2021, Apr_2021, May_2021, Jun_2021, Jul_2021, Aug_2021, Sep_2021, Oct_2021)

# Remove unnecessary columns for the data extracts
alltrips <- alltrips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))

## Inspect the dimension of data
colnames(alltrips)
nrow(alltrips)
dim(alltrips)
head(alltrips)
tail(alltrips)
str(alltrips)
summary(alltrips)

## Use re-code to rename the membership mode
alltrips <- alltrips %>%
  mutate(member_casual = recode(member_casual,"Subscriber" = "member", "Customer" = "casual"))

table(alltrips$member_casual)

## Convert POSI Dates as date format
alltrips$date <- as.Date(alltrips$started_at)
alltrips$month <- format(as.Date(alltrips$date), "%m")
alltrips$day <- format(as.Date(alltrips$date), "%d")
alltrips$year <- format(as.Date(alltrips$date), "%Y")
alltrips$day_of_week <- format(as.Date(alltrips$date), "%A")

## Calculate Ride Length
alltrips$ride_length <- difftime(alltrips$ended_at, alltrips$started_at)

## Recheck Updated Structure
str(alltrips)

## Convert ride length from factor to numeric for calculation
is.factor(alltrips$ride_length)
alltrips$ride_length <- as.numeric(as.character(alltrips$ride_length))

## Verify the character type is numeric
is.numeric(alltrips$ride_length)

## Remove Bad Data from either incomplete ride length (less than 0) or taken out of docks.
alltrips_v2 <- alltrips[!(alltrips$start_station_name == "HQ QR" | alltrips$ride_length < 0), ]

## Remove the NA values to get a more precise data summary
alltrips_v3 <- na.omit(alltrips_v2)

## Order the weekdays as the typical weekday sequence
alltrips_v3$day_of_week <- ordered(alltrips_v3$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

## Summarize the data based on the customer type
customer_summary <- alltrips_v3 %>%
  group_by(member_casual) %>%
  summarize(avg_length = mean(ride_length), median_length = median(ride_length), max_length = max(ride_length), min_length = min(ride_length))

## Summarize the data based on the combination of weekdays and customer type
weekday_summary <- alltrips_v3 %>%
  group_by(day_of_week, member_casual) %>%  
  summarize(avg_length = mean(ride_length), median_length = median(ride_length), max_length = max(ride_length), min_length = min(ride_length))

## Data Wrangling for the summaries within weekdays and number of rides
alltrips_v3 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)
geom_col(position = "dodge")

## Plot weekday's ride count by membership type
alltrips_v3 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + 
  ggtitle("E-Bike Memebrship Type's Ride Count Summary") +
  labs (x = "Weekdays", y = "# of Rides")
ggsave("ride_count.jpg", width = 2000, height = 1000, units = c("px"))

##  Plot weekday's average duration
alltrips_v3 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  ggtitle("E-Bike Memebrship Type's Ride Duration Average") +
  labs (x = "Weekdays", y = "Ride Duration (seconds)")
ggsave("ridetime_avg.jpg", width = 2000, height = 1000, units = c("px"))