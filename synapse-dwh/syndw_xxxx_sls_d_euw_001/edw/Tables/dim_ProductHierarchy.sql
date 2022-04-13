CREATE TABLE [edw].[dim_ProductHierarchy]
(
    [ProductHierarchyNode]   nvarchar(36) NOT NULL,
    [Product_L1_PillarID]        nvarchar(36) NULL,
    [Product_L2_GroupID]         nvarchar(36) NULL,
    [Product_L3_TypeID]          nvarchar(36) NULL,
    [Product_L4_FamilyID]        nvarchar(36) NULL,
    [Product_L5_SubFamilyID]     nvarchar(36) NULL,

    [Product_L1_Pillar]          nvarchar(80) NULL,
    [Product_L2_Group]           nvarchar(80) NULL,
    [Product_L3_Type]            nvarchar(80) NULL,
    [Product_L4_Family]          nvarchar(80) NULL,
    [Product_L5_SubFamily]       nvarchar(80) NULL

, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO