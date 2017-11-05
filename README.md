# Getting-and-cleaning-data-Project-Coursera
Getting and cleaning data - Week4_final project
Assignment:
You should create one R script called run_analysis.R that does the following. 

1.	Merges the training and the test sets to create one data set. See object: “test_train_set”.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. See object: “test_train_mean_std”
3.	Uses descriptive activity names to name the activities in the data set. See object: “test_train_set”.
4.	Appropriately labels the data set with descriptive variable names. See object: “test_train_set”.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. See object: “Average_test_train”

The following steps are followed in the run_analysis.R script :

1)	create folder for data if it doesn’t exists and download data to "./data/datafilesproject.zip",
2)	unzip data file: a folder named “UCI HAR Dataset” is created in "./data”
3)	read and assemble test data set (“testDataSet”)
-add column names to x_test (requirement #4: Appropriately labels the data set with descriptive variable names)
-bind subject_test, y_test (after adding activity labels as required in step 3) and x_test. 
4)	read and assemble test data set (“trainDataSet”)
-add column names to x_train (requirement #4: Appropriately labels the data set with descriptive variable names)
-bind subject_train, y_train (after adding activity labels as required in step 3) and x_train. 
5)	Merge test and train data sets (requirement 1 assignment): “test_train_set”
6)	Extract only the measurements on the mean and standard deviation for each measurement (Requirement 2): “test_train_mean_std”
7)	Create a second, independent tidy data set with the average of each variable for each activity and each subject (Requirement 5): “Average_test_train”
8)	Write a text with the required data sets in the working directory: "Average_test_train.txt"
