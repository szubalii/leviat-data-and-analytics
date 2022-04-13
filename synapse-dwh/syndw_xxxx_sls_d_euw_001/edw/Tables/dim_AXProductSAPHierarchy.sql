CREATE TABLE [edw].[dim_AXProductSAPHierarchy]
(
    [ProductID]              NVARCHAR(110) NOT NULL,
    [ProductExternalID]      NVARCHAR(110) NOT NULL,
    [Product]                NVARCHAR(250),
    [ProductID_Name]         NVARCHAR(400),
    [MaterialTypeID]         NVARCHAR(20),
    [MaterialType]           NVARCHAR(25),
    [ProductHierarchy]       NVARCHAR(36)  NULL,
    [Product_L1_PillarID]    NVARCHAR(36)  NULL,
    [Product_L2_GroupID]     NVARCHAR(36)  NULL,
    [Product_L3_TypeID]      NVARCHAR(36)  NULL,
    [Product_L4_FamilyID]    NVARCHAR(36)  NULL,
    [Product_L5_SubFamilyID] NVARCHAR(36)  NULL,
    [Product_L1_Pillar]      NVARCHAR(100),
    [Product_L2_Group]       NVARCHAR(100),
    [Product_L3_Type]        NVARCHAR(100),
    [Product_L4_Family]      NVARCHAR(100),
    [Product_L5_SubFamily]   NVARCHAR(100),
    [DATAAREAID]             NVARCHAR(8)   NOT NULL,
    [DATAAREAID_Calculated]  NVARCHAR(8)   NOT NULL,
    [SAP_MATERIAL]           NVARCHAR(100),
    [MIGRATE]                CHAR(25),
    [ORIGINAL_MATERIAL]      NVARCHAR(100),
    [t_applicationId]        VARCHAR(32),
    [t_jobId]                VARCHAR(36),
    [t_jobDtm]               DATETIME,
    [t_lastActionCd]         VARCHAR(1),
    [t_jobBy]                NVARCHAR(128),
    [t_extractionDtm]        DATETIME
   -- CONSTRAINT [PK_dim_AXProductSAPHierarchy] PRIMARY KEY NONCLUSTERED ([ProductID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO