# Descrption this module

## Source data
The data was provided in a zip file by Coursera available on the following link 
  [UCI HAR Dataset]
  (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Preparation
Nessary to use `require(dplyr)` or `library(dplyr)` . Please you can download this `install.packages("dplyr")` 
or `install.packages("tidyverse")`. If you have problem it's may be from 'RCPP' library.

## Process 
- Trying to download archive
- Unziping archive
- Reading files
- Merging the data sets to creating one data set
- Extracting only the mean and standard deviation for each measurement
- Renaming and hanling missunderstanding characters
- Creating tidy sets of the average of each variable for each activity and each subject.
- Creating`tidy.txt` file.
