CREATE VIEW [edw].[vw_SalesDocumentItemType]
	AS SELECT 
		   SalesDocumentItemTypeText.[SalesDocumentItemType]     AS [SalesDocumentItemTypeID]
         , SalesDocumentItemTypeText.[SalesDocumentItemTypeName] AS [SalesDocumentItemType]
         , t_applicationId
    FROM [base_s4h_cax].[I_SalesDocumentItemTypeText] SalesDocumentItemTypeText
    WHERE SalesDocumentItemTypeText.[Language] = 'E'
