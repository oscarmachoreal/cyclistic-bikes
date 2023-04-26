# Cyclistic Bike-Share Data Analysis

![](banner_chicago.png)

## Introduction
Bike-sharing programs have gained significant popularity in recent years due to their potential to offer an affordable, environmentally-friendly, and convenient transportation option for urban commuters. However, with this rapid growth comes the challenge of navigating speedy success and ensuring sustainable growth.

The goal of this project is to maximize the number of annual memberships. The project will identify how casual riders and annual members use Cyclistic bikes differently. After identifying the differences, the project will outline the major findings and recommendations based on the analysis. Each recommendation must be backed up with compelling data insights and professional data visualizations. The final deliverable will recommend the 3 most effective recommendations for growing the number of annual memberships. 

## Problem Statement

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, Ms. Lily Moreno (Cyclistic's Director of Marketing) believes that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to
do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why
casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are
interested in analyzing the Cyclistic historical bike trip data to identify trends.

So I will produce a report with the following deliverables:
1. A clear statement of the business task
2. A description of all data sources used
3. Documentation of any cleaning or manipulation of data
4. A summary of the analysis
5. Supporting visualizations and key findings
6. My top three recommendations based on the analysis

## Business Task
Analyze historical trips data from the past 12 months to identify trends and discover connections between the bike usage among annual members and casual riders.


## Skills Demonstrated
The following R features were incorporated:
- Data Wrangling
- Statistical Analysis
- Visualization
- Report Generation

## Data Sourcing
[Source of Data](https://divvy-tripdata.s3.amazonaws.com/index.html)

This is public data that you can use to explore how different customer types are using Cyclistic bikes. 

Note that data-privacy issues prohibit us from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

The data is reliable since it is being provided by Motivate Internation Inc. for this analysis. Also, the given dataset is original and comprehensive.

CSV files with trip data collected from April 01, 2019 to March 31, 2020 provided by Motivate Internation Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).

## Data Transformation/Cleaning:
Data was efficiently cleaned and transformed using the **tydiverse** and **lubridate** packages in R.
Some of the applied steps included:

- Stack individual dataframes into one big data frame
- Remove latitude and longitude related variables
- Add columns that list the date, month, day and year of each ride
- Add a 'ride_length' calculation in seconds and convert from factor to numeric
- Remove data on bikes quality check rides done by HQ

## Modeling
I have decided to use a single dataframe rather than a normalized model. This decision was based on the fact that a single dataframe can provide a more comprehensive view of the data, as all the relevant information is contained in one table. With a single dataframe, I can easily manipulate and analyze the data using a variety of tools and techniques, such as filtering, grouping, and aggregating. 

Additionally, using a single dataframe allows me to more easily identify and correct any data quality issues that may arise, as I can quickly locate and fix any errors within the same table. While a star schema may provide some benefits in terms of data organization and query performance, for this particular analysis, I believe that a single dataframe is the most appropriate and efficient approach.

## Analysis and Visualizations
![](average_duration.png)

![](number_of_rides.png)
 
## Conclusions & Recommendations
The average ride time of casual members is significantly higher than the average ride time of regular members. Additionally, the number of rides on weekends by casual members is equal to the number of rides of regular members. Given that the company's objective is to grow the number of regular members, I have some recommendations.

Firstly, it's important to understand the differences in behavior between casual and regular members. Casual members tend to use the service for longer periods, while regular members are more likely to use it for shorter, more frequent trips. Therefore, the company could consider offering incentives or promotions that encourage regular members to take longer rides, such as discounts for longer trips.

Secondly, since the number of rides on weekends by casual members is equal to the number of rides of regular members, the company could target casual members on weekends with promotions that incentivize them to become regular members. For example, the company could offer a weekend-only promotion that rewards casual members with a free month of membership if they use the service a certain number of times on weekends.

Thirdly, the company could use data analysis to identify common trip patterns among regular members and use this information to create targeted marketing campaigns that encourage casual members to become regular members. For example, if data analysis shows that regular members tend to use the service for commuting to work or school, the company could create a campaign that targets casual members who live or work in areas with a high concentration of regular members.

Overall, it's important for the bike-sharing company to understand the behavior and needs of its customers in order to create targeted campaigns that encourage casual members to become regular members. By offering incentives for longer rides, targeting casual members on weekends, and creating targeted marketing campaigns, the company can increase the number of regular members and improve its overall revenue.
