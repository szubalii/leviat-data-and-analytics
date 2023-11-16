CREATE VIEW [dm_sales].[vw_dim_PriceListType] AS
SELECT
     [PriceListTypeID]
    ,[PriceListType]
    ,[t_applicationId]
FROM [edw].[dim_PriceListType]