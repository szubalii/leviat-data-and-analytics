
-- Do not select quotations in vw_SDDocumentIncompletionLog
CREATE PROCEDURE [tc.edw.vw_SDDocumentIncompletionLog].[test contains no quotations]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentIncompletionLog]';

  
  INSERT INTO base_s4h_cax.I_SDDocumentIncompletionLog (SDDocument)
  VALUES
    ('001');

  -- Act: 
  SELECT
    SDDocument
  INTO actual
  FROM [edw].[vw_SDDocumentIncompletionLog]

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
