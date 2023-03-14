CREATE VIEW intm_axbi.vw_FACT_CUSTPACKINGSLIPTRANS AS
select
       [DW_Id]
      ,[DATAAREAID]
      ,[ORIGSALESID]
      ,[PACKINGSLIPID]
      ,[DLVCOUNTRYREGIONID]
      ,[DELIVERYDATE]
      ,[DeliveryDate_RunningDayNumber]
      ,[HPLDLVMODEID]
      ,[INVENTTRANSID]
      ,[ITEMID]
      ,[INVENTDIMID]
      ,[ORDERACCOUNT]
      ,[SalesTaker]
      ,[DLVTerm]
      ,[Payment]
      ,[DIMENSION]
      ,[HPLCOSTPRICE]
      ,[QTY]
      ,[AMOUNTCUR_CZ]
      ,[CURRENCYCODE_CZ]
      ,[SHIPPINGDATEREQUESTED]
      ,[ShippingSiteRequested_RunningDayNumber]
      ,[SHIPPINGDATECONFIRMED_tf]
      ,[ShippingDateConfirmed_tf_RunningDayNumber]
      ,[RECID]
      ,[INVENTSITEID]
      ,[INVENTLOCATIONID]
      ,[DeliveryDateDiff]
      ,[Reliability01]
      ,[DeliveryDateDiff2]
      ,[Reliability201]
      ,[CategoryId]
      ,[ExtendedCategoryId]
      ,[bomlines]
      ,[SalesLine_Dw_Id]
      ,[CountryRegion_DW_Id]
      ,[DateKey_DeliveryDate]
      ,[CustPackingslipJour_DW_Id]
      ,[ReqItemTable_DW_Id]
      ,[SameDeliveryDate_SalesLine]
      ,[Reliability_Stock_Items]
      ,[HLFSEGMENTID]
      ,[Segment_DW_Id]
      ,[SALESGROUP]
      ,[SalesPerson_DW_Id]
      ,[DW_Id_Itemid]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
from 
    (
    select 
       [DW_Id]
      ,[DATAAREAID]
      ,[ORIGSALESID]
      ,[PACKINGSLIPID]
      ,[DLVCOUNTRYREGIONID]
      ,[DELIVERYDATE]
      ,[DeliveryDate_RunningDayNumber]
      ,[HPLDLVMODEID]
      ,[INVENTTRANSID]
      ,[ITEMID]
      ,[INVENTDIMID]
      ,[ORDERACCOUNT]
      ,[SalesTaker]
      ,[DLVTerm]
      ,[Payment]
      ,[DIMENSION]
      ,[HPLCOSTPRICE]
      ,[QTY]
      ,[AMOUNTCUR_CZ]
      ,[CURRENCYCODE_CZ]
      ,[SHIPPINGDATEREQUESTED]
      ,[ShippingSiteRequested_RunningDayNumber]
      ,[SHIPPINGDATECONFIRMED_tf]
      ,[ShippingDateConfirmed_tf_RunningDayNumber]
      ,[RECID]
      ,[INVENTSITEID]
      ,[INVENTLOCATIONID]
      ,[DeliveryDateDiff]
      ,[Reliability01]
      ,[DeliveryDateDiff2]
      ,[Reliability201]
      ,[CategoryId]
      ,[ExtendedCategoryId]
      ,[bomlines]
      ,[SalesLine_Dw_Id]
      ,[CountryRegion_DW_Id]
      ,[DateKey_DeliveryDate]
      ,[CustPackingslipJour_DW_Id]
      ,[ReqItemTable_DW_Id]
      ,[SameDeliveryDate_SalesLine]
      ,[Reliability_Stock_Items]
      ,[HLFSEGMENTID]
      ,[Segment_DW_Id]
      ,[SALESGROUP]
      ,[SalesPerson_DW_Id]
      ,[DW_Id_Itemid]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
     ,ROW_NUMBER() OVER (PARTITION BY  PACKINGSLIPID,INVENTTRANSID,DW_Id ORDER BY DW_TimeStamp DESC) AS rn 
    from 
    (
    SELECT * FROM [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS]
    UNION ALL
    SELECT * FROM [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS_Archive]
    ) t
) q
where rn=1
 ;
