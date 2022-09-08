CREATE VIEW [edw].[vw_WorkCenterCapacity]
AS
SELECT
        WCC.[WorkCenterInternalID]
    ,   WCC.[Plant]
    ,   WCC.[WorkCenter]
    ,   WCC.[WorkCenterCategoryCode]
    ,   WCCT.[WorkCenterCategoryName] AS [WorkCenterCategory]
    ,   WCC.[CapacityInternalID]
    ,   WCC.[CapacityCategoryCode]
    ,   ICCT.[CapacityCategoryName] AS [CapacityCategory]
    ,   WCC.[ValidityStartDate]
    ,   WCC.[ValidityEndDate]
    ,   IC.[CapacityBreakDuration]
    ,   IC.[CapacityStartTime]
    ,   IC.[CapacityEndTime]
    ,   ((IC.[CapacityEndTime] - IC.[CapacityStartTime] - IC.[CapacityBreakDuration])/60)/60 AS [DailyCapacityHrs]
    ,   WCC.[t_applicationId]
    ,   WCC.[t_extractionDtm]
FROM
    [base_s4h_cax].[I_WorkCenterCapacity] WCC
LEFT JOIN
    [base_s4h_cax].[I_Capacity] IC
    ON
        WCC.[CapacityInternalID] = IC.[CapacityInternalID]
LEFT JOIN
    [base_s4h_cax].[I_CapacityCategoryText] ICCT
    ON
        WCC.[CapacityCategoryCode] = ICCT.[CapacityCategoryCode]
        AND
        ICCT.[Language] = 'E'
LEFT JOIN 
    [base_s4h_cax].[I_WorkCenterCategoryText] WCCT
    ON
        WCC.[WorkCenterCategoryCode] = WCCT.[WorkCenterCategoryCode]
        AND
        WCCT.[Language] = 'E'