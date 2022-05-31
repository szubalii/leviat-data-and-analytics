CREATE VIEW [edw].[vw_InventoryTransactionType]
	AS SELECT
        ITT.[InventoryTransactionType] as [InventoryTransactionTypeID],
        ITText.[InventoryTransactionTypeText],
        ITT.[IsPhysicalInventoryRelevant],
        ITT.[IsMaterialDocumentRelevant],
        ITT.[IsReservationRelevant],
        ITT.[t_applicationId]
    FROM [base_s4h_cax].[I_InventoryTransactionType] ITT
             LEFT JOIN [base_s4h_cax].[I_InventoryTransactionTypeT] ITText
                       ON ITText.[InventoryTransactionType] = ITT.[InventoryTransactionType]
                           AND
                          ITText.[Language] = 'E'

