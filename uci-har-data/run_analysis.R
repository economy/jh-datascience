library(reshape2)
library(plyr)

## Read all data - NB: read.csv with arg sep=" " throws off the formatting; must use read.table for support vectors

subj_train <- read.csv("train/subject_train.txt", header=F)
subj_test <- read.csv("test/subject_test.txt", header=F)
act_train <- read.csv("train/y_train.txt", header=F)
act_test <- read.csv("test/y_test.txt", header=F)
features <- read.table("features.txt", header=F)

f <- gsub("\\(\\)","",features$V2)
f <- gsub("-","",f)
featnames <- c(f[1:6],f[41:46],f[81:86],f[121:126],f[161:166],f[201:202],f[214:215],f[227:228],f[240:241],
               f[253:254],f[266:271],f[345:350],f[424:429],f[503:504],f[516:517],f[529:530],f[542:543])

train <- read.table("train/X_train.txt", col.names=f, colClasses = 'numeric', header=F)
test <- read.table("test/X_test.txt", col.names=f, colClasses = 'numeric', header=F)

## Merge training and test, select specific columns
together <- rbind(test, train)
subjects <- rbind(subj_test, subj_train)
activities <- rbind(act_test, act_train)

pared <- subset(together, select=featnames)

## New frame (data should still be sorted in original order, so horizontal merge is acceptable)
clean <- data.frame(Subject = subjects$V1,Activity = activities$V1, pared)

## Activity labels
clean$Activity[clean$Activity==1] <- "walking"
clean$Activity[clean$Activity==2] <- "walking_upstairs"
clean$Activity[clean$Activity==3] <- "walking_downstairs"
clean$Activity[clean$Activity==4] <- "sitting"
clean$Activity[clean$Activity==5] <- "standing"
clean$Activity[clean$Activity==6] <- "laying"

## Build summary set
molten <- melt(clean, id.vars = c("Subject", "Activity"))
mns <- ddply(molten, c("Subject", "Activity", "variable"), summarize, mean = mean(value))

write.table(mns, file="summary.txt", append=F, row.names=F)
