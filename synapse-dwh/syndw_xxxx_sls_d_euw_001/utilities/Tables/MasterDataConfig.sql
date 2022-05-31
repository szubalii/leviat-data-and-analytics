CREATE TABLE [utilities].[MasterDataConfig]
(
  [ADLSContainer] NVARCHAR(100) NOT NULL,
  [ADLSDirectory] NVARCHAR(100),
  [ADLSFileName] NVARCHAR(100) NOT NULL,
  [FieldDelimiter] CHAR(1),
  [BaseSchemaName] NVARCHAR(),
  [BaseTableName] NVARCHAR(),
  [ApplicationID] NVARCHAR(),
  
)
