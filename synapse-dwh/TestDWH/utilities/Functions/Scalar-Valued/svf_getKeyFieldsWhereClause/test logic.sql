-- DROP PROCEDURE [tc.utilities.svf_getKeyFieldsWhereClause].[test logic]
-- AS
-- BEGIN

--   -- Act: 
--   DECLARE
--     @actual NVARCHAR(1024) = (SELECT
--       [utilities].[svf_getKeyFieldsWhereClause](
--         'base_s4h_cax',
--         'active'
--       )
--     ),
--     @expected NVARCHAR(1024) = N'[base_s4h_cax].[active].[PrimaryKeyField_1] = src.[PrimaryKeyField_1]
--       AND
--       [base_s4h_cax].[active].[PrimaryKeyField_2] = src.[PrimaryKeyField_2]';

--   -- Assert:
--   EXEC tSQLt.AssertEquals @expected, @actual;
-- END;
