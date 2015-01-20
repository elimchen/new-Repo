# **Getting and Cleaning Data** 
### Course Project

## *Project Description*

The purpose of this project is to demonstrate students' ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Studend will be graded by their peers on a series of yes/no questions related to the project. Student will be required to submit: 
*1) a tidy data set as described below, 
*2) a link to a Github repository with your script for performing the analysis, and 
*3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
*4) a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  


[The link below are the data for the project:]   

(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


## *Steps Performing the Data Cleaning*

A R script called **run_analysis.R** has been create to perform the taskes below: 
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names. 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## *Details*
* Set your working directory at ./UCI HAR Dataset

* Require Libraries are 
...*library(dplyr)
...*library(reshape2)
...*library(plyr)

* Folders, Files and discription of the file content
..* ./UCI HAR Dataset
....*features.txt: List of all features.
....*activity_labels.txt: Links the class labels with their activity name

..* ./UCI HAR Dataset/train : Training set data  
....*X_train.txt: 
....*y_train.txt: Training labels.
....*subject_train.txt: Training labels.

....*X_test.txt: Test set.

- 'test/y_test.txt': Test labels.
