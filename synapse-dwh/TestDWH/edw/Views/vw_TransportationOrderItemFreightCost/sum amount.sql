-- Test for sum logic in [edw].[vw_TransportationOrderItemFreightCost]
CREATE PROCEDURE [tc.edw.vw_TransportationOrderItemFreightCost].[test sum logic]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
  
  INSERT INTO base_s4h_cax.I_TransportationOrderItem
    (MANDT, TransportationOrderItemUUID, TranspOrdDocReferenceID, TranspOrdDocReferenceItmID)
  VALUES 
    (200, CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 1, 1)
    ,(200, CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 2, 2);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    (CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 120, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 140, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 100, 'EUR');
  
  -- Act: 
  SELECT
     TranspOrdDocReferenceID
    , TranspOrdDocReferenceItmID
    , FrtCostDistrItemAmount
    , FrtCostDistrItemAmtCrcy
  INTO actual
  FROM 
    [edw].[vw_TransportationOrderItemFreightCost];

  -- Fill expected
  CREATE TABLE expected (
    TranspOrdDocReferenceID     INT,
    TranspOrdDocReferenceItmID  INT,
    FrtCostDistrItemAmount      INT,
    FrtCostDistrItemAmtCrcy     VARCHAR(3)
  );

  INSERT INTO expected 
    (TranspOrdDocReferenceID, TranspOrdDocReferenceItmID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    (1, 1, 260, 'CHF')
    , (2, 2, 100, 'EUR');
  
  -- Assert:

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
