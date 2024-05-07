CREATE TABLE [base_s4h_cax].[NSDM_V_MAWEV]
-- MAWEV Compatibility View
(
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MATNR] nvarchar(40) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [WERKS] nvarchar(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ALAND] nvarchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [VHART] nvarchar(4) -- collate Latin1_General_100_BIN2
--, [tragr] nvarchar(4) collate Latin1_General_100_BIN2
--, [dismm] nvarchar(2) collate Latin1_General_100_BIN2
--, [atpkz] nvarchar(1) collate Latin1_General_100_BIN2
--, [ladgr] nvarchar(4) collate Latin1_General_100_BIN2
--, [vbamg] decimal(13,3)
--, [vbeaz] decimal(5,2)
--, [vrvez] decimal(5,2)
--, [xchar] nvarchar(1) collate Latin1_General_100_BIN2
--, [xchpf] nvarchar(1) collate Latin1_General_100_BIN2
--, [apokz] nvarchar(1) collate Latin1_General_100_BIN2
--, [mtvfp] nvarchar(2) collate Latin1_General_100_BIN2
--, [beskz] nvarchar(1) collate Latin1_General_100_BIN2
--, [eisbe] decimal(13,3)
--, [umlmc] decimal(13,3)
--, [plifz] decimal(3)
--, [webaz] decimal(3)
--, [wzeit] decimal(3)
--, [dzeit] decimal(3)
--, [bearz] decimal(5,2)
--, [ruezt] decimal(5,2)
--, [tranz] decimal(5,2)
--, [bwtty] nvarchar(1) collate Latin1_General_100_BIN2
--, [lvorm] nvarchar(1) collate Latin1_General_100_BIN2
--, [minbe] decimal(13,3)
--, [stawn] nvarchar(17) collate Latin1_General_100_BIN2
--, [herkl] nvarchar(3) collate Latin1_General_100_BIN2
--, [herkr] nvarchar(3) collate Latin1_General_100_BIN2
--, [mtver] nvarchar(4) collate Latin1_General_100_BIN2
--, [prctr] nvarchar(10) collate Latin1_General_100_BIN2
--, [miskz] nvarchar(1) collate Latin1_General_100_BIN2
--, [vrmod] nvarchar(1) collate Latin1_General_100_BIN2
--, [vint1] char(3) collate Latin1_General_100_BIN2
--, [vint2] char(3) collate Latin1_General_100_BIN2
--, [sobsl] nvarchar(2) collate Latin1_General_100_BIN2
--, [disgr] nvarchar(4) collate Latin1_General_100_BIN2
--, [diber] nvarchar(1) collate Latin1_General_100_BIN2
--, [strgr] nvarchar(2) collate Latin1_General_100_BIN2
--, [sbdkz] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm1] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm2] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm3] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm4] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm5] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm6] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm7] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm8] nvarchar(1) collate Latin1_General_100_BIN2
--, [taxm9] nvarchar(1) collate Latin1_General_100_BIN2
--, [sernp] nvarchar(4) collate Latin1_General_100_BIN2
--, [stdpd] nvarchar(40) collate Latin1_General_100_BIN2
--, [cuobj] char(18) collate Latin1_General_100_BIN2
--, [vhart] nvarchar(4) collate Latin1_General_100_BIN2
--, [fuelg] decimal(3)
--, [stfak] smallint
--, [magrv] nvarchar(4) collate Latin1_General_100_BIN2
--, [kzumw] nvarchar(1) collate Latin1_General_100_BIN2
--, [qmatv] nvarchar(1) collate Latin1_General_100_BIN2
--, [mfrgr] nvarchar(8) collate Latin1_General_100_BIN2
--, [basmg] decimal(13,3)
--, [serlv] nvarchar(1) collate Latin1_General_100_BIN2
--, [kzwsm] nvarchar(1) collate Latin1_General_100_BIN2
--, [eprio] nvarchar(4) collate Latin1_General_100_BIN2
--, [kzeff] nvarchar(1) collate Latin1_General_100_BIN2
--, [meins] nvarchar(3) collate Latin1_General_100_BIN2
--, [uchkz] nvarchar(1) collate Latin1_General_100_BIN2
--, [sgt_rel] nvarchar(1) collate Latin1_General_100_BIN2
--, [sgt_covs] nvarchar(8) collate Latin1_General_100_BIN2
--, [sgt_statc] nvarchar(1) collate Latin1_General_100_BIN2
--, [sgt_scope] nvarchar(1) collate Latin1_General_100_BIN2
--, [sgt_stk_prt] nvarchar(1) collate Latin1_General_100_BIN2
--, [sgt_mrpsi] nvarchar(1) collate Latin1_General_100_BIN2
--, [ppskz] nvarchar(1) collate Latin1_General_100_BIN2
--, [fsh_mg_arun_req] nvarchar(1) collate Latin1_General_100_BIN2
--, [fsh_seaim] nvarchar(1) collate Latin1_General_100_BIN2
--, [fprfm] nvarchar(3) collate Latin1_General_100_BIN2
--, [arun_fix_batch] nvarchar(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_NSDM_E_MAWEV] PRIMARY KEY NONCLUSTERED([MANDT],[MATNR],[WERKS],[ALAND]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
