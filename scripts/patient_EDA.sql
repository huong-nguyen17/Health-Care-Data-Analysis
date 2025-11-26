
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables dim_patient
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
select *
from [gold].[dim_patient]


--dim_patient EDA
select distinct count(*) as total_patients
from [gold].[dim_patient]

--patient segmentation by state and gender
select 
	state,
	gender, 
	count (*) as total_patients
from [gold].[dim_patient]
group by state, gender
order by state, total_patients desc

--patient segmentation by marital status
select 
	maritalstatus,
	count (*) as total_patients
from [gold].[dim_patient]
group by maritalstatus
order by total_patients desc

--patient info
select 
	DATEDIFF(year, MIN(BirthDate), GETDATE()) AS oldest_patient_age_years,
    DATEDIFF(year, MAX(BirthDate), GETDATE()) AS youngest_patient_age_years
from [gold].[dim_patient]
	
-- Age distribution
SELECT
    FLOOR(DATEDIFF(YEAR, BirthDate, GETDATE()) / 10.0) * 10 AS AgeGroup,
    COUNT(*) AS PatientCount
FROM gold.dim_patient
WHERE BirthDate IS NOT NULL
GROUP BY FLOOR(DATEDIFF(YEAR, BirthDate, GETDATE()) / 10.0) * 10
ORDER BY PatientCount desc;

-- Nulls in important columns
SELECT
    SUM(CASE WHEN BirthDate IS NULL THEN 1 ELSE 0 END) AS MissingBirthDate,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END)     AS MissingGender,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END)       AS MissingCity
FROM gold.dim_patient;
--patient background 
select distinct language
from [gold].[dim_patient]
