CREATE TABLE [log].layer (
    ExistingId BIGINT
,   ExistingNK varchar(50)
,   ExistingDescription VARCHAR(250)
,	ExistingLocationId BIGINT
,	ActionTaken nvarchar(10)
,	NewId BIGINT
,	NewNK varchar(50)
,	NewDescription VARCHAR(250)
,	NewLocationId BIGINT
,   t_jobDtm DATETIME
); 