﻿CREATE VIEW [edw].[vw_CostCenter]
AS
SELECT 
	CostCenter.[ControllingArea]
    ,CostCenter.[CostCenter] AS [CostCenterID]
    ,CostCenterText.[CostCenterName] AS [CostCenter]
    ,CostCenterText.[CostCenterDescription]
    ,CostCenter.[ValidityEndDate]
    ,CostCenter.[ValidityStartDate]
    ,[IsBlkdForPrimaryCostsPosting]
    ,[IsBlockedForPlanPrimaryCosts]
    ,[CompanyCode]
    ,[BusinessArea]
    ,[CostCenterCategory]
    ,[CostCtrResponsiblePersonName]
    ,[CostCtrResponsibleUser]
    ,[CostCenterCurrency]
    ,[CostingSheet]
    ,[TaxJurisdiction]
    ,[ProfitCenter]
    ,[Plant]
    ,[LogicalSystem]
    ,[CostCenterCreationDate]
    ,[CostCenterCreatedByUser]
    ,[IsBlkdForSecondaryCostsPosting]
    ,[IsBlockedForRevenuePosting]
    ,[IsBlockedForCommitmentPosting]
    ,[IsBlockedForPlanSecondaryCosts]
    ,[IsBlockedForPlanRevenues]
    ,[CostCenterAllocationMethod]
    ,[ConsumptionQtyIsRecorded]
    ,[Department]
    ,[SubsequentCostCenter]
    ,[ConditionUsage]
    ,[ConditionApplication]
    ,[CostCenterAccountingOverhead]
    ,[Country]
    ,[FormOfAddress]
    ,[AddressName]
    ,[AddressAdditionalName]
    ,[CostCenterAddrName3]
    ,[CostCenterAddrName4]
    ,[CityName]
    ,[District]
    ,[StreetAddressName]
    ,[POBox]
    ,[PostalCode]
    ,[POBoxPostalCode]
    ,[Region]
    ,CostCenter.[Language]
    ,[TeleboxNumber]
    ,[PhoneNumber1]
    ,[PhoneNumber2]
    ,[FaxNumber]
    ,[TeletexNumber]
    ,[TelexNumber]
    ,[DataCommunicationPhoneNumber]
    ,[CostCenterPrinterDestination]
    ,[CostCenterStandardHierArea]
    ,[CostCollector]
    ,[CostCenterIsComplete]
    ,[IsStatisticalCostCenter]
    ,[ObjectInternalID]
    ,[CostCenterFunction]
    ,[CostCenterAlternativeFunction]
    ,[FunctionalArea]
    ,[ActyIndepFormulaPlanningTmpl]
    ,[ActyDepdntFormulaPlanningTmpl]
    ,[ActyIndependentAllocationTmpl]
    ,[ActyDependentAllocationTmpl]
    ,[ActlIndepStatisticalKeyFigures]
    ,[ActlDepStatisticalKeyFigures]
    ,[JointVenture]
    ,[JointVentureRecoveryCode]
    ,[JointVentureEquityType]
    ,[JointVentureObjectType]
    ,[JointVentureClass]
    ,[JointVentureSubClass]
    ,[BudgetCarryingCostCenter]
    ,[AvailabilityControlProfile]
    ,[AvailabilityControlIsActive]
    ,[Fund]
    ,[GrantID]
    ,[FundIsFixAssigned]
    ,[GrantIDIsFixAssigned]
    ,[FunctionalAreaIsFixAssigned]
    ,CostCenter.[t_applicationId]
FROM 
    [base_s4h_cax].[I_CostCenter] CostCenter
LEFT JOIN 
    [base_s4h_cax].[I_CostCenterText] CostCenterText
    ON 
        CostCenter.[CostCenter] = CostCenterText.[CostCenter]
        AND
        CostCenterText.[Language] = 'E'
        -- AND
        -- CostCenter.MANDT = 200 
        -- AND
        -- CostCenterText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod