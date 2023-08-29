
/////////////////////Experiment 1/////////////////////////////////

1a. To process all the incomplete datasets from 1 to 14, run Main Program:	

	C28_RKNN_Impute_V1.m

1b. To process single dataset, for instance the 23th dataset in \Incomplete datasets\Data 10, in Main Program：
Line 28, set i = 10:10, 
Line 53, set j = 23:23

	RKNN_Impute_Single_V1.m


/////////////////////Experiment 2/////////////////////////////////

2a. To process all the incomplete datasets from 1 to 14, run Main Program:	

	C28_RKNN_Impute_V2.m

2b. To process single dataset, for instance the 10th dataset in \Incomplete datasets\Data 6, in Main Program： 
Line 28, set i = 6:6, 
Line 53, set j = 10:10

	RKNN_Impute_Single_V2.m

////////////////////////////////////////////////////////////////////
3. MATLAB Functions:
	1) Use Random KNN for missing data imputation:

	RandomKNNImputeV5.m (used for Exp.2)

	Note: in this code, instead of using knnsearch 	function or pdist2 function, I vectorized matrices for 	Euclidian Distance computation + sort function to find the index of K smallest values of computed Euclidian distances to boost the computing speed.

	RandomKNNImputeV4.m (used for Exp.1)


                2) Sort file or folder names in natural order:

                  sort_nat.m    [1]

4. Table_NRMS_Record1.xlsx is the record of Experiment 1.

5. Table_NRMS_Record2.xlsx is the record of Experiment 2, which is incomplete. the rest datasets can be imputed and get NRMS and Runtime recorded, but it is very time consuming, so I stoped the running of main program.

6. Table_NRMS_Write.xlsx is used to write NRMS and Runtime data automatically by the Main Program.


Reference:
[1] Douglas Schwarz (2022). sort_nat: Natural Order Sort 	(https://www.mathworks.com/matlabcentral/fileexchange/10959-sort_nat-natural-order-sort), MATLAB Central File Exchange. Retrieved July 23, 2022.