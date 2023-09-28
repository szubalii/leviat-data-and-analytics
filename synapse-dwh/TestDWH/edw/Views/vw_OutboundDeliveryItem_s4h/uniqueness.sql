CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test uniqueness]
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
