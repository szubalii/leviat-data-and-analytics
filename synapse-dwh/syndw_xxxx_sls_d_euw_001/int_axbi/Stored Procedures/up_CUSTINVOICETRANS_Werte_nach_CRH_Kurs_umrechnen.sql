-- =============================================
-- Author:		<Author: Erich Kallnik>
-- Create date: <Create Date: 15.01.2020>
-- Description:	<CUSTINVOICETRANS in aktuelle Währung umrechnen>
-- =============================================
CREATE PROCEDURE [dbo].[up_CUSTINVOICETRANS_Werte_nach_CRH_Kurs_umrechnen] 
	-- Add the parameters for the stored procedure here
(
	@P_DATAAREAID nvarchar(4),
    @P_CURR nvarchar(3),
	@P_YEAR smallint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	declare @CRH_Kurs numeric(15,6)
	
	-- CRH Kurs aus Tabelle CURRENCY ermitteln
	select @CRH_Kurs = CRHRATE from CRHCURRENCY
	 where YEAR = @P_YEAR and CURRENCY = @P_CURR

		UPDATE CUSTINVOICETRANS
		SET PRODUCTSALESEUR = PRODUCTSALESLOCAL / @CRH_Kurs, 
		    OTHERSALESEUR   = OTHERSALESLOCAL / @CRH_Kurs, 
		    ALLOWANCESEUR   = ALLOWANCESLOCAL / @CRH_Kurs, 
		    SALES100EUR     = SALES100LOCAL / @CRH_Kurs, 
		    FREIGHTEUR      = FREIGHTLOCAL / @CRH_Kurs, 
		    COSTAMOUNTEUR   = COSTAMOUNTLOCAL / @CRH_Kurs 
	WHERE DATAAREAID = @P_DATAAREAID

END

