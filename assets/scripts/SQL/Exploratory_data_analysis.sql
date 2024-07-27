/*
1. Define Variables
2. Create a CTE that rounds the average views per video.
3. Select the relevant columns
4. Filter the results by the YouTube Channel with the highest subscriber bases
5. Order by net profit from highest to lowest
*/


-- 1. Define the variables
DECLARE @conversionRate FLOAT = 0.02;
DECLARE @productCost MONEY = 5.0;
DECLARE @campaignCost MONEY = 50000.0;

-- 2.

WITH ChannelData AS
(
	SELECT
		channel_name,
		total_views,
		total_videos,
		ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_view_per_video
	FROM
	    dbo.view_uk_youtubers_2024


)
-- 3. Select relevant columns
SELECT 
	channel_name,
	rounded_avg_view_per_video,
	(rounded_avg_view_per_video * @conversionRate) AS potential_unit_sold_per_video,
	(rounded_avg_view_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
	(rounded_avg_view_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit

FROM 
	ChannelData

WHERE 
	channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')
	
ORDER BY 
	net_profit DESC
;