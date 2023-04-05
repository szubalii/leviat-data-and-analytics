CREATE VIEW [dm_sales].[vw_dim_DistributionChannel]
AS 
SELECT 
       [DistributionChannelID],
       [DistributionChannel]
 FROM [edw].[dim_DistributionChannel]