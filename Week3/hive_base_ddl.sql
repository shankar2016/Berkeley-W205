DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE 	hospitals(
		Provider_ID  		string,
		Name  			string,
		Address  		string,
		City  			string,
		State  			string,
		ZIP_CODE  		string,
		County  		string,
		Phone_Number  		string,
		Type  			string,
		Ownership  		string,
		Emergency_Services  	string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES( 
		"separatorChar" = ',', 
		"quoteChar" = '"', 
		"escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/';

DROP TABLE IF EXISTS effective_care;
CREATE EXTERNAL TABLE effective_care( 
		Provider_ID  		string,
		Name  			string,
		Address  		string,
		City  			string,
		State  			string,
		ZIP_CODE  		string,
		County  		string,
		Phone_Number 		string,
		Measure_ID  		string,
        	Measure_Name  		string,
        	Score  			int,
        	Sample  		int,
		Footnote  		string,
		Measure_Start_Date  	date,
		Measure_End_Date 	date
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES( 
		"separatorChar" = ',', 
		"quoteChar" = '"', 
		"escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/';

DROP TABLE IF EXISTS readmissions;
CREATE EXTERNAL TABLE readmissions( 
		Provider_ID  		string,
		Name  			string,
		Address  		string,
		City  			string,
		State  			string,
		ZIP_CODE  		string,
		County  		string,
		Phone_Number  		string,
		Measure_ID  		string,
		Measure_Name  		string,
		Compared_to_National  	string,
		Denominator  		string,
		Score  			decimal,
		Lower_Estimate  	decimal,
		Higher_Estimate  	decimal,
		Footnote  		string,
		Measure_Start_Date  	date,
		Measure_End_Date 	date	
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES( 
		"separatorChar" = ',', 
		"quoteChar" = '"', 
		"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/';

DROP TABLE IF EXISTS measures;
CREATE EXTERNAL TABLE measures( 
		Measure_Name  		string,
		Measure_ID  		string,
		Meausre_StartQuarter  	string,
		Meausre_Start_Date  	date,
		Measure_EndQuarter  	string,
		Measure_End_Date 	date	
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES( 
		"separatorChar" = ',', 
		"quoteChar" = '"', 
		"escapeChar" = '\\' 
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/';

DROP TABLE IF EXISTS surveys_responses;
CREATE EXTERNAL TABLE surveys_responses( 
		Provider_ID 		string,
		Name  			string,
		Address  		string,
		City  			string,
		State  			string,
		ZIP_CODE  		string,
		County  		string,
		Communication_with_Nurses_Achievement_Points 	string, 
		Communication_with_Nurses_Improvement_Points 	string, 
		Communication_with_Nurses_Dimension_Score 	string, 
		Communication_with_Doctors_Achievement_Points 	string, 
		Communication_with_Doctors_Improvement_Points 	string, 
		Communication_with_Doctors_Dimension_Score 	string, 
		Responsiveness_of_Hospital_Staff_Achievement_Points 	string, 
		Responsiveness_of_Hospital_Staff_Improvement_Points 	string, 
		Responsiveness_of_Hospital_Staff_Dimension_Score 	string, 
		Pain_Management_Achievement_Points 		string, 
		Pain_Management_Improvement_Points 		string, 
		Pain_Management_Dimension_Score 		string, 
		Communication_about_Medicines_Achievement_Points 	string, 
		Communication_about_Medicines_Improvement_Points 	string, 
		Communication_about_Medicines_Dimension_Score 		string, 
		Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points 	string, 
		Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points 	string, 
		Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score 	string, 
		Discharge_Information_Achievement_Points 	string, 
		Discharge_Information_Improvement_Points 	string, 
		Discharge_Information_Dimension_Score 		string, 
		Overall_Rating_of_Hospital_Achievement_Points 	string, 
		Overall_Rating_of_Hospital_Improvement_Points 	string, 
		Overall_Rating_of_Hospital_Dimension_Score 	string, 
		HCAHPS_Base_Score 				INT,
		HCAHPS_Consistency_Score 			INT
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/';
