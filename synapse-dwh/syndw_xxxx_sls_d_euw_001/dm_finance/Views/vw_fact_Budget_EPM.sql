CREATE VIEW [dm_finance].[vw_fact_Budget_EPM]
AS
SELECT
      [CompanyCodeID]        
    , [ExQLReportingEntity]
    , [ReportingEntityID]
    , [CurrencyTypeID]  
    , [CurrencyType] 
    , [CurrencyID]      
    , [Date]               
    , [InOutID]            
    , [3_ReportedRevenue]
    , [ValueTypeID]
FROM [edw].[vw_Budget_EPM]