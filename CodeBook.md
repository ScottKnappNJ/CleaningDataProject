The 'run_analysis.R' script creates a tidy data set as outlined in the 5
steps of the course project.

**1.  Downloading the data**
        
        * Create folder (if needed) to download data - 'UCI HAR Dataset'
        * Download the data to the specified location
        
**2.  Assign each .txt file to a variable for download**
        
        * features <- features.txt (w. columns = n & variables)
        List of all the features
        * activites <- activity_labels.txt (w. columns = code, activity)
        Links the class labels with their activity name
        * subject_test <- subject_test.txt (w. columns = subject)
        Each row identifies the subject who performed the activity.
        * x_test <- X_test.txt (w. columns = variable from features)
        Test set
        * y_test <- Y_test.txt (w. columns = "code")
        Test labels
        * subject_train <- subject_train.txt (w. columns = subject)
        Each row identifies the subject who performed the activity.
        * x_train <- X_train.txt (w. columns = variable from features)
        Train set
        * y_train <- Y_train.txt (w. columns = "code")
        Train labels

**3. Merges the training and test sets to create one data set**

        * x_total is created by merging x_train & x_test using rbind()
        * y_total is created by merging y_train & y_test using rbind()
        * subject_total is created by merging subject_train & subject_text using rbind()
        * data_toal is combined by merging subject_toal, y_total, x_total using cbind()
        
**4. Extracts only the measurements on the mean and standard deviation for each measurement**

        * col_data is created by extracting the column names using colnames()
        * col_extract is a vector of column numbers created by subsetting by "mean" and 
                "std" in the column headings using grep() then sorting the vector
        * subset_data is creating by using select() to choose only columns:
                subject, code & those found in col_extract
                
**5. Uses descriptive activity names to name the activities in the data set**
        
        * subestting out the code column usingg subset_data$code, replace each
                code with the associated activity using gsub()
        * repeat for all numbered codes from 'activities

**6. Appropriately label the data set with descriptive variable names**
        
        * extract the column names into a vector called col_data2 using colnames()
        * replace the "code"" column name with "activty" using col_data[2] <-
        * using gsub() make the following replacement:
                * ^t <- Time
                * ^f <- Frequency
                * Acc <- Acceleration
                * Gyro <- Gyroscope
                * Mag <- Magnitude
                * Freq <- Frequency
                
        * reinsert the col_names vector into the colnames using colnames()
        
**7. From the data set in 4), create a second, independent tidy data set with the average**
        **of each variable for each activity and each subject**
        
        * tidy_data is created by summarizing subset_data by taking the mean through 
                 using summarize_all() after applying grouped_by() for subject and activity
        * Create tidy_data.txt using write.table()
        
