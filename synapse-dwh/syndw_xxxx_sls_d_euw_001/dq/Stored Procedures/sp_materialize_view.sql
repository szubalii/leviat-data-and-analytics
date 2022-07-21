CREATE PROC [dq].[sp_materialize_view]
	@SourceSchema NVARCHAR(128),
	@SourceView  NVARCHAR(128),
	@DestSchema NVARCHAR(128),
	@DestTable NVARCHAR(128),
	@t_jobId VARCHAR(36),
	@t_jobDtm DATETIME,
	@t_lastActionCd VARCHAR(1),
	@t_jobBy NVARCHAR(128)
AS
BEGIN
        EXECUTE [edw].[sp_materialize_view]
        @SourceSchema,
        @SourceView,
        @DestSchema,
        @DestTable,
        @t_jobId,
        @t_jobDtm,
        @t_lastActionCd,
        @t_jobBy
END