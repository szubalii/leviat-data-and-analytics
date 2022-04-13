CREATE VIEW [edw].[vw_FinancialTransactionTypeT]
AS 
    SELECT 
	      [FinancialTransactionType] AS [FinancialTransactionTypeID]
,       [FinancialTransactionTypeName] AS [FinancialTransactionType]
,       [t_applicationId]
    FROM 
        [base_s4h_cax].[I_FinancialTransactionTypeT]
    WHERE 
        [Language] = 'E' 
        -- AND 
        -- [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
