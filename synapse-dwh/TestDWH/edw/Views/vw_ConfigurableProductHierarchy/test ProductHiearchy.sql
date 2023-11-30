CREATE PROCEDURE [tc.edw.vw_ConfigurableProductHierarchy].[test ProductHierarchy]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_ProductHierarchyVariantConfigCharacteristic]';
  EXEC tSQLt.FakeTable '[base_ff]', '[ConfigurableProductCharacteristic]';

  SELECT TOP(0) *
  INTO #vw_ProductHierarchyVariantConfigCharacteristic
  FROM edw.vw_ProductHierarchyVariantConfigCharacteristic;

  INSERT INTO #vw_ProductHierarchyVariantConfigCharacteristic (
    ProductSurrogateKey,
    CharacteristicName
  )
  VALUES
    ('1_1', 'NEGATIVE_TEST'),
    ('2_2', 'ZCH_SO_ITEM_PROD_HIERARCHY'),
    ('3_3', 'ZCH_SO_ITEM_PROD_HIERARCHY1');

  EXEC ('INSERT INTO edw.vw_ProductHierarchyVariantConfigCharacteristic SELECT * FROM #vw_ProductHierarchyVariantConfigCharacteristic');

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

