CREATE PROCEDURE [tc.edw.vw_ConfigurableProductHierarchy].[test ProductHierarchy]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_ProductHierarchyVariantConfigCharacteristic]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ConfigurableProductCharacteristic]';

  INSERT INTO edw.vw_ProductHierarchyVariantConfigCharacteristic (
    ProductSurrogateKey,
    CharacteristicName
    )
  VALUES 
    ('1_1', 'NEGATIVE_TEST'),
    ('2_2', 'ZCH_SO_ITEM_PROD_HIERARCHY'),
    ('3_3', 'ZCH_SO_ITEM_PROD_HIERARCHY1');

  -- INSERT INTO base_s4h_cax.I_Product (Product)
  -- VALUES (1), (2), (3);

  -- INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  -- VALUES 
  --   (2, 2, 6), 
  --   (3, 3, 7);

  -- INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  -- VALUES (7, 11), (4, 12);

  INSERT INTO base_ff.ConfigurableProductCharacteristic (CharacteristicName, CharacteristicCategory)
  VALUES 
    ('ZCH_SO_ITEM_PROD_HIERARCHY', 'ProductHierarchy'),
    ('ZCH_SO_ITEM_PROD_HIERARCHY1', 'ProductHierarchy');

-- Act: 
  SELECT
    sk_dim_ConfigurableProductHierarchy,
    ProductHierarchy
  INTO actual
  FROM [edw].[vw_ConfigurableProductHierarchy];

  -- Assert:
  CREATE TABLE expected (
    [sk_dim_ConfigurableProductHierarchy] NVARCHAR(111),
    [ProductHierarchy] NVARCHAR(70)
  );

  INSERT INTO expected (
    sk_dim_ConfigurableProductHierarchy,
    ProductHierarchy
  )
  VALUES
    ('2_2'),
    ('3_3');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;

