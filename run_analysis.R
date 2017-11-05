# Getting and cleaning data - Week4_final project
#You should create one R script called run_analysis.R that does the following.
#1.	Merges the training and the test sets to create one data set.
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
#3.	Uses descriptive activity names to name the activities in the data set
#4.	Appropriately labels the data set with descriptive variable names.
#5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#create folder for data
if (!file.exists("data")) {
        dir.create ("data")
}
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/datafilesproject.zip", method = "curl")

unzip("./data/datafilesproject.zip", exdir = "./data")

#packages needed for the program
library(dplyr)
#read files
#features (names for x_test and x_train columns) and activity labels (names for y_train adn y_test)
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#test set
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt",col.names = "activity")
#add columnt names to x_test
colnames(x_test) <- features$V2

#add activity names to test_labels
test_labelswnames <- gsub(6,"LAYING",
                          (gsub(5,"STANDING",
                                (gsub(4,"SITTING",
                                      (gsub(3,"WALKING_DOWNSTAIRS",
                                            (gsub(2,"WALKING_UPSTAIRS",
                                                  (gsub(1,"WALKING",test_labels$activity)))))))))))
#assemble test data set, adding a column to specify "Test" or "Train" data set (included in 3rd column)
testDataSet <- cbind (subject_test, test_labelswnames, x_test, deparse.level = 1) %>% 
        mutate (dataSet = "Test") %>% 
        rename (replace = c("test_labelswnames" = "activity")) 
testDataSet <- testDataSet[,c(1,2,564, 3:563)]


#train set
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt",col.names = "activity")
#add column names to x_train (for requirement 4 assignment: Appropriately labels the data set with descriptive variable names)

colnames(x_train) <- features$V2
#add activity names to train_labels
#(requirement 3 of teh assignment : # uses descriptive activity names)
train_labelswnames <- gsub(6,"LAYING",
                          (gsub(5,"STANDING",
                                (gsub(4,"SITTING",
                                      (gsub(3,"WALKING_DOWNSTAIRS",
                                            (gsub(2,"WALKING_UPSTAIRS",
                                                  (gsub(1,"WALKING",train_labels$activity)))))))))))

#assemble train data set, adding a column to specify "Test" or "Train" data set(included in 3rd column)
trainDataSet <- cbind (subject_train, train_labelswnames, x_train, deparse.level = 1) %>% 
        mutate (dataSet = "Train") %>% 
        rename(replace = c("train_labelswnames" = "activity"))
trainDataSet <- trainDataSet[,c(1,2,564, 3:563)]

#MERGE test and train data sets (requirement 1 assignment)
# This data set uses descriptive activity names to name the activities in the data set

test_train_set <- merge(testDataSet,trainDataSet, all.x = TRUE,all.y = TRUE)

#Extracts only the measurements on the mean and standard deviation for each measurement (Requirement 2 assignment).
test_train_mean_std <- select(test_train_set, subject,activity,dataSet,contains("mean()"),contains("std()"))

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
Average_test_train <- test_train_mean_std %>%
        group_by(subject,activity)%>%
        select(-dataSet) %>%
        summarize_all (mean) 
 #rename columns to reflect "mean/subject and activity"
colnames(Average_test_train) <- c("subject", "activity", 
                                paste("Mean_",colnames(Average_test_train[3:68]), sep=""))
#export required data set (step 5) to txt file:
write.table(Average_test_train, "Average_test_train.txt",row.name=FALSE)