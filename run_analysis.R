require(plyr)
# 1
#Read the Train set and the Test set
traindata <- as.matrix(read.table("UCI HAR Dataset/train/X_train.txt" ))
testdata <- as.matrix(read.table("UCI HAR Dataset/test/X_test.txt" ))
#Combine by rows
data <- rbind(traindata, testdata)

# 2 
#Row mean
dataMeans <- rowMeans(data)
#Row sd
dataSD <- apply( data, 1, sd )
#Create a data frame with results
df <- data.frame(datamean = dataMeans, datasd = dataSD)

#3
#Read the activity labels
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_names) <- c("id", "desc")
#Read the activity id of Train and Test
act_train <- read.table("UCI HAR Dataset/train/y_train.txt")
act_test <- read.table("UCI HAR Dataset/test/y_test.txt")
#Combine by rows
activity_id <- rbind(act_train, act_test)
names(activity_id) <- c("id")
#Merge activity_id and activity_names
activity <- merge(activity_id, activity_names, by.x = "id", by.y = "id", all = T)
activity <- activity$desc
#Combine df and activity
data1 <- cbind(df, activity)

#4
#labels the data set
names(data1) <- c("mean", "sd", "activity")
head(data1)


#5
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(sub_train, sub_test)
names(subject) <- c("subject")
data2 <- data1
data2 <- cbind(data2,subject)
data2 <- ddply(data2, .(activity,subject), summarize, ave_mean = mean(sd), ave_sd = mean(sd) )
write.table(x = data2,file = "data2.txt",row.name=FALSE )

