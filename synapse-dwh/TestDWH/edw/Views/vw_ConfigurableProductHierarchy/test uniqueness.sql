CREATE PROCEDURE [tc.edw.vw_ConfigurableProductHierarchy].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[Z_C_VariantConfig_ProductHierarchy_F]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Product]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_ProductText]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNode]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ProductHierarchyNodeMapping]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ProductHierarchy]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ConfigurableProductCharacteristic]';

  INSERT INTO base_s4h_cax.Z_C_VariantConfig_ProductHierarchy_F (
     SalesDocument 
    ,SalesDocumentItem
    ,CharacteristicName
    ,CharValue
    ,ProductID
    )
  VALUES 
    (1, 1, 'ZCH_SO_ITEM_PROD_HIERARCHY', 1, 1), 
    (1, 2, 'ZCH_SO_ITEM_PROD_HIERARCHY', 2, 2), 
    (2, 1, 'ZCH_SO_ITEM_PROD_HIERARCHY1', 3, 1), 
    (2, 2, 'ZCH_SO_ITEM_PROD_HIERARCHY1', 4, 2);

  INSERT INTO base_s4h_cax.I_Product (MANDT, Product)
  VALUES (100, 1), (100, 2);

  INSERT INTO base_s4h_cax.I_ProductText (MANDT, Product, [Language])
  VALUES (100, 1, 'E'), (100, 2, 'E');

  INSERT INTO base_s4h_cax.I_ProductTypeText (MANDT, ProductType, [Language])
  VALUES (100, 1, 'E'), (100, 2, 'E');

  INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  VALUES 
    (1, 1, 5), (1, 2, 6), (2, 1, 7), (2, 2, 8);

  INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  VALUES (1, 1), (1, 2), (2, 1), (2, 2);

  INSERT INTO edw.dim_ProductHierarchy (ProductHierarchyNode)
  VALUES (1), (2), (3);

  INSERT INTO base_ff.ConfigurableProductCharacteristic (CharacteristicName, CharacteristicCategory)
  VALUES 
    ('ZCH_SO_ITEM_PROD_HIERARCHY', 'ProductHierarchy'), 
    ('ZCH_SO_ITEM_PROD_HIERARCHY1', 'ProductHierarchy');

  -- Act: 
  SELECT
    sk_dim_ConfigurableProductHierarchy
  INTO actual
  FROM [edw].[vw_ConfigurableProductHierarchy]
  GROUP BY
    sk_dim_ConfigurableProductHierarchy
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
