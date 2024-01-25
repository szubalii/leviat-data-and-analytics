CREATE PROCEDURE [tc.dbo.svf_get_failed_extract].[test failed extract exists]
AS
BEGIN  
  DECLARE TINYINT @actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.batch (
    entity_id,
    activity_id,
    status_id
  )
  VALUES
    (1, 1 , 4),
    (1, 2 , 2),
    (1, 21 , 4),
    (2, 1 , 4),
    (2, 2 , 2),
    (2, 21 , 2);

  -- Act: 
  SELECT
    @actual = svf_get_failed_extract(1);

  -- Assert:
  EXEC tSQLt.AssertEquals @actual, 1;
END;
GO

