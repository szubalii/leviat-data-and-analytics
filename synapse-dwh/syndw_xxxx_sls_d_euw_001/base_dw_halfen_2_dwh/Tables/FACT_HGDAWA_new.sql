CREATE TABLE [base_dw_halfen_2_dwh].[FACT_HGDAWA_new] (
    [DW_Id]                                   BIGINT           NOT NULL,
    [Company]                                 NVARCHAR (8)     NULL,
    [Distributioncompany]                     NVARCHAR (8)     NULL,
    [Salesarea]                               NVARCHAR (3)     NULL,
    [Inside_Outside]                          NVARCHAR (1)     NULL,
    [Inside_Outside-Text]                     VARCHAR (50)     NULL,
    [Site]                                    NVARCHAR (8)     NULL,
    [Invoiceno]                               CHAR (20)        NULL,
    [Invoicedate]                             DATETIME         NULL,
    [Accountingdate]                          DATETIME         NULL,
    [Year]                                    BIGINT           NULL,
    [Month]                                   BIGINT           NULL,
    [Day]                                     BIGINT           NULL,
    [Orderno]                                 CHAR (20)        NULL,
    [Deliveryno]                              CHAR (20)        NULL,
    [Posno]                                   DECIMAL (38, 12) NULL,
    [Orderdate]                               DATETIME         NULL,
    [Deldateplan]                             DATETIME         NULL,
    [Deldateconfirmed]                        DATETIME         NULL,
    [Deldateact]                              DATETIME         NULL,
    [SalesType]                               BIGINT           NULL,
    [Customerno]                              NVARCHAR (10)    NULL,
    [Country]                                 CHAR (3)         NULL,
    [Postalcode]                              CHAR (10)        NULL,
    [DlvCountry]                              NVARCHAR (10)    NULL,
    [DlvState]                                NVARCHAR (20)    NULL,
    [DlvCounty]                               NVARCHAR (20)    NULL,
    [Mainsalesperson]                         NVARCHAR (2)     NULL,
    [Salesperson]                             NVARCHAR (10)    NULL,
    [Maindistrict]                            NCHAR (2)        NULL,
    [Salesdistrict]                           NVARCHAR (10)    NULL,
    [Lineofbusiness]                          CHAR (10)        NULL,
    [Concern]                                 CHAR (10)        NULL,
    [I_E_V]                                   NVARCHAR (1)     NULL,
    [I_E_V-Text]                              VARCHAR (20)     NULL,
    [Responsible]                             CHAR (10)        NULL,
    [Warehouse]                               NVARCHAR (6)     NULL,
    [Aquisitioncode]                          CHAR (1)         NULL,
    [Aquisitioncode-Text]                     VARCHAR (40)     NULL,
    [Originwarehouse]                         NVARCHAR (6)     NULL,
    [OriginAquisitioncode]                    CHAR (1)         NULL,
    [OriginAquisitioncode-Text]               VARCHAR (50)     NULL,
    [Itemno]                                  NVARCHAR (20)    NULL,
    [Productsub_group]                        NVARCHAR (20)    NULL,
    [Itemtype]                                CHAR (3)         NULL,
    [Productgroup]                            NVARCHAR (20)    NULL,
    [Productline]                             NVARCHAR (20)    NULL,
    [Productrange]                            NVARCHAR (20)    NULL,
    [CRHProductGroupID]                       NVARCHAR (10)    NULL,
    [Production_Purchase]                     CHAR (1)         NULL,
    [Stainlesssteelflag]                      NVARCHAR (1)     NULL,
    [Stainlesssteel-Text]                     VARCHAR (25)     NULL,
    [MainProductclass]                        VARCHAR (5)      NULL,
    [Productclass]                            NVARCHAR (20)    NULL,
    [Configno]                                DECIMAL (38)     NULL,
    [Pricelistno]                             CHAR (10)        NULL,
    [Projectno]                               NVARCHAR (20)    NULL,
    [ProjectPos]                              NVARCHAR (10)    NULL,
    [Kitheaderno]                             CHAR (20)        NULL,
    [Bruttosaleslocal]                        DECIMAL (38, 2)  NULL,
    [BruttosalesCRHEUR]                       DECIMAL (38, 2)  NULL,
    [Brutto2saleslocal]                       DECIMAL (38, 2)  NULL,
    [Brutto2salesCRHEUR]                      DECIMAL (38, 2)  NULL,
    [Nettosalesposlocal]                      DECIMAL (38, 2)  NULL,
    [NettosalesposCRHEUR]                     DECIMAL (38, 2)  NULL,
    [Linepercentweighted]                     DECIMAL (38, 2)  NULL,
    [Invoicedsaleslocal]                      DECIMAL (38, 2)  NULL,
    [InvoicedsalesCRHEUR]                     DECIMAL (38, 2)  NULL,
    [Othersaleslocal]                         DECIMAL (38, 6)  NULL,
    [OthersalesCRHEUR]                        DECIMAL (38, 6)  NULL,
    [Allowanceslocal]                         DECIMAL (38, 6)  NULL,
    [AllowancesCRHEUR]                        DECIMAL (38, 6)  NULL,
    [Sales100%local]                          DECIMAL (38, 6)  NULL,
    [Sales100%CRHEUR]                         DECIMAL (38, 6)  NULL,
    [TZlocal]                                 DECIMAL (38, 2)  NULL,
    [TZCRHEUR]                                DECIMAL (38, 2)  NULL,
    [TZpercent]                               DECIMAL (38, 2)  NULL,
    [LZlocal]                                 DECIMAL (38, 2)  NULL,
    [LZCRHEUR]                                DECIMAL (38, 2)  NULL,
    [LZpercent]                               DECIMAL (38, 2)  NULL,
    [Linediscount1local]                      DECIMAL (38, 2)  NULL,
    [Linediscount1CRHEUR]                     DECIMAL (38, 2)  NULL,
    [Linediscount1percent]                    DECIMAL (38, 2)  NULL,
    [Linediscount2local]                      DECIMAL (38, 2)  NULL,
    [Linediscount2CRHEUR]                     DECIMAL (38, 2)  NULL,
    [Linediscount2percent]                    DECIMAL (38, 2)  NULL,
    [Orderdiscountlocal]                      DECIMAL (38, 2)  NULL,
    [OrderdiscountCRHEUR]                     DECIMAL (38, 2)  NULL,
    [Orderdiscountpercent]                    DECIMAL (38, 2)  NULL,
    [Productsaleslocal]                       DECIMAL (38, 6)  NULL,
    [ProductsalesCRHEUR]                      DECIMAL (38, 6)  NULL,
    [Plantsellingpricelocal]                  DECIMAL (38, 6)  NULL,
    [PlantsellingpriceCRHEUR]                 DECIMAL (38, 6)  NULL,
    [ICPlocal]                                DECIMAL (38, 6)  NULL,
    [ICPCRHEUR]                               DECIMAL (38, 6)  NULL,
    [SMClocal]                                DECIMAL (38, 6)  NULL,
    [SMCCRHEUR]                               DECIMAL (38, 6)  NULL,
    [SMCsumlocal]                             DECIMAL (38, 6)  NULL,
    [SMCsumCRHEUR]                            DECIMAL (38, 6)  NULL,
    [Variablesellingcostslocal]               DECIMAL (38, 6)  NULL,
    [VariablesellingcostsCRHEUR]              DECIMAL (38, 6)  NULL,
    [Netsaleslocal]                           DECIMAL (38, 6)  NULL,
    [NetsalesCRHEUR]                          DECIMAL (38, 6)  NULL,
    [Grossmarginlocal]                        DECIMAL (38, 6)  NULL,
    [GrossmarginCRHEUR]                       DECIMAL (38, 6)  NULL,
    [contribmarginIIdclocal]                  DECIMAL (38, 6)  NULL,
    [contribmarginIIdcCRHEUR]                 DECIMAL (38, 6)  NULL,
    [contribmarginIIholocal]                  DECIMAL (38, 6)  NULL,
    [contribmarginIIhoCRHEUR]                 DECIMAL (38, 6)  NULL,
    [Plantoverheadcostslocal]                 DECIMAL (38, 6)  NULL,
    [PlantoverheadcostsCRHEUR]                DECIMAL (38, 6)  NULL,
    [contribmarginIIIlocal]                   DECIMAL (38, 6)  NULL,
    [contribmarginIIICRHEUR]                  DECIMAL (38, 6)  NULL,
    [Invoicequantity]                         DECIMAL (38, 6)  NULL,
    [Orderquantity]                           DECIMAL (38, 6)  NULL,
    [Netweight]                               DECIMAL (38, 3)  NULL,
    [Freightinvoicedlocal]                    DECIMAL (38, 6)  NULL,
    [FreightinvoicedCRHEUR]                   DECIMAL (38, 6)  NULL,
    [Tollinvoicedlocal]                       DECIMAL (38, 6)  NULL,
    [TollinvoicedCRHEUR]                      DECIMAL (38, 6)  NULL,
    [Packingsinvoicedlocal]                   DECIMAL (38, 6)  NULL,
    [PackingsinvoicedCRHEUR]                  DECIMAL (38, 6)  NULL,
    [Surchargeonshortquantitylocal]           DECIMAL (38, 6)  NULL,
    [SurchargeonshortquantityCRHEUR]          DECIMAL (38, 6)  NULL,
    [Planningcostsinvoicedlocal]              DECIMAL (38, 6)  NULL,
    [PlanningcostsinvoicedCRHEUR]             DECIMAL (38, 6)  NULL,
    [Packingdepositlocal]                     DECIMAL (38, 6)  NULL,
    [PackingdepositCRHEUR]                    DECIMAL (38, 6)  NULL,
    [Miscellaneousproceedsinvoicedlocal]      DECIMAL (38, 6)  NULL,
    [MiscellaneousproceedsinvoicedCRHEUR]     DECIMAL (38, 6)  NULL,
    [Reservecustomerbonuslocal]               DECIMAL (38, 6)  NULL,
    [ReservecustomerbonusCRHEUR]              DECIMAL (38, 6)  NULL,
    [Warrentieslocal]                         DECIMAL (38, 6)  NULL,
    [WarrentiesCRHEUR]                        DECIMAL (38, 6)  NULL,
    [Marketingcostsallowanceslocal]           DECIMAL (38, 6)  NULL,
    [MarketingcostsallowancesCRHEUR]          DECIMAL (38, 6)  NULL,
    [Reservecustomerdiscountlocal]            DECIMAL (38, 6)  NULL,
    [ReservecustomerdiscountCRHEUR]           DECIMAL (38, 6)  NULL,
    [Freightcostslocal]                       DECIMAL (38, 6)  NULL,
    [FreightcostsCRHEUR]                      DECIMAL (38, 6)  NULL,
    [Packingcostslocal]                       DECIMAL (38, 6)  NULL,
    [PackingcostsCRHEUR]                      DECIMAL (38, 6)  NULL,
    [Dutieslocal]                             DECIMAL (38, 6)  NULL,
    [DutiesCRHEUR]                            DECIMAL (38, 6)  NULL,
    [Insurancelocal]                          DECIMAL (38, 6)  NULL,
    [InsuranceCRHEUR]                         DECIMAL (38, 6)  NULL,
    [Commissionslocal]                        DECIMAL (38, 6)  NULL,
    [CommissionsCRHEUR]                       DECIMAL (38, 6)  NULL,
    [Licenceslocal]                           DECIMAL (38, 6)  NULL,
    [LicencesCRHEUR]                          DECIMAL (38, 6)  NULL,
    [SMCordinarysteellocal]                   DECIMAL (38, 6)  NULL,
    [SMCordinarysteelCRHEUR]                  DECIMAL (38, 6)  NULL,
    [SMCstainlesssteellocal]                  DECIMAL (38, 6)  NULL,
    [SMCstainlesssteelCRHEUR]                 DECIMAL (38, 6)  NULL,
    [SMCotherrawmateriallocal]                DECIMAL (38, 6)  NULL,
    [SMCotherrawmaterialCRHEUR]               DECIMAL (38, 6)  NULL,
    [SMCmaterialoverheadcostslocal]           DECIMAL (38, 6)  NULL,
    [SMCmaterialoverheadcostsCRHEUR]          DECIMAL (38, 6)  NULL,
    [SMCalloysurchargelocal]                  DECIMAL (38, 6)  NULL,
    [SMCalloysurchargeCRHEUR]                 DECIMAL (38, 6)  NULL,
    [SMCexternalproductioncostslocal]         DECIMAL (38, 6)  NULL,
    [SMCexternalproductioncostsCRHEUR]        DECIMAL (38, 6)  NULL,
    [SMCvariableproductioncostslocal]         DECIMAL (38, 6)  NULL,
    [SMCvariableproductioncostsCRHEUR]        DECIMAL (38, 6)  NULL,
    [SMCfixedproductioncostslocal]            DECIMAL (38, 6)  NULL,
    [SMCfixedproductioncostsCRHEUR]           DECIMAL (38, 6)  NULL,
    [CostsofcapitalE01local]                  DECIMAL (38, 6)  NULL,
    [CostsofcapitalE01CRHEUR]                 DECIMAL (38, 6)  NULL,
    [WarehousechargesE02local]                DECIMAL (38, 6)  NULL,
    [WarhousechargesE02CRHEUR]                DECIMAL (38, 6)  NULL,
    [HandlingchargesE03local]                 DECIMAL (38, 6)  NULL,
    [HandlingchargesE03CRHEUR]                DECIMAL (38, 6)  NULL,
    [PackagingchargesE04local]                DECIMAL (38, 6)  NULL,
    [PackagingchargesE04CRHEUR]               DECIMAL (38, 6)  NULL,
    [PlantoverheadE05local]                   DECIMAL (38, 6)  NULL,
    [PlantoverheadE05CRHEUR]                  DECIMAL (38, 6)  NULL,
    [E06local]                                DECIMAL (38, 6)  NULL,
    [E06CRHEUR]                               DECIMAL (38, 6)  NULL,
    [E07local]                                DECIMAL (38, 6)  NULL,
    [E07CRHEUR]                               DECIMAL (38, 6)  NULL,
    [PlantprofitE08local]                     DECIMAL (38, 6)  NULL,
    [PlantprofitE08CRHEUR]                    DECIMAL (38, 6)  NULL,
    [ICsurchargeE09local]                     DECIMAL (38, 6)  NULL,
    [ICsurchargeE09CRHEUR]                    DECIMAL (38, 6)  NULL,
    [FreightsurchargeE10local]                DECIMAL (38, 6)  NULL,
    [FreightsurchargeE10CRHEUR]               DECIMAL (38, 6)  NULL,
    [Freightdctocustomerlocal]                DECIMAL (38, 6)  NULL,
    [FreightdctocustomerCRHEUR]               DECIMAL (38, 6)  NULL,
    [FreightAR_LAtodclocal]                   DECIMAL (38, 6)  NULL,
    [FreightAR_LAtodcCRHEUR]                  DECIMAL (38, 6)  NULL,
    [FreightPNtoAR_LAlocal]                   DECIMAL (38, 6)  NULL,
    [FreightPNtoAR_LACRHEUR]                  DECIMAL (38, 6)  NULL,
    [DAN502]                                  DECIMAL (38, 2)  NULL,
    [DAN503]                                  DECIMAL (38, 2)  NULL,
    [DAA705]                                  NVARCHAR (20)    NULL,
    [LengthinMper1]                           DECIMAL (38, 2)  NULL,
    [LengthinM]                               DECIMAL (38, 2)  NULL,
    [Freight_Tollinvoicedlocal]               DECIMAL (38, 6)  NULL,
    [Freight_TollinvoicedCRHEUR]              DECIMAL (38, 6)  NULL,
    [Packaginginvoicedlocal]                  DECIMAL (38, 6)  NULL,
    [PackaginginvoicedCRHEUR]                 DECIMAL (38, 6)  NULL,
    [Grosssaleslocal]                         DECIMAL (38, 6)  NULL,
    [GrosssalesCRHEUR]                        DECIMAL (38, 6)  NULL,
    [CostCenter]                              NVARCHAR (3)     NULL,
    [DAGRWE]                                  DECIMAL (38, 3)  NULL,
    [CurrencyRatelocaltoCRH1EUR] DECIMAL (38, 9)  NULL,
    [CurrencyEUR]							  CHAR(3)          NULL,
    [Currencylocal]				     		  CHAR(3)          NULL,
    [Salespersonname]						  NVARCHAR(140)    NULL,
    [Salesdistrictname]		     			  NVARCHAR(60)     NULL,
    [Projectname]							  NVARCHAR(140)    NULL,
    [Projectdeliverycountry]				  NVARCHAR(10)     NULL,
    [Projectdeliverycity]					  NVARCHAR(140)    NULL,
    [Companycountrycode]					  CHAR(10)         NULL,
    [Companycountryname]					  CHAR(50)         NULL,
    [DW_Batch]                                BIGINT           NULL,
    [DW_SourceCode]                           VARCHAR (15)     NOT NULL,
    [DW_TimeStamp]                            DATETIME         NOT NULL,
    [t_applicationId]                        VARCHAR    (32)  NULL,
    [t_jobId]                                VARCHAR    (36)  NULL,
    [t_jobDtm]                               DATETIME,
    [t_jobBy]                                NVARCHAR  (128)  NULL,
    [t_extractionDtm]                        DATETIME,
    [t_filePath]                             NVARCHAR (1024)  NULL
    CONSTRAINT [PK_FACT_HGDAWA_new] PRIMARY KEY NONCLUSTERED ([DW_Id] ASC) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

