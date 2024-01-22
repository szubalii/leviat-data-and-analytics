CREATE VIEW [edw].[vw_fact_SalesDocumentItem] 
AS
SELECT  
       doc.[sk_fact_SalesDocumentItem]        
     , doc.[SalesDocument]                    
     , doc.[SalesDocumentItem]                
     , doc.[CurrencyTypeID]                   
     , doc.[CurrencyType]                     
     , doc.[CurrencyID]                       
     , doc.[ExchangeRate]                     
     , doc.[SDDocumentCategoryID]             
     , doc.[SalesDocumentTypeID]              
     , doc.[SalesDocumentItemCategoryID]      
     , doc.[IsReturnsItemID]                  
     , doc.[CreationDate]                     
     , doc.[CreationTime]                     
     , doc.[LastChangeDate]                   
     , doc.[SalesOrganizationID]              
     , doc.[DistributionChannelID]            
     , doc.[DivisionID]                       
     , doc.[SalesGroupID] 
     , doc.[SalesGroupName]                   
     , doc.[SalesOfficeID]                    
     , doc.[InternationalArticleNumberID]     
     , doc.[BatchID]                          
     , doc.[MaterialID]                       
     , doc.[nk_ProductPlant]                  
     , doc.[ProductSurrogateKey]              
     , doc.[OriginallyRequestedMaterialID]    
     , doc.[MaterialSubstitutionReasonID]     
     , doc.[MaterialGroupID]                  
     , doc.[BrandID]                          
     , doc.[Brand]                            
     , doc.[SoldToPartyID]                    
     , doc.[ShipToPartyID]                    
     , doc.[PayerPartyID]                     
     , doc.[BillToPartyID]                    
     , doc.[SDDocumentReasonID]               
     , doc.[SalesDocumentDate]                
     , doc.[OrderQuantity]                    
     , doc.[OrderQuantityUnitID]              
     , doc.[TargetQuantity]                   
     , doc.[TargetQuantityUnitID]             
     , doc.[TargetToBaseQuantityDnmntr]       
     , doc.[TargetToBaseQuantityNmrtr]        
     , doc.[OrderToBaseQuantityDnmntr]        
     , doc.[OrderToBaseQuantityNmrtr]         
     , doc.[ConfdDelivQtyInOrderQtyUnit]      
     , doc.[TargetDelivQtyInOrderQtyUnit]     
     , doc.[ConfdDeliveryQtyInBaseUnit]       
     , doc.[BaseUnitID]                       
     , doc.[ItemGrossWeight]                  
     , doc.[ItemNetWeight]                    
     , doc.[ItemWeightUnitID]                 
     , doc.[ItemVolume]                       
     , doc.[ItemVolumeUnitID]                 
     , doc.[ServicesRenderedDate]             
     , doc.[SalesDistrictID]                  
     , doc.[CustomerGroupID]                  
     , doc.[HdrOrderProbabilityInPercentID]   
     , doc.[ItemOrderProbabilityInPercentID]  
     , doc.[SalesDocumentRjcnReasonID]        
     , doc.[PricingDate]                      
     , doc.[ExchangeRateDate]                 
     , doc.[PriceDetnExchangeRate]            
     , doc.[StatisticalValueControlID]        
     , doc.[NetAmount]                        
     , doc.[TransactionCurrencyID]            
     , doc.[SalesOrganizationCurrencyID]      
     , doc.[NetPriceAmount]                   
     , doc.[NetPriceQuantity]                 
     , doc.[NetPriceQuantityUnitID]           
     , doc.[TaxAmount]                        
     , doc.[CostAmount]                       
     , doc.[Margin]                           
     , doc.[Subtotal1Amount]                  
     , doc.[Subtotal2Amount]                  
     , doc.[Subtotal3Amount]                  
     , doc.[Subtotal4Amount]                  
     , doc.[Subtotal5Amount]                  
     , doc.[Subtotal6Amount]                  
     , doc.[ShippingPointID]                  
     , doc.[ShippingTypeID]                   
     , doc.[DeliveryPriorityID]               
     , doc.[InventorySpecialStockTypeID]      
     , doc.[RequestedDeliveryDate]            
     , doc.[ShippingConditionID]              
     , doc.[DeliveryBlockReasonID]            
     , doc.[PlantID]                          
     , doc.[StorageLocationID]                
     , doc.[RouteID]                          
     , doc.[IncotermsClassificationID]        
     , doc.[IncotermsVersionID]               
     , doc.[IncotermsTransferLocationID]      
     , doc.[IncotermsLocation1ID]             
     , doc.[IncotermsLocation2ID]             
     , doc.[MinDeliveryQtyInBaseUnit]         
     , doc.[UnlimitedOverdeliveryIsAllowedID] 
     , doc.[OverdelivTolrtdLmtRatioInPct]     
     , doc.[UnderdelivTolrtdLmtRatioInPct]    
     , doc.[PartialDeliveryIsAllowedID]       
     , doc.[BindingPeriodValidityStartDate]   
     , doc.[BindingPeriodValidityEndDate]     
     , doc.[OutlineAgreementTargetAmount]     
     , doc.[BillingDocumentDate]              
     , doc.[BillingCompanyCodeID]             
     , doc.[HeaderBillingBlockReasonID]       
     , doc.[ItemBillingBlockReasonID]         
     , doc.[FiscalYearID]                     
     , doc.[FiscalPeriodID]                   
     , doc.[CustomerAccountAssignmentGroupID] 
     , doc.[ExchangeRateTypeID]               
     , doc.[CompanyCodeCurrencyID]            
     , doc.[FiscalYearVariantID]              
     , doc.[BusinessAreaID]                   
     , doc.[ProfitCenterID]                   
     , doc.[OrderID]                          
     , doc.[ProfitabilitySegmentID]           
     , doc.[ControllingAreaID]                
     , doc.[ReferenceSDDocumentID]            
     , doc.[ReferenceSDDocumentItemID]        
     , doc.[ReferenceSDDocumentCategoryID]    
     , doc.[OriginSDDocumentID]               
     , doc.[OriginSDDocumentItemID]           
     , doc.[OverallSDProcessStatusID]         
     , doc.[OverallTotalDeliveryStatusID]     
     , doc.[OverallOrdReltdBillgStatusID]     
     , doc.[TotalCreditCheckStatusID]         
     , doc.[DeliveryBlockStatusID]            
     , doc.[TotalSDDocReferenceStatusID]      
     , doc.[SDDocReferenceStatusID]           
     , doc.[OverallSDDocumentRejectionStsID]  
     , doc.[SDDocumentRejectionStatusID]      
     , doc.[OverallTotalSDDocRefStatusID]     
     , doc.[OverallSDDocReferenceStatusID]    
     , doc.[ItemGeneralIncompletionStatusID]  
     , doc.[ItemBillingIncompletionStatusID]  
     , doc.[PricingIncompletionStatusID]      
     , doc.[ItemDeliveryIncompletionStatusID] 
     , doc.[SalesAgentID]                     
     , doc.[SalesAgent]                       
     , doc.[ExternalSalesAgentID]             
     , doc.[ExternalSalesAgent]               
     , doc.[GlobalParentID]                   
     , doc.[GlobalParent]                     
     , doc.[LocalParentID]                    
     , doc.[LocalParent]                      
     , doc.[ProjectID]                        
     , doc.[Project]                          
     , doc.[SalesEmployeeID]                  
     , doc.[SalesEmployee]                    
     , doc.[GlobalParentCalculatedID]         
     , doc.[GlobalParentCalculated]           
     , doc.[LocalParentCalculatedID]          
     , doc.[LocalParentCalculated]            
     , doc.[SDoc_ControllingObjectID]         
     , doc.[SDItem_ControllingObjectID]       
     , doc.[InOutID]                          
     , doc.[CorrespncExternalReference]       
     , doc.[OpenDeliveryNetAmount]            
     , doc.[OrderType]                        
     , doc.[ItemOrderStatus]                  
     , doc.[OrderStatus]                      
     , doc.[ActualDeliveredQuantityInBaseUnit]
     , doc.[BillingQuantityInBaseUnit]        
     , doc.[ActualDeliveredQuantityIBUOverall]
     , doc.[BillingQuantityIBUOverall]        
     , doc.[ItemDeliveryStatus]               
     , doc.[OverallDeliveryStatus]            
     , doc.[ScheduleLineCategory]             
     , dimBBS.[BillingBlockStatusID]
     , dimBBS.[BillingBlockStatus]
     , DeliveryItem.[HDR_PlannedGoodsIssueDate]
     , DeliveryItem.[HDR_ShippingPointID]
     , DeliveryItem.[HDR_HeaderBillingBlockReason]
     , DeliveryItem.[HDR_TotalBlockStatusID]
     , DeliveryItem.[HDR_ShipmentBlockReason]
     , DeliveryItem.[HDR_DeliveryBlockReason]
     , DeliveryItem.[CreatedByUserID]
     , DeliveryItem.[OutboundDelivery]
     , DeliveryItem.[OutboundDeliveryItem]
     , edw.[svf_getIsOrderItemBlockedFlag] (
          doc.[DeliveryBlockReasonID]
        , dimBBS.[BillingBlockStatusID]
        , doc.[HeaderBillingBlockReasonID]
        , doc.[ItemBillingBlockReasonID]
        , DeliveryItem.[HDR_DeliveryBlockReason] 
       )                                          AS [IsOrderItemBlockedFlag]
     , doc.[t_applicationId]
     , doc.[t_extractionDtm]
FROM [edw].[fact_SalesDocumentItem] doc
LEFT JOIN 
    [edw].[dim_BillingBlockStatus] dimBBS
        ON 
        dimBBS.[BillingBlockStatusID] = doc.[BillingBlockStatusID]
LEFT JOIN 
    [edw].[vw_LatestOutboundDeliveryItem] DeliveryItem
        ON 
        doc.[SalesDocument] = DeliveryItem.[ReferenceSDDocument]
        AND 
        doc.[SalesDocumentItem] = DeliveryItem.[ReferenceSDDocumentItem]
