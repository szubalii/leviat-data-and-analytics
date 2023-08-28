CREATE VIEW [dm_finance].[vw_dim_ValueType]
AS
SELECT
       [ValueTypeID]
     , [ValueType]
     , [t_applicationId]
FROM [edw].[dim_ValueType]