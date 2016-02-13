
##read in train dataset and test dataset. Rename the dataset
data.1 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/X_test.txt")
name.data = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/features.txt")
names(data.1) = name.data[,2]
data.2 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/Y_test.txt")
data.3 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/X_train.txt")
names(data.3) = name.data[,2]

##combine the two datasets
data.whole = rbind(data.1,data.3)

##extract variables contain "mean", "Mean", or "std".
colno = grep("[Mm]ean|std",name.data[,2])
dim(data.whole)
data.req = data.whole[,colno]

##calculate the average of extracted dataset
data.avg = as.data.frame(apply(data.req,1,mean))
names(data.avg) = "average"
write.table(data.avg,"dataavg.txt",row.name =F)
