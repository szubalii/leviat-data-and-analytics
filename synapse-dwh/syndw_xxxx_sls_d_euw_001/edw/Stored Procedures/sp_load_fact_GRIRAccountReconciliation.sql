CREATE PROC [edw].[sp_load_fact_GRIRAccountReconciliation]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    DECLARE @isViewNotEmpty   BIT = 0;
    DECLARE @errmessage NVARCHAR(2048);
    -- Set reportDate to first day of the current month
    DECLARE @reportDate DATE = DATEADD(DAY, 1, EOMONTH(GETDATE(), -1));

    BEGIN TRY
        SELECT TOP 1
            @isViewNotEmpty = 1
        FROM
            [edw].[vw_GRIRAccountReconciliation];

        IF (@isViewNotEmpty = 0)
            BEGIN
                SET @errmessage = 'Temporary view [edw].[vw_GRIRAccountReconciliation] was not filled with data.';
                THROW 50001, @errmessage, 1;
            END;

	    IF OBJECT_ID('[edw].[fact_GRIRAccountReconciliation_tmp]') IS NOT NULL
		    DROP TABLE [edw].[fact_GRIRAccountReconciliation_tmp];

        CREATE TABLE [edw].[fact_GRIRAccountReconciliation_tmp]
        WITH
        (
            DISTRIBUTION = HASH ([PurchasingDocument]),
            CLUSTERED COLUMNSTORE INDEX
        )
        AS SELECT 
              [CompanyCodeID]                    
            , [PurchasingDocument]               
            , [PurchasingDocumentItem]           
            , [ReportDate]                       
            , [PurchasingDocumentItemUniqueID]   
            , [OldestOpenItemPostingDate]        
            , [LatestOpenItemPostingDate]        
            , [SupplierID]                         
            , [SupplierName]                     
            , [HasNoInvoiceReceiptPosted]        
            , [BalAmtInCompanyCodeCrcy]          
            , [BalAmtInEUR]                      
            , [BalAmtInUSD]                      
            , [CompanyCodeCurrency]              
            , [BalanceQuantityInRefQtyUnit]      
            , [ReferenceQuantityUnit]            
            , [NumberOfGoodsReceipts]            
            , [NumberOfInvoiceReceipts]          
            , [ResponsibleDepartment]            
            , [ResponsiblePerson]                
            , [GRIRClearingProcessStatus]        
            , [GRIRClearingProcessPriority]      
            , [HasNote]                          
            , [AccountAssignmentCategory]        
            , [ValuationType]                    
            , [IsGoodsRcptGoodsAmtSurplus]       
            , [IsGdsRcptDelivCostAmtSurplus]     
            , [SystemMessageType]                
            , [SystemMessageNumber]              
            , [t_applicationId]                  
            , [t_extractionDtm]                  
            , [t_jobId]                          
            , [t_jobDtm]                         
            , [t_lastActionCd]                   
            , [t_jobBy]                          
           FROM
               [edw].[fact_GRIRAccountReconciliation]
           WHERE 
               FORMAT(ReportDate, 'yyyyMM') <> FORMAT(@reportDate,'yyyyMM');

        INSERT INTO [edw].[fact_GRIRAccountReconciliation_tmp] (
                [CompanyCodeID]                    
            ,   [PurchasingDocument]               
            ,   [PurchasingDocumentItem]           
            ,   [ReportDate]                       
            ,   [PurchasingDocumentItemUniqueID]   
            ,   [OldestOpenItemPostingDate]        
            ,   [LatestOpenItemPostingDate]        
            ,   [SupplierID]                         
            ,   [SupplierName]                     
            ,   [HasNoInvoiceReceiptPosted]        
            ,   [BalAmtInCompanyCodeCrcy]          
            ,   [BalAmtInEUR]                      
            ,   [BalAmtInUSD]                      
            ,   [CompanyCodeCurrency]              
            ,   [BalanceQuantityInRefQtyUnit]      
            ,   [ReferenceQuantityUnit]            
            ,   [NumberOfGoodsReceipts]            
            ,   [NumberOfInvoiceReceipts]          
            ,   [ResponsibleDepartment]            
            ,   [ResponsiblePerson]                
            ,   [GRIRClearingProcessStatus]        
            ,   [GRIRClearingProcessPriority]      
            ,   [HasNote]                          
            ,   [AccountAssignmentCategory]        
            ,   [ValuationType]                    
            ,   [IsGoodsRcptGoodsAmtSurplus]       
            ,   [IsGdsRcptDelivCostAmtSurplus]     
            ,   [SystemMessageType]                
            ,   [SystemMessageNumber]   
            ,   [t_applicationId]
            ,   [t_extractionDtm]
            ,   [t_jobId]
            ,   [t_jobDtm]
            ,   [t_lastActionCd]
            ,   [t_jobBy]
        )
        SELECT
                [CompanyCodeID]                    
            ,   [PurchasingDocument]               
            ,   [PurchasingDocumentItem]           
            ,   CONVERT (date, GETDATE()) AS [ReportDate]
            ,   [PurchasingDocumentItemUniqueID]   
            ,   [OldestOpenItemPostingDate]        
            ,   [LatestOpenItemPostingDate]        
            ,   [SupplierID]                         
            ,   [SupplierName]                     
            ,   [HasNoInvoiceReceiptPosted]        
            ,   [BalAmtInCompanyCodeCrcy]          
            ,   [BalAmtInEUR]                      
            ,   [BalAmtInUSD]                      
            ,   [CompanyCodeCurrency]              
            ,   [BalanceQuantityInRefQtyUnit]      
            ,   [ReferenceQuantityUnit]            
            ,   [NumberOfGoodsReceipts]            
            ,   [NumberOfInvoiceReceipts]          
            ,   [ResponsibleDepartment]            
            ,   [ResponsiblePerson]                
            ,   [GRIRClearingProcessStatus]        
            ,   [GRIRClearingProcessPriority]      
            ,   [HasNote]                          
            ,   [AccountAssignmentCategory]        
            ,   [ValuationType]                    
            ,   [IsGoodsRcptGoodsAmtSurplus]       
            ,   [IsGdsRcptDelivCostAmtSurplus]     
            ,   [SystemMessageType]                
            ,   [SystemMessageNumber]   
            ,   [t_applicationId]
            ,   [t_extractionDtm]
            ,   @t_jobId AS t_jobId
            ,   @t_jobDtm AS t_jobDtm
            ,   @t_lastActionCd AS t_lastActionCd
            ,   @t_jobBy AS t_jobBy
        FROM
            [edw].[vw_GRIRAccountReconciliation];

        RENAME OBJECT [edw].[fact_GRIRAccountReconciliation] TO [fact_GRIRAccountReconciliation_old];
        RENAME OBJECT [edw].[fact_GRIRAccountReconciliation_tmp] TO [fact_GRIRAccountReconciliation];
        DROP TABLE [edw].[fact_GRIRAccountReconciliation_old];

    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
		THROW 50001, @errmessage, 1;
    END CATCH
END
GO