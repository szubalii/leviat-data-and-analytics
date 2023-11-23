CREATE PROCEDURE [tc.edw.vw_ConfigurableProductHierarchy].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[Z_C_VariantConfig_ProductHierarchy_F]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNode]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNodeMapping]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ConfigurableProductCharacteristic]';

  INSERT INTO base_s4h_cax.Z_C_VariantConfig_ProductHierarchy_F (
     SalesDocument 
    ,SalesDocumentItem
    ,CharacteristicName
    ,ProductID
    ,CharValue
    )
  VALUES 
    (1, 1, 'ZCH_SO_ITEM_PROD_HIERARCHY', 1, 1), 
    (2, 2, 'ZCH_SO_ITEM_PROD_HIERARCHY1', 2, 2),
    (3, 3, 'ZCH_SO_ITEM_PROD_HIERARCHY1', 3, 3),
    (4, 4, 'ZCH_SO_ITEM_PROD_HIERARCHY1', 4, 4);

  INSERT INTO base_s4h_cax.I_Product (MANDT, Product)
  VALUES (100, 1), (100, 2), (100, 3), (100, 4);

  INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  VALUES 
    (2, 2, 6), 
    (3, 3, 7);

  INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  VALUES (7, 11), (4, 12);

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
    ('1_1', 1),
    ('2_6', 6),
    ('3_7', 11),
    ('4_4', 12);


  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;

