CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test IC_Balance_KPI]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
   
 INSERT INTO edw.fact_ACDOCA (
    GLAccountID,
    PartnerCompanyID,
    AmountInCompanyCodeCurrency
  )
  VALUES
     (0021102100,'DE35',10)
    ,(0026200100,'DE35',10)
    ,(0018300100,'DE35',10)
    ,(0021390121,'DE35',10)
    ,(0035800100,'DE35',10)
    ,(0015112105,'DE35',10)
    ,(0021102111,'DE35',10)
    ,(0035500101,'DE35',10)
    ,(0015112110,'DE35',10)
    ,(0021102198,'DE35',10)
    ,(0035600100,'DE35',10)
    ,(0015112199,'DE35',10)
    ,(0021102199,'DE35',10)
    ,(0035700100,'DE35',10)
    ,(0021102101,'DE35',10)
    ,(0035200100,'DE35',10)
    ,(0015112100,'DE35',10)
    ,(0021102110,'DE35',10)
    ,(0035500100,'DE35',10)
    ,(1111111111,'DE35',10)
    ,(NULL,'DE35',10)
    ,(0021102100,'',10)
    ,(0026200100,'',10)
    ,(0018300100,'',10)
    ,(0021390121,'',10)
    ,(0035800100,'',10)
    ,(0015112105,'',10)
    ,(0021102111,'',10)
    ,(0035500101,'',10)
    ,(0015112110,'',10)
    ,(0021102198,'',10)
    ,(0035600100,'',10)
    ,(0015112199,'',10)
    ,(0021102199,'',10)
    ,(0035700100,'',10)
    ,(0021102101,'',10)
    ,(0035200100,'',10)
    ,(0015112100,'',10)
    ,(0021102110,'',10)
    ,(0035500100,'',10)
    ,(1111111111,'',10)
    ,(NULL,'',10)
    ,(0021102100,NULL,10)
    ,(0026200100,NULL,10)
    ,(0018300100,NULL,10)
    ,(0021390121,NULL,10)
    ,(0035800100,NULL,10)
    ,(0015112105,NULL,10)
    ,(0021102111,NULL,10)
    ,(0035500101,NULL,10)
    ,(0015112110,NULL,10)
    ,(0021102198,NULL,10)
    ,(0035600100,NULL,10)
    ,(0015112199,NULL,10)
    ,(0021102199,NULL,10)
    ,(0035700100,NULL,10)
    ,(0021102101,NULL,10)
    ,(0035200100,NULL,10)
    ,(0015112100,NULL,10)
    ,(0021102110,NULL,10)
    ,(0035500100,NULL,10)
    ,(1111111111,NULL,10)
    ,(NULL,NULL,10);


  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('EUR', '30', 50),
    ('EUR', '40', 50),
    ('PLN', '30', 50),
    ('PLN', '40', 50);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');


  -- Act: 
  SELECT IC_Balance_KPI
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  CREATE TABLE expected (
    IC_Balance_KPI INT
  );

  INSERT INTO expected(
    IC_Balance_KPI
    
  )
  VALUES
    (NULL),
    (500);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
