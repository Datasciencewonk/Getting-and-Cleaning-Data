Variable Name	Description	
subject =   	tracks individual who performed activity	
activity =	name of activity performed: Laying, Sitting , Walking, Walking Upstairs, Walking Downstairs	
feature(s)= 	identified by the accelerometer and gyroscope used during testing/training sessions	
(T)Time		time measurement	
(F)Frequency	frequency domain signal  measurement	
Body		physical movement	
Acc		acceleration of movement	
Gravity		acceleration with gravitational factor	
Gyro		gyroscope instrument measurement	
Jerk		sudden movement	
Mag		movement magnitude	
subTrain	stores data table for subject training raw data	
SubTest	stores 	data table for subject testing raw data	
yActiveTrain	stores data table for y training labels	
yActiveTest	stores data table for y testing labels	
xDataTrain	stores data table for x training set	
xDataTest	stores data table fo x testing set	
totalSubject	stores row binding of the subTest and Subtraining raw data	
totalYActivity	stores row binding for y label training and testing raw data	
dataTable	stores the merged data from all raw data sources 	
dataFeatures	stores features.text raw data into a data table	
activtiyLables	stores activity_labels.txt raw data into a data table	
TotalSubandYAct	stores the binding of columns for the totalSubject and TotalYActivity data tables	
 
