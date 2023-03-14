CREATE VIEW intm_axbi.vw_DIM_INVENTLOCATION AS
select
       [DW_Id]
      ,[NAME]
      ,[INVENTLOCATIONID]
      ,[DATAAREAID]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
from 
    (
    select 
       [DW_Id]
      ,[NAME]
      ,[INVENTLOCATIONID]
      ,[DATAAREAID]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
      ,ROW_NUMBER() OVER (PARTITION BY DW_Id,INVENTLOCATIONID ORDER BY DW_TimeStamp DESC) AS rn 
    from 
    (
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTLOCATION]
    UNION ALL
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTLOCATION_Archive]
    ) views
) a
where rn=1
 ;