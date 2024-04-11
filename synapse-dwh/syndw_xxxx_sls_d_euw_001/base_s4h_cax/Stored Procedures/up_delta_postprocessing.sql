CREATE PROC [base_s4h_cax].[up_delta_postprocessing]
  @source_schema NVARCHAR(128),
  @source_table NVARCHAR(128),
  @target_schema NVARCHAR(128),
  @target_table NVARCHAR(128),
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
AS
BEGIN


  -- Copy data from base_s4h_cax to intm_s4h for follow-up processing in edw
  EXEC [edw].[sp_materialize_view]
    @source_schema,
    @source_table,
    @target_schema,
    @target_table,
    0,
    @t_jobId,
    @t_jobDtm,
    @t_lastActionCd,
    @t_jobBy

  -- Truncate base_s4h_cax delta table as delta in base layer is correctly processed
  EXEC [utilities].[sp_truncate_table]
    @source_schema,
    @source_table

END;
