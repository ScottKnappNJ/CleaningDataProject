## Script for Getting and Cleaning Data Course Project

## 1) Merges the training and test sets to create one data set
## 2) Extracts only the measurements on the mean and standard deviation for
##      each measurement
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names
## 5) From the data set in 4), create a second, independent tidy data set
##      with the average of each variable for each activity and each subject

library(dplyr)

## Download the data

print("retrieving data")

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

print("creating data tables")

features <- read.table("UCI HAR Dataset/features.txt", 
                        col.names = c("n", "variables"))        ## 561 x 2
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                        col.names = c("code", "activity"))      ## 6 x 2
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                        col.names = "subject")                  ## 2947 x 1
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                        col.names = features$variables)         ## 2947 x 561
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", 
                        col.names = "code")                     ## 2947 x 1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                        col.names = "subject")                  ## 7352 x 1
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                        col.names = features$variables)         ## 7352 x 561
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt",
                        col.names = "code")                     ## 7352 x 1

print("tidying up the data")

## 1) Merges the training and test sets to create one data set

x_total <- rbind(x_train, x_test)                               ## 10,299 x 561
y_total <- rbind(y_train, y_test)                               ## 10,299 x 1
subject_total <- rbind(subject_train, subject_test)             ## 10,299 x 1
data_total <- cbind(subject_total, y_total, x_total)            ## 10,299 x 563


## 2) Extracts only the measurements on the mean and standard deviation for
##      each measurement

col_data <- colnames(data_total)
col_extract <- sort(c(grep("mean", col_data), grep("std", col_data)))
## returns the position of any column headers with mean or std in the name

subset_data <- data_total %>% select(subject, code, col_extract)


## 3) Uses descriptive activity names to name the activities in the data set

subset_data$code <- gsub(1, "Walking", subset_data$code)
subset_data$code <- gsub(2, "Walking_Upstairs", subset_data$code)
subset_data$code <- gsub(3, "Walking_Downstairs", subset_data$code)
subset_data$code <- gsub(4, "Sitting", subset_data$code)
subset_data$code <- gsub(5, "Standing", subset_data$code)
subset_data$code <- gsub(6, "Laying", subset_data$code)
##  Note to self; need to find a more elegant solution involving 'activities'


## 4) Appropriately labels the data set with descriptive variable names

col_data2 <- colnames(subset_data)
## extract column name to make changes to

col_data2[2] <- "activity"
col_data2 <- gsub("^t","Time", col_data2)
col_data2 <- gsub("^f","Frequency", col_data2)
col_data2 <- gsub("Acc","Acceleraion", col_data2)
col_data2 <- gsub("Gyro","Gyroscope", col_data2)
col_data2 <- gsub("Mag","Magnitude", col_data2)
col_data2 <- gsub("Freq","Frequency", col_data2)

colnames(subset_data) <- col_data2
## rename columns in data set to match the changes made


## 5) From the data set in 4), create a second, independent tidy data set
##      with the average of each variable for each activity and each subject

tidy_data <- subset_data %>% 
                group_by(subject, activity) %>%
                summarize_all(mean)
write.table(tidy_data, "tidydata.txt", row.name = FALSE)

print("tidydata.txt created")