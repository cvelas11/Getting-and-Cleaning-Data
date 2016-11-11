
setwd("D:/Dropbox/Data Science Course/3. Getting and Cleaning Data/Assignment/data")

#------------------------------------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.

## step 1: dowload zip data from the website and unzip it in the same folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "getdata_projectfiles_UCI HAR Dataset.zip"

if(!file.exists(fileName)){
	download.file(fileUrl,fileName)
}
unzip(fileName)

## step 2: load all data into R
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")  
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")  
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #JO: train subject indicates the subject who performed the activity for each window sample
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## step 3: merge test and train data
train_Data <- cbind(subject_train, y_train, x_train) #merge by column by subject + training label + training set data
test_Data <- cbind(subject_test, y_test, x_test)
full_Data <- rbind(train_Data, test_Data)


#------------------------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## step 1: load feature name into R
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

## step 2:  extract mean and standard deviation of each measurements
featureIndex <- grep(("mean\\(\\)|std\\(\\)"), features) 

finalData <- full_Data[, c(1, 2, featureIndex+2)] 
colnames(finalData) <- c("subject", "activity", features[featureIndex])

#------------------------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set

## step 1: load activity data into R
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## step 2: replace 1 to 6 with activity names
finalData$activity <- factor(finalData$activity, levels = activity_labels[,1], labels = activity_labels[,2]) 

#------------------------------------------------------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive variable names.

names(finalData) <- gsub("\\()", "", names(finalData)) 
names(finalData) <- gsub("^t", "Time_", names(finalData)) 
names(finalData) <- gsub("^f", "Frequency_", names(finalData))
names(finalData) <- gsub("-",  "_", names(finalData))
names(finalData) <- gsub("mean", "Mean", names(finalData)) 
names(finalData) <- gsub("std", "Std", names(finalData)) 


#------------------------------------------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each 
library(plyr)
groupData <- ddply(finalData, .(subject, activity), function(x) colMeans(x[,-c(1:2)]))

write.table(groupData, "./TidyData.txt", row.names = FALSE)






