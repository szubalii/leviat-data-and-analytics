CREATE TABLE [log].recipient_email_address (
    ExistingId BIGINT
,   ExistingEmailAddress varchar(50)
,	ActionTaken nvarchar(10)
,	NewId BIGINT
,	NewEmailAddress varchar(50)
,   t_jobDtm DATETIME
); 