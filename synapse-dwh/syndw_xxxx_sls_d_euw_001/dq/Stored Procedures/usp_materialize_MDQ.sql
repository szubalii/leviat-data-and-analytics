CREATE PROC [dq].[usp_materialize_MDQ]
    @t_jobId        [varchar](36),
    @t_jobDtm       [datetime],
    @t_lastActionCd [varchar](1),
    @t_jobBy        [nvarchar](20)
AS
BEGIN

DECLARE @ProductTotal INT

SET @ProductTotal = (SELECT COUNT([Product]) as [ProductTotals] FROM [base_s4h_cax].[I_Product])
	
INSERT INTO [dq].[dim_RuleProduct] (
      [RuleID]  
    , [Product]
    , [t_jobId]     
    , [t_jobDtm]     
    , [t_lastActionCd]
    , [t_jobBy]         
)

SELECT 
      [RuleID]  
    , [Product]
    , @t_jobId     
    , @t_jobDtm     
    , @t_lastActionCd
    , @t_jobBy
FROM [dq].[vw_Totals]
  

INSERT INTO [dq].[fact_ProductTotal] (
      [ProductTotals]     
    , [ErrorTotals]      
    , [t_jobId]     
    , [t_jobDtm]     
    , [t_lastActionCd]
    , [t_jobBy]         
)

SELECT 
	  @ProductTotal                             AS [ProductTotals]     
    , COUNT(DISTINCT t.[Product])			    AS [ErrorTotals]
    , @t_jobId     
    , @t_jobDtm     
    , @t_lastActionCd
    , @t_jobBy
FROM 
	[dq].[vw_Totals] t


INSERT INTO [dq].[fact_RuleTotal] (
      [RuleID]
    , [RecordTotals]
    , [ErrorTotals]
    , [t_jobId]
    , [t_jobDtm]
    , [t_lastActionCd]
    , [t_jobBy]
)

SELECT 
      [RuleID]
    , [RecordTotals]
    , [ErrorTotals]
    , @t_jobId     
    , @t_jobDtm     
    , @t_lastActionCd
    , @t_jobBy
FROM [dq].[vw_RuleTotal]

END