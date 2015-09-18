# script: run_analysis.R - Coursera
# Michael Kamfonas

# required libraries
	library(plyr)

# working directory contains all scripts and files - setwd("D:/Coursera/work/R2/DataPrepProject")
# relative data directory is:
	print("Preparation and downloading completed")
	dataDir<-"../data"
	zipFileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	zipDest<-paste0(dataDir,"/UCI_HAR_Dataset.zip")
	
	if(!file.exists(dataDir)){dir.create("./data")}

	if(!file.exists(zipDest)){
		download.file(zipFileUrl,destfile=zipDest)
	}
	
	unzip(zipDest,overwrite=TRUE,unzip="unzip",exdir=dataDir)

	print("Preparation and downloading completed")

# import metadata first
	activity.labels 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/activity_labels.txt"))
	features 		<-  read.table(paste0(dataDir,"/UCI HAR Dataset/features.txt"))

	X_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/X_test.txt"))
	y_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/y_test.txt"))
	subject.test 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/subject_test.txt"))
	subject.train 	<-  read.table(paste0(dataDir,"/UCI HAR Dataset/train/subject_train.txt"))
	X_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/X_train.txt"))
	y_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/y_train.txt"))

	print("Data frames loaded")
	

# convert activities to factors based on the labels provided
	y_test$V1<-factor(y_test$V1,labels=activity.labels[,2])
	y_train$V1<-factor(y_train$V1,labels=activity.labels[,2])
	print("Activity factor completed")
	
# identify and index names containing std() or mean()
	var.index <- grep("mean\\(\\)|std\\(\\)",features$V2)

# label metrics with meaningful names based on the features metadata names
# 1. remove any spaces, left and rigth parentheses
# 2. Assign the derived labels to the X_test and X_train data frames
	features$label<-gsub("[\\(\\) ]","",features$V2)
	features$label<-gsub("-","_",features$label)
	names(X_test)<-features[,"label"]
	names(X_train)<-features[,"label"]

	print("Renames and variable filtering completed")
	
# combine test and train frames to a new data frame with only the metrics required, the subjects and the activities
	data <- rbind(
			cbind(y_test,subject.test,X_test[,var.index]), 
			cbind(y_train,subject.train,X_train[,var.index])
		)		
	names(data)[1]<-"ACTIVITY"
	names(data)[2]<-"SUBJECT"

	print("Combined data frame creation completed")


