  # To install Packages  for analysis
install.packages("tidyverse") # opinionated collection of R packages designed for data science
library(tidyverse)


library(lubridate)

install.packages("ggplot2")   #for data visualization
library(ggplot2)            

install.packages("dplyr")   # a structure of data manipulation that help resolve the most frequent data
library("dplyr")


  


#library(str)             #for structure of the dataset

#For this project I will be loading 4 csv files out of the 19 sheets for my analysis
daily_activity <- read.csv("C:/Desktop/Analytics Certificate/Course 8/dailyActivity_merged.csv")
daily_steps <- read.csv("C:/Desktop/Analytics Certificate/Course 8/dailySteps_merged.csv")
weight_log_info <- read.csv("C:/Desktop/Analytics Certificate/Course 8/weightLogInfo_merged.csv")
daily_sleep <- read.csv("C:/Desktop/Analytics Certificate/Course 8/sleepDay_merged.csv")


# To display the structure of each columns in daily activity 
str(daily_activity)

# To display the columns and first serveral rows in daily activity datset.
head(daily_activity)

# To display the column name of daily_activity dataframe
colnames(daily_activity)

# columns of the dataset and display some portion of the data with respect to each attribute
library(tidyverse)

glimpse(daily_activity)



# To display the summary of each columns in daily steps
str(daily_steps)

# To display the columns and first serveral rows in daily daily steps.
head(daily_steps)

# To display the column name 
colnames(daily_steps)

# columns of the dataset and display some portion of the data with respect to each attribute
glimpse(daily_steps)


# To display the structure of each columns in daily weight log info
str(weight_log_info)

# To display the columns and first serveral rows in daily weight log info.
head(weight_log_info)

# To display the column name 
colnames(weight_log_info)

# columns of the dataset and display some portion of the data with respect to each attribute
glimpse(weight_log_info)

# To display the structure of each columns in daily sleep
str(daily_sleep)

# To display the columns and first serveral rows in daily daily sleep.
head(daily_sleep)

# To display the column name 
colnames(daily_sleep)

# columns of the dataset and display some portion of the data with respect to each attribute
glimpse(daily_sleep)

# Cleaning and Formatting

# To check for error and inconsistency in the 3 tables that will be used for thea analysis
length(unique(daily_activity$Id))   # for daily_activity


length(unique(daily_sleep$Id))     # for daily_sleep

length(unique(weight_log_info$Id))    # for weight_log_info

length(unique(daily_steps$Id))     # For daily Steps


# To check for duplicates in daily activity
sum(duplicated(daily_activity))
# No duplicate value

# To check for duplicates in daily steps
sum(duplicated(daily_steps))
# No duplicate value

sum(duplicated(daily_sleep)) # check for duplicate in daily sleep
# Found 3 duplicate values in daily_sleep table.


# To remove the 3 duplicate  vslues found in daily sleep and rename the dataframe

new_daily_sleep <-daily_sleep[!(duplicated(daily_sleep) | duplicated(daily_sleep, fromLast = TRUE)), ]
sum(duplicated(new_daily_sleep))
# No duplicate value

# The "duplicated" function  test to see if a line appears at least for the second time starting at line one. 
#If the argument fromLast = TRUE is used, the function starts at the last line.
#Boths boolean results are combined with | (logical 'or') into a new vector which indicates all lines appearing more than once. 
#The result of this is negated using ! thereby creating a boolean vector indicating lines appearing only once.



# check for duplicate in weight log info
sum(duplicated(weight_log_info))
# No duplicate value

# To check for missing values 
any(is.na(daily_activity)) # check for missing values in daily activity dataframe

any(is.na(new_daily_sleep)) # check for missing values in new daily sleep dataframe

any(is.na(daily_steps)) # check for missing values in daily steps dataframe

any(is.na(weight_log_info)) # check for missing values in weight log info dataframe


# To remove NA column in weight log info 
library("dplyr")   
new_weight_log_info <- select(weight_log_info, -Fat) # The "-" tell the select function that the column fat should be drop from the dataframe
head(new_weight_log_info)


