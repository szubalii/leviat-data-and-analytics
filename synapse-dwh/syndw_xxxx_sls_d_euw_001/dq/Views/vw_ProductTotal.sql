CREATE VIEW [dq].[vw_ProductTotal] AS
SELECT 
    (SELECT COUNT([Product]) FROM [base_s4h_cax].[I_Product]) AS [ProductTotals]
    , COUNT(DISTINCT t.[Product]) AS [ErrorTotals]
FROM 
	[dq].[vw_RuleProduct] t