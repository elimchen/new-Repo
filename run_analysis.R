library(dplyr)

###########################################################################################
#  read text files feature.txt & activity_labels.txt from UCI HAR Dataset folder into R   # 
###########################################################################################

ColumnName <- read.table("features.txt", header = FALSE,
                         stringsAsFactors = FALSE,col.names = c("Col_ID","Col_Name"))

ActName <- read.table("activity_labels.txt", header = FALSE,stringsAsFactors = FALSE,
                      col.names = c("Activity_Code","Activity_Name"))

###########################################################################################
#                 read text files from UCI HAR Dataset/test folder into R                 #
###########################################################################################

xTest <- read.table("./test/x_test.txt", stringsAsFactors = FALSE,col.names = ColumnName[,2] )
sTest <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE,col.names = "Subject_Code")
yTest <- read.table("./test/y_test.txt", stringsAsFactors = FALSE, col.names = "Activity_Code")

##################################################################
#               merge files from test folder                     #
##################################################################

dat_test1 <- cbind(sTest,xTest)
dat_test2 <- cbind(yTest,dat_test1)

###########################################################################################
#           read text files from UCI HAR Dataset/train folder into R                      #
###########################################################################################

xtrain <- read.table("./train/x_train.txt", stringsAsFactors = FALSE,col.names = ColumnName[,2] )
strain <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE,col.names = "Subject_Code")
ytrain <- read.table("./train/y_train.txt", stringsAsFactors = FALSE, col.names = "Activity_Code")

##################################################################
#               merge files from train folder                    #
##################################################################

dat_train1 <- cbind(strain,xtrain)
dat_train2 <- cbind(ytrain,dat_train1)

###########################################################################################
# 1.    Merges the training and the test sets to create one data set.                     #
###########################################################################################

data <- rbind(dat_train2, dat_test2)

###########################################################################################
#2.Extracts only the measurements on the mean and standard deviation for each measurement.#                     #
###########################################################################################

data <- select(data, matches("mean|std|Code"))

###########################################################################################
# 3.  Uses descriptive activity names to name the activities in the data set              #
###########################################################################################

data <- merge(ActName, data, all.data = TRUE)

###########################################################################################
# 4. Appropriately labels the data set with descriptive variable names                    #
###########################################################################################

# Remove parentheses
names(data) <- gsub(pattern = "\\(|\\)","",names(data))

# Make names descriptive
names(data) <- gsub(pattern = "Freq", replacement = "Frequency",names(data))
names(data) <- gsub(pattern = "^t", replacement = "TimeDomain",names(data))
names(data) <- gsub(pattern = "^f", replacement = "FrequencyDomain",names(data))
names(data) <- gsub(pattern = "Acc", replacement = "Acceleration",names(data))

names(data) <- gsub(pattern = "GyroJerk", replacement = "AngularAcceleration",names(data))
names(data) <- gsub(pattern = "Gyro", replacement = "AngularSpeed",names(data))
names(data) <- gsub(pattern = "Mag", replacement = "Magnitude",names(data))
names(data) <- gsub(pattern = "mean", replacement = "Mean",names(data))
names(data) <- gsub(pattern = "std", replacement = "StandardDeviation",names(data))
names(data) <- gsub(pattern = "BodyBody", replacement = "Body",names(data))
names(data) <- gsub(pattern = "tBody", replacement = "TimeDomainBody",names(data))

# Write data as a txt file   (first version of the clean data)                    
write.table(data, file="Smartphones Experiment.txt", sep=" ", col.names=TRUE, row.names=FALSE)

###########################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the    #
#    average of each variable for each activity and each subject.                         #
###########################################################################################

library(reshape2)
library(plyr)

LongData <- melt(data, id.vars=c("Activity_Code","Activity_Name","Subject_Code"))

# Apply mean function to dataset using dcast function
Clean_data   = dcast(LongData, Subject_Code + Activity_Name ~ variable, mean)

# Write 2nd version of clean data as a txt file                       
write.table(Clean_data, file="Smartphones Experiment Average.txt", sep=" ", col.names=TRUE, row.names=FALSE)
