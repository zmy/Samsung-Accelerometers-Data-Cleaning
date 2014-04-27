#1. Merges the training and the test sets to create one data set.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", head=FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", head=FALSE)
X <- rbind2(X_train, X_test)
features <- as.vector(read.table("./UCI HAR Dataset/features.txt", head=FALSE)$V2)
##fix duplicate feature names
for(i in which(duplicated(features))) {
  features[i] = paste(features[i], "_dup", as.character(i), sep="")
}
colnames(X) <- features

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
summary <- apply(X, 2, function(x) c(mean=mean(x), sd=sd(x)))

#3. Uses descriptive activity names to name the activities in the data set.
#4. Appropriately labels the data set with descriptive activity names.
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", head=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", head=FALSE)
y <- rbind2(y_train, y_test)$V1
activity_labels <- as.integer(read.table("./UCI HAR Dataset/activity_labels.txt")$V2)
X$labels <- factor(sapply(y, function(x) activity_labels[[x]]), activity_labels)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", head=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", head=FALSE)
X$subject <- rbind2(subject_train, subject_test)$V1
library(reshape2)
XMelt <- melt(X, id.vars=c("labels", "subject"), measure.vars=features)
XCast <- dcast(XMelt, labels+subject~variable, mean)

write.table(XCast, "data-tidy.txt")
write.csv(XCast, "data-tidy.csv")

