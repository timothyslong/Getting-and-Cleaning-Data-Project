*Getting and Cleaning Data* Final Project
========================================================
**Tim Long | 10/25/2014**

This project contains an R script (run_analysis.R) that summarizes accelerometer data generated from Samsung Galaxy S smartphones.  


A full description of the source data is available at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

************
Flow:
-----
1. Read the dimensional table of **activities** (ActivityID, Activity) from the file ./activity_labels.txt
2. Read the list of **features** to be used as column names from ./features.txt
3. Read the **train** x data (./train/X_train.txt and ./train/Y_train.txt), using **features** as the column names
4. Read the **test** x data (./test/X_test.txt and ./test/Y_test.txt) using **features** as the column names
5. Read the **subjects** from the ./train/subject_train.txt file
6. Combine the **subject**, **y**, and **x** for the train data, repeat for the test data
7. Union the train and test data together into one dataset called **all**
8. Reduce the dataset (**reduced**) to retain only the metrics that are either mean or standard deviation measurements
9. Summarize the **reduced** dataset to produce the average mean and average standard deviation for each subject and activity
10. Write this summarized output to file (./tidy_summary.txt)

************

Outputs:
----
**tidy_summary.txt** - Average mean value and average standard deviation value output for each subject and activity. |

tidy_summary.txt Codebook:
----

| Column              |  Description                                                                                              |
|---------------------|-----------------------------------------------------------------------------------------------------------|
| **SubjectID**       | A unique identifier for the Subject from which the accelerometer data was collected.                      |
| **Activity**        | The type of activity measured: [LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS] |
| **Average Mean**    | The average of all types of "mean" metrics collected in this activity for this subject.                   |
| **Average Stdev**   | The average of all the standard deviation metrics collected in this activity for this subject.            |


************

Assumptions:
------------------------
1.  The script assumes that the working directory is set to the location of the R script (run_analysis.R)
2.  The script assumes that the following data has already been downloaded and extracted (unzipped) into a folder in the working directory named "UCI HAR Dataset"
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
3.  The script assumes that packages **reshape** and **reshape2** are already installed.  If they are not, please execute the following R:

```{r}
install.packages('reshape')
install.packages('reshape2')
```
************