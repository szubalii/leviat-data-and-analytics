CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test CalculatedDelDate]
AS
BEGIN

  IF OBJECT_ID('actual')    IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected')  IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_OutboundDelivery_DeliveryDate') IS NOT NULL DROP TABLE #vw_OutboundDelivery_DeliveryDate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDelivery]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Route]';
  EXEC tSQLt.FakeTable '[intm_s4h]', '[vw_OutboundDelivery_DeliveryDate]';

  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem] ([MANDT], [OutboundDelivery], [OutboundDeliveryItem])
  VALUES
    (200, 1, 1)
    ,(200, 3, 3)
    ,(200, 4, 4)
    ,(200, 5, 5)
    ,(200, 6, 6);

  INSERT INTO [base_s4h_cax].[I_OutboundDelivery] ([MANDT], [OutboundDelivery], [ActualGoodsMovementDate], [ShippingCondition], [ProposedDeliveryRoute])
  VALUES 
  (200, 1, NULL, 70, 1)                   -- CalculatedDelDate NULL
  ,(200, 3, '2023-01-01', 50, 2)          -- CalculatedDelDate NULL
  ,(200, 4, '2023-01-01', 60, 1)          -- CalculatedDelDate NULL
  ,(200, 5, '2023-01-01', 70, 1)          -- CalculatedDelDate = ActualGoodsMovementDate + 1 DAY
  ,(200, 6, '2023-01-01', 70, 3);         -- CalculatedDelDate = ActualGoodsMovementDate

  INSERT INTO [edw].[dim_Route] ([ROUTEID], [DurInDays], [ROUTE], [TRAZT], [TDVZT], [SPFBK], [EXPVZ], [TDIIX])
  VALUES
    (1, 0, 'TST', 0, 0, 'T', 'T', 'T')
    ,(2, NULL, 'TST', 0, 0, 'T', 'T', 'T')
    ,(3, 10, 'TST', 0, 0, 'T', 'T', 'T');

  SELECT TOP(0) *
  INTO #vw_OutboundDelivery_DeliveryDate
  FROM intm_s4h.vw_OutboundDelivery_DeliveryDate;

  INSERT INTO #vw_OutboundDelivery_DeliveryDate (OutboundDelivery, CalculatedDelDate)
  VALUES (6, '2023-05-01');

  EXEC ('INSERT INTO intm_s4h.vw_OutboundDelivery_DeliveryDate SELECT * FROM #vw_OutboundDelivery_DeliveryDate');
  -- Act: 
  SELECT
    [OutboundDelivery],
    [HDR_ActualGoodsMovementDate],
    [HDR_ShippingCondition],
    [HDR_ProposedDeliveryRoute],
    [CalculatedDelDate]
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [OutboundDelivery],
    [HDR_ActualGoodsMovementDate],
    [HDR_ShippingCondition],
    [HDR_ProposedDeliveryRoute],
    [CalculatedDelDate])
  VALUES
    (1, NULL, 70, 1, NULL)                   -- CalculatedDelDate NULL
    ,(3, '2023-01-01', 50, 2, NULL)          -- CalculatedDelDate NULL
    ,(4, '2023-01-01', 60, 1, NULL)          -- CalculatedDelDate NULL
    ,(5, '2023-01-01', 70, 1, '2023-01-02')  -- CalculatedDelDate = ActualGoodsMovementDate + 1 DAY
    ,(6, '2023-01-01', 70, 3, '2023-05-01'); -- CalculatedDelDate = ActualGoodsMovementDate

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
