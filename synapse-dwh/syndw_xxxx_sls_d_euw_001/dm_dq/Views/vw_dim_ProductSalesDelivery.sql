CREATE VIEW [dm_dq].[vw_dim_ProductSalesDelivery] AS 

SELECT 
     [sk_ProductSalesDelivery]
    ,[ProductID]
    ,[SalesOrganizationID]
    ,[DistributionChannelID]
    ,[Product]
    ,[SalesOrganization]
    ,[DistributionChannel]
    ,[AccountDetnProductGroup]
    ,[CashDiscountIsDeductible]
    ,[IsMarkedForDeletion]
    ,[ItemCategoryGroup]
    ,[ItemCategoryGroupName]
FROM 
    [edw].[dim_ProductSalesDelivery]