
setwd("C:/Users/Louis Hognon/Documents/FormationR/Getting_and_cleaning_data")
#

# 0/ Dowload the data of X_train and X_test-------------------

X_test <- read.table("~/FormationR/Getting_and_cleaning_data/X_test.txt", quote="\"",
                     comment.char="")

X_train <- read.table("~/FormationR/Getting_and_cleaning_data/X_train.txt", quote="\"",
                      comment.char="")


# 1/ Merge the two files X_train and X_test----------------
fusion <- rbind(X_test,X_train)


# 2/ Extracts only the measurements on the mean and standard deviation for each measurement--------------

means <- apply(fusion,2,mean)
sd <- apply(fusion, 2, sd)

## 2 bis

resuls <- data.frame(noms_colonnes = names(fusion), moyenne = means, ecart_type = sd)

# 3/ Uses descriptive activity names to name the activities in the data set------------------

listname <- read.table("~/FormationR/Getting_and_cleaning_data/features.txt",
                       quote="\"", comment.char="")
      
      
##3 Check : all the names are contained within the $V2 or [2] of listname dataframe
head(listname$V2,4)

# 4/ Appropriately labels the data set with descriptive variable names------------------
colnames(fusion) <- listname$V2

# 5/From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject--------------

#Add a Source column to identify X and Y data
fusion$Source <- rep(c("X_test", "X_train"), c(nrow(X_test), nrow(X_train)))

#Check the number of X_test and X_train
table(fusion$Source)

#Create a data frame specified by subject X_train and X_test, use num_cols
num_cols <- names(fusion)[1:561]

# Calculate the mean by each subject
mean_fusion <- aggregate(fusion[num_cols], by = list(fusion[, "Source"]), FUN = mean)

# Rename the column "Group.1" by "People"
colnames(mean_fusion)[1] <- "People"

#Extract the data with write.table

write.table(mean_fusion,file = "Tidy_data_set_by_subject.txt", sep = "\t", row.names = FALSE)
#The sep argument specifies the separator character between the columns in the text file. 

