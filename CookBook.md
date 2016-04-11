1. subject = tracks individual who performed activity

2. activity = name of activity performed: Laying, Sitting , Walking, Walking Upstairs, Walking Downstairs

3. feature(s) =	identified by the accelerometer and gyroscope used during testing/training sessions

4. (T)Time =	time measurement

5. (F)Frequency	= frequency domain signal  measurement

6. Body =	physical movement

7. Acc =	acceleration of movement

8. Gravity =	acceleration with gravitational factor

9. Gyro =	gyroscope instrument measurement

10.Jerk =	sudden movement

11.Mag =	movement magnitude

12.subTrain	= stores data table for subject training raw data

13.SubTest = stores data table for subject testing raw data

14.yActiveTrain =	stores data table for y training labels

15.yActiveTest = stores data table for y testing labels

16.xDataTrain =	stores data table for x training set

17.xDataTest =	stores data table fo x testing set

18.totalSubject =	stores row binding of the subTest and Subtraining raw data

19.totalYActivity	= stores row binding for y label training and testing raw data

20.dataTable =	stores the merged data from all raw data sources 

21.dataFeatures =	stores features.text raw data into a data table

22.activtiyLables	= stores activity_labels.txt raw data into a data table

23.TotalSubandYAct = stores the binding of columns for the totalSubject and TotalYActivity data tables

24.dataFeaturesMeanStd =	extracts the mean and standard deviation to another variable: dataFeatures$featureName
