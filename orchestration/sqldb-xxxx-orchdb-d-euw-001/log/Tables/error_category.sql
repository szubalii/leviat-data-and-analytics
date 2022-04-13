CREATE TABLE [log].error_category (
    ExistingId BIGINT
,   ExistingNK varchar(50)
,   ExistingDescription VARCHAR(250)
,	ActionTaken nvarchar(10)
,	NewId BIGINT
,	NewNK varchar(50)
,	NewDescription VARCHAR(250)
,   t_jobDtm DATETIME
); 