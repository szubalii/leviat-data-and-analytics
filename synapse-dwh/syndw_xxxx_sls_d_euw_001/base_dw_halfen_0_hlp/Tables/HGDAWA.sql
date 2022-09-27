CREATE TABLE [base_dw_halfen_0_hlp].[HGDAWA](
	[DACONO] [char](8) NOT NULL,
	[DADICO] [char](8) NOT NULL,
	[DAAREA] [char](3) NOT NULL,
	[DASITE] [char](8) NOT NULL,
	[DAIVNO] [char](20) NOT NULL,
	[DAIVDT] [datetime] NULL,
	[DAACDT] [datetime] NULL,
	[DAJAHR] [smallint] NULL,
	[DAMONA] [smallint] NULL,
	[DATAGE] [smallint] NULL,
	[DAORNO] [char](20) NOT NULL,
	[DADLIX] [char](20) NOT NULL,
	[DAPONR] [decimal](28, 12) NOT NULL,
	[DAPOSX] [decimal](28, 12) NOT NULL,
	[DAORDT] [datetime] NOT NULL,
	[DADWDT] [datetime] NOT NULL,
	[DACODT] [datetime] NOT NULL,
	[DADLDT] [datetime] NOT NULL,
	[DAORTP] [int] NOT NULL,
	[DACUNO] [char](10) NOT NULL,
	[DACSCD] [char](3) NOT NULL,
	[DAPONO] [char](10) NOT NULL,
	[DASMCD] [char](10) NOT NULL,
	[DASDST] [char](10) NOT NULL,
	[DACFC4] [char](10) NOT NULL,
	[DACCUS] [char](10) NULL,
	[DAINEX] [char](1) NOT NULL,
	[DARESP] [char](10) NOT NULL,
	[DAWHLO] [char](6) NULL,
	[DAPUIT] [char](1) NULL,
	[DAOWHL] [char](6) NULL,
	[DAOPUI] [char](1) NULL,
	[DAITNO] [char](20) NOT NULL,
	[DAITGR] [nvarchar](20) NOT NULL,
	[DAITTY] [char](3) NOT NULL,
	[DAITCL] [nvarchar](20) NOT NULL,
	[DABUAR] [nvarchar](20) NOT NULL,
	[DAPRDB] [nvarchar](20) NOT NULL,
	[DAPRHW] [char](1) NULL,
	[DAEDEL] [char](1) NOT NULL,
	[DAGRTI] [nvarchar](20) NOT NULL,
	[DACFIN] [numeric](7, 0) NULL,
	[DAPRRF] [char](10) NOT NULL,
	[DAPROJ] [char](20) NOT NULL,
	[DAELNO] [char](10) NOT NULL,
	[DASETK] [char](20) NULL,
	[DACUCD] [char](3) NOT NULL,
	[DABRAM] [numeric](15, 2) NULL,
	[DABRAC] [numeric](15, 2) NULL,
	[DAB2AM] [numeric](15, 2) NULL,
	[DAB2AC] [numeric](15, 2) NULL,
	[DALNAM] [numeric](15, 2) NULL,
	[DALNAC] [numeric](15, 2) NULL,
	[DALNAP] [numeric](5, 2) NULL,
	[DASAAM] [numeric](15, 2) NULL,
	[DAARAT] [numeric](15, 9) NULL,
	[DAARAC] [numeric](15, 9) NULL,
	[DACUCC] [char](3) NULL,
	[DASAAC] [numeric](15, 2) NULL,
	[DAOSAL] [numeric](17, 6) NULL,
	[DAOSAC] [numeric](17, 6) NULL,
	[DAALOL] [numeric](17, 6) NULL,
	[DAALOC] [numeric](17, 6) NULL,
	[DA100L] [numeric](17, 6) NULL,
	[DA100C] [numeric](17, 6) NULL,
	[DATEZS] [numeric](15, 2) NULL,
	[DATEZC] [numeric](15, 2) NULL,
	[DATEZP] [numeric](5, 2) NULL,
	[DALZUS] [numeric](15, 2) NULL,
	[DALZUC] [numeric](15, 2) NULL,
	[DALZUP] [numeric](5, 2) NULL,
	[DARAPO] [numeric](15, 2) NULL,
	[DARAPC] [numeric](15, 2) NULL,
	[DARAPP] [numeric](5, 2) NULL,
	[DARABA] [numeric](15, 2) NULL,
	[DARABC] [numeric](15, 2) NULL,
	[DARABP] [numeric](5, 2) NULL,
	[DARAAU] [numeric](15, 2) NULL,
	[DARAAC] [numeric](15, 2) NULL,
	[DARAAP] [numeric](5, 2) NULL,
	[DAPRSA] [numeric](17, 6) NULL,
	[DAPRSC] [numeric](17, 6) NULL,
	[DAPSPR] [numeric](17, 6) NULL,
	[DAPSPC] [numeric](17, 6) NULL,
	[DAKPSP] [char](1) NULL,
	[DAPRPM] [char](1) NULL,
	[DAUCOS] [numeric](17, 6) NULL,
	[DAUCOC] [numeric](17, 6) NULL,
	[DAHCOS] [numeric](17, 6) NULL,
	[DAHCOC] [numeric](17, 6) NULL,
	[DAMFCL] [numeric](17, 6) NULL,
	[DAMFCC] [numeric](17, 6) NULL,
	[DAVSCL] [numeric](17, 6) NULL,
	[DAVSCC] [numeric](17, 6) NULL,
	[DANETL] [numeric](17, 6) NULL,
	[DANETC] [numeric](17, 6) NULL,
	[DAGMAL] [numeric](17, 6) NULL,
	[DAGMAC] [numeric](17, 6) NULL,
	[DACM1L] [numeric](17, 6) NULL,
	[DACM1C] [numeric](17, 6) NULL,
	[DACM2L] [numeric](17, 6) NULL,
	[DACM2C] [numeric](17, 6) NULL,
	[DAPLOL] [numeric](17, 6) NULL,
	[DAPLOC] [numeric](17, 6) NULL,
	[DACM3L] [numeric](17, 6) NULL,
	[DACM3C] [numeric](17, 6) NULL,
	[DAIVQT] [numeric](15, 6) NULL,
	[DAIVQA] [numeric](15, 6) NULL,
	[DAIVQS] [numeric](15, 6) NULL,
	[DAORQT] [numeric](15, 6) NULL,
	[DAORQS] [numeric](15, 6) NULL,
	[DAORQA] [numeric](15, 6) NULL,
	[DASTUN] [char](3) NULL,
	[DAALUN] [char](3) NULL,
	[DASPUN] [char](3) NULL,
	[DAGRWE] [numeric](9, 3) NULL,
	[DANEWE] [numeric](9, 3) NULL,
	[DAFFRA] [numeric](17, 6) NULL,
	[DAFFRC] [numeric](17, 6) NULL,
	[DAFMAU] [numeric](17, 6) NULL,
	[DAFMAC] [numeric](17, 6) NULL,
	[DAFVPA] [numeric](17, 6) NULL,
	[DAFVPC] [numeric](17, 6) NULL,
	[DAFMMZ] [numeric](17, 6) NULL,
	[DAFMMC] [numeric](17, 6) NULL,
	[DAFPLK] [numeric](17, 6) NULL,
	[DAFPLC] [numeric](17, 6) NULL,
	[DAFPFV] [numeric](17, 6) NULL,
	[DAFPFC] [numeric](17, 6) NULL,
	[DAFSEL] [numeric](17, 6) NULL,
	[DAFSEC] [numeric](17, 6) NULL,
	[DAKBON] [numeric](17, 6) NULL,
	[DAKBOC] [numeric](17, 6) NULL,
	[DAGWLS] [numeric](17, 6) NULL,
	[DAGWLC] [numeric](17, 6) NULL,
	[DAWKZU] [numeric](17, 6) NULL,
	[DAWKZC] [numeric](17, 6) NULL,
	[DAKSKT] [numeric](17, 6) NULL,
	[DAKSKC] [numeric](17, 6) NULL,
	[DAVFRA] [numeric](17, 6) NULL,
	[DAVFRC] [numeric](17, 6) NULL,
	[DAVVPK] [numeric](17, 6) NULL,
	[DAVVPC] [numeric](17, 6) NULL,
	[DAVZOL] [numeric](17, 6) NULL,
	[DAVZOC] [numeric](17, 6) NULL,
	[DATPVS] [numeric](17, 6) NULL,
	[DATPVC] [numeric](17, 6) NULL,
	[DAPROV] [numeric](17, 6) NULL,
	[DAPROC] [numeric](17, 6) NULL,
	[DALIZZ] [numeric](17, 6) NULL,
	[DALIZC] [numeric](17, 6) NULL,
	[DANOST] [numeric](17, 6) NULL,
	[DANOSC] [numeric](17, 6) NULL,
	[DAEDST] [numeric](17, 6) NULL,
	[DAEDSC] [numeric](17, 6) NULL,
	[DASROH] [numeric](17, 6) NULL,
	[DASROC] [numeric](17, 6) NULL,
	[DAMGZU] [numeric](17, 6) NULL,
	[DAMGZC] [numeric](17, 6) NULL,
	[DALGZU] [numeric](17, 6) NULL,
	[DALGZC] [numeric](17, 6) NULL,
	[DAEXBK] [numeric](17, 6) NULL,
	[DAEXBC] [numeric](17, 6) NULL,
	[DAVAFK] [numeric](17, 6) NULL,
	[DAVAFC] [numeric](17, 6) NULL,
	[DAFIFK] [numeric](17, 6) NULL,
	[DAFIFC] [numeric](17, 6) NULL,
	[DAICPL] [nvarchar](20) NULL,
	[DAICFD] [datetime] NULL,
	[DAICTD] [datetime] NULL,
	[DAICPP] [decimal](28, 12) NULL,
	[DAICPC] [nvarchar](6) NULL,
	[DAICDA] [nvarchar](8) NULL,
	[DAICCN] [nvarchar](40) NULL,
	[DAICMU] [decimal](28, 12) NULL,
	[DAICPQ] [decimal](28, 12) NULL,
	[DAICCP] [decimal](28, 12) NULL,
	[DAICCU] [nvarchar](20) NULL,
	[DAICPU] [decimal](28, 12) NULL,
	[DAVA01] [numeric](17, 6) NULL,
	[DAVA02] [numeric](17, 6) NULL,
	[DAVA03] [numeric](17, 6) NULL,
	[DAVA04] [numeric](17, 6) NULL,
	[DAVA05] [numeric](17, 6) NULL,
	[DAVB01] [numeric](17, 6) NULL,
	[DAVB02] [numeric](17, 6) NULL,
	[DAVB03] [numeric](17, 6) NULL,
	[DAVB04] [numeric](17, 6) NULL,
	[DAVB05] [numeric](17, 6) NULL,
	[DAVB06] [numeric](17, 6) NULL,
	[DAVB07] [numeric](17, 6) NULL,
	[DAVB08] [numeric](17, 6) NULL,
	[DAVB09] [numeric](17, 6) NULL,
	[DAVB10] [numeric](17, 6) NULL,
	[DAVB11] [numeric](17, 6) NULL,
	[DAVB12] [numeric](17, 6) NULL,
	[DAVB13] [numeric](17, 6) NULL,
	[DAVB14] [numeric](17, 6) NULL,
	[DAVC01] [numeric](17, 6) NULL,
	[DAVC02] [numeric](17, 6) NULL,
	[DAVD01] [numeric](17, 6) NULL,
	[DAVD02] [numeric](17, 6) NULL,
	[DAVE01] [numeric](17, 6) NULL,
	[DAVE02] [numeric](17, 6) NULL,
	[DAVE03] [numeric](17, 6) NULL,
	[DAVE04] [numeric](17, 6) NULL,
	[DAVE05] [numeric](17, 6) NULL,
	[DAVE06] [numeric](17, 6) NULL,
	[DAVE07] [numeric](17, 6) NULL,
	[DAVE08] [numeric](17, 6) NULL,
	[DAVE09] [numeric](17, 6) NULL,
	[DAVE10] [numeric](17, 6) NULL,
	[DCVA01] [numeric](17, 6) NULL,
	[DCVA02] [numeric](17, 6) NULL,
	[DCVA03] [numeric](17, 6) NULL,
	[DCVA04] [numeric](17, 6) NULL,
	[DCVA05] [numeric](17, 6) NULL,
	[DCVB01] [numeric](17, 6) NULL,
	[DCVB02] [numeric](17, 6) NULL,
	[DCVB03] [numeric](17, 6) NULL,
	[DCVB04] [numeric](17, 6) NULL,
	[DCVB05] [numeric](17, 6) NULL,
	[DCVB06] [numeric](17, 6) NULL,
	[DCVB07] [numeric](17, 6) NULL,
	[DCVB08] [numeric](17, 6) NULL,
	[DCVB09] [numeric](17, 6) NULL,
	[DCVB10] [numeric](17, 6) NULL,
	[DCVB11] [numeric](17, 6) NULL,
	[DCVB12] [numeric](17, 6) NULL,
	[DCVB13] [numeric](17, 6) NULL,
	[DCVB14] [numeric](17, 6) NULL,
	[DCVC01] [numeric](17, 6) NULL,
	[DCVC02] [numeric](17, 6) NULL,
	[DCVD01] [numeric](17, 6) NULL,
	[DCVD02] [numeric](17, 6) NULL,
	[DCVE01] [numeric](17, 6) NULL,
	[DCVE02] [numeric](17, 6) NULL,
	[DCVE03] [numeric](17, 6) NULL,
	[DCVE04] [numeric](17, 6) NULL,
	[DCVE05] [numeric](17, 6) NULL,
	[DCVE06] [numeric](17, 6) NULL,
	[DCVE07] [numeric](17, 6) NULL,
	[DCVE08] [numeric](17, 6) NULL,
	[DCVE09] [numeric](17, 6) NULL,
	[DCVE10] [numeric](17, 6) NULL,
	[DASMPL] [nvarchar](20) NULL,
	[DASMFD] [datetime] NULL,
	[DASMTD] [datetime] NULL,
	[DASMPP] [decimal](28, 12) NULL,
	[DASMPC] [nvarchar](6) NULL,
	[DASMDA] [nvarchar](8) NULL,
	[DASMCN] [nvarchar](40) NULL,
	[DASMMU] [decimal](28, 12) NULL,
	[DASMPQ] [decimal](28, 12) NULL,
	[DASMCP] [decimal](28, 12) NULL,
	[DASMCU] [nvarchar](20) NULL,
	[DASMPU] [decimal](28, 12) NULL,
	[DAHA01] [numeric](17, 6) NULL,
	[DAHA02] [numeric](17, 6) NULL,
	[DAHA03] [numeric](17, 6) NULL,
	[DAHA04] [numeric](17, 6) NULL,
	[DAHA05] [numeric](17, 6) NULL,
	[DAHB01] [numeric](17, 6) NULL,
	[DAHB02] [numeric](17, 6) NULL,
	[DAHB03] [numeric](17, 6) NULL,
	[DAHB04] [numeric](17, 6) NULL,
	[DAHB05] [numeric](17, 6) NULL,
	[DAHB06] [numeric](17, 6) NULL,
	[DAHB07] [numeric](17, 6) NULL,
	[DAHB08] [numeric](17, 6) NULL,
	[DAHB09] [numeric](17, 6) NULL,
	[DAHB10] [numeric](17, 6) NULL,
	[DAHB11] [numeric](17, 6) NULL,
	[DAHB12] [numeric](17, 6) NULL,
	[DAHB13] [numeric](17, 6) NULL,
	[DAHB14] [numeric](17, 6) NULL,
	[DAHC01] [numeric](17, 6) NULL,
	[DAHC02] [numeric](17, 6) NULL,
	[DAHD01] [numeric](17, 6) NULL,
	[DAHD02] [numeric](17, 6) NULL,
	[DCHA01] [numeric](17, 6) NULL,
	[DCHA02] [numeric](17, 6) NULL,
	[DCHA03] [numeric](17, 6) NULL,
	[DCHA04] [numeric](17, 6) NULL,
	[DCHA05] [numeric](17, 6) NULL,
	[DCHB01] [numeric](17, 6) NULL,
	[DCHB02] [numeric](17, 6) NULL,
	[DCHB03] [numeric](17, 6) NULL,
	[DCHB04] [numeric](17, 6) NULL,
	[DCHB05] [numeric](17, 6) NULL,
	[DCHB06] [numeric](17, 6) NULL,
	[DCHB07] [numeric](17, 6) NULL,
	[DCHB08] [numeric](17, 6) NULL,
	[DCHB09] [numeric](17, 6) NULL,
	[DCHB10] [numeric](17, 6) NULL,
	[DCHB11] [numeric](17, 6) NULL,
	[DCHB12] [numeric](17, 6) NULL,
	[DCHB13] [numeric](17, 6) NULL,
	[DCHB14] [numeric](17, 6) NULL,
	[DCHC01] [numeric](17, 6) NULL,
	[DCHC02] [numeric](17, 6) NULL,
	[DCHD01] [numeric](17, 6) NULL,
	[DCHD02] [numeric](17, 6) NULL,
	[DAKO01] [numeric](17, 6) NULL,
	[DAKO02] [numeric](17, 6) NULL,
	[DAKO03] [numeric](17, 6) NULL,
	[DAKO04] [numeric](17, 6) NULL,
	[DAKO05] [numeric](17, 6) NULL,
	[DAKO06] [numeric](17, 6) NULL,
	[DAKO07] [numeric](17, 6) NULL,
	[DAKO08] [numeric](17, 6) NULL,
	[DAKO09] [numeric](17, 6) NULL,
	[DAKO10] [numeric](17, 6) NULL,
	[DAKO11] [numeric](17, 6) NULL,
	[DAKO12] [numeric](17, 6) NULL,
	[DAKO13] [numeric](17, 6) NULL,
	[DAKO14] [numeric](17, 6) NULL,
	[DAKO15] [numeric](17, 6) NULL,
	[DAUM01] [numeric](17, 6) NULL,
	[DAUM02] [numeric](17, 6) NULL,
	[DAUM03] [numeric](17, 6) NULL,
	[DAUM04] [numeric](17, 6) NULL,
	[DAUM05] [numeric](17, 6) NULL,
	[DAUM06] [numeric](17, 6) NULL,
	[DAUM07] [numeric](17, 6) NULL,
	[DAUM08] [numeric](17, 6) NULL,
	[DAUM09] [numeric](17, 6) NULL,
	[DAUM10] [numeric](17, 6) NULL,
	[DAUM11] [numeric](17, 6) NULL,
	[DAUM12] [numeric](17, 6) NULL,
	[DAN501] [numeric](5, 2) NULL,
	[DAN502] [numeric](5, 2) NULL,
	[DAN503] [numeric](5, 2) NULL,
	[DAN504] [numeric](5, 2) NULL,
	[DAN505] [numeric](5, 2) NULL,
	[DAN506] [numeric](5, 2) NULL,
	[DAN507] [numeric](5, 2) NULL,
	[DAN508] [numeric](5, 2) NULL,
	[DAN509] [numeric](5, 2) NULL,
	[DAN510] [numeric](5, 2) NULL,
	[DAN901] [numeric](9, 2) NULL,
	[DAN902] [numeric](9, 2) NULL,
	[DAN903] [numeric](9, 2) NULL,
	[DAN904] [numeric](9, 2) NULL,
	[DAN905] [numeric](9, 2) NULL,
	[DAN906] [numeric](9, 2) NULL,
	[DAN907] [numeric](9, 2) NULL,
	[DAN908] [numeric](9, 2) NULL,
	[DAN909] [numeric](9, 2) NULL,
	[DAN910] [numeric](9, 2) NULL,
	[DAN911] [numeric](9, 3) NULL,
	[DAN912] [numeric](9, 3) NULL,
	[DAN913] [numeric](9, 3) NULL,
	[DAN914] [numeric](9, 3) NULL,
	[DAN915] [numeric](9, 3) NULL,
	[DAA101] [char](1) NULL,
	[DAA102] [char](1) NULL,
	[DAA103] [char](1) NULL,
	[DAA104] [char](1) NULL,
	[DAA105] [char](1) NULL,
	[DAA106] [char](1) NULL,
	[DAA107] [char](1) NULL,
	[DAA108] [char](1) NULL,
	[DAA109] [char](1) NULL,
	[DAA110] [char](1) NULL,
	[DAA301] [char](3) NULL,
	[DAA302] [char](3) NULL,
	[DAA303] [char](3) NULL,
	[DAA304] [char](3) NULL,
	[DAA305] [char](3) NULL,
	[DAA306] [char](3) NULL,
	[DAA307] [char](3) NULL,
	[DAA308] [char](3) NULL,
	[DAA309] [char](3) NULL,
	[DAA310] [char](3) NULL,
	[DAA701] [char](7) NULL,
	[DAA702] [char](7) NULL,
	[DAA703] [char](7) NULL,
	[DAA704] [char](7) NULL,
	[DAA705] [nvarchar](20) NULL,
	[DADT01] [numeric](8, 0) NULL,
	[DADT02] [numeric](8, 0) NULL,
	[DADT03] [numeric](8, 0) NULL,
	[DADT04] [numeric](8, 0) NULL,
	[DADT05] [numeric](8, 0) NULL,
	[DATMST] [datetime2](6) NULL,
	[DADRID] [nvarchar](10) NULL,
	[DADZIP] [nvarchar](20) NULL,
	[DADSTA] [nvarchar](20) NULL,
	[DADCOU] [nvarchar](20) NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);