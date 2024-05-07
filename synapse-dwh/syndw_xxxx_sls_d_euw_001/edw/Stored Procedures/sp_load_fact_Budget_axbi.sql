CREATE PROC [edw].[sp_load_fact_Budget_axbi]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    DECLARE @isViewNotEmpty   BIT = 0;
    DECLARE @errmessage NVARCHAR(2048);

    BEGIN TRY
        SELECT TOP 1
            @isViewNotEmpty = 1
        FROM
            [edw].[vw_Budget_axbi];

        IF (@isViewNotEmpty = 0)
            BEGIN
                SET @errmessage = 'Temporary view [edw].[vw_Budget_axbi] was not filled with data.';
                THROW 50001, @errmessage, 1;
            END;

	    IF OBJECT_ID('[edw].[fact_Budget_axbi_tmp]') IS NOT NULL
		    DROP TABLE [edw].[fact_Budget_axbi_tmp];

        CREATE TABLE [edw].[fact_Budget_axbi_tmp]
        WITH
        (
            DISTRIBUTION = HASH ([nk_fact_Budget]),
            CLUSTERED COLUMNSTORE INDEX
        )
        AS SELECT 
            [sk_fact_Budget]
        ,   [nk_fact_Budget]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [AccountingDate]
        ,   [SalesOrganizationID]
        ,   [SoldToParty]
        ,   [FinSales100]
        ,   [Year]
        ,   [Month]
        ,   [YearMonth]
        ,   [axbi_DataAreaID]
        ,   [axbi_DataAreaName]
        ,   [axbi_DataAreaGroup]
        ,   [axbi_MaterialID]
        ,   [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   edw.svf_getInOutID_axbi (InOutID) as [InOutID]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   [t_jobId]
        ,   [t_jobDtm]
        ,   [t_lastActionCd]
        ,   [t_jobBy]
           FROM
               [edw].[fact_Budget_axbi]
           WHERE
               [Year]  NOT IN (
                   SELECT
                       [Year]
                   FROM
                       [edw].[vw_Budget_axbi]
                   GROUP BY
                       [Year]
               );

        INSERT INTO [edw].[fact_Budget_axbi_tmp](
            [nk_fact_Budget]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [AccountingDate]
        ,   [SalesOrganizationID]
        ,   [SoldToParty]
        ,   [FinSales100]
        ,   [Year]
        ,   [Month]
        ,   [YearMonth]
        ,   [axbi_DataAreaID]
        ,   [axbi_DataAreaName]
        ,   [axbi_DataAreaGroup]
        ,   [axbi_MaterialID]
        ,   [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   [t_jobId]
        ,   [t_jobDtm]
        ,   [t_lastActionCd]
        ,   [t_jobBy]
        )
        SELECT
            [nk_fact_Budget]
        ,   [CurrencyTypeID]
        ,   [CurrencyType]
        ,   [CurrencyID]
        ,   [ExchangeRate]
        ,   [AccountingDate]
        ,   [SalesOrganizationID]
        ,   [SoldToParty]
        ,   [FinSales100]
        ,   [Year]
        ,   [Month]
        ,   [YearMonth]
        ,   [axbi_DataAreaID]
        ,   [axbi_DataAreaName]
        ,   [axbi_DataAreaGroup]
        ,   [axbi_MaterialID]
        ,   [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [InOutID]
        ,   [t_applicationId]
        ,   [t_extractionDtm]
        ,   @t_jobId AS t_jobId
        ,   @t_jobDtm AS t_jobDtm
        ,   @t_lastActionCd AS t_lastActionCd
        ,   @t_jobBy AS t_jobBy
        FROM
            [edw].[vw_Budget_axbi];

        RENAME OBJECT [edw].[fact_Budget_axbi] TO [fact_Budget_axbi_old];
        RENAME OBJECT [edw].[fact_Budget_axbi_tmp] TO [fact_Budget_axbi];
        DROP TABLE [edw].[fact_Budget_axbi_old];

    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
		THROW 50001, @errmessage, 1;
    END CATCH
END
GO