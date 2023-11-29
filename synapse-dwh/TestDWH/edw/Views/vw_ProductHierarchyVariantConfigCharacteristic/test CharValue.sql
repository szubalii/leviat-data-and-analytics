CREATE PROCEDURE [tc.edw.vw_ProductHierarchyVariantConfigCharacteristic].[test CharValue]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[Z_C_VariantConfig_ProductHierarchy_F]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNode]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNodeMapping]';

  INSERT INTO base_s4h_cax.Z_C_VariantConfig_ProductHierarchy_F (
    SalesDocument,
    SalesDocumentItem,
    ProductID,
    CharValue
  )
  VALUES 
    (1, 1, 1, 1),
    (1, 2, 2, 2),
    (2, 1, 3, 3),
    (2, 2, 4, 4);

  INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  VALUES
    (3, 3, 5),
    (4, 4, 6),
    (11, 12, 16);

  INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  VALUES (2, 7), (6, 8), (9, 10);

  -- INSERT INTO base_ff.ConfigurableProductCharacteristic (CharacteristicName, CharacteristicCategory)
  -- VALUES 
  --   ('ZCH_SO_ITEM_PROD_HIERARCHY', 'ProductHierarchy'),
  --   ('ZCH_SO_ITEM_PROD_HIERARCHY1', 'ProductHierarchy');

-- Act: 
  SELECT
    SalesDocument,
    SalesDocumentItem,
    CharValue
  INTO actual
  FROM [edw].[vw_ProductHierarchyVariantConfigCharacteristic];

  -- Assert:
  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
    SalesDocument,
    SalesDocumentItem,
    CharValue
  )
  VALUES
    (1, 1, 1),
    (1, 2, 7),
    (2, 1, 5),
    (2, 2, 8);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