tidy_data <-  ddply(data,.(ACTIVITY,SUBJECT),summarize,
		avg_BodyAcc_mean_X			= mean(tBodyAcc_mean_X		), 	
		avg_BodyAcc_mean_Y			= mean(tBodyAcc_mean_Y		), 	
		avg_BodyAcc_mean_Z			= mean(tBodyAcc_mean_Z		), 	
		avg_BodyAcc_std_X				= mean(tBodyAcc_std_X			), 
		avg_BodyAcc_std_Y				= mean(tBodyAcc_std_Y			), 
		avg_BodyAcc_std_Z				= mean(tBodyAcc_std_Z			), 
		avg_GravityAcc_mean_X			= mean(tGravityAcc_mean_X		), 	
		avg_GravityAcc_mean_Y			= mean(tGravityAcc_mean_Y		), 	
		avg_GravityAcc_mean_Z			= mean(tGravityAcc_mean_Z		), 	
		avg_GravityAcc_std_X			= mean(tGravityAcc_std_X		), 	
		avg_GravityAcc_std_Y			= mean(tGravityAcc_std_Y		), 	
		avg_GravityAcc_std_Z			= mean(tGravityAcc_std_Z			), 
		avg_BodyAccJerk_mean_X		= mean(tBodyAccJerk_mean_X		), 
		avg_BodyAccJerk_mean_Y		= mean(tBodyAccJerk_mean_Y		), 
		avg_BodyAccJerk_mean_Z		= mean(tBodyAccJerk_mean_Z		), 
		avg_BodyAccJerk_std_X			= mean(tBodyAccJerk_std_X		), 	
		avg_BodyAccJerk_std_Y			= mean(tBodyAccJerk_std_Y		), 	
		avg_BodyAccJerk_std_Z			= mean(tBodyAccJerk_std_Z		), 	
		avg_BodyGyro_mean_X			= mean(tBodyGyro_mean_X		), 	
		avg_BodyGyro_mean_Y			= mean(tBodyGyro_mean_Y		), 	
		avg_BodyGyro_mean_Z			= mean(tBodyGyro_mean_Z		), 	
		avg_BodyGyro_std_X			= mean(tBodyGyro_std_X			), 
		avg_BodyGyro_std_Y			= mean(tBodyGyro_std_Y			), 
		avg_BodyGyro_std_Z			= mean(tBodyGyro_std_Z			), 
		avg_BodyGyroJerk_mean_X		= mean(tBodyGyroJerk_mean_X	), 	
		avg_BodyGyroJerk_mean_Y		= mean(tBodyGyroJerk_mean_Y	), 	
		avg_BodyGyroJerk_mean_Z		= mean(tBodyGyroJerk_mean_Z		), 
		avg_BodyGyroJerk_std_X			= mean(tBodyGyroJerk_std_X		), 
		avg_BodyGyroJerk_std_Y			= mean(tBodyGyroJerk_std_Y		), 
		avg_BodyGyroJerk_std_Z			= mean(tBodyGyroJerk_std_Z		), 
		avg_BodyAccMag_mean			= mean(tBodyAccMag_mean		), 	
		avg_BodyAccMag_std			= mean(tBodyAccMag_std			), 
		avg_GravityAccMag_mean			= mean(tGravityAccMag_mean		), 
		avg_GravityAccMag_std			= mean(tGravityAccMag_std		), 	
		avg_BodyAccJerkMag_mean		= mean(tBodyAccJerkMag_mean	), 	
		avg_BodyAccJerkMag_std			= mean(tBodyAccJerkMag_std		), 
		avg_BodyGyroMag_mean			= mean(tBodyGyroMag_mean		), 
		avg_BodyGyroMag_std			= mean(tBodyGyroMag_std		), 	
		avg_BodyGyroJerkMag_mean		= mean(tBodyGyroJerkMag_mean	), 	
		avg_BodyGyroJerkMag_std		= mean(tBodyGyroJerkMag_std		), 
		avg_BodyAcc_mean_X			= mean(fBodyAcc_mean_X		), 	
		avg_BodyAcc_mean_Y			= mean(fBodyAcc_mean_Y		), 	
		avg_BodyAcc_mean_Z			= mean(fBodyAcc_mean_Z		), 	
		avg_BodyAcc_std_X				= mean(fBodyAcc_std_X			), 
		avg_BodyAcc_std_Y				= mean(fBodyAcc_std_Y			), 
		avg_BodyAcc_std_Z				= mean(fBodyAcc_std_Z			), 
		avg_BodyAccJerk_mean_X		= mean(fBodyAccJerk_mean_X		), 
		avg_BodyAccJerk_mean_Y		= mean(fBodyAccJerk_mean_Y		), 
		avg_BodyAccJerk_mean_Z		= mean(fBodyAccJerk_mean_Z		), 
		avg_BodyAccJerk_std_X			= mean(fBodyAccJerk_std_X		), 	
		avg_BodyAccJerk_std_Y			= mean(fBodyAccJerk_std_Y		), 	
		avg_BodyAccJerk_std_Z			= mean(fBodyAccJerk_std_Z		), 	
		avg_BodyGyro_mean_X			= mean(fBodyGyro_mean_X		), 	
		avg_BodyGyro_mean_Y			= mean(fBodyGyro_mean_Y		), 	
		avg_BodyGyro_mean_Z			= mean(fBodyGyro_mean_Z		), 	
		avg_BodyGyro_std_X			= mean(fBodyGyro_std_X			), 
		avg_BodyGyro_std_Y			= mean(fBodyGyro_std_Y			), 
		avg_BodyGyro_std_Z			= mean(fBodyGyro_std_Z			), 
		avg_BodyAccMag_mean			= mean(fBodyAccMag_mean		), 	
		avg_BodyAccMag_std			= mean(fBodyAccMag_std			), 
		avg_BodyBodyAccJerkMag_mean	= mean(fBodyBodyAccJerkMag_mean), 	
		avg_BodyBodyAccJerkMag_std		= mean(fBodyBodyAccJerkMag_std	), 
		avg_BodyBodyGyroMag_mean		= mean(fBodyBodyGyroMag_mean	), 	
		avg_BodyBodyGyroMag_std		= mean(fBodyBodyGyroMag_std	), 	
		avg_BodyBodyGyroJerkMag_mean	= mean(fBodyBodyGyroJerkMag_mean),	
		avg_BodyBodyGyroJerkMag_std	= mean(fBodyBodyGyroJerkMag_std	)
	)

write.table(tidy_data,"UCI_HAR_Aggregated.txt",row.names=FALSE)