any(is.na(new_weight_log_info)) # check for missing values in daily activity dataframe
# No more missing value

# I noticed the date column in the dataframes are store in character form, so it need to be converted to datetime type
# The 4 dataset for this analysis  have the same column named Id 





# To check the number of distinct Id in daily_activity, daily_sleep and weight _log_info data frames
n_distinct(daily_activity$Id)

n_distinct(daily_sleep$Id)

n_distinct(new_weight_log_info$Id)

n_distinct(daily_steps$Id)
#daily_activity and daily_steps have the same number of observations


# To check the number of observation in the dataframes

nrow(daily_activity)

nrow(daily_sleep)

nrow(new_weight_log_info)

nrow(daily_steps)
#There are 940 records in daily_activity data, 413 in daily_sleep, 67 in weight_log_info and 940 records in daily_steps


# To create month, date and weekday columns  into activity_date, weight_log_info and daily_sleep columns

# daily activity 
# Convert the char ActivityDate column to Date format
daily_activity$Date <- as.Date(daily_activity$ActivityDate,"%m/%d/%Y")
daily_activity$Date

# To create the month column using the conversion date dataframe
daily_activity$Month <- format(daily_activity$Date,"%B")
daily_activity$Month


# To create the weekday  column using the conversation date dataframe
daily_activity$WeekDay <- format(daily_activity$Date,"%A")
daily_activity$WeekDay




# new daily sleep 
# Convert the char SleepDay column to Date format
new_daily_sleep$Date <- as.Date(new_daily_sleep$SleepDay,"%m/%d/%Y")
daily_sleep$Date

# To create the month column using the conversion date dataframe
new_daily_sleep$Month <- format(new_daily_sleep$Date,"%B")
new_daily_sleep$Month


# To create the weekday  column using the conversation date dataframe
new_daily_sleep$Weekday <- format(new_daily_sleep$Date,"%A")
new_daily_sleep$Weekday 


# weight_log_info
# Convert the char Date column to Date format
new_weight_log_info$New_Date <- as.Date(weight_log_info$Date,"%m/%d/%Y")
new_weight_log_info$New_Date

# To create the month column using the conversion date dataframe
new_weight_log_info$Month<- format(new_weight_log_info$New_Date,"%B")
new_weight_log_info$Month


# To create the weekday  column using the conversation date dataframe
new_weight_log_info$WeekDay <- format(new_weight_log_info$New_Date,"%A")
new_weight_log_info$WeekDay


# To summarize the data in order to getnsights about the data.

#daily_activity %>%  select(TotalSteps,TotalDistance,SedentaryMinutes,VeryActiveMinutes) %>% summary()


#weight_log_info %>%  select(WeightKg,BMI) %>% summary()

#daily_sleep %>%  select(TotalSleepRecords,TotalMinutesAsleep,TotalTimeInBed) %>%summary()



# To interpret my statistical findings
#1. DAILY ACTIVITY

#Summary of daily_activity
summary(daily_activity)

#The average mean count of daily_activity daily is 7638 and a total distance of 5.490km
# Average mean  of active minutes daily is 21.16;
#Average mean of Sedentary minuts daily is 991.2'
#The average calories consumed daily is 2304 kCal
#the average totalsteps is 7638   OR 

mean(daily_activity$TotalSteps) # the mean of toal steps per day for daily activity dataframe is 7637.911

# since their is no demographic variables to classify how many steps is considered to be active to determine the type
#of user we have. I will be using the the article titled "How many steps a day is considered active"
#by Medical Author: Pallavi Suyog Uttekar, MD and reviewed on 7/15/2021 by Shaziya Allarakha, MD (https://www.medicinenet.com/how_many_steps_a_day_is_considered_active/article.htm).
# to classify the users.
#Sedentary: Less than 5,000 steps per day
#Low active: about 5,000 to 7,499 steps daily
#Somewhat active: about 7,500 to 9,999 steps daily
#Active: More than 10,000 steps daily
#Highly active: More than 12,500 steps daily

#To create a new table called usertype, we first calculate the daily_steps_average per user

