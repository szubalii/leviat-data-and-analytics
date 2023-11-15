CREATE PROCEDURE [tc.dm_procurement.vw_dim_GLAccountText].[test account with no marker]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_ff]', '[POAccount]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_GLAccountText]';
   
  INSERT INTO [base_ff].[POAccount] (
    GLAccountID
  )
  VALUES
    ('12345678')
    ,('23456789')
    ,('34567890');

  INSERT INTO [base_s4h_cax].[I_GLAccountText] (
    [MANDT]
    ,[ChartOfAccounts]
    ,[GLAccount]
    ,[Language]
  )
  VALUES
    ('200', 'TST', '0012345678', 'E')
    ,('200', 'TST', '0023456789', 'E')
    ,('200', 'TST', '0045678901', 'E');

  -- Act: 
  SELECT *
  INTO actual
  FROM [dm_procurement].[vw_dim_GLAccountText]
  WHERE GLAccountID IN ('0045678901')
    AND IsPurchaseOrderExpected <> 0;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
