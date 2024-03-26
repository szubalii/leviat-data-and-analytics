CREATE PROCEDURE [tc.edw.sp_materialize_view].[test source view does not exist]
AS
BEGIN

  CREATE TABLE [edw].[test_table](
    tf AS INT
  );

  DECLARE @errmessage NVARCHAR(2048) = 'Object [edw].[non_existing_test_view] does not exist.' + CHAR(13) + CHAR(10) +
    'Please check parameter values: @SourceSchema = ''edw'', @SourceView = ''non_existing_test_view''';

  EXEC tSQLt.ExpectException @Message = @errmessage, @ExpectedSeverity = 16, @ExpectedState = 10;

  EXEC edw.sp_materialize_view
    'edw',
    'non_existing_test_view',
    'edw',
    'test_table',
    NULL,
    NULL,
    NULL,
    NULL;

  DROP TABLE [edw].[test_table];

END