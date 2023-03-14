CREATE VIEW intm_axbi.vw_DIM_VENDTABLE AS
select
       [DW_Id]
      ,[ACCOUNTNUM]
      ,[DATAAREAID]
      ,[NAME]
      ,[VENDGROUP]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
from 
    (
    select 
       [DW_Id]
      ,[ACCOUNTNUM]
      ,[DATAAREAID]
      ,[NAME]
      ,[VENDGROUP]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
     ,ROW_NUMBER() OVER (PARTITION BY DW_Id,ACCOUNTNUM,DATAAREAID ORDER BY DW_TimeStamp DESC) AS rn 
    from 
    (
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_VENDTABLE]
    UNION ALL
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_VENDTABLE_Archive]
    ) t
) q
where rn=1
 ;
 