#You should create one R script called run_analysis.R that does the following. 

#install.packages('reshape')
library(reshape)

#install.packages('reshape2')
library(reshape2)

setwd('./UCI Har Dataset')

#1. Merges the training and the test sets to create one data set.

# Load the acitvity dimension data
activities <- read.table('activity_labels.txt', col.names=c('ActivityID','Activity'))

# Load the feature list into a dataframe.  These will become the column names in the train and test datasets
features <- read.table('features.txt', col.names=c('FeatureID','Feature'))

# Read both training sets (x and y)
x.train <- read.table('./train/X_train.txt', col.names=features$Feature)
y.train <- read.table('./train/Y_train.txt', col.names=c('ActivityID'))
train.subjects <- read.table('./train/subject_train.txt', col.names=c('SubjectID'))
# Column bind the three together into one dataframe
train <- cbind(train.subjects, y.train, x.train)

# Merge the Activity name onto the set by joining on ActivityID
train <- merge(activities, train, by.x='ActivityID', by.y='ActivityID', sort=FALSE)
# Mark this dataset with a column saying it came from the train source
train$source <- as.factor('train') 

# Repeat for the test sets (x and y)
x.test <- read.table('./test/X_test.txt', col.names=features$Feature)
y.test <- read.table('./test/Y_test.txt', col.names=c('ActivityID'))
test.subjects <- read.table('./test/subject_test.txt', col.names=c('SubjectID'))
test <- cbind(test.subjects, y.test, x.test)
test <- merge(activities, test, by.x='ActivityID', by.y='ActivityID', sort=FALSE)
# Mark this dataset with a column saying it came from the test source
test$source <- as.factor('test') 

# Combine (union all) the train and test set.
all <- rbind(train,test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Look for "std" or "mean" in the column names and subset them out, in addition to the Activity information
meanstdcols <- grep('(mean)|(std)', names(all))
keep <- c(565,2,3,meanstdcols) # keep the Mean and Std Dev columns plus the ActivityID and Activity
reduced <- all[,keep]

#3. Uses descriptive activity names to name the activities in the data set
# done earlier

#4. Appropriately labels the data set with descriptive variable names. 
# I feel like the var names are descriptive enough and preserve connectivity to original set.

#5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#   each variable for each activity and each subject.

melted <- melt(reduced, id.vars=c('source','Activity','SubjectID'))
#melted$VariableType <- as.factor(ifelse(grep('mean', melted$variable), 'mean', 'stdev'))

melted$VariableType <- as.factor(NA) 
levels(melted$VariableType) <- c('Mean','Stdev')
melted[grep('mean', melted$variable),]$VariableType <- 'Mean'
melted[grep('std', melted$variable),]$VariableType <- 'Stdev'



summ <- dcast(melted, SubjectID + Activity ~ VariableType, mean)
names(summ) <- c('SubjectId','Activity','Average Mean','Average Stdev')
View(summ)

write.table(summ, file='tidy_summary.txt', row.names=F)
