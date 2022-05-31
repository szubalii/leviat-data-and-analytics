CREATE TABLE [map_AXBI].[AXProductSAPHierarchy]
(   [DATAAREAID]         NVARCHAR(8)    NOT NULL,
    [UDF_SYSTEM]         NVARCHAR(20)   NOT NULL,
    [UDF_OPCO]           NVARCHAR(20)   NOT NULL,
    [UDF_COUNTRY]        NVARCHAR(3)    NOT NULL,
    [Wave]               NVARCHAR(5),
    [UDF_ITEMID]         NVARCHAR(100)  NOT NULL,
    [ITEMID]             NVARCHAR(100)  NOT NULL,
    [ITEMNAME]           NVARCHAR(150),
    [MATERIAL_TYPE]      NVARCHAR(20),
    [MIGRATE]            CHAR(25),
    [DUPLICATE_ID]       NVARCHAR(100),
    [DUPLICATE_INACTIVE] NVARCHAR(100),
    [ORIGINAL_MATERIAL]  NVARCHAR(100),
    [SAP_MATERIAL]       NVARCHAR(100),
    [FINAL_TEXT]         NVARCHAR(250),
    [PILLAR_OWNER]       NVARCHAR(100),
    [SALES_PROD_HIER_L1] NVARCHAR(100),
    [SALES_PROD_HIER_L2] NVARCHAR(100),
    [SALES_PROD_HIER_L3] NVARCHAR(100),
    [SALES_PROD_HIER_L4] NVARCHAR(100),
    [SALES_PROD_HIER_L5] NVARCHAR(100),
    [t_applicationId]    VARCHAR(32)    NULL,
    [t_jobId]            VARCHAR(36)    NULL,
    [t_jobDtm]           DATETIME       NULL,
    [t_jobBy]            NVARCHAR(128)  NULL,
    [t_filePath]         NVARCHAR(1024) NULL
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO