## Overview

The intention of the project is to demonstrate skills in getting, cleaning and transforrming data, to prepare them for statistical analysis. 

A data set is provided <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">here</a>. 
A description of the methodology and purpose of the data set is elaborated <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>. 
The objective and steps of this analysis is summarized as follows:

<ol><li>Download and unzip the data
</li><li> Combine the required data sets
</li><li> Extract only means and standard deviation measurements and label them with meaningful names
</li><li> Name activities in a descriptive way 
</li><li> Tabulate the sum of each of the extracted variables by activity and subject
</li><li> Produce a text file using write.table() with row.name=FALSE and upload it to github.
</li></ol>

## The Original Data Set

The data set provided is a zipped directory that contains a root directory named <em>UCI HAR Dataset</em> and 
among others, it incudes the following relevant directories and files for this exercise:
<dl>
<dt>File <em>activity_labels.txt</em></dt><dd> A listing of the enumeration type denoting the six activities</dd>
<dt>File <em>features.txt</em></dt><dd>A two-column listing of all features included in the X-data sets. 
		The first column denotes the position index and the second an abbreviated description of the measurement variable</dd>
<dt>Directory <em>test</em></dt><dd> including the test data set:
		<dl>	<dt>File <em>subject_test.txt</em></dt><dd>A single column and 2947 rows of the identifier of the subject of each respective experimet</dd>
			<dt>File <em>X_test.txt</em></dt><dd>A 561-column listing oof 2947 rows (denoting experiments) with all measured values</dd>
			<dt>File <em>y_test.txt</em></dt><dd>A single integer column with values 1:6 and 2947 rows denoting the activity being performed by the subject of each experiment</dd>
		</dl></dd>
<dt>Directory <em>train</em></dt><dd> including the training data set. Both training and test data are to be combined into a single set of observations for this exercise.
		<dl>	<dt>File <em>subject_train.txt</em></dt><dd>A single column and 7352 rows of the identifier of the subject of each respective experimet</dd>
			<dt>File <em>X_train.txt</em></dt><dd>A 561-column listing oof 7352 rows (denoting experiments) with all measured values</dd>
			<dt>File <em>y_train.txt</em></dt><dd>A single integer column with values 1:6 and 7352 rows denoting the activity being performed by the subject of each experiment</dd>
		</dl></dd>
</dl>

The directory is downloaded, stored at a relative data location, and the contents are uncomressed using the "unzip" function.
The script checks to see if the data directory exists, and if not it creates it. It also checks and skips the download if the zip file exists in the data directory. 
Every time the script runs, the unzip function overlays any potentially existing objects in the data directory.

The data files are then loaded into data frames as follows:

<code>
	activity.labels 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/activity_labels.txt"))
	features 		<-  read.table(paste0(dataDir,"/UCI HAR Dataset/features.txt"))

	X_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/X_test.txt"))
	y_test 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/y_test.txt"))
	subject.test 	<- read.table(paste0(dataDir,"/UCI HAR Dataset/test/subject_test.txt"))
	subject.train 	<-  read.table(paste0(dataDir,"/UCI HAR Dataset/train/subject_train.txt"))
	X_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/X_train.txt"))
	y_train 		<- read.table(paste0(dataDir,"/UCI HAR Dataset/train/y_train.txt"))
</code>

## Data Set Transformations

### Use of Metadata

The transformation of the data involves a very large number of columns. Consequently, we chose to perform some of the data preparation
steps using the metadata provided in the data set.

## Acknowledgements
Use of this dataset in publications is acknowledged by referencing the following publication:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
	"Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine." 
	International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

