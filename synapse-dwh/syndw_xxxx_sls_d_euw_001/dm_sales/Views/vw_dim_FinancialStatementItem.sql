CREATE VIEW [dm_sales].[vw_dim_FinancialStatementItem] AS
SELECT
       [FinancialStatementVariant],     
       [HierarchyNode],                 
       [NodeType],                      
       [FinancialStatementItem],        
       [ParentNode],                    
       [ChildNode],                     
       [SiblingNode],                   
       [FinStatementHierarchyLevelVal], 
       [LastChangeDate],              
       [ResponsiblePerson],             
       [OffsettingItem],                
       [FinStatementItemDescription],
       [t_extractionDtm],
       [t_applicationId]
FROM
     [edw].[dim_FinancialStatementItem]
