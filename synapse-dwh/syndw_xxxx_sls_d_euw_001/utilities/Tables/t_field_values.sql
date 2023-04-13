CREATE TABLE [utilities].[t_field_values] (
    [table_id]      INT             NOT NULL,
    [file_name]     VARCHAR(1024)   NOT NULL,
    [default_field]  VARCHAR  (30)  NOT NULL,
    [index]         TINYINT         NOT NULL,
    [default_value] NVARCHAR(1024)  NOT NULL
)
WITH (HEAP, DISTRIBUTION = REPLICATE);
