CREATE PROCEDURE [tc.edw.vw_ProductHierarchyVariantConfigCharacteristic].[test ProductSurrogateKey]
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
    CharacteristicName,
    CharValue
  )
  VALUES 
    (1, 1, 1, 1, 1),
    (1, 2, 2, 2, 2),
    (2, 1, 3, 3, 3),
    (2, 2, 4, 4, 4);

  INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  VALUES
    (3, 3, 5),
    (4, 4, 6),
    (11, 12, 16);

  INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  VALUES (2, 7), (6, 8), (9, 10);

-- Act: 
  SELECT
    SalesDocument,
    SalesDocumentItem,
    ProductSurrogateKey
  INTO actual
  FROM [edw].[vw_ProductHierarchyVariantConfigCharacteristic];

  -- Assert:
  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
    SalesDocument,
    SalesDocumentItem,
    ProductSurrogateKey
  )
  VALUES
    (1, 1, '1_1'),
    (1, 2, '2_7'),
    (2, 1, '3_5'),
    (2, 2, '4_8');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
