CREATE VIEW [dm_dq].[vw_Totals_Product] AS 

WITH CountProducts AS (
	SELECT 
		COUNT([Product]) as [ProductTotals]
	FROM
		[base_s4h_cax].[I_Product]
)

SELECT 
	(SELECT [ProductTotals] FROM CountProducts )    AS [ProductTotals]     
  , COUNT(DISTINCT pr.[Product])					AS [ErrorTotals]
FROM 
	[dm_dq].[vw_Product] pr
