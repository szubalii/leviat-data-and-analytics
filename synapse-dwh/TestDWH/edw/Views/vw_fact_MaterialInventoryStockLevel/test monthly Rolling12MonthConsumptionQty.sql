CREATE PROCEDURE [tc.edw.vw_fact_MaterialInventoryStockLevel].[test monthly Rolling12MonthConsumptionQty]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_Calendar]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_MaterialDocumentItem]';

  INSERT INTO edw.dim_Calendar (
    CalendarDate,
    YearWeek,
    YearMonth,
    FirstDayOfMonthDate
  )
  VALUES
    ('2022-12-01', NULL, 202212, '2022-12-01'),
    ('2022-12-22', NULL, 202212, '2022-12-01'),
    ('2023-01-01', NULL, 202301, '2023-01-01'),
    ('2023-01-29', NULL, 202301, '2023-01-01'),
    ('2023-02-01', NULL, 202302, '2023-02-01'),
    ('2023-03-01', NULL, 202303, '2023-03-01'),
    ('2023-04-01', NULL, 202304, '2023-04-01'),
    ('2023-05-01', NULL, 202305, '2023-05-01'),
    ('2023-06-01', NULL, 202306, '2023-06-01'),
    ('2023-07-01', NULL, 202307, '2023-07-01'),
    ('2023-07-08', NULL, 202307, '2023-07-01'),
    ('2023-08-01', NULL, 202308, '2023-08-01'),
    ('2023-09-01', NULL, 202309, '2023-09-01'),
    ('2023-10-01', NULL, 202310, '2023-10-01'),
    ('2023-10-22', NULL, 202310, '2023-10-01'),
    ('2023-11-01', NULL, 202311, '2023-11-01'),
    ('2023-12-01', NULL, 202312, '2023-12-01'),
    ('2024-01-01', NULL, 202401, '2024-01-01'),
    ('2024-01-22', NULL, 202401, '2024-01-01'),
    ('2024-01-23', NULL, 202401, '2024-01-01'),
    ('2024-02-01', NULL, 202402, '2024-02-01'),
    ('2024-02-29', NULL, 202402, '2024-02-01'),
    ('2024-03-01', NULL, 202403, '2024-03-01');

  INSERT INTO edw.fact_MaterialDocumentItem (
    [MaterialID]
  , [HDR_PostingDate]
  , [MatlCnsmpnQtyInMatlBaseUnit]
   ,[t_applicationId]
  )
  VALUES
    (1, '2022-12-22', 100, 's4h-cap-100'),
    (1, '2023-01-29', -20, 's4h-cap-100'),
    (1, '2023-02-01', -20, 's4h-cap-100'),
    (1, '2023-07-08',  10, 's4h-cap-100'),
    (1, '2023-10-22',  20, 's4h-cap-100'),
    (1, '2024-01-22', -10, 's4h-cap-100'),
    (1, '2024-01-23', -10, 's4h-cap-100'),
    (1, '2024-02-29',  20, 's4h-cap-100'),
    (1, '2024-03-01',  20, 's4h-cap-100');

  -- Act: 
  SELECT
    [MaterialID],
    -- [YearWeek],
    [YearMonth],
    [Rolling12MonthConsumptionQty]
  INTO actual
  FROM [edw].[vw_fact_MaterialInventoryStockLevel]
  WHERE
    YearWeek <= 202405
    OR
    YearMonth <= 202403

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    [MaterialID],
    -- [YearWeek],
    [YearMonth],
    [Rolling12MonthConsumptionQty]
  )
  VALUES
    (1, 202212, 100),
    (1, 202301,  80),
    (1, 202302,  60),
    (1, 202303,  60),
    (1, 202304,  60),
    (1, 202305,  60),
    (1, 202306,  60),
    (1, 202307,  70),
    (1, 202308,  70),
    (1, 202309,  70),
    (1, 202310,  90),
    (1, 202311,  90),
    (1, 202312, -10),
    (1, 202401, -10),
    (1, 202402,  30),
    (1, 202403,  50);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;