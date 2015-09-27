#### Raw Data

The raw data that is accelerometer data collected from the Samsung Galaxy S smartphone, get this data from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

There are 3 types of data files and each type of file is split to train and test, such as Xtrain.txt and Xtest.txt, 
which are stored in different folder like train and test:

X: include X_train.txt and X_test.txt, display rows of feature measurements
y: include y_train.txt and y_test.txt, store the activity labels(integer) corresponding to each row of X.
subject: include subject_train.txt and subject_test.txt, store the subjects on which each row of X was measured.

There are some additional files to represent the data:

features.txt: The dictionary from features id(integer) to feature names.
activity_labels.txt: The dictionary from activity labels(integer) to descriptive names.

#### Data load

The Xtrain, Xtest, ytrain, ytest, subjecttrain, subjecttrain data is loaded from each of the training and test datasets file.

All the columns are loaded, then using rbind merge Xtrain and Xtest, ytrain and ytest, subjecttrain and subjecttest, 
at the end using cbind merge the data which last step get.

#### Data Extract

Get the interested data which include the mean() and sd() columns which the feature names included from features.txt

#### Rename

Rename the activities labels(integer) to the activity descriptive names.

Rename the variables(columns) to meaningful names from features.txt.

#### Group

Using group_by and summarize_each method to get the tidy data 
include with the average of each variable for each activity and each subject.

#### Output

This result is output as tidydata.txt
