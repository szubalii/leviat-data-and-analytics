CREATE PROC [dq].[usp_dim_RuleProduct]
    @t_jobId        [varchar](36),
    @t_jobDtm       [datetime],
    @t_lastActionCd [varchar](1),
    @t_jobBy        [nvarchar](20)
AS
BEGIN

DECLARE @ProductTotal INT

SET @ProductTotal = (SELECT COUNT([Product]) as [ProductTotals] FROM [base_s4h_cax].[I_Product])

CREATE TABLE #Totals
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
AS 
(
          SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_2]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_8]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_16]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_17]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_18]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_19]

        UNION ALL

        SELECT
              [RuleID]
            , [Product]     
            , @t_jobId     
            , @t_jobDtm     
            , @t_lastActionCd
            , @t_jobBy
        FROM
            [dq].[vw_Product_1_20]
 )
	
INSERT INTO [dq].[dim_RuleProduct] (
      [RuleID]  
    , [Product]
    , [t_jobId]     
    , [t_jobDtm]     
    , [t_lastActionCd]
    , [t_jobBy]         
)

SELECT *
FROM #Totals
  
INSERT INTO [dq].[TotalsProduct] (
      [ProductTotals]     
    , [ErrorTotals]      
    , [t_jobId]         
    , [t_jobDtm]        
    , [t_lastActionCd]  
    , [t_jobBy]        
)

SELECT * 
FROM (
    SELECT 
	      @ProductTotal                             AS [ProductTotals]     
        , COUNT(DISTINCT t.[Product])			    AS [ErrorTotals]
        , @t_jobId     
        , @t_jobDtm     
        , @t_lastActionCd
        , @t_jobBy
    FROM 
	    #Totals t
) AS Products


INSERT INTO [dq].[Totals] (
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
FROM [dq].[vw_Totals]

END