CREATE VIEW [base_s4h_cax].[vw__delta]
AS
WITH add_rn AS (
  SELECT
    *,
    ROW_NUMBER () OVER (
      PARTITION BY
        [PrimaryKeyField_1],
        [PrimaryKeyField_2]
      ORDER BY
        [t_extractionDtm] DESC,
        [TS_SEQUENCE_NUMBER] DESC
    ) AS rn
  FROM base_s4h_cax._delta
)
-- leave only the latest records
SELECT *
FROM add_rn
WHERE rn=1