CREATE VIEW [edw].[vw_dim_SalesEmployee]
AS 
SELECT
          [SDDocument]
        , [PartnerFunction]
        , [PartnerFunctionName]
        , [Customer]
        , [Personnel]
        , [FullName]
FROM [edw].[dim_BillingDocumentPartnerFs]
WHERE PartnerFunction = 'VE'
