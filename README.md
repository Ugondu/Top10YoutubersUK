# Data Portfolio: Excel to Power BI
![image](https://github.com/user-attachments/assets/2ea73bed-e58f-4d65-a490-375ea3d278a7)
## Table of Contents.
- [Objective](#objective)
- [Data Source](#data-source)
- [Data Processing Steps](#data-processing-steps)
- [Design](#design)
	- [Dashboard Template](#dashboard-template)
	- [Tools](#tools)
- [Development](#development)
	- [Data Exploration](#data-exploration)
	- [Data Cleaning](#data-cleaning)
	- [Data Transformation](#data-transformation)
	- [Create SQL view](#create-sql-view)
- [Visualization](#visualization)
	- [Results](#results)
	- [PowerBI DAX Measures](#powerbi-dax-measures)
- [Analysis](#analysis)
	- [Findings](#findings)
- [Recommendations](#recommendations)
- [Conclusion](#conclusion)

# Objective
The Head of Marketing plans to run a campaign for the remainder of the year and seeks to identify the top YouTube channels to effectively reach end users. 
### To achieve this objective
Create a dashboard that provides insight into the top UK YouTubers in 2024 to include their
* Subscriber count
* Total views
* Total videos, and
* Engagement metrics
This will guide the marketing team to make informed decisions about the best performing YouTube channels to collaborate with for their marketing campaigns.
## User story
As the Head of Marketing, I want to use a dashboard that analyzes YouTube channel data in the UK. This dashboard should allow us to identify the top-performing channels based on metrics like subscriber base and average views. With this information, I can make informed decisions about which YouTubers are right to collaborate with, thereby maximizing the effectiveness of each marketing campaign.
# Data source
### What data is needed to achieve our objective?
We need data on the top UK youtubers in 2024 that includes their.
* Channel names
* Total subscribers
* Total views
* Total videos uploaded  

### Where has the dataset originated from?

The data is sourced from Kaggle, the link can be found here  [see here to find it.](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download)
# Data Processing Steps.
-	Design
-	Tools
# Design
## Dashboard components required
### What should the dashboard contain based on the requirement provided?
To understand what it should contain, we need to figure out what questions we need the dashboard to answer:
1.	Who are the top 10 YouTubers with the most subscribers?
2.	Which 3 channels have uploaded the most videos?
3.	Which 3 channels have the most views?
4.	Which 3 channels have the highest average views per video?
5.	Which 3 channels have the highest views per subscriber ratio?
6.	Which 3 channels have the highest subscriber engagement rate per video uploaded?
## Template
### The final dashboard should look like 
![image](https://github.com/user-attachments/assets/465bb0aa-0bf6-4054-a996-84f3fbb878cd)

### The data visuals that may be appropriate and effective in answering our business questions:
1. Table
2. Treemap
3. Scorecards
4. Horizontal bar chart
## Tools 

| Tool | Purpose |
| --- | --- |
| Excel | Exploring the data |
| SQL Server | Cleaning, testing, and analyzing the data |
| Power BI | Visualizing the data via interactive dashboards |
| GitHub | Hosting the project documentation and version control |
| Mokkup AI | Designing the wireframe/mockup of the dashboard |

# Development
### The step-by-step approach in dealing with the business problem;
1.	Get the data
2.	Explore the data in Excel
3.	Load the dataset into the SQL server
4.	Clean the dataset with SQL
5.	Test the dataset with SQL
6.	Visualise the cleaned dataset in Power BI
7.	Generate the findings based on the insights
8.	Document and publish on GitHub page.
## Data exploration
To prepare the dataset for analysis, we examine for errors, inconsistencies, whitespaces, and any other issues that may arise during data collection and entry.

### Dataset Overview.
From the dataset it appears that the ‘channel_name’ column contains the channel ID which is separated by ‘@’ sign. 
### Data cleaning
To refine and structure the dataset ready for exploratory data analysis, 
*Extract the channel name from the first column
*Remove columns not relevant to our analysis
*Convert each column to the appropriate datatype
*Remove null and blank columns.
### Transform the data 
```sql
/*
# 1. Select the required columns
# 2. Extract the channel name from the 'NOMBRE' column
*/

-- 1.
SELECT
    SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS channel_name,  -- 2.
    total_subscribers,
    total_views,
    total_videos

FROM
    TOP_10_INFLUENCERS
```
### Create the SQL view 

```sql
/*
# 1. Create a view to store the transformed data
# 2. Cast the extracted channel name as VARCHAR(100)
# 3. Select the required columns from the     TOP_10_INFLUENCERS
SQL table 
*/

-- 1.
CREATE VIEW view_uk_youtubers_2024 AS

-- 2.
SELECT
    CAST(SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS VARCHAR(100)) AS channel_name, -- 2. 
    total_subscribers,
    total_views,
    total_videos

-- 3.
FROM
    TOP_10_INFLUENCERS

```
# Visualization 
### Results

### What does the dashboard look like?

![image](https://github.com/user-attachments/assets/5f026720-55a7-461f-8f0b-6785c63a653b)


This shows the top YouTubers for 2024 in the UK based on subscription, views, and videos uploaded. 
### PowerBI DAX Measures
### 1. Total Subscribers (M)
```sql
Total Subscribers (M) = 
VAR million = 1000000
VAR sumOfSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR totalSubscribers = DIVIDE(sumOfSubscribers,million)

RETURN totalSubscribers

```

### 2. Total Views (B)
```sql
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR totalViews = ROUND(sumOfTotalViews / billion, 2)

RETURN totalViews

```

### 3. Total Videos
```sql
Total Videos = 
VAR totalVideos = SUM(view_uk_youtubers_2024[total_videos])

RETURN totalVideos

```

### 4. Average Views Per Video (M)
```sql
Average Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR  avgViewsPerVideo = DIVIDE(sumOfTotalViews,sumOfTotalVideos, BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo 

```
### 5. Subscriber Engagement Rate
```sql
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngRate 

```
### 6. Views per subscriber
```sql
Views Per Subscriber = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews, sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber 

```
# Analysis 

## Findings
Our analysis will be guided by the following business questions below - 
1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?


### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name         | Subscribers (M) |
|------|----------------------|-----------------|
| 1    | NoCopyrightSounds    | 33.60           |
| 2    | DanTDM               | 28.60           |
| 3    | Dan Rhodes           | 26.50           |
| 4    | Miss Katy            | 24.50           |
| 5    | Mister Max           | 24.40           |
| 6    | KSI                  | 24.10           |
| 7    | Jelly                | 23.50           |
| 8    | Dua Lipa             | 23.30           |
| 9    | Sidemen              | 21.00           |
| 10   | Ali-A                | 18.90           |


### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name    | Videos Uploaded |
|------|-----------------|-----------------|
| 1    | GRM Daily       | 14,696          |
| 2    | Manchester City | 8,248           |
| 3    | Yogscast        | 6,435           |



### 3. Which 3 channels have the most views?


| Rank | Channel Name | Total Views (B) |
|------|--------------|-----------------|
| 1    | DanTDM       | 19.78           |
| 2    | Dan Rhodes   | 18.56           |
| 3    | Mister Max   | 15.97           |


### 4. Which 3 channels have the highest average views per video?

| Channel Name | Averge Views per Video (M) |
|--------------|-----------------|
| Mark Ronson  | 32.27           |
| Jessie J     | 5.97            |
| Dua Lipa     | 5.76            |


### 5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel Name       | Views per Subscriber        |
|------|-----------------   |---------------------------- |
| 1    | GRM Daily          | 1185.79                     |
| 2    | Nickelodeon        | 1061.04                     |
| 3    | Disney Junior UK   | 1031.97                     |


### 6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel Name    | Subscriber Engagement Rate  |
|------|-----------------|---------------------------- |
| 1    | Mark Ronson     | 343,000                     |
| 2    | Jessie J        | 110,416.67                  |
| 3    | Dua Lipa        | 104,954.95                  |

1. NoCopyrightSOunds, Dan Rhodes and DanTDM are the channnels with the most subscribers in the UK
2. GRM Daily, Man City and Yogscast are the channels with the most videos uploaded
3. DanTDM, Dan RHodes and Mister Max are the channels with the most views
4. Entertainment channels are useful for broader reach, as those consistently posting and generating the most engagement focus on entertainment and music.



# Recommendations 
1. Dan Rhodes is the best YouTube channel to collaborate with if we want to maximize visbility because this channel has the most YouTube subscribers in the UK
2. Although GRM Daily, Man City and Yogcasts are regular publishers on YouTube, it may be worth considering whether collaborating with them with the current budget caps are worth the effort, as the potential return on investments is significantly lower compared to the other channels.
3. Mister Max is the best YouTuber to collaborate with if we're interested in maximizing reach, but collaborating with DanTDM and Dan Rhodes may be better long-term options considering the fact that they both have large subscriber bases and are averaging significantly high number of views.
4. The top 3 channels to form collaborations with are NoCopyrightSounds, DanTDM and Dan Rhodes based on this analysis, because they attract the most engagement on their channels consistently.

# Conclusion
### Recommended Course of Action:
Based on our analysis, we believe the best channel to establish a long-term partnership to promote the client's products is the Dan Rhodes channel. We will engage with the marketing client to understand their expectations from this collaboration. 
If we successfully meet the expected milestones, we will consider future partnerships with the DanTDM, Mister Max, and NoCopyrightSounds channels.
Steps to Implement the Recommended Decisions Effectively:
1. Initiate Contact:
	* Reach out to the teams behind each of these channels, starting with Dan Rhodes.
	* Reason: Building a relationship and setting the groundwork for negotiation.
2. Negotiate Contracts:
	* Negotiate contracts within the budgets allocated to each marketing campaign.
	* Reason: Ensure financial feasibility and mutual agreement on deliverables and terms.
3. Launch Campaigns:
	* Kick off the campaigns and track their performances against the KPIs.
	* Reason: Monitor and ensure the campaigns are delivering the expected results.
4.Review and Optimize:
	* Review the campaigns' outcomes, gather insights, and optimize based on feedback from converted customers and each channel's audiences.
	* Reason: Continuously improve the campaign's effectiveness and make data-driven decisions for future collaborations.

By following these steps, we can effectively implement the recommended decisions and maximize the success of our marketing campaigns through strategic partnerships with top-performing YouTube channels.


