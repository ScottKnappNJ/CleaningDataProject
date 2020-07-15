# CleaningDataProject

## Getting and Cleaning Data Class Project

This repository is a class submission by Scott Knapp for Getting and Cleaning 
course project.  It has the information needed to run the analysis on
the Activity Recognition data setf from Smart Labs.

### Dataset 

Can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Files for analysis

**Codebook.md** - a code book that lays out the data, variable and any work 
        performed to tidy the data.
        
**run_analysis.R** - runs the data set-up and the 5 steps outlined in the 
        course project:
        
        * Merges the training and test sets to create one data set
        * Extracts only the measurements on the mean and standard deviation for
              each measurement
        * Uses descriptive activity names to name the activities in the data set
        * Appropriately labels the data set with descriptive variable names
        * From the data set in 4), create a second, independent tidy data set
        * with the average of each variable for each activity and each subject

**tidydata.txt** - final tidy data exported to a .txt file for submission
