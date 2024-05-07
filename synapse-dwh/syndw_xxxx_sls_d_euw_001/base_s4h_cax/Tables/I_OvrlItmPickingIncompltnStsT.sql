CREATE TABLE [base_s4h_cax].[I_OvrlItmPickingIncompltnStsT]
-- Overall Item Picking Incompletion Status Text
(
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [OvrlItmPickingIncompletionSts] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [OvrlItmPickingIncompltnStsDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_OvrlItmPickingIncompltnStsT] PRIMARY KEY NONCLUSTERED([MANDT],[OvrlItmPickingIncompletionSts],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
