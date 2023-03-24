CREATE VIEW [edw].[vw_PurgAccAssignment]
AS
SELECT 
       [MANDT]
      ,[EBELN] as PurchaseOrder
      ,[EBELP] as PurchaseOrderItem
      ,[ZEKKN]
      ,[SAKTO]
      ,[KOSTL]
      ,[VBELN] as ICSalesDocumentID
      ,[VBELP] as ICSalesDocumentItemID
      ,[t_applicationId]
  FROM [base_s4h_cax].[PurgAccAssignment]