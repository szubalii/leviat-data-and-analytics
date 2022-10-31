-- =============================================
-- Author:		<Kallnik, Erich>
-- Create date: <10.08.2021>
-- Description:	<TOM Dashboard: Ancon Australia Connolly Load Customer, Article and Sales Data from .txt file>
-- =============================================
--
CREATE PROCEDURE [intm_axbi].[up_ReadSales_ANAC_pkg]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Import Customer Master Data
    declare @lYear smallint = (select datepart(year,max([ACCOUNTINGDATE])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANAC]),
			@lMonth tinyint = (select datepart(month,max([ACCOUNTINGDATE])) from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANAC]),
            @lRate numeric(15,6)

	select @lRate = [CRHRATE] 
    from [base_tx_ca_0_hlp].[CRHCURRENCY] 
    where [YEAR] = @lYear and [CURRENCY] = 'AUD'

	-- Calculate the EUR values per CRH Rate 
	UPDATE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANAC]
	set [PRODUCTSALESEUR] = a.[PRODUCTSALESLOCAL]/@lRate, -- invoiced sales per article sales position
	    [OTHERSALESEUR]   = a.[OTHERSALESLOCAL]/@lRate, -- article no FREIGHT and ADMIN 
	    [ALLOWANCESEUR]   = a.[ALLOWANCESLOCAL]/@lRate, -- no existing invoiced allowances from Ancon Connolly Australia 
	    [SALES100EUR]   = a.[SALES100LOCAL]/@lRate, -- Sales100 is recalculated in procedure "up_ReadSales_ANAC_Jahr_Monat" because the OTHERSALES of ADMIN and FREIGHT have not yet been distributed.
	    [FREIGHTEUR]   = a.[FREIGHTLOCAL]/@lRate, -- internal freight, not invoiced freight. we don't consider at TOM dashboard.
	    [COSTAMOUNTEUR]   = a.[COSTAMOUNTLOCAL]/@lRate -- Cost amount per sales position
	from [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANAC] as a 
    where datepart(Year, a.ACCOUNTINGDATE) = @lYear 

	-- Calculation of Ancon Connolly Sales Data per Month
	EXEC [intm_axbi].[up_ReadSales_ANAC_Jahr_Monat] @lYear, @lMonth

END
