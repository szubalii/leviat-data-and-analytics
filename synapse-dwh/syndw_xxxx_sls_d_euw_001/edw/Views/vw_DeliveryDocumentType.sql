CREATE VIEW [edw].[vw_DeliveryDocumentType]
	AS SELECT
	    DeliveryDocumentType.[DeliveryDocumentType]          AS [DeliveryDocumentTypeID]
        ,DeliveryDocumentTypeText.[DeliveryDocumentTypeName] AS [DeliveryDocumentType]
        ,DeliveryDocumentType.[SDDocumentCategory]
        ,DeliveryDocumentType.[PrecedingDocumentRequirement]
        ,DeliveryDocumentType.[t_applicationId]
    FROM
        [base_s4h_cax].[I_DeliveryDocumentType] DeliveryDocumentType
    LEFT JOIN
		[base_s4h_cax].[I_DeliveryDocumentTypeText] DeliveryDocumentTypeText
    ON
        DeliveryDocumentType.[DeliveryDocumentType] = DeliveryDocumentTypeText.[DeliveryDocumentType]
        AND
        DeliveryDocumentTypeText.[Language] = 'E'
        -- AND
        -- DeliveryDocumentTypeText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
