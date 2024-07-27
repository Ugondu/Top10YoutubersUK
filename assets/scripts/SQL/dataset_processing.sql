/* 
# Data cleaning steps
1. Remove columns not relevant to the analysis
2. Extract YouTube channel names from the 'Nombre' column
3. Rename necessary columns using aliases

*/

--SELECT 
--	NOMBRE,
--	total_subscribers,
--	total_views,
--	total_videos
--FROM TOP_10_INFLUENCERS
;

-- Extract Channel names from 'NOMBRE' column using CHARINDEX AND SUBSTRING FUNCTIONS

SELECT CHARINDEX('@', NOMBRE), NOMBRE
FROM TOP_10_INFLUENCERS;

-- USING SUBSTRING FUNCTION TO EXTRACT THE NAMES FROM THE COLUMN
SELECT SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS channel_name
FROM TOP_10_INFLUENCERS;
































- TO ENSURE THAT THE COLUMN ONLY TAKES IN STRING USING CAST FUNCTION
SELECT CAST(
			SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS varchar(100))
					AS channel_name
FROM TOP_10_INFLUENCERS;

-- TO RESTORE THE COLUMNS RELEVANT TO OUR ANALYSIS
SELECT CAST(
			SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS varchar(100))
					AS channel_name,
					total_subscribers,
					total_videos,
					total_views
FROM TOP_10_INFLUENCERS;

-- TO CREATE A VIEW FOR POWERBI USERS

CREATE VIEW view_uk_youtubers_2024 AS

SELECT CAST(
			SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS varchar(100))
					AS channel_name,
					total_subscribers,
					total_videos,
					total_views
FROM TOP_10_INFLUENCERS;
-- View Created Table
SELECT *
FROM 
view_uk_youtubers_2024;

/*
# Data Quality checks.
1. The data needs to be of 100 rows ( Perform a row count test)
2. The dataset needs four fields (Column count test)
3. The channel name must be in string format, total subscribers, total videos, total views in whole number.
4. Each record muust be void of duplicate values.
*/

-- Row Count using the count function

SELECT COUNT(*) AS no_of_rows
FROM view_uk_youtubers_2024 ;

-- Column count check using information schema
SELECT COUNT(*) as COLUMN_COUNT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_uk_youtubers_2024'

-- Data Type check using information schema
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_uk_youtubers_2024';

-- CHECK FOR DUPLICATES
SELECT channel_name,
		COUNT(*) as duplicate_count
FROM view_uk_youtubers_2024
GROUP BY channel_name
HAVING COUNT(*) > 1;

-- Having completed the dataset cleaning and quality checks, the dataset is fit for further analysis on PowerBi.

