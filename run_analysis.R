library(plyr)
   
# 1. Load all of the data 
    
#download the data 
file <- "getdata-projectfiles-UCI HAR Dataset.zip"
if(!file.exists(file)){
        dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfil
        es%2FUCI%20HAR%20Dataset.zip "
        download.file(dataURL, file, method="curl")
        unzip(file)
}
      
#Load the data files
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
    
#Load the subject label data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
    
#Load the activity label data
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
    
#Load the features label data and set all column names
columnNames <- scan("UCI HAR Dataset/features.txt", what="character")
    
# 2. Merge all of the data and correctly label columns
    
#Combine the test and train data sets 
data <- rbind(testData, trainData)
  
#Combine subject data sets 
subjectData <- rbind(testSubject, trainSubject)
    
#Combine activity data sets and make values descriptive
activityData <- rbind(testActivity, trainActivity)
activityData <- activityLabels[activityData[,1],2]
    
#Combine all of the data
data <- cbind(data, activityData, subjectData)
    
#correct and set the column names
columnNames <- columnNames[c(FALSE,TRUE)]
colnames(data) <- c(columnNames,"activity", "subject")
    
# 3. Select mean and standard deviation data only 
 
#select only the mean and std columns
meanNames <- grepl("mean()", columnNames, fixed=TRUE)
stdNames <- grepl("std()", columnNames, fixed=TRUE)
data<-data[,(meanNames | stdNames)]
    
# 4. Write data to file "tidy.txt"
    
averages <- ddply(data, .(activity,subject), function(x) colMeans(x[, 1:66]))
write.table(averages, "tidy.txt", row.names=FALSE)
    
