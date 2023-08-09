CREATE FUNCTION [edw].[svf_getSAPHierarchyNode](
  @ProductHierarchyNode NVARCHAR(80)
)
RETURNS NVARCHAR(80)
AS
BEGIN
DECLARE @CheckProductHierarchyNode NVARCHAR(80) =
  case
    when ISNULL(@ProductHierarchyNode,'') = ''
    then 'Unassigned SAP Hierarchy'
    else @ProductHierarchyNode
  end;

  RETURN @CheckProductHierarchyNode
END;