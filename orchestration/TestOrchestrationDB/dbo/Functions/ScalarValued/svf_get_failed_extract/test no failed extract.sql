CREATE PROCEDURE [tc.dbo.svf_get_failed_extract].[test no failed extract]
AS
BEGIN  
  DECLARE @actual TINYINT;

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
  SET @actual = dbo.svf_get_failed_extract(2);

  -- Assert:
  EXEC tSQLt.AssertEquals @actual, 0;
END;
GO

