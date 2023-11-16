CREATE VIEW [edw].[vw_PriceListType]
AS
     SELECT 
		[PriceListType] AS [PriceListTypeID]
     ,    [PriceListTypeName] AS [PriceListType]
     ,    [t_applicationId]
     FROM 
          [base_s4h_cax].[I_PriceListTypeText] PriceListTypeText
     WHERE 
          PriceListTypeText.[Language] = 'E' 
          -- AND
          -- PriceListTypeText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
