##Workflow

'run_analysis.R' script does the following action sequence:

1. Merge the training and the test sets to create one data set.
	1. Using download.file() together with unzip() functi to download the zip file from the website and extraction
	2. sing read.table() function to load "X_train.txt", "y_train", "subject_train" in train directory and "X_test", "y_test", 		"subject_test" into R.
	3. Using rbind() and cbind() functions to merge training and test data sets together.

2. Extract only the measurements on the mean and standard deviation for each measurement.
	1. Using read.table() function to load "features.txt" into R.
	2. Using grep() function to find the indexes with "mean()" and "sd()".
	3. Then select all relevant columns using the selected the indexed features name created the previous step.
	
3. Uses descriptive activity names to name the activities in the data set
	1. Using read.table() function to load "activity_labels.txt" into R.
	2. Using factor() function to replace activity number labels with the activity names
	
4. Appropriately labels the data set with descriptive variable names
	1. Using gsub() function to replace all characters such that all variable names are labelled correctly.
	
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	1. Using ddply() functions in the plyr package to calculate the mean of each variable for each activity and each subject

