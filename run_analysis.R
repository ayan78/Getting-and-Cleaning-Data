library(data.table)
library(dplyr)

# Read metadata

features <- read.table("features.txt")
actLabels <- read.table("activity_labels.txt", header = FALSE)

# Read training data
sTrain <- read.table("train/subject_train.txt", header = FALSE)
aTrain <- read.table("train/y_train.txt", header = FALSE)
fTrain <- read.table("train/X_train.txt", header = FALSE)

# read test data
sTest <- read.table("test/subject_test.txt", header = FALSE)
aTest <- read.table("test/y_test.txt", header = FALSE)
fTest <- read.table("test/X_test.txt", header = FALSE)

# Merge respective test and train datasets
sMerge <- rbind(sTrain, sTest)
aMerge <- rbind(aTrain, aTest)
fMerge <- rbind(fTrain, fTest)

# Rename merged feature set column names by taking names from features (needs transformation)
# And give column names to merged subject and activity sets. 
colnames(fMerge) <- t(features[2])
colnames(aMerge) <- "Activities"
colnames(sMerge) <- "Subjects"

# Merge all the datasets to one
fullSet <- cbind(fMerge,aMerge,sMerge)

# Get columns with mean and std
meanInd <- grep(".*Mean.*", names(fullSet), ignore.case=TRUE)
stdInd  <- grep(".*Std.*", names(fullSet), ignore.case=TRUE)

# Combine the column indexes and add the last two (activity and subject) columns as well
fColIndex <-sort(c(meanInd,stdInd,562,563))

## Subset the data to extract only relevant columns
subSet1 <- fullSet[,fColIndex]

# Give descriptive names to the Activities from actLabels
colnames(actLabels)  = c('Activities','ActivityType')
subSet2 = merge(subSet1,actLabels,by='Activities',all.x=TRUE)

# Descriptive names to all the columns alredy done

names(subSet2)

# Expand short forms
names(subSet2)<-gsub("Acc", "Accelerometer", names(subSet2))
names(subSet2)<-gsub("Gyro", "Gyroscope", names(subSet2))
names(subSet2)<-gsub("BodyBody", "Body", names(subSet2))
names(subSet2)<-gsub("Mag", "Magnitude", names(subSet2))
names(subSet2)<-gsub("^t", "Time", names(subSet2))
names(subSet2)<-gsub("^f", "Frequency", names(subSet2))
names(subSet2)<-gsub("tBody", "TimeBody", names(subSet2))


# Rename the variables with () pattern
names(subSet2) = gsub("\\()","",names(subSet2))
names(subSet2)<-gsub("-mean", "Mean", names(subSet2), ignore.case = TRUE)
names(subSet2)<-gsub("-std", "STD", names(subSet2), ignore.case = TRUE)
names(subSet2)<-gsub("-freq", "Frequency", names(subSet2), ignore.case = TRUE)

# Create new Tidy data by taking average per subject per activity
subSet2$Subjects <- as.factor(subSet2$Subjects)
subSet3 <- data.table(subSet2[,2:89])

finalSet <- aggregate(. ~Subjects + ActivityType, subSet3, mean)
finalSet <- finalSet[order(finalSet$Subjects,finalSet$ActivityType),]

# Write the tidy data file 
write.table(finalSet, file = "TidyData.txt", row.names = FALSE)













