CREATE TABLE [base_s4h_cax].[P_OrganizationAddress]
(    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [ADDRNUMBER] NVARCHAR(10)  -- Address Number
  , [DATE_FROM] DATE  -- Valid-from date - in current Release only 00010101 possible
  , [nation] NVARCHAR(1)  -- Version ID for International Addresses
  , [date_to] DATE  -- Valid-to date in current Release only 99991231 possible
  , [title] NVARCHAR(4)  -- Form-of-Address Key
  , [name1] NVARCHAR(40)  -- Name 1
  , [name2] NVARCHAR(40)  -- Name 2
  , [name3] NVARCHAR(40)  -- Name 3
  , [name4] NVARCHAR(40)  -- Name 4
  , [name_text] NVARCHAR(50)  -- Converted name field (with form of address)
  , [name_co] NVARCHAR(40)  -- c/o name
  , [city1] NVARCHAR(40)  -- City
  , [city2] NVARCHAR(40)  -- District
  , [city_code] NVARCHAR(12)  -- City code for city/street file
  , [cityp_code] NVARCHAR(8)  -- District code for City and Street file
  , [home_city] NVARCHAR(40)  -- City (different from postal city)
  , [cityh_code] NVARCHAR(12)  -- Different city for city/street file
  , [chckstatus] NVARCHAR(1)  -- City file test status
  , [regiogroup] NVARCHAR(8)  -- Regional structure grouping
  , [post_code1] NVARCHAR(10)  -- City postal code
  , [post_code2] NVARCHAR(10)  -- PO Box Postal Code
  , [post_code3] NVARCHAR(10)  -- Company Postal Code (for Large Customers)
  , [pcode1_ext] NVARCHAR(10)  -- (Not Supported)City Postal Code Extension, e.g. ZIP+4+2 Code
  , [pcode2_ext] NVARCHAR(10)  -- (Not Supported) PO Box Postal Code Extension
  , [pcode3_ext] NVARCHAR(10)  -- (Not Supported) Major Customer Postal Code Extension
  , [po_box] NVARCHAR(10)  -- PO Box
  , [dont_use_p] NVARCHAR(4)  -- PO Box Address Undeliverable Flag
  , [po_box_num] NVARCHAR(1)  -- Flag: PO Box Without Number
  , [po_box_loc] NVARCHAR(40)  -- PO Box city
  , [city_code2] NVARCHAR(12)  -- City PO box code (City file)
  , [po_box_reg] NVARCHAR(3)  -- Region for PO Box (Country, State, Province, ...)
  , [po_box_cty] NVARCHAR(3)  -- PO box country
  , [postalarea] NVARCHAR(15)  -- (Not Supported) Post Delivery District
  , [transpzone] NVARCHAR(10)  -- Transportation zone to or from which the goods are delivered
  , [street] NVARCHAR(60)  -- Street
  , [dont_use_s] NVARCHAR(4)  -- Street Address Undeliverable Flag
  , [streetcode] NVARCHAR(12)  -- Street Number for City/Street File
  , [streetabbr] NVARCHAR(2)  -- (Not Supported) Abbreviation of Street Name
  , [house_num1] NVARCHAR(10)  -- House Number
  , [house_num2] NVARCHAR(10)  -- House number supplement
  , [house_num3] NVARCHAR(10)  -- (Not supported) House Number Range
  , [str_suppl1] NVARCHAR(40)  -- Street 2
  , [str_suppl2] NVARCHAR(40)  -- Street 3
  , [str_suppl3] NVARCHAR(40)  -- Street 4
  , [location] NVARCHAR(40)  -- Street 5
  , [building] NVARCHAR(20)  -- Building (Number or Code)
  , [floor] NVARCHAR(10)  -- Floor in building
  , [roomnumber] NVARCHAR(10)  -- Room or Apartment Number
  , [country] NVARCHAR(3)  -- Country Key
  , [langu] CHAR(1)  -- Language Key
  , [region] NVARCHAR(3)  -- Region (State, Province, County)
  , [addr_group] NVARCHAR(4)  -- Address Group (Key) (Business Address Services)
  , [flaggroups] NVARCHAR(1)  -- Flag: There are more address group assignments
  , [pers_addr] NVARCHAR(1)  -- Flag: This is a personal address
  , [sort1] NVARCHAR(20)  -- Search Term 1
  , [sort2] NVARCHAR(20)  -- Search Term 2
  , [sort_phn] NVARCHAR(20)  -- (Not Supported) Phonetic Search Sort Field
  , [deflt_comm] NVARCHAR(3)  -- Communication Method (Key) (Business Address Services)
  , [tel_number] NVARCHAR(30)  -- First telephone no.: dialling code+number
  , [tel_extens] NVARCHAR(10)  -- First Telephone No.: Extension
  , [fax_number] NVARCHAR(30)  -- First fax no.: dialling code+number
  , [fax_extens] NVARCHAR(10)  -- First fax no.: extension
  , [flagcomm2] NVARCHAR(1)  -- Flag: Telephone number(s) defined
  , [flagcomm3] NVARCHAR(1)  -- Flag: Fax number(s) defined
  , [flagcomm4] NVARCHAR(1)  -- Flag: Teletex number(s) defined
  , [flagcomm5] NVARCHAR(1)  -- Flag: Telex number(s) defined
  , [flagcomm6] NVARCHAR(1)  -- Flag: E-mail address(es) defined
  , [flagcomm7] NVARCHAR(1)  -- Flag: RML (remote mail) addresse(s) defined
  , [flagcomm8] NVARCHAR(1)  -- Flag: X.400 addresse(s) defined
  , [flagcomm9] NVARCHAR(1)  -- Flag: RFC destination(s) defined
  , [flagcomm10] NVARCHAR(1)  -- Flag: Printer defined
  , [flagcomm11] NVARCHAR(1)  -- Flag: SSF defined
  , [flagcomm12] NVARCHAR(1)  -- Flag: URI/FTP address defined
  , [flagcomm13] NVARCHAR(1)  -- Flag: Pager address defined
  , [addrorigin] NVARCHAR(4)  -- (Not Supported) Address Data Source (Key)
  , [mc_name1] NVARCHAR(25)  -- Name (Field NAME1) in Uppercase for Search Help
  , [mc_city1] NVARCHAR(25)  -- City name in Uppercase for Search Help
  , [mc_street] NVARCHAR(25)  -- Street Name in Uppercase for Search Help
  , [extension1] NVARCHAR(40)  -- Extension (only for data conversion) (e.g. data line)
  , [extension2] NVARCHAR(40)  -- Extension (only for data conversion) (e.g. telebox)
  , [time_zone] NVARCHAR(6)  -- Address time zone
  , [taxjurcode] NVARCHAR(15)  -- Tax Jurisdiction
  , [address_id] NVARCHAR(10)  -- (Not supported) Physical address ID
  , [langu_crea] CHAR(1)  -- Address record creation original language
  , [adrc_uuid] BINARY(16)  -- UUID Used in the Address
  , [uuid_belated] NVARCHAR(1)  -- Indicator: UUID created later
  , [id_category] NVARCHAR(1)  -- Category of an Address ID
  , [adrc_err_status] NVARCHAR(1)  -- Error Status of Address
  , [po_box_lobby] NVARCHAR(40)  -- PO Box Lobby
  , [deli_serv_type] NVARCHAR(4)  -- Type of Delivery Service
  , [deli_serv_number] NVARCHAR(10)  -- Number of Delivery Service
  , [county_code] NVARCHAR(8)  -- County code for county
  , [county] NVARCHAR(40)  -- County
  , [township_code] NVARCHAR(8)  -- Township code for Township
  , [township] NVARCHAR(40)  -- Township
  , [mc_county] NVARCHAR(25)  -- County name in upper case for search help
  , [mc_township] NVARCHAR(25)  -- Township name in upper case for search help
  , [xpcpt] NVARCHAR(1)  -- Business Purpose Completed Flag
  , [_dataaging] DATE  -- Data Filter Value for Data Aging
  , [duns] NVARCHAR(9)  -- Dun & Bradstreet number (DUNS)
  , [dunsp4] NVARCHAR(4)  -- DUNS+4 number (the last four digit)
  , [OrganizationName] NVARCHAR(163)
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_P_OrganizationAddress] PRIMARY KEY NONCLUSTERED
  (
      [MANDT]
  ) NOT ENFORCED
) WITH (
  HEAP
)
