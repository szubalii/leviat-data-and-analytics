CREATE PROCEDURE [tc.edw.svf_getInventory_Adj_KPI].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    BusinessTransactionTypeID CHAR(4),
    TransactionTypeDeterminationID CHAR(3),
    AmountInCompanyCodeCurrency INT
  );
  INSERT INTO testdata (
    BusinessTransactionTypeID,
    TransactionTypeDeterminationID,
    AmountInCompanyCodeCurrency
  )
  VALUES
    (NULL, NULL, 10),
    ('RMBL', NULL, 10),
    (NULL, 'UMB', 10),
    ('RMBL', 'UMB', 10);

  -- Act:
  SELECT
    BusinessTransactionTypeID,
    TransactionTypeDeterminationID,
    Inventory_Adj_KPI
  INTO actual
  FROM (
    SELECT
      BusinessTransactionTypeID,
      TransactionTypeDeterminationID,
      [edw].[svf_getInventory_Adj_KPI](
        BusinessTransactionTypeID,
        TransactionTypeDeterminationID,
        AmountInCompanyCodeCurrency
      ) AS Inventory_Adj_KPI
    FROM testdata
  ) a;

  -- Assert:
  CREATE TABLE expected (
    BusinessTransactionTypeID CHAR(4),
    TransactionTypeDeterminationID CHAR(3),
    Inventory_Adj_KPI INT
  );
  INSERT INTO expected (
    BusinessTransactionTypeID,
    TransactionTypeDeterminationID,
    Inventory_Adj_KPI
  )
  VALUES
    (NULL, NULL, NULL),
    ('RMBL', NULL, NULL),
    (NULL, 'UMB', NULL),
    ('RMBL', 'UMB', 10);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
