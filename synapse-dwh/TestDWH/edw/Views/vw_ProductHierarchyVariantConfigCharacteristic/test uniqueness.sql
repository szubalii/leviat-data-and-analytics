CREATE PROCEDURE [tc.edw.vw_ProductHierarchyVariantConfigCharacteristic].[test uniqueness]
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
    (1, 1, 1, 1, 2),
    (1, 1, 1, 2, 1),
    (1, 1, 1, 2, 2),
    (1, 2, 2, 1, 3),
    (1, 2, 2, 2, 4);

  INSERT INTO base_ff.ProductHierarchyNode (ProductID, old_ProductHierarchyNode, new_ProductHierarchyNode)
  VALUES
    (2, 3, 4);

  INSERT INTO base_ff.ProductHierarchyNodeMapping (OldProductHierarchyNode, NewProductHierarchyNode)
  VALUES (1, 5), (4, 6);

-- Act: 
  SELECT
    SalesDocument,
    SalesDocumentItem
  INTO actual
  FROM [edw].[vw_ProductHierarchyVariantConfigCharacteristic]
  GROUP BY
    SalesDocument,
    SalesDocumentItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
