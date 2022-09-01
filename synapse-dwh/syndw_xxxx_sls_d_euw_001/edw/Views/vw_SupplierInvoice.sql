CREATE VIEW [dbo].[vw_SupplierInvoice]
  AS 
  
  SELECT 
    [SupplierInvoice]     AS [SupplierInvoiceID],                
    [FiscalYear],                     
    [SupplierInvoiceUUID],            
    [CompanyCode],                    
    [DocumentDate],                   
    [PostingDate],                    
    [InvoiceReceiptDate],             
    [SupplierInvoiceIDByInvcgParty],  
    [InvoicingParty],                 
    [DocumentCurrency],               
    [InvoiceGrossAmount],             
    [IsInvoice],                      
    [UnplannedDeliveryCost],          
    [DocumentHeaderText],             
    [CreatedByUser],                  
    [LastChangedByUser],              
    [SuplrInvcExtCreatedByUser],      
    [CreationDate],                   
    [ManualCashDiscount],             
    [PaymentTerms],                   
    [DueCalculationBaseDate],         
    [CashDiscount1Percent],           
    [CashDiscount1Days],              
    [CashDiscount2Percent],           
    [CashDiscount2Days],              
    [NetPaymentDays],                 
    [PaymentBlockingReason],          
    [AccountingDocumentType],         
    [SupplierInvoiceStatus],          
    [SupplierInvoiceOrigin],          
    [BusinessNetworkOrigin],         
    [SuplrInvcTransactionCategory],   
    [SuplrInvcManuallyReducedAmount], 
    [SuplrInvcManualReductionTaxAmt], 
    [SuplrInvcAutomReducedAmount],    
    [SuplrInvcAutomReductionTaxAmt],  
    [BPBankAccountInternalID],        
    [ExchangeRate],                   
    [StateCentralBankPaymentReason],  
    [SupplyingCountry],               
    [PaymentMethod],                  
    [PaymentMethodSupplement],        
    [PaymentReference],               
    [InvoiceReference],               
    [InvoiceReferenceFiscalYear],     
    [FixedCashDiscount],              
    [UnplannedDeliveryCostTaxCode],   
    [UnplndDelivCostTaxJurisdiction], 
    [AssignmentReference],            
    [SupplierPostingLineItemText],    
    [TaxIsCalculatedAutomatically],   
    [BusinessPlace],                  
    [PaytSlipWthRefSubscriber],       
    [PaytSlipWthRefCheckDigit],       
    [PaytSlipWthRefReference],        
    [IsEndOfPurposeBlocked],          
    [BusinessSectionCode],            
    [BusinessArea],                   
    [ElectronicInvoiceUUID],          
    [TaxDeterminationDate],           
    [DeliveryOfGoodsReportingCntry],  
    [SupplierVATRegistration],        
    [IsEUTriangularDeal],    
    [t_applicationId],
    [t_extractionDtm]        
  FROM 
    [base_s4h_cax].[I_SupplierInvoice]
Where 
  [ReverseDocument] IS NULL            