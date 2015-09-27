## step 1:  Merges the training and the test sets to create one data set.
## read the data from files
Xtrain <- read.table("UCI HAR DataSet/train/X_train.txt", header = FALSE)
Xtest <- read.table("UCI HAR DataSet/test/X_test.txt", header = FALSE)

ytrain <- read.table("UCI HAR DataSet/train/y_train.txt", header = FALSE)
subjecttrain <- read.table("UCI HAR DataSet/train/subject_train.txt", header = FALSE)

ytest <- read.table("UCI HAR DataSet/test/y_test.txt", header = FALSE)
subjecttest <- read.table("UCI HAR DataSet/test/subject_test.txt", header = FALSE)

## merge using rbind
Xall <- rbind(Xtrain, Xtest)
yall <- rbind(ytrain, ytest)
sall <- rbind(subjecttrain, subjecttest)

## merge using cbind
alll <- cbind(Xall, yall)
alll <- cbind(alll, sall)

## step 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
## I get all of measurements which include "-Mean()-" or "-std()-" 
## However, I don't count the measurements which include "-MeanFreq"
## So, I maybe miss some columns, but I think it's not an important issue for this assignment
## get column number by manual
col <-
        c(
                1:6, 41:46, 81:86, 
                121:126, 161:166, 201:202, 214:215, 
                227:228, 240:241, 253:254, 266:271, 
                345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 562:563
        )
## extract
extract <- alll[, col]
dim(extract)
## 10299, 68

## step 3 : Uses descriptive activity names to name the activities in the data set
## I think this step is about rename the activities of participants
## I just write some loop to do it
## I agree with that the factor/level method maybe a better solution

for ( i in 1:nrow(e)) {
        if (e$Activities[i] == 1) {
                ##e[i]$Activities == ""
                e$Activities[i] <- "WALKING" }
        else if (e$Activities[i] == 2) {
                e$Activities[i] <- "WALKING_UPSTAIRS" }
        else if (e$Activities[i] == 3) {
                e$Activities[i] <- "WALKING_DOWNSTAIRS" }
        else if (e$Activities[i] == 4) {
                e$Activities[i] <- "SITTING" }
        else if (e$Activities[i] == 5) {
                e$Activities[i] <- "STANDING" }        
        else if (e$Activities[i] == 6) {
                e$Activities[i] <- "LAYING" }
        }       

## step 4 : Appropriately labels the data set with descriptive variable names. 
## I do this by manual, it terrible work
## Maybe I should do it by programming ?

ns <- c(
        "MeanOfBodyAccX", "MeanOfBodyAccY", "MeanOfBodyAccZ", 
        "StdOfBodyAccX", "StdOfBodyAccY", "StdOfBodyAccZ",
        "MeanOfGravityAccX", "MeanOfGravityAccY", "MeanOfGravityAccZ", 
        "StdOfGravityAccX", "StdOfGravityAccY", "StdOfGravityAccZ", 
        "MeanOfBodyAccJerkX", "MeanOfBodyAccJerkY", "MeanOfBodyAccJerkZ",
        "StdOfBodyAccJerkX", "StdOfBodyAccJerkY", "StdOfBodyAccJerkZ",
        "MeanOfBodyGyro", "MeanOfBodyGyro", "MeanOfBodyGyro", 
        "StdOfBodyGyro", "StdOfBodyGyro", "StdOfBodyGyro", 
        "MeanOfBodyGyroJerk", "MeanOfBodyGyroJerk", "MeanOfBodyGyroJerk", 
        "StdOfBodyGyroJerk", "StdOfBodyGyroJerk", "StdOfBodyGyroJerk", 
        "MeanOfBodyAccMag", "StdOfBodyAccMag", 
        "MeanOfGravityAccMag", "StdOfGravityAccMag", 
        "MeanOfBodyAccJerkMag", "StdOfBodyAccJerkMag", 
        "MeanOfBodyGyroMag", "StdOfBodyGyroMag", 
        "MeanOfBodyGyroJerkMag", "StdOfBodyGyroJerkMag", 
        "MeanOfBodyAcc", "MeanOfBodyAcc", "MeanOfBodyAcc", 
        "StdOfBodyAcc", "StdOfBodyAcc", "StdOfBodyAcc", 
        "MeanOfBodyAccJerk", "MeanOfBodyAccJerk", "MeanOfBodyAccJerk", 
        "StdOfBodyAccJerk", "StdOfBodyAccJerk", "StdOfBodyAccJerk", 
        "MeanOfBodyGyro", "MeanOfBodyGyro", "MeanOfBodyGyro", 
        "StdOfBodyGyro", "StdOfBodyGyro", "StdOfBodyGyro", 
        "MeanOfBodyAccMag", "StdOfBodyAccMag", 
        "MeanOfBodyBodyAccJerkMag", "StdOfBodyBodyAccJerkMag", 
        "MeanOfBodyBodyGyroMag", "StdOfBodyBodyGyroMag", 
        "MeanOfBodyBodyGyroJerkMag", "StdOfBodyBodyGyroJerkMag",
        "Activities", "Participant")

names(extract) <- ns

## step 5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
## In this step, I use group_by method and pipeline style, and summarise_each method

td <- e %>% group_by(Participant, Activities) %>% summarise_each(funs(mean(., na.rm=TRUE)))
## get the final result file of tidy data
write.table(td, "tidydata.txt", row.name=FALSE)
