EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO

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


-- edw.svf_getManual_JE_KPI
CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFBU;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFBU', 'BKPFF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFPT;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFPT', 'BKPFF', 2000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFCL;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFCL', 'BKPFF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;AZUM;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'AZUM', 'BKPFF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFCV;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFCV', 'BKPFF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFBU;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFBU', 'BKPF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFPT;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFPT', 'BKPF', 2000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFCL;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFCL', 'BKPF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;AZUM;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'AZUM', 'BKPF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (SA;RFCV;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'SA', 'RFCV', 'BKPF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFBU;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFBU', 'BKPFF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFPT;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFPT', 'BKPFF', 2000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFCL;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFCL', 'BKPFF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;AZUM;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'AZUM', 'BKPFF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFCV;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFCV', 'BKPFF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFBU;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFBU', 'BKPF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFPT;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFPT', 'BKPF', 2000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFCL;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFCL', 'BKPF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;AZUM;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'AZUM', 'BKPF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (JR;RFCV;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'JR', 'RFCV', 'BKPF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFBU;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFBU', 'BKPFF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFPT;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFPT', 'BKPFF', 2000.00
  ));

  -- Assert:.
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFCL;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFCL', 'BKPFF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;AZUM;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'AZUM', 'BKPFF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFCV;BKPFF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFCV', 'BKPFF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFBU;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFBU', 'BKPF', 1000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFPT;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFPT', 'BKPF', 2000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 2000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFCL;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFCL', 'BKPF', 3000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 3000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;AZUM;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'AZUM', 'BKPF', 4000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 4000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (AB;RFCV;BKPF;AmountInCompanyCodeCurrency)=AmountInLocalCurrency]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'AB', 'RFCV', 'BKPF', 5000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 5000.00, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunctions].[test edw.svf_getManual_JE_KPI: (WE;RMWE;MKPF;AmountInCompanyCodeCurrency)=0]
AS
BEGIN
  -- Act: 
  DECLARE @actual DECIMAL(23, 2) = ( SELECT edw.svf_getManual_JE_KPI(
    'WE', 'RMWE', 'MKPF', 9000.00
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0.00, @actual;
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
