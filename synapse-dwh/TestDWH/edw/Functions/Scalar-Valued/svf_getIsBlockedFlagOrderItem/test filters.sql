CREATE PROCEDURE [tc.edw.svf_getIsBlockedFlagOrderItem].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    DeliveryBlockReasonID NVARCHAR(2),
    BillingBlockStatusID NVARCHAR(1),
    HeaderBillingBlockReasonID NVARCHAR(2),
    ItemBillingBlockReasonID NVARCHAR(2),
    HDR_DeliveryBlockReason NVARCHAR(2) 
  );
  INSERT INTO testdata (
    DeliveryBlockReasonID,
    BillingBlockStatusID,
    HeaderBillingBlockReasonID,
    ItemBillingBlockReasonID,
    HDR_DeliveryBlockReason
  )
  VALUES
    ('ZW', '', '', '', ''),
    ('', 'C', '', '', ''),
    ('', '', 'Z1', '', ''),
    ('', '', '', 'Z5', ''),
    ('', '', '', '', 'ZN'),
    ('', '', '', '', ''),
    (NULL, NULL, NULL, NULL, NULL);

  -- Act:
  SELECT
    DeliveryBlockReasonID,
    BillingBlockStatusID,
    HeaderBillingBlockReasonID,
    ItemBillingBlockReasonID,
    HDR_DeliveryBlockReason,
    IsBlockedFlagOrderItem
  INTO actual
  FROM (
    SELECT
      DeliveryBlockReasonID,
      BillingBlockStatusID,
      HeaderBillingBlockReasonID,
      ItemBillingBlockReasonID,
      HDR_DeliveryBlockReason,
      [edw].[svf_getIsBlockedFlagOrderItem](
        DeliveryBlockReasonID,
        BillingBlockStatusID,
        HeaderBillingBlockReasonID,
        ItemBillingBlockReasonID,
        HDR_DeliveryBlockReason
      ) AS IsBlockedFlagOrderItem
    FROM testdata
  ) a;

  -- Assert:
  CREATE TABLE expected (
    DeliveryBlockReasonID NVARCHAR(2),
    BillingBlockStatusID NVARCHAR(1),
    HeaderBillingBlockReasonID NVARCHAR(2),
    ItemBillingBlockReasonID NVARCHAR(2),
    HDR_DeliveryBlockReason NVARCHAR(2),
    IsBlockedFlagOrderItem NVARCHAR(2)
  );
  INSERT INTO expected (
    DeliveryBlockReasonID,
    BillingBlockStatusID,
    HeaderBillingBlockReasonID,
    ItemBillingBlockReasonID,
    HDR_DeliveryBlockReason,
    IsBlockedFlagOrderItem
  )
  VALUES
    ('ZW', '', '', '', '', 1),
    ('', 'C', '', '', '', 1),
    ('', '', 'Z1', '', '', 1),
    ('', '', '', 'Z5', '', 1),
    ('', '', '', '', 'ZN', 1),
    ('', '', '', '', '', 0),
    (NULL, NULL, NULL, NULL, NULL, 0);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
