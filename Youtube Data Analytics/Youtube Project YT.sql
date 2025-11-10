SELECT TOP (1000) [video_id]
      ,[video_trending_date]
      ,[video_trending_country]
      ,[channel_id]
      ,[video_title]
      ,[video_category_id]
      ,[video_duration]
      ,[video_dimension]
      ,[video_definition]
      ,[video_licensed_content]
      ,[video_view_count]
      ,[video_like_count]
      ,[video_comment_count]
      ,[channel_title]
      ,[channel_description]
      ,[channel_custom_url]
      ,[channel_country]
      ,[channel_view_count]
      ,[channel_subscriber_count]
      ,[channel_have_hidden_subscribers]
      ,[channel_video_count]
      ,[channel_localized_title]
      ,[video_pub_date]
      ,[video_pub_day]
      ,[video_pub_hour]
      ,[channel_pub_date]
      ,[channel_pub_day]
      ,[channel_pub_hour]
      ,[Engagemen_Rate]
      ,[dislike]
      ,[like_ratio]
  FROM [Team Project YT].[dbo].[youtube_trending_3_countries CD]

  select *
  from[youtube_trending_3_countries CD]
  
  --1.
 /* Identify top 10 channels by view_count */
  select top 10 channel_title,sum(video_view_count)as views
  from[youtube_trending_3_countries CD]
  group by channel_title
  order by views desc

  /* Identify top 10 channels by like_count */
  select top 10 channel_title,sum(video_like_count)as likes
  from[youtube_trending_3_countries CD]
  group by channel_title
  order by likes desc

  /* Identify top 10 channels by Engagemen_rate */
  select  top 10  channel_title,avg(Engagemen_Rate)as Engagement_rate
  from[youtube_trending_3_countries CD]
  group by channel_title
  order by Engagement_Rate desc

  --2.Find which categories have the highest average views. 
  select top 1 video_category_id,avg(video_view_count)as avg_count
  from[youtube_trending_3_countries CD]
  group by video_category_id
  order by avg_count desc

  --3.Compare engagement rates across selected countries. 
  select channel_country,avg(Engagemen_Rate)as avg_engagemen_rate
  from[youtube_trending_3_countries CD]
  group by channel_country
  order by avg_engagemen_Rate desc

  --4.Analyze weekly trends in uploads and views. 
  select video_pub_day,
  count(video_id) as total_uploads,
  sum(video_view_count)as total_view
  from[youtube_trending_3_countries CD]
  group by video_pub_day
 order by video_pub_day

 --Analyze monthly trends in uploads and views. 
 select 
    year(video_pub_date)as year_trend,
  month(video_pub_date)as month_trend,
  count(video_id) as total_uploads,
  sum(video_view_count)as total_view
  from[youtube_trending_3_countries CD]
  group by year(video_pub_date),month(video_pub_date)
 order by year_trend ,month_trend ;

 --5.Latest Top 10 Trending Videos --
 select top 10 Video_id,video_title,video_category_id,
 video_trending_date,video_trending_country
 from[youtube_trending_3_countries CD]
 order by video_trending_date desc;

 --  LatestTop 10 trending video in india--
 select top 10 Video_id,video_title,video_category_id,
 video_trending_date,video_trending_country
 from[youtube_trending_3_countries CD]
 where video_trending_country='IND'
order by video_trending_date desc;
 
 --6.Category Wise total_created_videos--
 select video_category_id, count(video_id)as total_videos
 from[youtube_trending_3_countries CD]
 group by video_category_id
 order by total_videos desc

 --7.Find top 10 videos which duration is higher to 5 minutes.
 select top 10 video_title,video_duration,video_view_count,
 channel_title,channel_country,video_category_id
 from[youtube_trending_3_countries CD]
 where video_duration>'pt5m5s'
 order by video_view_count desc

 -- 8. Top highest subscriberd channels--
 select top 5 channel_title,channel_country,channel_have_hidden_subscribers,sum(channel_subscriber_count) as total_subscribers
 from[youtube_trending_3_countries CD]
 group by channel_title,channel_country,channel_have_hidden_subscribers
 order by total_subscribers desc

 --9. top 10 Most liked videos in India
 select top 10 video_id,video_title,video_category_id,channel_country,channel_id,
 sum(video_like_count)as total_likes
 from[youtube_trending_3_countries CD]
 where channel_country='IND'
 group by video_id,video_title,video_category_id,channel_country,channel_id
 order by total_likes desc

 --10. top 10 Most viewd videos in India
 select top 10 video_id,video_title,video_category_id,channel_country,channel_id,
 sum(video_view_count)as total_views
 from[youtube_trending_3_countries CD]
 where channel_country='IND' and
 video_category_id='News & politics'
 group by video_id,video_title,video_category_id,channel_country,channel_id
 order by total_views desc

 -- 11. On which day are the maximum no. of movies published in india.
 select channel_pub_day,video_category_id,channel_country,count(video_id)as total_videos
from[youtube_trending_3_countries CD]
where channel_country='IND' and 
video_category_id='film & animation'
group by channel_pub_day,video_category_id,channel_country
order by total_videos desc

--12. like_ratio fall down content quality low.
select 
year(video_pub_date)as year,
month(video_pub_date)as month,
avg(like_ratio) as avg_ratio
from[youtube_trending_3_countries CD]
group by year(video_pub_date),
month(video_pub_date)
order by year,month

 --This is For checking --
 select channel_pub_date,channel_pub_day,channel_pub_hour
 from[youtube_trending_3_countries CD]

 select video_tags
 from[youtube_trending_3_countries CD]

 select channel_country
 from[youtube_trending_3_countries CD]
 where channel_country ='IND'

 select dislike
 from[youtube_trending_3_countries CD]
 where dislike=0

 select Engagemen_Rate,dislike,like_ratio
 from[youtube_trending_3_countries CD]
