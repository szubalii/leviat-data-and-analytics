-- Test for sum logic in [edw].[vw_TransportationOrderItemFreightCost]
CREATE PROCEDURE [tc.edw.vw_TransportationOrderItemFreightCost].[test sum amount]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_TransportationOrderItem') IS NOT NULL DROP TABLE #vw_TransportationOrderItem;
  IF OBJECT_ID('tempdb..#vw_FrtCostDistrItm') IS NOT NULL DROP TABLE #vw_FrtCostDistrItm;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_FrtCostDistrItm]';

  SELECT TOP(0) *
  INTO #vw_TransportationOrderItem
  FROM edw.vw_TransportationOrderItem;

  -- #2
  INSERT INTO #vw_TransportationOrderItem
    (TranspOrdDocReferenceID, TranspOrdDocReferenceItmID, TransportationOrderItemUUID)
  VALUES
     (1, 1, 1)
    ,(2, 1, 2);

  EXEC ('INSERT INTO edw.vw_TransportationOrderItem SELECT * FROM #vw_TransportationOrderItem');

  SELECT TOP(0) *
  INTO #vw_FrtCostDistrItm
  FROM edw.vw_FrtCostDistrItm;

  -- #2
  INSERT INTO #vw_FrtCostDistrItm 
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount)
  VALUES
     (1, 120)
    ,(1, 140)
    ,(2, 100);

  EXEC ('INSERT INTO edw.vw_FrtCostDistrItm SELECT * FROM #vw_FrtCostDistrItm');
  
  -- Act: 
  SELECT
    TranspOrdDocReferenceID
  , TranspOrdDocReferenceItmID
  , FrtCostDistrItemAmount
  INTO actual
  FROM [edw].[vw_TransportationOrderItemFreightCost];

  -- Fill expected
  CREATE TABLE expected (
    TranspOrdDocReferenceID     INT,
    TranspOrdDocReferenceItmID  INT,
    FrtCostDistrItemAmount      INT
  );

  INSERT INTO expected (
    TranspOrdDocReferenceID,
    TranspOrdDocReferenceItmID,
    FrtCostDistrItemAmount
  )
  VALUES
    (1, 1, 260)
  , (2, 1, 100);
  
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
