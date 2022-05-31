CREATE TABLE [base_ff].[SAPDummyProduct]
(
  ProductID NVARCHAR(40) NOT NULL,
  ProductExternalID NVARCHAR(40),
  Product NVARCHAR(40),
  ProductType NVARCHAR(4),
  ProductHierarchyNode NVARCHAR(18),
  Product_L1_Pillar NVARCHAR(40),
  Product_L2_Group NVARCHAR(40),
  Product_L3_Type NVARCHAR(40),
  Product_L4_Family NVARCHAR(40),
  Product_L5_SubFamily NVARCHAR(40),
  [t_applicationId] VARCHAR (32),
  [t_jobId] VARCHAR (36),
  [t_jobDtm] DATETIME,
  [t_jobBy] VARCHAR (128),
  [t_filePath] NVARCHAR (1024),
  CONSTRAINT [PK_SAPDummyProduct] PRIMARY KEY NONCLUSTERED (
    ProductID
  ) NOT ENFORCED
)
WITH (
  HEAP
)
