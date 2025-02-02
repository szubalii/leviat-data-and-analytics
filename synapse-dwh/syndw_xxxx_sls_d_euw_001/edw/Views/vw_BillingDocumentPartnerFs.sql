﻿CREATE VIEW [edw].[vw_BillingDocumentPartnerFs]
	AS SELECT
        [SDDocument]
        , [PartnerFunction]
        , [PartnerFunctionName]
        , [Customer]
        , [Personnel]
        , [FullName]
        , [t_applicationId]
        , [t_extractionDtm]
    FROM [base_s4h_cax].[C_BillingDocumentPartnerFs]
    GROUP BY
        [SDDocument]
        , [PartnerFunction]
        , [PartnerFunctionName]
        , [Customer]
        , [Personnel]
        , [FullName]
        , [t_applicationId]
        , [t_extractionDtm]