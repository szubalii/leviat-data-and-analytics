CREATE PROCEDURE [tc.intm_s4h.vw_OriginalConfirmedScheduleLineDeliveryDate].[test min values]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_ChangeDocumentItem_VBEP_EDATU]';

  
  INSERT INTO [base_s4h_cax].[I_ChangeDocumentItem_VBEP_EDATU] (
    [ChangeDocTableKey],
    [ChangeDocPreviousFieldValue]
  VALUES
    ('20000200658340000100002','2023-08-28'),
    ('20000200658340000100002','2023-07-05')
    ('20000200658340000100002','2023-07-24');

  -- Act: 
  SELECT
    [SalesDocumentID],
    [SalesDocumentItemID],
    [ScheduleLine],
    [OriginalConfirmedDeliveryDate]
  INTO actual
  FROM [intm_s4h].[vw_OriginalConfirmedScheduleLineDeliveryDate]

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
   [SalesDocumentID],
   [SalesDocumentItemID],
   [ScheduleLine],
   [OriginalConfirmedDeliveryDate])
  VALUES
    ('0020065834','000010','0002','023-07-05');

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;