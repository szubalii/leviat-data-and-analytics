CREATE TABLE [base_tx_crh_2_dwh].[DIM_CUSTTABLE](
	[DW_Id] [bigint] NOT NULL,
	[ACCOUNTNUM] [nvarchar](20) NULL,
	[COUNTRYREGIONID] [nvarchar](10) NULL,
	[COUNTY] [nvarchar](10) NULL,
	[CREDITMAX] [decimal](38, 0) NULL,
	[CREDITRATING] [nvarchar](10) NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[CUSTGROUP] [nvarchar](10) NULL,
	[NAME] [nvarchar](60) NULL,
	[SALESGROUP] [nvarchar](10) NULL,
	[STATE] [nvarchar](10) NULL,
	[PAYMTERMID] [nvarchar](10) NULL,
	[CASHDISC] [nvarchar](10) NULL,
	[CustGroup_Name] [nvarchar](60) NULL,
	[SalesGroup_Name] [nvarchar](60) NULL,
	[PaymTerm_Description] [nvarchar](60) NULL,
	[CashDisc_Description] [nvarchar](60) NULL,
	[ZIPCODE] [nvarchar](10) NULL,
	[COMMISSIONGROUP] [nvarchar](10) NULL,
	[SALESPOOLID] [nvarchar](10) NULL,
	[CommissionGroup_Name] [nvarchar](60) NULL,
	[SalesPool_Name] [nvarchar](60) NULL,
	[LINEDISC] [nvarchar](10) NULL,
	[PRICEGROUP] [nvarchar](10) NULL,
	[COMPANYCHAINID] [nvarchar](60) NULL,
	[SEGMENTID] [nvarchar](20) NULL,
	[ADUPOTENTIAL] [decimal](38, 12) NULL,
	[PARTYID] [nvarchar](20) NULL,
	[FJA] [varchar](50) NULL,
	[STATUS] [nvarchar](20) NULL,
	[PotentialGroup] [varchar](50) NULL,
	[ADUSOFTWAREID] [nvarchar](10) NULL,
	[CITY] [nvarchar](60) NULL,
	[ADUHASBONUSYN] [varchar](3) NULL,
	[INVOICEACCOUNT] [nvarchar](20) NULL,
	[CountryName] [nvarchar](60) NULL,
	[CountryGroup] [varchar](50) NULL,
	[ADUORDERATINVOICE] [int] NULL,
	[ADUORDERATINVOICEYN] [varchar](3) NULL,
	[QSSCountryGroup] [varchar](50) NULL,
	[DIMENSION3_] [nvarchar](10) NULL,
	[NAMEALIAS] [nvarchar](20) NULL,
	[DIMENSION5_] [nvarchar](10) NULL,
	[ADUADDINVADMINCOSTYN] [varchar](3) NULL,
	[ADUEXTERNALSONUMBERMANDATORYYN] [varchar](3) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_DIM_CUSTTABLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);