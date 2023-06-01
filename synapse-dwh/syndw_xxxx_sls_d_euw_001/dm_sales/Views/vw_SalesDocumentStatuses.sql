CREATE VIEW [edw].[vw_SalesDocumentStatuses]
AS
    SELECT 'Closed'     AS Status
    ,   0               AS OrderType
    ,   'C'             AS DeliveryStatus
    ,   'F'             AS InvoiceStatus
    UNION ALL SELECT 'Delivered not Invoiced',   0,        'C',       'N'
    UNION ALL SELECT 'Delivered not Invoiced',   0,        'C',       'P'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'A',       'F'
    UNION ALL SELECT 'Open',                     0,        'A',       'N'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'A',       'P'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    0,        'B',       'F'
    UNION ALL SELECT 'Delivered not Invoiced',   0,        'B',       'N'
    UNION ALL SELECT 'Open',                     0,        'B',       'P'
    UNION ALL SELECT 'Closed',                   1,        'C',       'F'
    UNION ALL SELECT 'Delivered not Invoiced',   1,        'C',       'N'
    UNION ALL SELECT 'Delivered not Invoiced',   1,        'C',       'P'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'A',       'F'
    UNION ALL SELECT 'Open',                     1,        'A',       'N'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'A',       'P'
    UNION ALL SELECT 'ZZ_To_Be_Investigated',    1,        'B',       'F'
    UNION ALL SELECT 'Delivered not Invoiced',   1,        'B',       'N'
    UNION ALL SELECT 'Open',                     1,        'B',       'P'
    UNION ALL SELECT 'Closed',                   2,        null,      'F'
    UNION ALL SELECT 'Open',                     2,        null,      'N'
    UNION ALL SELECT 'Open',                     2,        null,      'P'
    UNION ALL SELECT 'Closed',                   0,        '',        'F'
    UNION ALL SELECT 'Open',                     0,        '',        'N'
    UNION ALL SELECT 'Open',                     0,        '',        'P'
    UNION ALL SELECT 'Closed',                   1,        '',        'F'
    UNION ALL SELECT 'Open',                     1,        '',        'N'
    UNION ALL SELECT 'Open',                     1,        '',        'P'