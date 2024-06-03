CREATE VIEW [edw].[vw_CustomerCalculated_US]
    AS 
SELECT 
        COALESCE(map_Cust.[UniqueCustomerNumber], CONCAT(CUST.[COMP],'-',CUST.[CUSTOMER])) AS [CustomerIDCalculated] 
    ,   COALESCE(map_Cust.[CustName], CUST.CustName) AS [CustomerCalculated] 
    ,   map_Cust.CustomerPillar AS [CustomerPillarCalculated]
    ,   NULL AS [isReviewed] 
    ,   'no_SAP' AS [mappingType] 
    ,   map_Cust.[UniqueCustomerNumber] AS [axbiCustomeraccount]
    ,   map_Cust.[CustName] AS [axbiItemName]
    ,   NULL AS [axbiCustomerPillarCalculated]
    ,   CUST.[t_applicationId]
    ,   CUST.[t_jobId]
    ,   CUST.[t_jobDtm]
    ,   CUST.[t_jobBy]
    ,   CUST.[t_extractionDtm]
    ,   CUST.[t_filePath]
FROM 
    [base_us_leviat_db].[CUSTOMERS] CUST
LEFT JOIN
    [map_USA].[Customer] map_Cust
        ON map_Cust.[UniqueCustomerNumber]=CONCAT(CUST.[COMP],'-',CUST.[CUSTOMER])
