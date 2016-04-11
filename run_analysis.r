#Code for Final Project
#Load everything I **think** I'm going to need. 
library(data.table)
library(reshape2)
library(dplyr)
library(tidyr)

# Download File
setwd("C:/Getting and Cleaning Data/Week 4")
if(!file.exists("./data")){dir.create("./data")}
dataTableurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataTableurl,destfile="./data/Dataset.zip",method="curl")

#Unzip File
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Read data into variable
f <-"C:/Getting and Cleaning Data/Week 4/UCI HAR Dataset"

# Read Subject Files into R
subTrain <- tbl_df(read.table(file.path(f, "train", "subject_train.txt")))
subTest  <- tbl_df(read.table(file.path(f, "test" , "subject_test.txt" )))

# Read Y Files (Activity) into R
yActiveTrain <- tbl_df(read.table(file.path(f, "train", "Y_train.txt")))
yActiveTest  <- tbl_df(read.table(file.path(f, "test" , "Y_test.txt" )))

#Read X data files into R
xDataTrain <- tbl_df(read.table(file.path(f, "train", "X_train.txt" )))
xDataTest  <- tbl_df(read.table(file.path(f, "test" , "X_test.txt" )))

# Row Bind Subject Train and Test Files Together and set Names
totalSubject <- rbind(subTrain, subTest)
setnames(totalSubject, "V1", "subject")

#Row Bind Y Train and Test Files Together and set names
totalYActivity<- rbind(yActiveTrain, yActiveTest)
setnames(totalYActivity, "V1", "activityNum")

#Row Bind the X data files
dataTable <- rbind(xDataTrain, xDataTest)

# Read “Features” into R (tbl_df worked the best in terms of not experiencing argument errors). Set names of features# name variables according to feature e.g.(V1 = "tBodyAcc-mean()-X")
dataFeatures <- tbl_df(read.table(file.path(f, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName

#Read Activity Lables into R and set names.
activityLabels<- tbl_df(read.table(file.path(f, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

# Merge columns
totalSubandYAct<- cbind(totalSubject, totalYActivity)
dataTable <- cbind(totalSubandYAct, dataTable)

# Extracting mean and standard deviation
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE) #var name

#Unite Mean Std.Features and subset into data table
dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable,select=dataFeaturesMeanStd) 

##Merge Activity Labels into Data Table
dataTable <- merge(activityLabels, dataTable , by="activityNum", all.x=TRUE)
dataTable$activityName <- as.character(dataTable$activityName)

## Conjure dataTable with variable means sorted by subject and Activity
dataTable$activityName <- as.character(dataTable$activityName)
dataAggr<- aggregate(. ~ subject - activityName, data = dataTable, mean) 
dataTable<- tbl_df(arrange(dataAggr,subject,activityName))
head(str(dataTable),2)

#Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  69 variables:
# $ subject                    : int  1 1 1 1 1 1 2 2 2 2 ...
# $ activityName               : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
# $ activityNum                : num  6 4 5 1 3 2 6 4 5 1 ...
# $ tBodyAcc-mean()-X          : num  0.222 0.261 0.279 0.277 0.289 ...
# $ tBodyAcc-mean()-Y          : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
# $ tBodyAcc-mean()-Z          : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
# $ tBodyAcc-std()-X           : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
# $ tBodyAcc-std()-Y           : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
# $ tBodyAcc-std()-Z           : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
# $ tGravityAcc-mean()-X       : num  -0.249 0.832 0.943 0.935 0.932 ...
# $ tGravityAcc-mean()-Y       : num  0.706 0.204 -0.273 -0.282 -0.267 ...
# $ tGravityAcc-mean()-Z       : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
# $ tGravityAcc-std()-X        : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
# $ tGravityAcc-std()-Y        : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
# $ tGravityAcc-std()-Z        : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...

#Replaces string match with name in data table
names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))

# View
head(str(dataTable),6)

#Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  69 variables:
# $ subject                                       : int  1 1 1 1 1 1 2 2 2 2 ...
# $ activityName                                  : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
# $ activityNum                                   : num  6 4 5 1 3 2 6 4 5 1 ...
# $ timeBodyAccelerometer-MEAN()-X                : num  0.222 0.261 0.279 0.277 0.289 ...
# $ timeBodyAccelerometer-MEAN()-Y                : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
# $ timeBodyAccelerometer-MEAN()-Z                : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
# $ timeBodyAccelerometer-SD()-X                  : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
# $ timeBodyAccelerometer-SD()-Y                  : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
# $ timeBodyAccelerometer-SD()-Z                  : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
# $ timeGravityAccelerometer-MEAN()-X             : num  -0.249 0.832 0.943 0.935 0.932 ...
# $ timeGravityAccelerometer-MEAN()-Y             : num  0.706 0.204 -0.273 -0.282 -0.267 ...
# $ timeGravityAccelerometer-MEAN()-Z             : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
# $ timeGravityAccelerometer-SD()-X               : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
# $ timeGravityAccelerometer-SD()-Y               : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
# $ timeGravityAccelerometer-SD()-Z               : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
# $ timeBodyAccelerometerJerk-MEAN()-X            : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
# $ timeBodyAccelerometerJerk-MEAN()-Y            : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
# $ timeBodyAccelerometerJerk-MEAN()-Z            : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
# $ timeBodyAccelerometerJerk-SD()-X              : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...



#Tidy Data!
write.csv(dataTable, "TidyData1.csv")

