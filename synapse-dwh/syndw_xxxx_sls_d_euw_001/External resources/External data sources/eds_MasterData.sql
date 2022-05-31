-- TODO use different credential: use AD service principal:
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/create-external-data-source-transact-sql?view=azure-sqldw-latest&preserve-view=true&tabs=dedicated#b-create-external-data-source-to-reference-azure-data-lake-store-gen-1-or-2-using-a-service-principal

CREATE EXTERNAL DATA SOURCE eds_FlatFiles
WITH (
  TYPE = HADOOP,
  LOCATION = 'abfss://flat-files@$(storageAccount).dfs.core.windows.net',
  CREDENTIAL= dsc_MSI
);
