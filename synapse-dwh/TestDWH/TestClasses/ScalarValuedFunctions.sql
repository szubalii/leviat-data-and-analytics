-- EXEC [tSQLt].[SetFakeViewOn] 'edw';
-- GO

EXEC tSQLt.NewTestClass 'ScalarValuedFunctions';
GO


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


-- EXEC [tSQLt].[SetFakeViewOff] 'edw';

-- GO
