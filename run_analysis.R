
##read in train dataset and test dataset. Rename the dataset
data.1 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/X_test.txt")
name.data = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/features.txt")
act.test = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/y_test.txt")
names(data.1) = name.data[,2]
act.train = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/y_train.txt")
data.3 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/X_train.txt")
names(data.3) = name.data[,2]

##combine the two datasets
data.whole = rbind(data.1,data.3)
data.act = rbind(act.test,act.train)
names(data.act) ="activity"



##extract variables contain "mean", "Mean", or "std".
colno = grep("[Mm]ean|std",name.data[,2])
dim(data.whole)
data.req = data.whole[,colno]
data.req.w = cbind(data.req,data.act)
##calculate the average of extracted dataset
data.avg = as.data.frame(tapply(data.req.w,factor(data.req.w$activity),mean))

require("dplyr")
data.avg = data.req.w %>%
  group_by(activity) %>%
  summarise_each(funs(mean(.,na.rm = TRUE)))
label.act = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/activity_labels.txt")
dim(data.avg)
data.avg[,1]= label.act[,2]
names(data.avg)
write.table(data.avg,"/Users/yexu/Documents/coursera/dataavg.txt",row.name =FALSE)
