EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO
EXEC tSQLt.NewTestClass 'OutboundDelivery';
GO

CREATE PROCEDURE [OutboundDelivery].[test edw.vw_LatestOutboundDeliveryItem uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';

  INSERT INTO edw.fact_OutboundDeliveryItem (
    ReferenceSDDocument
    , ReferenceSDDocumentItem
    , HDR_ActualGoodsMovementDate
    , OutboundDelivery)
  VALUES (1, 1, '2020-01-01', 1)
  , (1, 1, '2020-01-02', 2)
  , (1, 1, '2020-01-03', 3)
  , (2, 2, '2020-01-10', 4)
  , (2, 2, '2020-01-10', 5)

  -- Collect non-unique records
  SELECT
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [OutboundDelivery].[test latest HDR_ActualGoodsMovementDate in vw_fact_ScheduleLineStatus]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentScheduleLine]';

  INSERT INTO [edw].[fact_OutboundDeliveryItem] 
    (ReferenceSDDocument, ReferenceSDDocumentItem, HDR_ActualGoodsMovementDate)
  VALUES 
    (1,1,'2020-01-01')
    , (1,1,'2020-01-02')
    , (1,1,'2020-01-03');

  INSERT INTO [edw].[dim_SalesDocumentScheduleLine]
    (SalesDocumentID, SalesDocumentItem)
  VALUES
    (1,1);
    
  -- Collect records with not latest date
  SELECT
    [nk_fact_SalesDocumentItem]
  INTO actual
  FROM 
    [dm_sales].[vw_fact_ScheduleLineStatus] SLS
  LEFT JOIN 
    [edw].[fact_OutboundDeliveryItem]       ODI
    ON SLS.SalesDocumentID = ODI.ReferenceSDDocument
        AND SLS.SalesDocumentItem = ODI.ReferenceSDDocumentItem
  WHERE
    ODI.[HDR_ActualGoodsMovementDate] <= GETDATE()
    AND SLS.[SDI_ODB_LatestActualGoodsMovmtDate] < ODI.[HDR_ActualGoodsMovementDate];

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [Uniqueness].[test dm_sales.vw_fact_OutboundDeliveryItem: uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDDocumentCategory]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_MaterialGroup]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemCategory]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_DeliveryDocumentType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_DistributionChannel]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDProcessStatus]';

  INSERT INTO edw.dim_SDDocumentCategory (SDDocumentCategoryID, SDDocumentCategory)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_MaterialGroup (MaterialGroupID, MaterialGroup)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SalesDocumentItemCategory (SalesDocumentItemCategoryID, SalesDocumentItemCategory)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_DeliveryDocumentType (DeliveryDocumentTypeID, DeliveryDocumentType)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SalesDocumentItemType (SalesDocumentItemTypeID, SalesDocumentItemType)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_DistributionChannel (DistributionChannelID, DistributionChannel)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SDProcessStatus (SDProcessStatusID, SDProcessStatus)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.fact_OutboundDeliveryItem (
    sk_fact_OutboundDeliveryItem,
    ReferenceSDDocumentCategoryID,
    ProductGroupID,
    DeliveryDocumentItemCategoryID,
    HDR_DeliveryDocumentTypeID,
    SalesDocumentItemTypeID,
    DistributionChannelID,
    SDProcessStatusID
  )
  VALUES
    (0, 1, 1, 1, 1, 1, 1, 1),
    (1, 1, 1, 1, 1, 1, 1, 1),
    (2, 2, 2, 2, 2, 2, 2, 2),
    (3, 2, 2, 2, 2, 2, 2, 2);

  -- Act: 
  SELECT
    sk_fact_OutboundDeliveryItem
  INTO actual
  FROM [dm_sales].[vw_fact_OutboundDeliveryItem]
  GROUP BY
    sk_fact_OutboundDeliveryItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [Uniqueness].[test edw.vw_OutboundDeliveryItem_s4h: uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDelivery]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentCompletePartners]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Supplier]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Route]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Customer]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO base_s4h_cax.I_OutboundDeliveryItem (OutboundDelivery, OutboundDeliveryItem)
  VALUES (1, 1), (1, 2), (2, 1), (2, 2);

  INSERT INTO base_s4h_cax.I_OutboundDelivery (OutboundDelivery, SoldToParty, ActualDeliveryRoute, ProposedDeliveryRoute)
  VALUES (1, 1, 1, 1), (2, 2, 2, 2);

  INSERT INTO base_s4h_cax.I_SDDocumentCompletePartners (SDDocument, SDDocumentItem, PartnerFunction, Supplier)
  VALUES
    (1, 1, 'XX', 1),
    (1, 000000, 'SP', 1), -- SDDocumentItem is always 000000 for PartnerFunction SP (Delivery Agent)
    (1, 2, 'XX', 1),
    (2, 1, 'XX', 1),
    (2, 000000, 'SP', 1),
    (2, 2, 'XX', 1);

  INSERT INTO base_s4h_cax.I_Supplier (Supplier)
  VALUES (1), (2);

  INSERT INTO base_s4h_cax.I_SalesDocumentScheduleLine (SalesDocument, SalesDocumentItem, ScheduleLine)
  VALUES (1, 1, 1), (1, 1, 2), (1, 2, 1), (1, 2, 2), (2, 1, 1), (2, 1, 2), (2, 2, 1), (2, 2, 2);

  INSERT INTO edw.dim_Route (ROUTEID)
  VALUES (1), (2);

  INSERT INTO edw.dim_Customer (CustomerID)
  VALUES (1), (2);

  INSERT INTO edw.fact_SalesDocumentItem (
    sk_fact_SalesDocumentItem,
    -- nk_fact_SalesDocumentItem,
    SalesDocument,
    SalesDocumentItem,
    CurrencyTypeID,
    t_applicationId
  )
  VALUES
    ( 0, 1, 1, 10, 's4h-ca'),
    ( 1, 1, 1, 20, 's4h-ca'),
    ( 2, 1, 1, 30, 's4h-ca'),
    ( 3, 1, 2, 10, 's4h-ca'),
    ( 4, 1, 2, 20, 's4h-ca'),
    ( 5, 1, 2, 30, 's4h-ca'),
    ( 6, 2, 1, 10, 's4h-ca'),
    ( 7, 2, 1, 20, 's4h-ca'),
    ( 8, 2, 1, 30, 's4h-ca'),
    ( 9, 2, 2, 10, 's4h-ca'),
    (10, 2, 2, 20, 's4h-ca'),
    (11, 2, 2, 30, 's4h-ca');

  -- Act: 
  SELECT
    nk_fact_OutboundDeliveryItem
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h]
  GROUP BY
    nk_fact_OutboundDeliveryItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO
