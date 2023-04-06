CREATE VIEW [dm_sales].[vw_dim_InOut]
	AS 
SELECT 
    [InOutID],
    [InOut]
FROM base_ff.InOut