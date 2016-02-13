
##read in train dataset and test dataset. Rename the dataset
data.1 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/X_test.txt")
name.data = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/features.txt")
act.test = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/y_test.txt")
names(data.1) = name.data[,2]
act.train = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/y_train.txt")
data.3 = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/X_train.txt")
names(data.3) = name.data[,2]
sub.test = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/test/subject_test.txt")
sub.train = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/train/subject_train.txt")
##combine the two datasets
data.whole = rbind(data.1,data.3)
data.act = rbind(act.test,act.train)
names(data.act) ="activity"
data.sub = rbind(sub.test,sub.train)
names(data.sub) = "subject.id"

##extract variables contain "mean", "Mean", or "std".
colno = grep("[Mm]ean|std",name.data[,2])
dim(data.whole)
data.req = data.whole[,colno]
data.req.w = cbind(data.req,data.act,data.sub)

##calculate the average of extracted dataset
data.avg = as.data.frame(tapply(data.req.w,factor(data.req.w$activity),mean))

require("dplyr")
data.avg = data.req.w %>%
  group_by(activity,subject.id) %>%
  summarise_each(funs(mean(.,na.rm = TRUE)))

label.act = read.table("/Users/yexu/Documents/coursera/UCI HAR Dataset/activity_labels.txt")
names(label.act)=c("activity","activity.id")


dim(data.avg)
tidy = merge(label.act,data.avg,"activity")
dim(tidy)
tidy = tidy[,-1]
write.table(tidy,"/Users/yexu/Documents/coursera/tidy.txt",row.name =FALSE)
