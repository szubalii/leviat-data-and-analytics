CREATE TABLE [edw].[dim_Route]
(
[ROUTEID]          NVARCHAR(6) NOT NULL
,[ROUTE]           NVARCHAR(40) NOT NULL
,[TRAZT]           DECIMAL(5,2) NOT NULL
,[TRAZTD]          DECIMAL(11)
,[TDVZT]           DECIMAL(5,2) NOT NULL
,[TDVZTD]          DECIMAL(11)
,[TDVZND]          DECIMAL(11)
,[SPFBK]           NVARCHAR(2) NOT NULL
,[EXPVZ]           NVARCHAR(1) NOT NULL
,[TDIIX]           NVARCHAR(1) NOT NULL
,[SPZST]           NVARCHAR(10)
,[FAHZTD]          DECIMAL(11)
,[DISTZ]           DECIMAL(13,3)
,[MEDST]           NVARCHAR(3) --collate Latin1_General_100_BIN2
,[VSART]           NVARCHAR(2)
,[VSAVL]           NVARCHAR(2)
,[VSANL]           NVARCHAR(2)
,[TDLNR]           NVARCHAR(10)
,[ROUTID]          NVARCHAR(100)
,[TCTAB]           NVARCHAR(1)
,[ALLOWED_TWGT]    DECIMAL(8)
,[ALLOWED_UOM]     NVARCHAR(3) --collate Latin1_General_100_BIN2
,[DurInDays]       DECIMAL(11)
,[t_applicationId] VARCHAR(32)
,[t_jobId]         VARCHAR(36)
,[t_jobDtm]        DATETIME
,[t_lastActionCd]  VARCHAR(1)
,[t_jobBy]         NVARCHAR(128)
,CONSTRAINT [PK_dim_Route] PRIMARY KEY NONCLUSTERED ([ROUTEID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO