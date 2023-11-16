CREATE FUNCTION [edw].[svf_getSAPHierarchyNode](
  @ProductHierarchyNode NVARCHAR(80)
)
RETURNS NVARCHAR(80)
AS
BEGIN
    RETURN
        COALESCE(@ProductHierarchyNode, 'Unassigned SAP Hierarchy');
END;