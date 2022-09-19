-- =============================================
-- Author:		<Kallnik,,Erich>
-- Create date: <05.11.2019,,>
-- Description:	<Get CashDiscPct >
-- =============================================
CREATE FUNCTION [dbo].[uf_get_CashDiscPct]
(
	-- Input Variables --
	@CASHDISC nvarchar(5)
)
RETURNS tinyint
AS
BEGIN
	-- internal Variables --
			
	-- Return Value --
	DECLARE	@Return_Value tinyint
	
	IF substring(@CASHDISC, 3, 1) between '1' and '9' 
		SET @Return_Value = cast(substring(@CASHDISC, 3, 1) as tinyint)
	ELSE
		IF substring(@CASHDISC, 4, 1) between '1' and '9' 
			SET @Return_Value = cast(substring(@CASHDISC, 4, 1) as tinyint)
			ELSE
			SET @Return_Value = 0
	
	RETURN @Return_Value
END