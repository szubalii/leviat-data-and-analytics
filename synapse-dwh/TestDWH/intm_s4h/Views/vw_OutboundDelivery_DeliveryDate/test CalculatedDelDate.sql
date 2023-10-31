
CREATE PROCEDURE [tc.intm_s4h.vw_OutboundDelivery_DeliveryDate].[test CalculatedDelDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDelivery]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Route]';


  [base_s4h_cax].[I_OutboundDelivery]
   [edw].[dim_Route] 
  INSERT INTO [base_s4h_cax].[I_OutboundDelivery]([OutboundDelivery],[ActualDeliveryRoute],[ActualGoodsMovementDate])
  VALUES ('1','1','2023-04-28'),('2','2','0001-01-01'),('3','3','2023-10-08');

  INSERT INTO [edw].[dim_Route] ([ROUTEID],[DurInDays])
  VALUES ('1',3),('2',0),('3',2);

  -- Act: 
  SELECT    
    [CalculatedDelDate]
  INTO actual
  FROM [intm_s4h].[vw_OutboundDelivery_DeliveryDate]

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected([CalculatedDelDate])
  VALUES('2023-05-06'),('2023-10-10');
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;