daily_step_average <- daily_activity %>% 
  group_by(Id) %>% 
  summarise (mean_daily_steps = mean(TotalSteps))

head(daily_step_average)

# create the new table called usertype and classify the user based on the daily step average

User_Type  <-daily_step_average %>%
  mutate(User_Type = case_when(
    mean_daily_steps< 5000 ~"Sedentary",mean_daily_steps >= 5000 & mean_daily_steps < 7499 ~ "Low Active",
    mean_daily_steps >= 7500 & mean_daily_steps < 9999 ~ "Somewhat Active",  mean_daily_steps >= 10000 ~ "Active",
    mean_daily_steps > 12500 ~ "Highly Active"))

head(User_Type)

# create the percentage of each user type     

User_Type_percent<- User_Type %>%
  group_by(User_Type) %>%
  summarise(Total= n()) %>%
  mutate(labels =scales::percent(Total / sum(Total))) %>% 
  arrange(desc(labels))

head(User_Type_percent)

# Plot the graph of each user type

ggplot (data= User_Type_percent, aes(x=User_Type, y=labels))+
  geom_col()+labs(x="User Type",y="Total %",title="User Type Distribution by Mean of Daily Steps")
# From the histrogram graph, Low Active (27.3%) and Somewhat Active(27.3%)  are relatively distributed among the user. 




# 2. WEIGHT LOG INFO

#Summary of weight_log_info
summary(new_weight_log_info)

#The average weightkg is 72.04kg
#Average BMI is 25.19

# 3. DAILY SLEEP

#Summary of daily_sleep
summary(new_daily_sleep)

#The mean total minutes  asleep is 418.9
# The average total time in bed is 458.3 minutes


#4. DAILY STEPS

#Summary of daily_steps
summary(daily_steps)

#The average steptotal is 7638 steps



# EXPLORATIONs



# To calculate the most active days of the week 
# using the totalsteps by weekday
# 1. Order the day of the week
daily_activity$WeekDay <- ordered(daily_activity$WeekDay,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))


ggplot(data = daily_activity, aes(x= WeekDay, y = TotalSteps))+
  geom_col(fill="purple") + labs(x="WeekDay",y="TotalSteps",title = "Week Day by Total Steps")
# User use FitBit fitness tracker application to track thier totalsteps  mostly Tuesday, Wednesday , Thursday.This behaviour can be term as a result of users using  the tracker to tack to track thierq daily activities.



# using the VeryActiveMinutes by weekday
#2.  Order the day of the week
daily_activity$WeekDay <- ordered(daily_activity$WeekDay,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))


ggplot(data = daily_activity, aes(x= WeekDay, y = VeryActiveMinutes))+
  geom_col(fill="blue") + labs(x="WeekDay",y="VeryActiveMinutes",title = "Week Day by Very Active Minutes")

# using the Calories by weekday
# 3. Order the day of the week
daily_activity$WeekDay <- ordered(daily_activity$WeekDay,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))


ggplot(data = daily_activity)+ geom_col(aes(x= WeekDay, y = Calories),fill= "orange")+
  labs(x="WeekDay",y="Calories",title = "Week Day by Calories")
# User use FitBit fitness tracker application to track thier calories and Tuesday, Wednesday , Thursday have the hightest caloires burned.



# 1. for Daily activity (Relation between Total Steps and SedentaryMinutes)
ggplot (data= daily_activity, aes(x=TotalSteps, y=SedentaryMinutes,color= Calories))+
  geom_point()+ labs(x="Total Steps",y="Sedentary Minutes",title="Total Steps by Sedentary Minutes")

# From the scatter graph, there is a negative relationship between total steps and sedentary miutes because people do not move when they are not physically active

# 2. for Daily activity (To find if there is a relation between Total Steps by calories and colour of the line can be controlled using colour aesthetic
ggplot(data=daily_activity, aes(x=TotalSteps, y = Calories))+ geom_point() + stat_smooth(method=lm, fill="blue", colour="darkblue", size=1)+
  labs(x="Total Steps",y="Calories",title="Total Steps by Calories")

