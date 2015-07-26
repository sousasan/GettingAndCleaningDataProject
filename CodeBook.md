#Codebook.md

This code book will contains the inputs outputs and manipulations used in run_analysis.R


##Input
run_analysis.R requires no inputs and is not a function requiring arguments. The only data it requires is pulled from a set URL to a data set.

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


