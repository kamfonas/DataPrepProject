# script: run_analysis.R - Coursera
# Michael Kamfonas
# working directory contains all scripts and files - setwd("D:/Coursera/work/R2/DataPrepProject")
# relative data directory is:
	
	dataDir<-"../data"
	zipFileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	zipDest<-paste0(dataDir,"/UCI_HAR_Dataset.zip")
	
	if(!file.exists(dataDir)){dir.create("./data")}

	if(!file.exists(zipDest)){
		download.file(zipFileUrl,destfile=zipDest)
	}
	
	unzip(zipDest,overwrite=TRUE,unzip="unzip",exdir=dataDir)

# import metadata first
	activity.labels 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/activity_labels.txt"))
	features 		<-  read.table(paste0(dataDir,"/UCI HAR Dataset/features.txt"))

	X_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/X_test.txt"))
	y_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/y_test.txt"))
	subject.test 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/subject_test.txt"))
	subject.train 	<-  read.table(paste0(dataDir,"/UCI HAR Dataset/train/subject_train.txt"))
	X_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/X_train.txt"))
	y_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/y_train.txt"))


# convert activities to factors based on the labels provided
	y_test$V1<-factor(y_test$V1,labels=activity.labels[,2])
	y_train$V1<-factor(y_test$V1,labels=activity.labels[,2])

# identify and index names containing std() or mean()
	var.index <- grep("mean\\(\\)|std\\(\\)",features$V2)

# label metrics with meaningful names based on the features metadata names
# 1. remove any spaces, left and rigth parentheses
# 2. Assign the derived labels to the X_test and X_train data frames
	features$label<-gsub("[\\(\\) ]","",features$V2)
	names(X_test)<-features[,"label"]
	names(X_train)<-features[,"label"]
	
# combine test and train frames to a new data frame with only the metrics required, the subjects and the activities
	data <- rbind(
			cbind(y_test,subject.test,X_test[,var.index]), 
			cbind(y_train,subject.train,X_train[,var.index])
		)


#restData <- read.csv("./data/restaurants.csv")