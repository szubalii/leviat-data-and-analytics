CREATE PROCEDURE [tc.dq.vw_BP_2_1_6].[test correct work rule 2_1_6]
AS
BEGIN
    IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    IF OBJECT_ID('temp_table') IS NOT NULL DROP TABLE temp_table;

    CREATE TABLE temp_table (
	    [BusinessPartnerID] NVARCHAR(10),
	    [PaymentMethodsList] NVARCHAR(10),
	    [CollectionAuthInd] NVARCHAR(1)
    );

    INSERT INTO temp_table(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('1','F',NULL);
    INSERT INTO temp_table(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('2','F','');
    INSERT INTO temp_table(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('3','E',NULL);
    INSERT INTO temp_table(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('4','E','');

    SELECT *
    INTO actual
    FROM temp_table
    WHERE
        [PaymentMethodsList] = 'F'
        AND
        ([CollectionAuthInd] IS NULL OR [CollectionAuthInd]='')

    SELECT TOP(0) *
    INTO expected
    FROM temp_table;

    INSERT INTO expected(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('1','F',NULL);

    INSERT INTO expected(BusinessPartnerID,PaymentMethodsList,CollectionAuthInd)
    VALUES ('2','F','');

    EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
