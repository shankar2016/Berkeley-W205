select Metric1 from surveys_responses_parquet LIMIT 5;
select Metric2 from surveys_responses_parquet LIMIT 5;
select Metric3 from surveys_responses_parquet LIMIT 5;
select Metric4 from surveys_responses_parquet LIMIT 5;
select Metroc5 from surveys_responses_parquet LIMIT 5;
select Metric6 from surveys_responses_parquet LIMIT 5;
select Metric7 from surveys_responses_parquet LIMIT 5;
select Metric8 from surveys_responses_parquet LIMIT 5;
select Metric9 from surveys_responses_parquet LIMIT 5;
select Metric10 from surveys_responses_parquet LIMIT 5;
select Metric11 from surveys_responses_parquet LIMIT 5;
select Metric12 from surveys_responses_parquet LIMIT 5;
select Metric13 from surveys_responses_parquet LIMIT 5;
select Metric14 from surveys_responses_parquet LIMIT 5;
select Metric15 from surveys_responses_parquet LIMIT 5;
select Metric16 from surveys_responses_parquet LIMIT 5;
select Metric17 from surveys_responses_parquet LIMIT 5;
select Metric18 from surveys_responses_parquet LIMIT 5;
select Metric19 from surveys_responses_parquet LIMIT 5;
select Metric20 from surveys_responses_parquet LIMIT 5;
select Metric21 from surveys_responses_parquet LIMIT 5;
select Metric22 from surveys_responses_parquet LIMIT 5;
select Metric23 from surveys_responses_parquet LIMIT 5;
select Metric24 from surveys_responses_parquet LIMIT 5;


SELECT regexp_extract(Metric23, '[0-9]$', 0) as survey_score FROM surveys_responses_parquet LIMIT 10;
SELECT regexp_extract(Metric21, '[0-9][0-9]$', 0) as survey_score FROM surveys_responses_parquet LIMIT 10;

-- From the survey scores, extract a composite score from all the "Dimension" scores and the 
-- HCAHPS data. The dimension scores are in the "# out of ##" format. So, extarct the leading
-- number and divide by the total to get an average. Then add the HCAHPS Score to create the
-- composite on which we will make a decision
DROP TABLE IF EXISTS survey_composite;
CREATE TABLE IF NOT EXISTS survey_composite AS
SELECT Provider_ID, Name, 
	((regexp_extract(Metric3, '^[0-9]+', 0)+
	regexp_extract(Metric6, '^[0-9]+', 0)+
	regexp_extract(Metric9, '^[0-9]+', 0)+
	regexp_extract(Metric12, '^[0-9]+', 0)+
	regexp_extract(Metric15, '^[0-9]+', 0)+
	regexp_extract(Metric18, '^[0-9]+', 0)+
	regexp_extract(Metric21, '^[0-9]+', 0)+
	regexp_extract(Metric24, '^[0-9]+', 0))/80 + 
	regexp_extract(HCAHPS_Consistency_Score, '^[0-9]+', 0)) as survey_score
FROM surveys_responses_parquet
ORDER BY survey_score DESC
LIMIT 20;


SELECT hospitals_parquet.Provider_ID, corr(overall_hospital_score.t_score, survey_composite.survey_score) AS h_corr
FROM hospitals_parquet JOIN overall_hospital_score JOIN survey_composite 
ON hospitals_parquet.Provider_ID = overall_hospital_score.Provider_ID AND hospitals_parquet.Provider_ID = survey_composite.Provider_ID
GROUP BY hospitals_parquet.Provider_ID
ORDER BY h_corr DESC
LIMIT 20;



-- Bring in the scores from the effective care table
DROP TABLE IF EXISTS score_data;

CREATE TABLE IF NOT EXISTS score_data AS
SELECT Provider_ID, AVG(Score) AS eff_score FROM effective_care_parquet
GROUP BY Provider_ID
ORDER BY eff_score DESC;


-- Summarize the survey data from the survey_composite to just get the
-- needed fields of Provider_ID and Overall Survey score
DROP TABLE IF EXISTS survey_data;

CREATE TABLE IF NOT EXISTS survey_data AS
SELECT Provider_ID, AVG(survey_score) AS sur_score FROM survey_composite
GROUP BY Provider_ID
ORDER BY sur_score DESC;


-- Put together the data from the effective care and surveys
-- call the summarixed table as all_data
-- Summarize results from all_data table
DROP TABLE IF EXISTS all_data;

CREATE TABLE IF NOT EXISTS all_data AS
SELECT score_data.eff_score, survey_data.sur_score FROM score_data, survey_data
GROUP BY score_data.Provider_ID
LIMIT 20;



ON (score_data.Provider_ID = survey_data.Provider_ID)





SELECT name, 
	(regexp_extract(Metric3, '^[0-9]', 0)+
	regexp_extract(Metric6, '^[0-9]', 0)+
	regexp_extract(Metric9, '^[0-9]', 0)+
	regexp_extract(Metric12, '^[0-9]', 0)+
	regexp_extract(Metric15, '^[0-9]', 0)+
	regexp_extract(Metric18, '^[0-9]', 0)+
	regexp_extract(Metric21, '^[0-9]', 0)+
	regexp_extract(Metric24, '^[0-9]', 0)+
	regexp_extract(HCAHPS_Consistency_Score, '^[0-9]', 0)) as score
FROM surveys_responses_parquet
WHERE name LIKE  "HOSP COMUNITARIO BUEN SAMARITANO";


SELECT name, 
	(regexp_extract(Metric3, '^[0-9]', 0)+
	regexp_extract(Metric6, '^[0-9]', 0)+
	regexp_extract(Metric9, '^[0-9]', 0)+
	regexp_extract(Metric12, '^[0-9]', 0)+
	regexp_extract(Metric15, '^[0-9]', 0)+
	regexp_extract(Metric18, '^[0-9]', 0)+
	regexp_extract(Metric21, '^[0-9]', 0)+
	regexp_extract(Metric24, '^[0-9]', 0)+
	regexp_extract(HCAHPS_Consistency_Score, '^[0-9]', 0)) as score
FROM surveys_responses_parquet
WHERE name LIKE  "MEDINA REGIONAL HOSPITAL";


450348	FALLS COMMUNITY HOSPITAL AND CLINIC	251.28333333333333
400079	HOSP COMUNITARIO BUEN SAMARITANO	184.1
451330	MEDINA REGIONAL HOSPITAL	151.25714285714287
310002	NEWARK BETH ISRAEL MEDICAL CENTER	148.61578947368423
400032	HOSPITAL HERMANOS MELENDEZ INC	145.5327485380117
051318	REDWOOD MEMORIAL HOSPITAL	144.48333333333335
261317	MERCY HOSPITAL CASSVILLE	144.1
331316	COMMUNITY MEMORIAL HOSPITAL, INC	141.47916666666666
400013	HOSPITAL MENONITA DE CAYEY	140.675
140300	PROVIDENT HOSPITAL OF CHICAGO	139.96666666666667
