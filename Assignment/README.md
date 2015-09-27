The run_analysis.R script get the sumsang data from "UCI HAR DataSet" directory, 
then do some stuff, at the end output the tidy data in "tidydata.txt" file.

If you store the origin data in different folder, please change the parameters of read.table method

#### step 1:  Merges the training and the test sets to create one data set.

first read the data from files
then, merge data using rbind method seperately such as Xtrain and Xtest, ytrain and ytest, subjecttrain and subjecttest
third, merge data which get from pre-step using cbind

#### step 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 

Manually get all of measurements column number which include "-Mean()-" or "-std()-" 
In this step I don't count the measurements which include "-MeanFreq"
Extract the selected column from merge data, get a subset data which dimension is 10299 X 68

#### step 3 : Uses descriptive activity names to name the activities in the data set

using some loop to reassign the activities of participants from integer to characters

#### step 4 : Appropriately labels the data set with descriptive variable names. 

Get the descriptive name of the column manually, then rename the variable in extract data

#### step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Use group_by method and summarise_each method, and in pipeline style
Use write.table method, get the final result file of tidy data
