CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test IC_Balance_KPI]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
   
 INSERT INTO edw.fact_ACDOCA (
    GLAccountID,
    PartnerCompanyID,
    AmountInCompanyCodeCurrency,
    CompanyCodeCurrency
  )
  VALUES
     ('0021102100','DE35',10.00,'PLN')
    ,('0026200100','DE35',10.00,'PLN')
    ,('0018300100','DE35',10.00,'PLN')
    ,('0021390121','DE35',10.00,'PLN')
    ,('0035800100','DE35',10.00,'PLN')
    ,('0015112105','DE35',10.00,'PLN')
    ,('0021102111','DE35',10.00,'PLN')
    ,('0035500101','DE35',10.00,'PLN')
    ,('0015112110','DE35',10.00,'PLN')
    ,('0021102198','DE35',10.00,'PLN')
    ,('0035600100','DE35',10.00,'PLN')
    ,('0015112199','DE35',10.00,'PLN')
    ,('0021102199','DE35',10.00,'PLN')
    ,('0035700100','DE35',10.00,'PLN')
    ,('0021102101','DE35',10.00,'PLN')
    ,('0035200100','DE35',10.00,'PLN')
    ,('0015112100','DE35',10.00,'PLN')
    ,('0021102110','DE35',10.00,'PLN')
    ,('0035500100','DE35',10.00,'PLN')
    ,('1111111111','DE35',10.00,'PLN')
    ,(NULL,'DE35',10.00,'PLN')
    ,('0021102100','',10.00,'PLN')
    ,('0026200100','',10.00,'PLN')
    ,('0018300100','',10.00,'PLN')
    ,('0021390121','',10.00,'PLN')
    ,('0035800100','',10.00,'PLN')
    ,('0015112105','',10.00,'PLN')
    ,('0021102111','',10.00,'PLN')
    ,('0035500101','',10.00,'PLN')
    ,('0015112110','',10.00,'PLN')
    ,('0021102198','',10.00,'PLN')
    ,('0035600100','',10.00,'PLN')
    ,('0015112199','',10.00,'PLN')
    ,('0021102199','',10.00,'PLN')
    ,('0035700100','',10.00,'PLN')
    ,('0021102101','',10.00,'PLN')
    ,('0035200100','',10.00,'PLN')
    ,('0015112100','',10.00,'PLN')
    ,('0021102110','',10.00,'PLN')
    ,('0035500100','',10.00,'PLN')
    ,('1111111111','',10.00,'PLN')
    ,(NULL,'',10.00,'PLN')
    ,('0021102100',NULL,10.00,'PLN')
    ,('0026200100',NULL,10.00,'PLN')
    ,('0018300100',NULL,10.00,'PLN')
    ,('0021390121',NULL,10.00,'PLN')
    ,('0035800100',NULL,10.00,'PLN')
    ,('0015112105',NULL,10.00,'PLN')
    ,('0021102111',NULL,10.00,'PLN')
    ,('0035500101',NULL,10.00,'PLN')
    ,('0015112110',NULL,10.00,'PLN')
    ,('0021102198',NULL,10.00,'PLN')
    ,('0035600100',NULL,10.00,'PLN')
    ,('0015112199',NULL,10.00,'PLN')
    ,('0021102199',NULL,10.00,'PLN')
    ,('0035700100',NULL,10.00,'PLN')
    ,('0021102101',NULL,10.00,'PLN')
    ,('0035200100',NULL,10.00,'PLN')
    ,('0015112100',NULL,10.00,'PLN')
    ,('0021102110',NULL,10.00,'PLN')
    ,('0035500100',NULL,10.00,'PLN')
    ,('1111111111',NULL,10.00,'PLN')
    ,(NULL,NULL,10.00,'PLN');

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('PLN',10, 1);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  -- Act: 
  SELECT  GLAccountID
         ,PartnerCompanyID
         ,IC_Balance_KPI
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base]
  WHERE CurrencyTypeID = 10
  ORDER BY GLAccountID
          ,PartnerCompanyID
          ,IC_Balance_KPI;

  -- Assert:
  CREATE TABLE expected (
    [GLAccountID] nvarchar(20),
    [PartnerCompanyID] nvarchar(12),
    [IC_Balance_KPI] numeric(38,6)
  );

  INSERT INTO expected (
    GLAccountID,
    PartnerCompanyID,
    IC_Balance_KPI
  )
  VALUES
     ('0018300100','DE35',10.000000)
    ,('0021102100','DE35',10.000000)
    ,('0015112105','DE35',10.000000)
    ,('0015112110','DE35',10.000000)
    ,('0021102101','DE35',10.000000)
    ,('0026200100','DE35',10.000000)
    ,('1111111111','DE35',NULL)
    ,('0015112100','DE35',10.000000)
    ,('0021102199','DE35',10.000000)
    ,('0021102198','DE35',10.000000)
    ,('0021390121','DE35',10.000000)
    ,('0021102110','DE35',10.000000)
    ,('0035700100','DE35',10.000000)
    ,('0035200100','DE35',10.000000)
    ,(NULL,'DE35',NULL)
    ,('0035500101','DE35',10.000000)
    ,('0015112199','DE35',10.000000)
    ,('0035600100','DE35',10.000000)
    ,('0035500100','DE35',10.000000)
    ,('0021102111','DE35',10.000000)
    ,('0035800100','DE35',10.000000)
    ,('0021102100','',NULL)
    ,('0015112199','',NULL)
    ,('0035500101','',NULL)
    ,('0026200100','',NULL)
    ,('0035700100','',NULL)
    ,('0035200100','',NULL)
    ,('0015112105','',NULL)
    ,('0035800100','',NULL)
    ,('0021102101','',NULL)
    ,('0021102198','',NULL)
    ,('0035500100','',NULL)
    ,('0015112110','',NULL)
    ,('0015112100','',NULL)
    ,('0018300100','',NULL)
    ,('0021102110','',NULL)
    ,(NULL,'',NULL)
    ,('1111111111','',NULL)
    ,('0035600100','',NULL)
    ,('0021390121','',NULL)
    ,('0021102111','',NULL)
    ,('0021102199','',NULL)
    ,('0035800100',NULL,NULL)
    ,('0021390121',NULL,NULL)
    ,('0021102111',NULL,NULL)
    ,('0018300100',NULL,NULL)
    ,('0021102199',NULL,NULL)
    ,('0035500101',NULL,NULL)
    ,('0015112105',NULL,NULL)
    ,('0026200100',NULL,NULL)
    ,('0015112110',NULL,NULL)
    ,('0021102100',NULL,NULL)
    ,('0021102198',NULL,NULL)
    ,('0015112100',NULL,NULL)
    ,('0021102101',NULL,NULL)
    ,('0015112199',NULL,NULL)
    ,('0021102110',NULL,NULL)
    ,('0035500100',NULL,NULL)
    ,('0035700100',NULL,NULL)
    ,('0035600100',NULL,NULL)
    ,('0035200100',NULL,NULL)
    ,(NULL,NULL,NULL)
    ,('1111111111',NULL,NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
