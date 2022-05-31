CREATE VIEW [edw].[vw_GoodsMovementType]
	AS SELECT
        GMT.[GoodsMovementType] as [GoodsMovementTypeID],
        GMText.[GoodsMovementTypeName],
        GMT.[IsReversalMovementType],
        GMT.[t_applicationId]
    FROM [base_s4h_cax].[I_GoodsMovementType] GMT
             LEFT JOIN [base_s4h_cax].[I_GoodsMovementTypeT] GMText
                       ON GMText.[GoodsMovementType] = GMT.[GoodsMovementType]
                           AND
                          GMText.[Language] = 'E'