# Google Data Analytics Capstone Project
Author: Hsin Chih (Colin) Chen </br>

1: Synopsis
-----------

This capstone project is to use the knowledge from Google Data Analytics courses to answer business questions coming from bike-share service while using supporting evidence to persuade stakeholders & executive while the decisions have to be made. </br>

The data set is located in the [dataset link](https://divvy-tripdata.s3.amazonaws.com/index.html) to download.</br>

The description and instruction can be referred from this [documentation link](https://d3c33hcgiwev3.cloudfront.net/aacF81H_TsWnBfNR_x7FIg_36299b28fa0c4a5aba836111daad12f1_DAC8-Case-Study-1.pdf?Expires=1636329600&Signature=fosweeuKEsyIJLTMV5mLDBxvxIPCQ3BeqWSi~VTbRNMdYhvG4gpADXf3LhhkYATpdC3aavxzuc-GQMx5nBwj8YKKlDZkjTmkxn9i76M3Sm7udxs09ptL544LwkUwJv2J7W54T~UMWqpjNtpFFsoKtrcYsI8sgq2SesM5-rC2nCQ_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A). </br>

The published R-Markdown file is in [this link](https://rpubs.com/hsc251/Google_Capstone_Track1)


2: Ask
------------------

### 2.1: Identify the questions

Based on the situation from statistics coming from the data gathered, the following three questions will be addressed for the future marketing program: </br>

1. How do annual members and casual riders use Cyclistic bikes differently? </br>
2. Why would casual riders buy Cyclistic annual memberships? </br>
3. How can Cyclistic use digital media to influence casual riders to become members? </br>

When looking at the 3 questions above, the business deliverable will be impelmented based on the analysis results between casual/members while trying understand the trends behind before giving necessary recommendation. </br>

Throughout this capstone project, all execution will be done with R-Programming for data gathering, data cleaning and summarizing the visuals. </br>

3: Prepare
------------------

### 3.1: Data Preparation.

The analysis period occurred between 2020 October to 2021 October, this 1 year span data will be applied to analyze the trend between casual customers and members. </br>

The data from 2020 October and 2021 October are all stored in different csv files, which can be found in [here](https://divvy-tripdata.s3.amazonaws.com/index.html) </br>

The following code will summarize which R-packages this analysis have applied for </br>

```r
library(tidyverse)
library(lubridate)
library(ggplot2)
library(stats)
library(dplyr)
```
</br>

Once the packages have been loaded, the following command will be applied to load the monthly data while verifying each month's data have the same attribute names. </br>

*Remark: The csv files were pre-downloaded to the working directory, so the loading data will just be directly coming from the file source* </br>

```r
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
```
</br>

After loading the data, it's time to process and clean the data before visualizing them </br>.

4: Process
------------------

### 4.1: Verify Data Structure & Combine all in One

The following command will verify the structure of each month's database, then redefine the nature of each data attribute before combining into the whole year's data frame prior to analysis. </br>

```r
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

## Rename the conflicted variables as character variables
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

## Stack all data as one data frame
alltrips <- bind_rows(Oct_2020, Nov_2020, Dec_2020, Jan_2021, Feb_2021, Mar_2021, Apr_2021, May_2021, Jun_2021, Jul_2021, Aug_2021, Sep_2021, Oct_2021)

## Remove unnecessary columns for the data extracts
alltrips <- alltrips %>%
  select(-c(start_lat, start_lng, end_lat, end_lng))
```
</br>


### 4.2: Data Clean Up and Conversion
After summarizing the 1 year span data as a complete data frame and removed unnecessary columns, this section will clean up the missing datas while converting the necessary dates into the designated formats before visualizing the plotting. </br>

*Remark: The calculated ride length will be consumed in seconds* </br>

```r
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
```
</br>

5: Analyze
------------------

### 5.1: Summarizing the Analysis

The following command will summarize based on either the membership types and associated weekdays for different membership types. </br>

```r
## Order the weekdays structure for confirmation
alltrips_v3$day_of_week <- ordered(alltrips_v3$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

## Summary based on the customer types
customer_summary <- alltrips_v3 %>%
  group_by(member_casual) %>%
  summarize(avg_length = mean(ride_length), median_length = median(ride_length), max_length = max(ride_length), min_length = min(ride_length))

## Summary based on the weekday types while splitting the customer types
weekday_summary <- alltrips_v3 %>%
  group_by(day_of_week, member_casual) %>%  
  summarize(avg_length = mean(ride_length), median_length = median(ride_length), max_length = max(ride_length), min_length = min(ride_length))
```
</br>


### 5.2: Results
The results are as follows by customer type </br>

Customer Type | Avg Ride Length (seconds) | Med Ride Length (seconds) | Max Ride Length (seconds) | Min Ride Length (seconds)
--- | --- | --- | --- | ---
Casual | 1974 | 1016 | 3356649 | 0
Member | 811 | 598 | 573467 | 0
</br>

The results are as follows by casual customers by weekdays </br>
Weekday | Avg Ride Length (seconds) | Med Ride Length (seconds) | Max Ride Length (seconds) | Min Ride Length (seconds)
--- | --- | --- | --- | ---
Sunday | 2282 | 1185 | 3235296 | 0
Monday | 1960 | 1016 | 1900899 | 0
Tuesday | 1763 | 902 | 2335375 | 0
Wednesday | 1710 | 881 | 2337785 | 0
Thursday | 1685 | 864 | 2946429 | 0
Friday | 1889 | 949 | 3341501 | 0
Saturday | 2125 | 1135 | 3356649 | 0
</br>

The results are as follows by member customers by weekdays </br>
Weekday | Avg Ride Length (seconds) | Med Ride Length (seconds) | Max Ride Length (seconds) | Min Ride Length (seconds)
--- | --- | --- | --- | ---
Sunday | 923 | 672 | 89995 | 0
Monday | 777 | 572 | 89993 | 0
Tuesday | 764 | 569 | 89996 | 0
Wednesday | 768 | 575 | 573467 | 0
Thursday | 760 | 569 | 89996 | 0
Friday | 796 | 586 | 542972 | 0
Saturday | 905 | 669 | 89996 | 0
</br>

### 5.3: Visualization
This section will demonstrate how to plot and visualize the findings for the graphs </br>

```r
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
```
</br>

Please refer to the following charts for the visualization: </br>

Number of Rides per Weekday Comparison </br>
![](https://github.com/hsc251/Google_Data_Analytics/blob/main/capstone/ride_count.jpg)

Ride Duration Average per Weekday Comparison </br>
![](https://github.com/hsc251/Google_Data_Analytics/blob/main/capstone/ridetime_avg.jpg)

6: Share
------------------

### 6.1: Summary Pitch

Based on the summaries and visuals, the following conclusions can be made.

1. Members and Casual customers do behave different, one of the biggest significant difference is that the casual rider's average ride duration is significantly greater than the average of the member customers.
2. Members have tendency to ride more frequent during the weekdays, while the casual riders ride more frequent during the weekend by the counts.

After seeing this trend, perhaps the following strategy can be implemented for the casual riders to buy memberships.

1. Have a cheaper rate of charge for the casual riders during the weekdays for them to persuade the change for being a member cyclist.
2. Or use the more you ride, the cheaper you get approach to encourage casual riders for the membership approach so they can pay at a fixed rate. 
