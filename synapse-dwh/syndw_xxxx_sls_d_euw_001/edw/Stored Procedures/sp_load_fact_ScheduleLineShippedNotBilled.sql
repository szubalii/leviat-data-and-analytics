CREATE PROC [edw].[sp_load_fact_ScheduleLineShippedNotBilled]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    DECLARE @isViewNotEmpty   BIT = 0;
    DECLARE @errmessage NVARCHAR(2048);

    BEGIN TRY
        SELECT TOP 1
            @isViewNotEmpty = 1
        FROM
            [edw].[vw_ScheduleLineShippedNotBilled];

        IF (@isViewNotEmpty = 0)
            BEGIN
                SET @errmessage = 'Temporary view [edw].[vw_ScheduleLineShippedNotBilled] was not filled with data.';
                THROW 50001, @errmessage, 1;
            END;

	    IF OBJECT_ID('[edw].[fact_ScheduleLineShippedNotBilled_tmp]') IS NOT NULL
		    DROP TABLE [edw].[fact_ScheduleLineShippedNotBilled_tmp];

        CREATE TABLE [edw].[fact_ScheduleLineShippedNotBilled_tmp]
        WITH
        (
            DISTRIBUTION = HASH ([SalesDocumentID]),
            CLUSTERED COLUMNSTORE INDEX
        )
        AS SELECT 
                [nk_fact_SalesDocumentItem]                
             ,  [SalesDocumentID]                          
             ,  [SalesDocumentItem]                        
             ,  [ReportDate]                               
             ,  [SalesDocumentTypeID]                      
             ,  [SDDocumentRejectionStatusID]              
             ,  [IsUnconfirmedDelivery]                    
             ,  [CurrencyTypeID]                           
             ,  [ScheduleLine]                             
             ,  [SalesDocumentOrderType]                   
             ,  [OrderStatus]                              
             ,  [ItemOrderStatus]                          
             ,  [SLDeliveryStatus]                         
             ,  [SLInvoicedStatus]                         
             ,  [SLStatus]                                 
             ,  [CreationDate]                             
             ,  [RequestedDeliveryDate]                    
             ,  [ConfirmedDeliveryDate]                    
             ,  [SDI_ODB_LatestActualGoodsMovmtDate]       
             ,  [DelivBlockReasonForSchedLine]             
             ,  [LoadingDate]                              
             ,  [ConfirmedQty]                             
             ,  [TotalOrderQty]                            
             ,  [TotalDelivered]                           
             ,  [SDSLOrderQtyRunningSum]                   
             ,  [ValueConfirmedQuantity]                   
             ,  [CurrencyID]                               
             ,  [BillingQuantity]                          
             ,  [ShippingConditionID]                      
             ,  [ScheduleLineCategory]                     
             ,  [NetAmount]                                
             ,  [OpenDeliveryValue]                        
             ,  [ClosedDeliveryValue]                      
             ,  [OpenInvoicedValue]                        
             ,  [ClosedInvoicedValue]                      
             ,  [PricePerUnit]                             
             ,  [InScope]                                  
             ,  [HDR_ActualGoodsMovementDate]              
             ,  [t_applicationId]                          
             ,  [t_extractionDtm]                          
             ,  [t_jobId]                                  
             ,  [t_jobDtm]                                 
             ,  [t_lastActionCd]                           
             ,  [t_jobBy]                                  
           FROM
               [edw].[fact_ScheduleLineShippedNotBilled]
           WHERE 
                FORMAT(ReportDate, 'yyyyMM') <> FORMAT(t_jobDtm,'yyyyMM');

        INSERT INTO [edw].[fact_ScheduleLineShippedNotBilled_tmp] (
                [nk_fact_SalesDocumentItem]                
             ,  [SalesDocumentID]                          
             ,  [SalesDocumentItem]                        
             ,  [ReportDate]                               
             ,  [SalesDocumentTypeID]                      
             ,  [SDDocumentRejectionStatusID]              
             ,  [IsUnconfirmedDelivery]                    
             ,  [CurrencyTypeID]                           
             ,  [ScheduleLine]                             
             ,  [SalesDocumentOrderType]                   
             ,  [OrderStatus]                              
             ,  [ItemOrderStatus]                          
             ,  [SLDeliveryStatus]                         
             ,  [SLInvoicedStatus]                         
             ,  [SLStatus]                                 
             ,  [CreationDate]                             
             ,  [RequestedDeliveryDate]                    
             ,  [ConfirmedDeliveryDate]                    
             ,  [SDI_ODB_LatestActualGoodsMovmtDate]       
             ,  [DelivBlockReasonForSchedLine]             
             ,  [LoadingDate]                              
             ,  [ConfirmedQty]                             
             ,  [TotalOrderQty]                            
             ,  [TotalDelivered]                           
             ,  [SDSLOrderQtyRunningSum]                   
             ,  [ValueConfirmedQuantity]                   
             ,  [CurrencyID]                               
             ,  [BillingQuantity]                          
             ,  [ShippingConditionID]                      
             ,  [ScheduleLineCategory]                     
             ,  [NetAmount]                                
             ,  [OpenDeliveryValue]                        
             ,  [ClosedDeliveryValue]                      
             ,  [OpenInvoicedValue]                        
             ,  [ClosedInvoicedValue]                      
             ,  [PricePerUnit]                             
             ,  [InScope]                                  
             ,  [HDR_ActualGoodsMovementDate]              
             ,  [t_applicationId]                          
             ,  [t_extractionDtm]                          
             ,  [t_jobId]                                  
             ,  [t_jobDtm]                                 
             ,  [t_lastActionCd]                           
             ,  [t_jobBy] 
        )
        SELECT
                [nk_fact_SalesDocumentItem]                
             ,  [SalesDocumentID]                          
             ,  [SalesDocumentItem]                        
             ,  [ReportDate]                               
             ,  [SalesDocumentTypeID]                      
             ,  [SDDocumentRejectionStatusID]              
             ,  [IsUnconfirmedDelivery]                    
             ,  [CurrencyTypeID]                           
             ,  [ScheduleLine]                             
             ,  [SalesDocumentOrderType]                   
             ,  [OrderStatus]                              
             ,  [ItemOrderStatus]                          
             ,  [SLDeliveryStatus]                         
             ,  [SLInvoicedStatus]                         
             ,  [SLStatus]                                 
             ,  [CreationDate]                             
             ,  [RequestedDeliveryDate]                    
             ,  [ConfirmedDeliveryDate]                    
             ,  [SDI_ODB_LatestActualGoodsMovmtDate]       
             ,  [DelivBlockReasonForSchedLine]             
             ,  [LoadingDate]                              
             ,  [ConfirmedQty]                             
             ,  [TotalOrderQty]                            
             ,  [TotalDelivered]                           
             ,  [SDSLOrderQtyRunningSum]                   
             ,  [ValueConfirmedQuantity]                   
             ,  [CurrencyID]                               
             ,  [BillingQuantity]                          
             ,  [ShippingConditionID]                      
             ,  [ScheduleLineCategory]                     
             ,  [NetAmount]                                
             ,  [OpenDeliveryValue]                        
             ,  [ClosedDeliveryValue]                      
             ,  [OpenInvoicedValue]                        
             ,  [ClosedInvoicedValue]                      
             ,  [PricePerUnit]                             
             ,  [InScope]                                  
             ,  [HDR_ActualGoodsMovementDate]              
             ,  [t_applicationId]                          
             ,  [t_extractionDtm]                          
             ,  @t_jobId AS t_jobId
             ,  @t_jobDtm AS t_jobDtm
             ,  @t_lastActionCd AS t_lastActionCd
             ,  @t_jobBy AS t_jobBy
        FROM
            [edw].[vw_ScheduleLineShippedNotBilled];

        RENAME OBJECT [edw].[fact_ScheduleLineShippedNotBilled] TO [fact_ScheduleLineShippedNotBilled_old];
        RENAME OBJECT [edw].[fact_ScheduleLineShippedNotBilled_tmp] TO [fact_ScheduleLineShippedNotBilled];
        DROP TABLE [edw].[fact_ScheduleLineShippedNotBilled_old];

    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
		THROW 50001, @errmessage, 1;
    END CATCH
END
GO