# From the plotted scatter graph, thereis a positivecorrelation between the totalsteps and calories people that took the most total steps burn the most calories i.e the higher the steps the more calories user burn. 



#3.  To find if there is a relation between sleep and time in bed?
ggplot(data= new_daily_sleep, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + geom_point() + stat_smooth(method = lm,  fill="blue", colour="darkblue", size=1)+
  labs(x="Total Minutes Asleep",y="Total Time In Bed",title="Total Minutes Asleep by Total Time In Bed")

# From the scater graph, we noticed a strong positive correlation between TotalMinutesAsleep and TotalTimeInBed also  we observed some outliers in  the middle and top of the scatter plot.
#we can say the outliers are the people who spend lot of time in bed but did not actually sleep  due to diffrent reasons To improve the sleep hours, a beep on the bellet time watch should be use to prepare user to sleep.




#4.  To find if there is Relationship between  active minutes  and calories

ggplot(data=daily_activity,aes(x = VeryActiveMinutes, y = Calories, color = Calories)) + geom_point() + stat_smooth(method = lm,  fill="orange", colour="darkorange", size=1)+
labs(x="Very Active Minutes",y="Calories",title = "Very Active Minutes by Calories Burned")

# From the graph, there is a strong correlation between very active minutes and calories burned with some outliers at bottom left and top left of the plot.





#No of days user use tracker in a week 
# Order the day of the week
#daily_activity$WeekDay <- ordered(daily_activity$WeekDay,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))

#ggplot(data=daily_activity) + geom_bar(mapping = aes(x=WeekDay),fill="blue") +
 # labs(x="WeekDay",y="Count",title="No. of times users used tracker across week")
# User use FitBit fitness tracker application to track thier activity  mostly Tuesday, Wednesday , Thursday.This behaviour can be term as a result of user being busy on week those days and uses the tracker to tack their daily activities.


# To plot daily sleep per week day

# Order the day of the week
new_daily_sleep$Weekday <- ordered(new_daily_sleep$Weekday,levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))


ggplot(data = new_daily_sleep, aes(x= Weekday, y = TotalMinutesAsleep))+
  geom_col() + labs(x="Weekday",y="Total Minutes Asleep",title = "Total Minutes Asleep By Week Day")
# User sleep most on wednesday, and Tuesday  while the least sleep day is on Monday.

#To analyze the relationship of weight data, merge dailyactivity and new weight log info dataframes

weight_daily_activity <- merge(daily_activity,new_weight_log_info, by = "Id")
head(weight_daily_activity)

summary(weight_daily_activity)


# To plot the relationship between veryactiveminutes and weightin kg

ggplot(data=weight_daily_activity) + geom_violin(mapping=aes(x=VeryActiveMinutes, y=WeightKg), fill = "blue") +
labs(title="Violin plot", subtitle="User Weight by Very Active Minutes", x="Very Active Minutes", y="Weight in Kg")


#From the violin plot, the median weight is 63.

#Most users have a weight that is between 61 and 85, but some users have weight that are low as 53 and as high as 134. From the plot we can see outlier weight to be 134.



# CONCLUSION AND RECOMMENDATION
# From my analysis carried out and using the business questions:


# The average total steps per day is 7638 which is below the 10,000 recommended steps per day which is termed the gold standards for adults.
# So the app should track users who do not meet the 10,000 recommended steps per day and send a reminder to to encourage them  

# People tend to be more active on on Tuesday, Wednesday and Thursday so they tend to use their app on week days maybe because they spend more time outside compare to weekends
# Most users weight in Kg is between 61 - 84.

#Since Bellabeat focus is on young and adult women empowerment and the data lack information on women Gender and Age
#therefore there is need for more data on young and adult female gender, and age  in order to meet  bellabeat mission. 

#Bellabeat marketing team can encourage users by educating them  the benefits of the fitness, recommend the types of exercises users can partake in, calories intake and burn rate information on Bellabeat application.
#The Bellabeat application  should always send reminder during weekends to encourage users to excerise regularly.
#The Bellabeat app should create a reward system such that users who meet their dail steps goals would earn points which can be converted to discount for bellabeat memembership  at the end of every year 