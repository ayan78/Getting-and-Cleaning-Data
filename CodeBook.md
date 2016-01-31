# Input Data Set

subject_test.txt has on the subjects.
activity_labels.txt has information on the activity types.
features.txt has the information on the features in the data sets.

## Training Data
X_train.txt has features information needed  for training.
y_train.txt corresponding activity information for X_train.txt.
subject_train.txt contains information on the subjects.

## Test Data
X_test.txt contains variable features that are intended for testing.
y_test.txt contains the activities corresponding to X_test.txt.
subject_test.txt contains information on the subjects.

#Transformations
The following are the transformations:
- All the input datasets are read using read.table function.
- The testing and training data for subject, activity and features are merged respectively using rbind function.
- Rename column names for each of the 3 merged datasets.
- Merge the 3 separate datasets into 1 full dataset using cbind function.
- Search for variables with 'mean' and 'std' using grep function repsectively.
- Subset the full dataset to obtain only relevant columns (mean and std).
- Give Descriptive names to the Activities using activity_labels.txt
- Give Descriptive names to all the column names by using the gsub command. E.g. replace t with 'Time' and f with 'Frequency'.
- Create new tidy data by taking average per subject per activity using the aggregate function.
- Write the tidy data using write.table.


# Output data 
TidyData.txt is a space delimited value file. 
