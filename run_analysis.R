
library(data.table)

library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "accelerometer_data.zip")
unzip("accelerometer_data.zip")

setwd("UCI HAR Dataset/")


#labels for activities
fread("activity_labels.txt")->activity_labels

#load features
fread("features.txt",data.table = FALSE)->features



#read training and test sets

fread("train/X_train.txt",data.table = FALSE)->TrainingSets
fread("test/X_test.txt",data.table = FALSE)->TestSets


#Filtering only the mean and standard deviation of the sets

features[,2]<-as.character(features[,2])
FeaturesFilter<- grepl("((.*)mean(.*))|((.*)std(.*))", features[,2])

TrainingSets<-TrainingSets[,FeaturesFilter]
TestSets<-TestSets[,FeaturesFilter]


#reading training and test labels and attributing them to the sets

fread("train/y_train.txt",header = FALSE, col.names = c("Label"))->TraingLabels
cbind(TraingLabels,TrainingSets)->TrainingSets

fread("test/y_test.txt",header = FALSE, col.names = c("Label"))->TestLabels
cbind(TestLabels,TestSets)->TestSets

#readding and attributing the subjects

fread("train/subject_train.txt",data.table = FALSE,col.names = "subjects") -> TrainingSubjects
cbind(TrainingSubjects,TrainingSets) -> TrainingSets

fread("test/subject_test.txt",data.table = FALSE,col.names = "subjects") -> TestSubjects
cbind(TestSubjects,TestSets) -> TestSets


#attributing the feature names

FeatureNames<-features[,2][FeaturesFilter]

colnames(TestSets)<-c(colnames(TestSets[c(1:2)]),FeatureNames)
colnames(TrainingSets)<-c(colnames(TrainingSets[c(1:2)]),FeatureNames)

#Uniting both tables, applyin descriptive activities names and changing variable names to make them more readeable

bind_rows(TestSets,TrainingSets)-> rawAll


full_join(activity_labels,rawAll, by=c("V1"="Label")) -> rawAll
rawAll<-rawAll[2:ncol(All)]
rename(rawAll,activities = V2) -> rawAll

colnames(rawAll)-> All_Names
gsub(".*[Bb]ody[Aa]cc","Body Acceleration ",All_Names)->All_Names
gsub(".*[Bb]ody[Gg]yro","Body Gyroscope ",All_Names)->All_Names
gsub(".*[Bb]ody[Aa]cc","Body Acceleration ",All_Names)->All_Names
gsub(".*[Gg]ravity[Aa]cc","Gravity Acceleration ",All_Names)->All_Names
sub("^t","time ",All_Names)->All_Names
sub("^f","frequency ",All_Names)->All_Names
gsub("\\-"," ",All_Names)-> All_Names
gsub("\\()","",All_Names)-> All_Names

All <- setNames(All,All_Names)
write.csv(All,"../../all.csv")


#second, independent tidy data set with the average of each variable for each activity and each subject

brief<-group_by(rawAll,subjects, activities)

write.csv(brief,"../../brief.csv")
