CREATE PROCEDURE [tc.edw.sp_materialize_view].[test destination table does not exist]
AS
BEGIN

  CREATE VIEW [edw].[test_view] AS (
    SELECT * FROM 
  );

  DECLARE @errmessage NVARCHAR(2048) = 'Object [edw].[non_existing_test_table] does not exist.' + CHAR(13) + CHAR(10) +
    'Please check parameter values: @DestSchema = ''edw'', @DestTable = ''non_existing_test_table''';

  EXEC tSQLt.ExpectException @Message = @errmessage, @ExpectedSeverity = 16, @ExpectedState = 10;

  EXEC edw.sp_materialize_view
    'edw',
    'test_view',
    'edw',
    'non_existing_test_table',
    NULL,
    NULL,
    NULL,
    NULL;

  DROP VIEW [edw].[test_view];

END