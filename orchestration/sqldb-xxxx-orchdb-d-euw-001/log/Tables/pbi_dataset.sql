CREATE TABLE [log].pbi_dataset (
    ExistingId BIGINT
,   ExistingWorkspaceGUID varchar(68)
,	ExistingWorkspaceName NVARCHAR(68)
,	ExistingDatasetGUID VARCHAR(68)
,	ExistingDatasetName VARCHAR(68)
,	ExistingScheduleRecurrence VARCHAR(5)
,	ExistingScheduleDay INT
,	ActionTaken nvarchar(10)
,	NewId BIGINT
,	NewWorkspaceGUID varchar(68)
,	NewWorkspaceName NVARCHAR(68)
,	NewDatasetGUID VARCHAR(68)
,	NewDatasetName VARCHAR(68)
,	NewScheduleRecurrence VARCHAR(5)
,	NewScheduleDay INT
,   t_jobDtm DATETIME
); 