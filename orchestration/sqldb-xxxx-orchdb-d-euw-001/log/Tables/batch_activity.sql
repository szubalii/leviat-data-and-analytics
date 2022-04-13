CREATE TABLE [log].batch_activity (
    ExistingId BIGINT
,   ExistingNK varchar(50)
,   ExistingDescription VARCHAR(250)
,   ExistingActivityOrder SMALLINT
,   ExistingIsDeprecated BIT
,	ActionTaken nvarchar(10)
,	NewId BIGINT
,	NewNK varchar(50)
,	NewDescription VARCHAR(250)
,   NewActivityOrder SMALLINT
,   NewIsDeprecated BIT
,   t_jobDtm DATETIME
); 