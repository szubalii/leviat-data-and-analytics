CREATE VIEW [dm_finance].[vw_fact_Budget_EPM]
AS
SELECT
      [CompanyCode]        
    , [ExQLReportingEntity]
    , [ReportingEntityID]
    , [CurrencyTypeID]  
    , [CurrencyType] 
    , [LocalCurrency]      
    , [Date]               
    , [InOutID]            
    , [3_ReportedRevenue]
    , [ValueTypeID]
FROM [edw].[vw_Budget_EPM]