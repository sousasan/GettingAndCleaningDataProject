#Codebook.md

This code book will describe the variables, inputs, outputs, manipulations, and variables used in run_analysis.R


##Input
run_analysis.R requires no inputs and is not a function requiring arguments. The only data required is pulled from URL to a data set.

##Output
run_analysis.R creates an ouput file to the current directory called "tidy.txt". This output file contains only the mean and standard deviation data averaged over each activity and subject

##run_analysis.R Execution

1. Loads data from:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) using download.file() and read.table()

2. Merges data from the files:
	*X_test.txt - test data set
	*y_test.txt - factored data on the activity of each observation in test set
	*subject_test.txt - information on subjects generating each observation in test set
	*X_train.txt - train data set
	*y_train.txt - factored data on the activity of each observation in train set
	*subject_train.txt - information on subjects generating each observation in test set
	*features.txt - names for each variable in the data sets
	*activity_labels.txt - names corresponding to the factored activity values

3. Uses rbind() to combine the test and train data sets, and cbind() to merge the subject and activity data with the data sets. 

4. Maps the activity factored values to the activity names.

5. Correctly labels the columns of the data set, using features.txt. 

6. Subsets only the data containing "mean" and "std" using grepl(). Uses ddply() to average out each activity per subject

7. Writes new data set to "tidy.txt" in the current folder using write.table()

##Variables

* `<file>` - the name of the zip file containing all of the data
* `<testData>` - data.frame object [2947 x 561] created from the downloaded X_test.txt file
* `<trainData>` - data.frame object [7352 x 561] created from the downloaded X_train.txt file 
* `<testSubject>` - data.frame object [2947 x 1] created from the subject_test.txt file
* `<trainSubject>` - data.frame object [7352 x 1] created from the subject_train.txt file
* `<testActivity>` - data.frame object [2947 x 1] created form the y_test.txt file containing factored values indicating the observation's corresponding activity
* `<trainActivity>` - data.frame object [7352 x 1] created form the y_train.txt file containing factored values indicating the observation's corresponding activity
* `<activityLabels>` - data.frame object [6 x 2] containing the descriptive labels for each of the factor values (1 - 6) for activity
* `<columnNames>` - the vector object (length: 561) created from the features.txt file containing the column names for the data sets
* `<data>` - the merged data set ([10299 x 68] at the end of execution) that will contain testData, trainData, column names, activity data and subject data at the end of the execution
* `<meanNames>` - a logical vector (length: 561) with the position of any column names (in columnNames) containing the string pattern "mean"
* `<stdNames>` - a logical vector (length: 561) with the position of any column names (in columnNames) containing the string pattern "std"
* `<averages>` - a subset data.frame of data [180 x 68], containing only the columns including string patterns "mean" and "std", averaged by subject and activity. averages is outputted into the tidy.txt file.

