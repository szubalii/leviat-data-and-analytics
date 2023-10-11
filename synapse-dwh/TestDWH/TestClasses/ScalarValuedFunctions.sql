-- EXEC [tSQLt].[SetFakeViewOn] 'edw';
-- GO

EXEC tSQLt.NewTestClass 'ScalarValuedFunctions';
GO

-- edw.svf_getInOutID_EPM
CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (005;3)=IC_Lev]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '005', '3'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_Lev', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (IP;NULL)=IC_Lev]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    'IP', NULL
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_Lev', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (IC__35%;NULL)=IC_Lev]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    'ICNL35', NULL
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_Lev', @actual;
END;
GO


CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (IC__^3^5%;NULL)=IC_CRH]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    'ICNL45', NULL
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_CRH', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (005;2)=OC]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '005', '2'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'OC', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (NULL;2)=OC]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    NULL, '2'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'OC', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (NULL;3)=IC_Lev]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    NULL, '3'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_Lev', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: ('';2)=OC]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '', '2'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'OC', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: ('';3)=IC_Lev]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '', '3'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'IC_Lev', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (NULL;1)=MA]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    NULL, 1
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'MA', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: ('';1)=MA]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '', 1
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'MA', @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInOutID_EPM: (003;)=MA]
AS
BEGIN
  -- Act: 
  DECLARE @actual CHAR(6) = ( SELECT edw.svf_getInOutID_EPM(
    '003', NULL
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'MA', @actual;
END;
GO

-- edw.svf_getIC_Balance_KPI
CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getIC_Balance_KPI: (0015112100,DE35;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getIC_Balance_KPI(
    '0015112100', 'DE35', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getIC_Balance_KPI: (0015112100,'';AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getIC_Balance_KPI(
    '0015112100', '', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getIC_Balance_KPI: (0011111111,DE35;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getIC_Balance_KPI(
    '0011111111', 'DE35', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

-- svf_getInventory_Adj_KPI
CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: (RMBL;UMB;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    'RMBL', 'UMB', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: (AS91;UMB;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    'AS91', 'UMB', 1000.00
  ));

    -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: (RMBL;BSX;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    'RMBL', 'BSX', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: (RMBL;'';AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    'RMBL', '', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: ('';UMB;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    '', 'UMB', 1000.00
  ));

    -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getInventory_Adj_KPI: ('';'';AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getInventory_Adj_KPI(
    '', '', 1000.00
  ));

    -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
END;
GO

-- EXEC [tSQLt].[SetFakeViewOff] 'edw';

-- GO
