﻿CREATE PROCEDURE [tc.intm_s4h.vw_SalesDocumentFirstScheduleLine].[test min values]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';

  
  INSERT INTO [base_s4h_cax].[I_SalesDocumentScheduleLine] (
    [SalesDocument],
    [SalesDocumentItem],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [ScheduleLine])
  VALUES
    ('1','1','2023-10-19','2023-10-17','001'),
    ('1','1','2023-10-18','2023-10-19','002')
    ('1','1','2023-10-20','2023-10-20','003');

  -- Act: 
  SELECT
    [SalesDocument],
    [SalesDocumentItem],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [ScheduleLine]
  INTO actual
  FROM [intm_s4h].[vw_SalesDocumentFirstScheduleLine];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [SalesDocument],
    [SalesDocumentItem],
    [ConfirmedDeliveryDate],
    [GoodsIssueDate],
    [ScheduleLine])
  VALUES
    ('1','1','2023-10-18','2023-10-17','001');

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;