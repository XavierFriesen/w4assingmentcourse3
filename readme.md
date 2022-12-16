Data is obtained from the UCI Machine Learning Repository. 
The reference is:
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory

Data is a recording of 30 subjects activities in their daily life, as captured by a digital watch with inertial sensors. In total 10299 observations of 6 behaviors by 30 subjects are observed. 

First data-set
Relevant Variables: 
Activity: Describes the activity the subject was performing during the measurement. There are in total six behaviors: 1) walking, 2) walking upstairs, 3) walking downstairs, 4) standing, 5) sitting, 6) lying. 

Subjects: identifies from which subject the measurement is. In total there are 30 subjects. 

Measurement Variables: Means and standard deviations over time in X-Y-Z dimensions. 

Second data-set: 
This dataset is the processed version of the data-set. It calculates the average values of the measurement version per subject per activity. 

Processing: 
Data was first loaded, next the six datasets were merged, and only measurements on mean and standard deviation were kept. The variables names were made better understandable, and the values for the activity variable were changed from numbers to easy-to-understand phrases. Lastly, the data was grouped by activity and subject, to calculate the means for all the other variables and report this in a seperate csv file. 