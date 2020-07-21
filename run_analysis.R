# 1. Merge the training and the test sets to create one data set
labels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE,
                     col.names=c("activityid","activity"))
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE,
                       col.names=c("featureid","feature"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            header=FALSE,col.names="subjectid")
labels_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                           header=FALSE,col.names="activityid")
data_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                         header=FALSE,col.names=features[,"feature"])

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                           header=FALSE,col.names="subjectid")
labels_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                          header=FALSE,col.names="activityid")
data_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                        header=FALSE,col.names=features[,"feature"])

combined_train <- cbind(subject_train,labels_train,data_train)
combined_test <- cbind(subject_test,labels_test,data_test)
alldata <- rbind(combined_train,combined_test)

rm(subject_train,labels_train,data_train,combined_train,subject_test,labels_test,data_test,combined_test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement
alldata <- alldata[,grepl("subjectid",names(alldata)) | 
                     grepl("activityid",names(alldata)) |
                     grepl("mean\\.",names(alldata)) | 
                     grepl("std",names(alldata))]

# 3. Use descriptive activity names to name the activities in the data set
alldata <- merge(alldata,labels,by="activityid")
alldata <- subset(alldata, select=c(1,69,2:68))  # Move the "activity" variable to the left

# 4. Appropriately label the data set with descriptive variable names
# I accomplished this in 1. above.

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
grouped <- group_by(alldata,activityid,subjectid)
summarized <- suppressWarnings(summarize(grouped,across(everything(),mean)))
summarized <- merge(summarized,labels,by="activityid")
summarized$activity = summarized$activity.y
summarized <- summarized[,!(names(summarized) %in% c("activity.x","activity.y"))]
summarized <- summarized[,c(2,1,69,3:68)]

rm(grouped,features,labels)
