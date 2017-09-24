# Final Project - Getting and Cleaning Data.

<small>ps.: Please note that English is not my main Language</small>

The following script will download data collected from accelerometers from the Samsung Galaxy 8 Smartphone. 
It'll then add the necessary information, such as activity and info, to the main dataset.
It'll keep only the columns that reflects Mean and Standard Deviation.
The final data will be a tidy and readeable merge of the datasets that represent the Test and traning, with readeable column names and desctiptive variable names where it applies.
Finally, the last bit of code creates an independent tidy data with the average of each variable by activity and subject.


For the project, the following instructions where followed:

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.