
#-----------#
## data loading
#-----------#

#getting data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "UCI HAR Dataset.zip"

if (!file.exists(file)) {
  download.file(url, file, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}

#loading relevant data
trainingsubjects <- read.table(file.path("train", "subject_train.txt"))
trainingvalues <- read.table(file.path("train", "X_train.txt"))
trainingactiv <- read.table(file.path("train", "Y_train.txt"))

testsubjects <- read.table(file.path("test", "subject_test.txt"))
testvalues <- read.table(file.path("test", "X_test.txt"))
testactiv <- read.table(file.path("test", "Y_test.txt"))

#read features from the data, which can be used for the variable names for the values datasets 
features <- read.table(file.path("features.txt"), as.is = TRUE)
#and file with names on activity
activities <- read.table(file.path("activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

#-----------#
## merging
#-----------#

#next we merge the six datasets (merging horizontally for the 3 training and test datasets, and merging those two horizontally)
alldata <- rbind(
  cbind(trainingactiv, trainingsubjects, trainingvalues), 
  cbind(testactiv, testsubjects, testvalues))

#add column names using features variable
colnames(alldata) <- c("activity", "subjects", features[,2])

#-----------#
## Only including variables which measure mean and std
#-----------#
#
filtereddata <- alldata[, grepl("activity|subjects|mean|std", colnames(alldata))]

#and remove other datasets to save memory
remove(alldata, features, testactiv, testsubjects, testvalues, trainingactiv, trainingsubjects, trainingvalues)

#change values in activity variable to more descriptive text, and make it a factor variable
filtereddata$activity <- factor(filtereddata$activity, levels = activities [, 1], labels = activities[,2])

#----------#
## making column names readible
#----------#
#getting colnamesto change
colnames <- colnames(filtereddata)

#remove special characters
colnamesnew <- gsub("[\\(\\)-]", "", colnames)

#expand abbreviations
colnamesnew <- gsub("^t", "time", colnamesnew)
colnamesnew <- gsub("^f", "frequency", colnamesnew)
colnamesnew <- gsub("std", "standarddeviation", colnamesnew)
colnamesnew <- gsub("Freq", "frequency", colnamesnew)
colnamesnew <- gsub("Acc", "accelerator", colnamesnew)
colnamesnew <- gsub("Mag", "magnitude", colnamesnew)

#add newcolnames to dataframe 
colnames(filtereddata) <- colnamesnew

#----------#
## last step: create new dataset with average for each variable per activity and subject
#----------#

#use dplyr to group by and summarize means, and create new dataframe
means <- filtereddata %>% group_by(activity, subjects) %>% summarise_each(funs(mean))

#create csv file
write.csv(means, "tidy_data_set_step5.csv")
