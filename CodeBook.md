CodeBook
====================================

The code [run_analysis.R](https://github.com/zmy/Samsung-Accelerometers-Data-Analysis/blob/master/run_analysis.R) performs following actions:
 1. Read table **UCI HAR Dataset/train/X_train.txt** into variable ```X_train``` and table **UCI HAR Dataset/train/X_test.txt** into ```X_test```. Then using ```rbind2``` to combine them into ```X```.
 2. Read the feature names from **UCI HAR Dataset/features.txt** into ```features```, and rename the duplicated names. Then assign ```features``` as the column names of ```X```.
 3. Calculate mean and standard deviation of each feature. The result is stored in the variable ```summary```.
 4. Read list **UCI HAR Dataset/train/y_train.txt** into variable ```y_train``` and **UCI HAR Dataset/test/y_test.txt** into ```y_test```. Then combine them into ```y``` - activity lables corresponding to ```X```.
 5. Change ```y``` into strings according to **UCI HAR Dataset/activity_labels.txt** and then assign it as a new column of ```X``` named ```labels```.
 6. Read list **UCI HAR Dataset/train/subject_train.txt** into variable ```subject_train``` and **UCI HAR Dataset/test/subject_test.txt** into ```subject_test```. Then combine them and assign as a new column of ```X``` as ```subject```
 7. Using ```melt``` and ```dcast``` method in library ```reshape2```, calculate the average of each feature of each ```labels``` and ```subject```.
