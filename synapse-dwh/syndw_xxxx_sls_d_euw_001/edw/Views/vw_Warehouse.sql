CREATE VIEW [edw].[vw_Warehouse]
	AS SELECT 
		    Warehouse.[Warehouse] AS [WarehouseId]
           ,WarehouseText.[WarehouseName] AS [Warehouse]
           ,Warehouse.t_applicationId
    FROM [base_s4h_cax].[I_Warehouse] Warehouse
    LEFT JOIN [base_s4h_cax].[I_WarehouseText] WarehouseText 
    ON Warehouse.[Warehouse] = WarehouseText.[Warehouse]
   AND WarehouseText.[Language] = 'E' 
--     WHERE Warehouse.[MANDT] = 200 AND WarehouseText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
