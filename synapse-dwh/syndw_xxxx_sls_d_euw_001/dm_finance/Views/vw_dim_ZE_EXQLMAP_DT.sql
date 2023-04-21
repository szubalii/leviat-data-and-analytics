CREATE VIEW dm_finance.vw_dim_ZE_EXQLMAP_DT AS
    SELECT
    nk_ExQLmap,
    GLAccountID,
    FunctionalAreaID,
    ExQLNode,
    ExQLAccount,
    t_applicationId,
    t_jobDtm,
    t_extractionDtm
FROM [edw].[dim_ZE_EXQLMAP_DT]