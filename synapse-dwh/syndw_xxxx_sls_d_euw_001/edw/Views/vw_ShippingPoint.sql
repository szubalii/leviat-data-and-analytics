CREATE VIEW [edw].[vw_ShippingPoint]
	AS SELECT
        [ShippingPoint] AS [ShippingPointID]
        ,[ActiveDepartureCountry]
        ,[AddressID]
        ,[PickingConfirmation]
        ,CASE
            WHEN SUBSTRING([ShippingPoint], 3, 1) = 'S'
            THEN 'Subcontractor'
            WHEN SUBSTRING([ShippingPoint], 3, 1) = 'X'
            THEN '3rd Party'
            ELSE 'Leviat'
        END AS [ShippingPointType]
        ,[t_applicationId]
    FROM
        [base_s4h_cax].[I_ShippingPoint]
