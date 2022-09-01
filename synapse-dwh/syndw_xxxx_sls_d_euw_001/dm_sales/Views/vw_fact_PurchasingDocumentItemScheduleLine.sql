CREATE VIEW [dm_sales].[vw_fact_PurchasingDocumentItemScheduleLine]
  AS
  SELECT 
  [PurchasingDocument]      AS    [PurchasingDocumentID],
  [PurchasingDocumentItem]  AS    [PurchasingDocumentItemID],
  [ScheduleLine],
  [ProcurementHubSourceSystem],
  [ScheduleLineOpenQuantity],
  [ScheduleLineDeliveryDate]            
  FROM 
    [base_s4h_cax].[I_PurgDocScheduleLineEnhanced]
  WHERE 
    [PurgDocSchdLnHasNextDelivery] = 'X'
