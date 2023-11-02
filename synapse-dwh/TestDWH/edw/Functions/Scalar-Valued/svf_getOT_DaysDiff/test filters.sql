CREATE PROCEDURE [tc.edw.svf_getOT_DaysDiff].[test filters]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  ---- Assemble:
  CREATE TABLE testdata (
    DeliveryDate DATE,
    CalculatedDate DATE,
    Cur_date DATE
  );

  INSERT INTO testdata (DeliveryDate,CalculatedDate,Cur_date)
  VALUES (NULL,'0001-01-01','2023-10-24'),('0001-01-01',NULL,'2023-10-24'),
  ('2023-10-18',NULL,'2023-10-24'),('2023-10-18','0001-01-01','2023-10-24'),
  ('2023-10-24',NULL,'2023-10-18'),('2023-10-24','0001-01-01','2023-10-18'),
  ('2023-10-18','2023-10-23','2023-10-24'),('2023-10-15','2023-10-21','2023-10-24');

  ---- Act:
  SELECT
    DeliveryDate,
    CalculatedDate,
    Cur_date,
    [edw].[svf_getOT_DaysDiff](DeliveryDate,CalculatedDate,Cur_date) AS OT_DaysDiff
  INTO actual
  FROM testdata;

  ---- Assert:
  CREATE TABLE expected (
    DeliveryDate DATE,
    CalculatedDate DATE,
    Cur_date DATE,
    OT_DaysDiff INT
  );

  INSERT INTO expected (DeliveryDate,CalculatedDate,Cur_date,OT_DaysDiff)
  VALUES ('0001-01-01',NULL,'2023-10-24',NULL),('2023-10-18',NULL,'2023-10-24',4),
 ('2023-10-18','0001-01-01','2023-10-24',4),('2023-10-24','0001-01-01','2023-10-18',NULL),
 ('2023-10-24',NULL,'2023-10-18',NULL),('2023-10-18','2023-10-23','2023-10-24',3),
 ('2023-10-15','2023-10-21','2023-10-24',6);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
