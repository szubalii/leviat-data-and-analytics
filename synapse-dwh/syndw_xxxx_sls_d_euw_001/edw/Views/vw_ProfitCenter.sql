CREATE VIEW [edw].[vw_ProfitCenter]
	AS SELECT 
        ProfitCenter.[ControllingArea]
    ,   ProfitCenter.[ProfitCenter]              AS [ProfitCenterID]
    ,   ProfitCenterText.[ProfitCenterName]      AS [ProfitCenter]
    ,    CASE
           WHEN
               RIGHT(ProfitCenter.[ProfitCenter], 1) in ('0', '1', '2', '3', '4')
           THEN
               RIGHT(ProfitCenter.[ProfitCenter], 1)
           ELSE
               NULL
        END AS [ProfitCenterTypeID]
    ,    CASE
           WHEN RIGHT(ProfitCenter.[ProfitCenter], 1) = '0'
              THEN 'Outlay'
           WHEN RIGHT(ProfitCenter.[ProfitCenter], 1) = '1'
             THEN 'Service'
           WHEN RIGHT(ProfitCenter.[ProfitCenter], 1) = '2'
             THEN 'Sales'
           WHEN RIGHT(ProfitCenter.[ProfitCenter], 1) = '3'
             THEN 'Production'
           WHEN RIGHT(ProfitCenter.[ProfitCenter], 1) = '4'
             THEN 'International'
           ELSE NULL
         END AS ProfitCenterType
    ,   ProfitCenterText.[ProfitCenterLongName]
    ,   ProfitCenter.[ValidityEndDate]
    ,   [ProfitCtrResponsiblePersonName]
    ,   [CompanyCode]
    ,   [ProfitCtrResponsibleUser]
    ,   ProfitCenter.[ValidityStartDate]
    ,   [Department]
    ,   [ProfitCenterStandardHierarchy]
    ,   [Segment]
    ,   [ProfitCenterIsBlocked]
    ,   [FormulaPlanningTemplate]
    ,   [FormOfAddress]
    ,   [AddressName]
    ,   [AdditionalName]
    ,   [ProfitCenterAddrName3]
    ,   [ProfitCenterAddrName4]
    ,   [StreetAddressName]
    ,   [POBox]
    ,   [CityName]
    ,   [PostalCode]
    ,   [District]
    ,   [Country]
    ,   [Region]
    ,   [TaxJurisdiction]
    ,   ProfitCenter.[Language]
    ,   [PhoneNumber1]
    ,   [PhoneNumber2]
    ,   [TeleboxNumber]
    ,   [TelexNumber]
    ,   [FaxNumber]
    ,   [DataCommunicationPhoneNumber]
    ,   [ProfitCenterPrinterName]
    ,   [ProfitCenterCreatedByUser]
    ,   [ProfitCenterCreationDate]
    ,   ProfitCenter.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_ProfitCenter] ProfitCenter
    LEFT JOIN 
        [base_s4h_cax].[I_ProfitCenterText] ProfitCenterText
        ON 
            ProfitCenter.[ProfitCenter] = ProfitCenterText.[ProfitCenter]
            AND
            ProfitCenterText.[Language] = 'E'
--    WHERE ProfitCenter.[MANDT] = 200 AND ProfitCenterText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
