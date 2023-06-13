CREATE TABLE [base_s4h_cax].[P_OrganizationAddress]
(    
    [CLIENT] CHAR(3) NOT NULL  -- Client
  , [ADDRNUMBER] NVARCHAR(10) NOT NULL  -- Address Number
  , [DATE_FROM] DATE  NOT NULL -- Valid-from date - in current Release only 00010101 possible
  , [NATION] NVARCHAR(1)  NOT NULL -- Version ID for International Addresses
  , [DATE_TO] DATE  -- Valid-to date in current Release only 99991231 possible
  , [TITLE] NVARCHAR(4)  -- Form-of-Address Key
  , [NAME1] NVARCHAR(40)  -- Name 1
  , [NAME2] NVARCHAR(40)  -- Name 2
  , [NAME3] NVARCHAR(40)  -- Name 3
  , [NAME4] NVARCHAR(40)  -- Name 4
  , [NAME_TEXT] NVARCHAR(50)  -- Converted name field (with form of address)
  , [NAME_CO] NVARCHAR(40)  -- c/o name
  , [CITY1] NVARCHAR(40)  -- City
  , [CITY2] NVARCHAR(40)  -- District
  , [CITY_CODE] NVARCHAR(12)  -- City code for city/street file
  , [CITYP_CODE] NVARCHAR(8)  -- District code for City and Street file
  , [HOME_CITY] NVARCHAR(40)  -- City (different from postal city)
  , [CITYH_CODE] NVARCHAR(12)  -- Different city for city/street file
  , [CHCKSTATUS] NVARCHAR(1)  -- City file test status
  , [REGIOGROUP] NVARCHAR(8)  -- Regional structure grouping
  , [POST_CODE1] NVARCHAR(10)  -- City postal code
  , [POST_CODE2] NVARCHAR(10)  -- PO Box Postal Code
  , [POST_CODE3] NVARCHAR(10)  -- Company Postal Code (for Large Customers)
  , [PCODE1_EXT] NVARCHAR(10)  -- (Not Supported)City Postal Code Extension, e.g. ZIP+4+2 Code
  , [PCODE2_EXT] NVARCHAR(10)  -- (Not Supported) PO Box Postal Code Extension
  , [PCODE3_EXT] NVARCHAR(10)  -- (Not Supported) Major Customer Postal Code Extension
  , [PO_BOX] NVARCHAR(10)  -- PO Box
  , [DONT_USE_P] NVARCHAR(4)  -- PO Box Address Undeliverable Flag
  , [PO_BOX_NUM] NVARCHAR(1)  -- Flag: PO Box Without Number
  , [PO_BOX_LOC] NVARCHAR(40)  -- PO Box city
  , [CITY_CODE2] NVARCHAR(12)  -- City PO box code (City file)
  , [PO_BOX_REG] NVARCHAR(3)  -- Region for PO Box (Country, State, Province, ...)
  , [PO_BOX_CTY] NVARCHAR(3)  -- PO box country
  , [POSTALAREA] NVARCHAR(15)  -- (Not Supported) Post Delivery District
  , [TRANSPZONE] NVARCHAR(10)  -- Transportation zone to or from which the goods are delivered
  , [STREET] NVARCHAR(60)  -- Street
  , [DONT_USE_S] NVARCHAR(4)  -- Street Address Undeliverable Flag
  , [STREETCODE] NVARCHAR(12)  -- Street Number for City/Street File
  , [STREETABBR] NVARCHAR(2)  -- (Not Supported) Abbreviation of Street Name
  , [HOUSE_NUM1] NVARCHAR(10)  -- House Number
  , [HOUSE_NUM2] NVARCHAR(10)  -- House number supplement
  , [HOUSE_NUM3] NVARCHAR(10)  -- (Not supported) House Number Range
  , [STR_SUPPL1] NVARCHAR(40)  -- Street 2
  , [STR_SUPPL2] NVARCHAR(40)  -- Street 3
  , [STR_SUPPL3] NVARCHAR(40)  -- Street 4
  , [LOCATION] NVARCHAR(40)  -- Street 5
  , [BUILDING] NVARCHAR(20)  -- Building (Number or Code)
  , [FLOOR] NVARCHAR(10)  -- Floor in building
  , [ROOMNUMBER] NVARCHAR(10)  -- Room or Apartment Number
  , [COUNTRY] NVARCHAR(3)  -- Country Key
  , [LANGU] CHAR(1)  -- Language Key
  , [REGION] NVARCHAR(3)  -- Region (State, Province, County)
  , [ADDR_GROUP] NVARCHAR(4)  -- Address Group (Key) (Business Address Services)
  , [FLAGGROUPS] NVARCHAR(1)  -- Flag: There are more address group assignments
  , [PERS_ADDR] NVARCHAR(1)  -- Flag: This is a personal address
  , [SORT1] NVARCHAR(20)  -- Search Term 1
  , [SORT2] NVARCHAR(20)  -- Search Term 2
  , [SORT_PHN] NVARCHAR(20)  -- (Not Supported) Phonetic Search Sort Field
  , [DEFLT_COMM] NVARCHAR(3)  -- Communication Method (Key) (Business Address Services)
  , [TEL_NUMBER] NVARCHAR(30)  -- First telephone no.: dialling code+number
  , [TEL_EXTENS] NVARCHAR(10)  -- First Telephone No.: Extension
  , [FAX_NUMBER] NVARCHAR(30)  -- First fax no.: dialling code+number
  , [FAX_EXTENS] NVARCHAR(10)  -- First fax no.: extension
  , [FLAGCOMM2] NVARCHAR(1)  -- Flag: Telephone number(s) defined
  , [FLAGCOMM3] NVARCHAR(1)  -- Flag: Fax number(s) defined
  , [FLAGCOMM4] NVARCHAR(1)  -- Flag: Teletex number(s) defined
  , [FLAGCOMM5] NVARCHAR(1)  -- Flag: Telex number(s) defined
  , [FLAGCOMM6] NVARCHAR(1)  -- Flag: E-mail address(es) defined
  , [FLAGCOMM7] NVARCHAR(1)  -- Flag: RML (remote mail) addresse(s) defined
  , [FLAGCOMM8] NVARCHAR(1)  -- Flag: X.400 addresse(s) defined
  , [FLAGCOMM9] NVARCHAR(1)  -- Flag: RFC destination(s) defined
  , [FLAGCOMM10] NVARCHAR(1)  -- Flag: Printer defined
  , [FLAGCOMM11] NVARCHAR(1)  -- Flag: SSF defined
  , [FLAGCOMM12] NVARCHAR(1)  -- Flag: URI/FTP address defined
  , [FLAGCOMM13] NVARCHAR(1)  -- Flag: Pager address defined
  , [ADDRORIGIN] NVARCHAR(4)  -- (Not Supported) Address Data Source (Key)
  , [MC_NAME1] NVARCHAR(25)  -- Name (Field NAME1) in Uppercase for Search Help
  , [MC_CITY1] NVARCHAR(25)  -- City name in Uppercase for Search Help
  , [MC_STREET] NVARCHAR(25)  -- Street Name in Uppercase for Search Help
  , [EXTENSION1] NVARCHAR(40)  -- Extension (only for data conversion) (e.g. data line)
  , [EXTENSION2] NVARCHAR(40)  -- Extension (only for data conversion) (e.g. telebox)
  , [TIME_ZONE] NVARCHAR(6)  -- Address time zone
  , [TAXJURCODE] NVARCHAR(15)  -- Tax Jurisdiction
  , [ADDRESS_ID] NVARCHAR(10)  -- (Not supported) Physical address ID
  , [LANGU_CREA] CHAR(1)  -- Address record creation original language
  , [ADRC_UUID] BINARY(16)  -- UUID Used in the Address
  , [UUID_BELATED] NVARCHAR(1)  -- Indicator: UUID created later
  , [ID_CATEGORY] NVARCHAR(1)  -- Category of an Address ID
  , [ADRC_ERR_STATUS] NVARCHAR(1)  -- Error Status of Address
  , [PO_BOX_LOBBY] NVARCHAR(40)  -- PO Box Lobby
  , [DELI_SERV_TYPE] NVARCHAR(4)  -- Type of Delivery Service
  , [DELI_SERV_NUMBER] NVARCHAR(10)  -- Number of Delivery Service
  , [COUNTY_CODE] NVARCHAR(8)  -- County code for county
  , [COUNTY] NVARCHAR(40)  -- County
  , [TOWNSHIP_CODE] NVARCHAR(8)  -- Township code for Township
  , [TOWNSHIP] NVARCHAR(40)  -- Township
  , [MC_COUNTY] NVARCHAR(25)  -- County name in upper case for search help
  , [MC_TOWNSHIP] NVARCHAR(25)  -- Township name in upper case for search help
  , [XPCPT] NVARCHAR(1)  -- Business Purpose Completed Flag
  , [_DATAAGING] DATE  -- Data Filter Value for Data Aging
  , [DUNS] NVARCHAR(9)  -- Dun & Bradstreet number (DUNS)
  , [DUNSP4] NVARCHAR(4)  -- DUNS+4 number (the last four digit)
  , [ORGANIZATIONNAME] NVARCHAR(163)
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_P_OrganizationAddress] PRIMARY KEY NONCLUSTERED
  (
       [CLIENT]
      ,[ADDRNUMBER]
      ,[DATE_FROM]
      ,[NATION]
  ) NOT ENFORCED
) WITH (
  HEAP
)
