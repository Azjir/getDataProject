activityNames <- read.table("activity_labels.txt",col.names=c("ActivityNumber,activityName"))
featureNames <- as.character(read.table("features.txt")$V2)

xTest <- read.table("test/X_test.txt")
subTest <- read.table("test/subject_test.txt",colClasses="factor")
yTest <- read.table("test/y_test.txt",colClasses="factor")

xTrain <- read.table("train/X_train.txt")
subTrain <- read.table("train/subject_train.txt",colClasses="factor")
yTrain <- read.table("train/y_train.txt",colClasses="factor")

testData <- cbind(subTest,yTest,xTest)
trainData <- cbind(subTrain,yTrain,xTrain)
allData <- rbind(testData,trainData)

names(allData) <- c("Subject","ActivityNumber",featureNames)
meanStDevIndices <- grep("mean|std",featureNames) + 2
allDataAndNames <- merge(allData,activityNames,sort=FALSE)

Subject <- allDataAndNames$Subject
ActivityName <- allDataAndNames$ActivityNumber.activityName
tidyData <- split(allDataAndNames[,meanStDevIndices],paste(Subject,ActivityName))

Result <- sapply(tidyData,colMeans)

write.table(Result,"result.txt",row.name=FALSE)
write.table(rownames(Result),"resultRows.txt")
