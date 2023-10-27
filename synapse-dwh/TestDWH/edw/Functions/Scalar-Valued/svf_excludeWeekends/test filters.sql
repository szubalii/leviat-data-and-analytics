CREATE PROCEDURE [tc.edw.svf_excludeWeekends].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    DeliveryDate DATE,
    CalculatedDate DATE,
    DeliveryDateWithoutWeekends DATE
  );

  INSERT INTO testdata (DeliveryDate,CalculatedDate)
  VALUES (NULL,'0001-01-01'),('0001-01-01',NULL),('2023-10-21',NULL),('2023-10-21','2023-10-22'),
  ('2023-10-21','2023-10-20'),('2023-10-22','2023-10-23'),('2023-10-22','2023-10-21'),
  ('2023-10-23','2023-10-23'),('2023-10-23','2023-10-24'),('2023-10-24','2023-10-23');

  -- Act:
  SELECT
    DeliveryDate,
    CalculatedDate,
    [edw].[svf_excludeWeekends](DeliveryDate,CalculatedDate) AS DeliveryDateWithoutWeekends
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    DeliveryDate DATE,
    CalculatedDate DATE,
    DeliveryDateWithoutWeekends DATE
  );
  INSERT INTO expected (DeliveryDate,CalculatedDate,DeliveryDateWithoutWeekends)
  VALUES (NULL,'0001-01-01',NULL),('0001-01-01',NULL,NULL),('2023-10-21',NULL,'2023-10-20'),
  ('2023-10-21','2023-10-22','2023-10-20'),('2023-10-21','2023-10-20','2023-10-23'),
  ('2023-10-22','2023-10-23','2023-10-20'),('2023-10-22','2023-10-21','2023-10-23'),
  ('2023-10-23','2023-10-23','2023-10-23'),('2023-10-23','2023-10-24','2023-10-23'),
  ('2023-10-24','2023-10-23','2023-10-24');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
