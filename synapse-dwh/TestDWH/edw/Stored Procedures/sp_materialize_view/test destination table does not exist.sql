CREATE PROCEDURE [tc.edw.sp_materialize_view].[test destination table does not exist]
AS
BEGIN

  

  DECLARE @errmessage NVARCHAR(2048) = 'Object [edw].[non_existing_test_table] does not exist.' + CHAR(13) + CHAR(10) +
    'Please check parameter values: @DestSchema = ''edw'', @DestTable = ''non_existing_test_table''';

  EXEC tSQLt.ExpectException @Message = @errmessage, @ExpectedErrorNumber = 50001, @ExpectedState = 1;

  EXEC edw.sp_materialize_view
    'edw',
    'vw_TestMaterialize',
    'edw',
    'non_existing_test_table',
    NULL,
    NULL,
    NULL,
    NULL;

END