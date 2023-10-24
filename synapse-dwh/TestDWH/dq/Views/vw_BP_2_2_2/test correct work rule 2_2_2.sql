CREATE PROCEDURE [tc.dq.vw_BP_2_2_2].[test correct work rule 2_2_2]
AS
BEGIN
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    IF OBJECT_ID('temp_table') IS NOT NULL DROP TABLE temp_table;

    CREATE TABLE temp_table (
	    [Supplier] NVARCHAR(10),
	    [SupplierAccountGroup] NVARCHAR(4),
        [CashPlanningGroup] NVARCHAR(10),
        [Supplier_Country] NVARCHAR(3),
	    [Company_Country] NVARCHAR(3)
    );

    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '1',
        'Z008',
        'A1',
        'IT',
        'FR'
    );
    
    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '2',
        'Z008',
        'A2',
        'IT',
        'IT'
    );
    
    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '3',
        'Z099',
        'A1',
        'IT',
        'FR'
    );

    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '4',
        'Z001',
        'A2',
        'FR',
        'FR'
    );

    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES(
        '5',
        'Z001',
        'A2',
        'IT',
        'FR'
    );

    INSERT INTO temp_table(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES(
        '6',
        'Z099',
        'A2',
        'IT',
        'IT'
    );

    SELECT *
    INTO actual
    FROM temp_table
    WHERE
        ([SupplierAccountGroup] <> 'Z008'
        AND
        [CashPlanningGroup]<>'A2'
        AND
        [Supplier_Country]<>[Company_Country])
        OR
        ([SupplierAccountGroup] = 'Z001'
        AND
        [CashPlanningGroup]<>'A1'
        AND
        [Supplier_Country]=[Company_Country])

    SELECT TOP(0) *
    INTO expected
    FROM temp_table;

    INSERT INTO expected(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '3',
        'Z099',
        'A1',
        'IT',
        'FR'
    );

    INSERT INTO expected(
        [Supplier],
        [SupplierAccountGroup],
        [CashPlanningGroup],
        [Supplier_Country],
        [Company_Country]
    )
    VALUES
    (
        '4',
        'Z001',
        'A2',
        'FR',
        'FR'
    );
    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
