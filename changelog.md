# Changelog
This file contains the notable changes to the project

Version 1.0.0 (03-25-2023) 
## New 
- Added columns based on “date” column (“month”, “day”, “year”, “day_of_week”) 
- Added “ride_length” calculation in seconds

## Changes 
- Removed latitude and longitude related columns (“start_lat”, “start_lng”, “end_lat”, “end_lng”)
- Converted “ride_length” from factor to numeric to run calculations on data
- Removed data from bikes quality checks

## Fixes 
- Fixed “date” column type into date
