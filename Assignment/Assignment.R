## step 1
Xtrain <-
        read.table("UCI HAR DataSet/train/X_train.txt", header = FALSE)
head(Xtrain[1:5], 3)
head(rownames(Xtrain), 3)
Xtest <-
        read.table("UCI HAR DataSet/test/X_test.txt", header = FALSE)
head(Xtest[1:5], 3)
head(rownames(Xtest), 3)

ytrain <-
        read.table("UCI HAR DataSet/train/y_train.txt", header = FALSE)
subjecttrain <-
        read.table("UCI HAR DataSet/train/subject_train.txt", header = FALSE)

ytest <- read.table("UCI HAR DataSet/test/y_test.txt", header = FALSE)
subjecttest <-
        read.table("UCI HAR DataSet/test/subject_test.txt", header = FALSE)

Xall <- rbind(Xtrain, Xtest)
yall <- rbind(ytrain, ytest)
sall <- rbind(subjecttrain, subjecttest)
dim(Xall)
## [1] 10299   561
dim(yall)
## [1] 10299     1
dim(sall)
## [1] 10299     1
all <- mutate(Xall, activities = yall, subject = sall)

dim(all)

alll <- cbind(Xall, yall)
alll <- cbind(alll, sall)

## step 2
col <-
        c(
                1:6, 41:46, 81:86, 
                121:126, 161:166, 201:202, 214:215, 
                227:228, 240:241, 253:254, 266:271, 
                345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 562:563
        )
extract <- alll[, col]
dim(extract)

## step 3

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

## step 4

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

## step 5

td <- e %>% group_by(Participant, Activities) %>% summarise_each(funs(mean(., na.rm=TRUE)))
write.table(td, "tidydata.txt", row.name=FALSE)
