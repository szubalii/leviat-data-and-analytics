CREATE VIEW [dq].[vw_BusinessPartnerTotal] AS
SELECT 
    (SELECT COUNT([BusinessPartner]) FROM [base_s4h_cax].[I_BusinessPartner]) AS [BusinessPartnerTotals]
    , COUNT(DISTINCT t.[BusinessPartner]) AS [ErrorTotals]
FROM 
	[dq].[vw_RuleBusinessPartner] t