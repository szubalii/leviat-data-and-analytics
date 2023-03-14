CREATE VIEW intm_axbi.vw_DIM_INVENTTABLE AS
select
       [DW_Id]
      ,[ITEMID]
      ,[ITEMGROUPID]
      ,[ITEMNAME]
      ,[DATAAREAID]
      ,[HALPRODUCTLINEID]
      ,[ITEMTYPE]
      ,[STOPEXPLODE]
      ,[HALITEMTYPE_NAME]
      ,[HALITEMTYPE]
      ,[ITEMTYPE_NAME]
      ,[HPLBUSINESSRULESTATUSID]
      ,[bomlines]
      ,[HALISKIT]
      ,[HALPRODUCTRANGEID]
      ,[PRIMARYVENDORID]
      ,[REQGROUPID]
      ,[HALSALEABLEITEM]
      ,[HPLMAINSTATISTICGROUPID]
      ,[COSTGROUPID]
      ,[HALSurchargeGroupPURCH]
      ,[ITEMBUYERGROUPID]
      ,[NETWEIGHT]
      ,[StockUnit]
      ,[MODELGROUPID]
      ,[ADMIN_VirtualDataAreaid_INVENTMODELGROUP]
      ,[MODELGROUP_NAME]
      ,[INCLPHYSICALVALUEINCOST]
      ,[BOMUNITID]
      ,[HALSTATISTICGROUPID]
      ,[HALPURCHCLASSIFIERID]
      ,[LastYear]
      ,[Type4PriceLastYear]
      ,[PurchasePriceUnit]
      ,[PurchPriceUnitID]
      ,[Price_ForInventoryReporting]
      ,[EXCHRATE_EUR]
      ,[Type4PriceLastYear_EUR]
      ,[HALPRODUCTLINENAME]
      ,[HALPRODUCTLINEID_NAME]
      ,[HALPRODUCTRANGENAME]
      ,[HALPRODUCTRANGEID_NAME]
      ,[HPLMAINSTATISTICGROUPNAME]
      ,[HPLLONGMAINSTATISTICGROUPID]
      ,[HPLLONGMAINSTATISTICGROUPID_NAME]
      ,[HALSTATISTICGROUPNAME]
      ,[HALSTATISTICGROUPID_NAME]
      ,[HPLSTATISTICGROUPID]
      ,[HPLSTATISTICGROUPNAME]
      ,[HPLSTATITICGROUPID_NAME]
      ,[ITEMID_NAME]
      ,[Type4MarkupLastYear]
      ,[Type4PriceUnitLastYear]
      ,[Type4PriceQuantityLastYear]
      ,[INTRACODE]
      ,[INTRACODENAME]
      ,[INTRACODE_NAME]
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
      ,[ITEMID]
      ,[ITEMGROUPID]
      ,[ITEMNAME]
      ,[DATAAREAID]
      ,[HALPRODUCTLINEID]
      ,[ITEMTYPE]
      ,[STOPEXPLODE]
      ,[HALITEMTYPE_NAME]
      ,[HALITEMTYPE]
      ,[ITEMTYPE_NAME]
      ,[HPLBUSINESSRULESTATUSID]
      ,[bomlines]
      ,[HALISKIT]
      ,[HALPRODUCTRANGEID]
      ,[PRIMARYVENDORID]
      ,[REQGROUPID]
      ,[HALSALEABLEITEM]
      ,[HPLMAINSTATISTICGROUPID]
      ,[COSTGROUPID]
      ,[HALSurchargeGroupPURCH]
      ,[ITEMBUYERGROUPID]
      ,[NETWEIGHT]
      ,[StockUnit]
      ,[MODELGROUPID]
      ,[ADMIN_VirtualDataAreaid_INVENTMODELGROUP]
      ,[MODELGROUP_NAME]
      ,[INCLPHYSICALVALUEINCOST]
      ,[BOMUNITID]
      ,[HALSTATISTICGROUPID]
      ,[HALPURCHCLASSIFIERID]
      ,[LastYear]
      ,[Type4PriceLastYear]
      ,[PurchasePriceUnit]
      ,[PurchPriceUnitID]
      ,[Price_ForInventoryReporting]
      ,[EXCHRATE_EUR]
      ,[Type4PriceLastYear_EUR]
      ,[HALPRODUCTLINENAME]
      ,[HALPRODUCTLINEID_NAME]
      ,[HALPRODUCTRANGENAME]
      ,[HALPRODUCTRANGEID_NAME]
      ,[HPLMAINSTATISTICGROUPNAME]
      ,[HPLLONGMAINSTATISTICGROUPID]
      ,[HPLLONGMAINSTATISTICGROUPID_NAME]
      ,[HALSTATISTICGROUPNAME]
      ,[HALSTATISTICGROUPID_NAME]
      ,[HPLSTATISTICGROUPID]
      ,[HPLSTATISTICGROUPNAME]
      ,[HPLSTATITICGROUPID_NAME]
      ,[ITEMID_NAME]
      ,[Type4MarkupLastYear]
      ,[Type4PriceUnitLastYear]
      ,[Type4PriceQuantityLastYear]
      ,[INTRACODE]
      ,[INTRACODENAME]
      ,[INTRACODE_NAME]
      ,[DW_Batch]
      ,[DW_SourceCode]
      ,[DW_TimeStamp]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_jobBy]
      ,[t_extractionDtm]
      ,[t_filePath]
     ,ROW_NUMBER() OVER (PARTITION BY DW_Id,ITEMID ORDER BY DW_TimeStamp DESC) AS rn 
    from 
    (
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTTABLE]
    UNION ALL
    SELECT * FROM [base_tx_halfen_2_dwh].[DIM_INVENTTABLE_Archive]
    ) views
) a
where rn=1
 ;
 