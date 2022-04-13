CREATE VIEW [edw].[vw_ValueType]
AS
SELECT
       [ValueTypeID]
     , [ValueType]
     , [t_applicationId]

FROM
    [base_ff].[ValueType]