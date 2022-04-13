CREATE TABLE [dbo].[pbi_dataset]
(
    [pbi_dataset_id] BIGINT NOT NULL,
    [workspace_guid] NVARCHAR(68) NOT NULL,
    [workspace_name] NVARCHAR(68),
	[dataset_guid] NVARCHAR(68) NOT NULL,
	[dataset_name] NVARCHAR(68),
	[schedule_recurrence] VARCHAR(5) NULL,
    [schedule_day] INT NULL,

    PRIMARY KEY CLUSTERED ([pbi_dataset_id] ASC)
);