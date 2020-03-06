# -----  add library
require(dplyr)

# -----  create variables
FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
NameFile <- "Dataset.zip"
OnlyName <- "UCI HAR Dataset"

# -----  download archive
## ----- if we don't have file with the same name
if (!file.exists(NameFile)) {
  download.file(FileUrl, NameFile, mode = "wb")
}

# -----  download archive
unzip(NameFile)

# -----  read files
Subject_tr <- read.table(file.path(OnlyName, "train", "subject_train.txt"))
Values_tr <- read.table(file.path(OnlyName, "train", "X_train.txt"))
Activity_tr <- read.table(file.path(OnlyName, "train", "y_train.txt"))
Subject_tt <- read.table(file.path(OnlyName, "test", "subject_test.txt"))
Values_tt <- read.table(file.path(OnlyName, "test", "X_test.txt"))
Activity_tt <- read.table(file.path(OnlyName, "test", "y_test.txt"))
Features <- read.table(file.path(OnlyName, "features.txt"), as.is = TRUE)
Activities <- read.table(file.path(OnlyName, "activity_labels.txt"))

# -----  join files
Full_Activity <- rbind(
  cbind(Subject_tr, Values_tr, Activity_tr),
  cbind(Subject_tt, Values_tt, Activity_tt)
)

# ----- assign column names
colnames(Full_Activity) <- c("subject", Features[, 2], "activity")

# ----- determine columns of data set wtih mean and standart_deviation
# ----- after we extract this data ser in our table
Full_Activity <- Full_Activity[, grepl("subject|activity|mean|std", colnames(Full_Activity))]

# ----- replace activity values with named factor levels
Full_Activity$activity <- factor(Full_Activity$activity, 
                                 levels = Activities[, 1], labels = Activities[, 2])

# ----- row names
Full_Activity_Cols <- colnames(Full_Activity)

# ----- delete special symbols
Full_Activity_Cols <- gsub("[\\(\\)-]", "", Full_Activity_Cols)

# ----- rename our row names
Full_Activity_Cols <- gsub("^f", "freq", Full_Activity_Cols)
Full_Activity_Cols <- gsub("^t", "time", Full_Activity_Cols)
Full_Activity_Cols <- gsub("Acc", "Accelerometer", Full_Activity_Cols)
Full_Activity_Cols <- gsub("Gyro", "Gyroscope", Full_Activity_Cols)
Full_Activity_Cols <- gsub("Mag", "Magnitude", Full_Activity_Cols)
Full_Activity_Cols <- gsub("Freq", "Frequency", Full_Activity_Cols)
Full_Activity_Cols <- gsub("mean", "Mean", Full_Activity_Cols)
Full_Activity_Cols <- gsub("std", "Standard_Deviation", Full_Activity_Cols)

# ----- give row names back in our table 
## ----- cleaning doubles names for better views
colnames(Full_Activity) <- gsub("BodyBody", "Body", Full_Activity_Cols)

# ----- group by subject and activity and summarise using mean
Full_Activity_Means <- Full_Activity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# ----- return table "tidy.txt"
write.table(Full_Activity_Means, "tidy.txt", row.names = FALSE, 
            quote = FALSE)

