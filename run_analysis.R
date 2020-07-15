## Script for Getting and Cleaning Data Course Project

## 1) Merges the training and test sets to create one data set
## 2) Extracts only the measurements on the mean and standard deviation for
##      each measurement
## 3) Uses descriptive activity names to name the activites in the data set
## 4) Appropriately labels the data set with descriptive variable names
## 5) From the data set in 4), creates a second, indepedent tidy data set
##      with the average of each variable for each acitvity and each subject

library(dplyr)

## Downloading the dataset

filename <- "CleaningDataProject.zip"

## Checking if file already exists
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method = "curl")
}

## Checking if file has been unzipped
if (!file.exists("UCI HAR Dataset")) {
        unzip(filename)
}

## Create the data tables

features <- read.table("UCI HAR Dataset/features.txt", 
                        col.names = c("n", "functions"))        ## 561 x 2
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                        col.names = c("code", "activity"))      ## 6 x 2
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                        col.names = "subject")                  ## 2947 x 1
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                        col.names = features$functions)         ## 2947 x 561
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", 
                        col.names = "code")                     ## 2947 x 1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                        col.names = "subject")                  ## 7352 x 1
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                        col.names = features$functions)         ## 7352 x 561
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt",
                        col.names = "code")                     ## 7352 x 1


