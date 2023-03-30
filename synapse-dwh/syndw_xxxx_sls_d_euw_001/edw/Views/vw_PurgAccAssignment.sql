CREATE VIEW [edw].[vw_PurgAccAssignment]
AS
SELECT 
       [MANDT]
      ,[EBELN] as PurchaseOrder
      ,[EBELP] as PurchaseOrderItem
      ,[ZEKKN] as SequentialNumberOfAccountAssignment
      ,[SAKTO] as GLAccountID
      ,[KOSTL] as CostCenterID
      ,[VBELN] as ICSalesDocumentID
      ,[VBELP] as ICSalesDocumentItemID
      ,[t_applicationId]
  FROM [base_s4h_cax].[PurgAccAssignment]