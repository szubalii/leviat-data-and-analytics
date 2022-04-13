CREATE VIEW [edw].[vw_ProductHierarchy]
	AS SELECT 
		phn.ProductHierarchyNode
         , [Product_L1_PillarID]        
         , [Product_L2_GroupID]         
         , [Product_L3_TypeID]          
         , [Product_L4_FamilyID]        
         , [Product_L5_SubFamilyID] 
         , phnt1.ProductHierarchyNodeText as [Product_L1_Pillar]
         , phnt2.ProductHierarchyNodeText as [Product_L2_Group]
         , phnt3.ProductHierarchyNodeText as [Product_L3_Type]
         , phnt4.ProductHierarchyNodeText as [Product_L4_Family]
         , phnt5.ProductHierarchyNodeText as [Product_L5_SubFamily]
         , phn.[t_applicationId]
    from (
             select ProductHierarchyNode
                  , case
                        when ProductHierarchyNodeLevel > 4
                            then [ProductHierarchyNode]
                 end                                        as [Product_L5_SubFamilyID]
                  , case
                        when ProductHierarchyNodeLevel > 3
                            then SUBSTRING([ProductHierarchyNode], 1, 13)
                 end                                        as [Product_L4_FamilyID]
                  , case
                        when ProductHierarchyNodeLevel > 2
                            then SUBSTRING([ProductHierarchyNode], 1, 8)
                 end                                        as [Product_L3_TypeID]
                  , case
                        when ProductHierarchyNodeLevel > 1
                            then SUBSTRING([ProductHierarchyNode], 1, 4)
                 end                                        as [Product_L2_GroupID]

                  , SUBSTRING([ProductHierarchyNode], 1, 1) as [Product_L1_PillarID]
                  , t_applicationId

             from [base_s4h_cax].[I_ProductHierarchyNode]
            --  where MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    ) phn
    left JOIN 
        [base_s4h_cax].[I_ProductHierarchyNodeText] phnt1
        on 
            phn.[Product_L1_PillarID] = phnt1.ProductHierarchyNode
            AND
            phnt1.[Language] = 'E' 
            -- and phnt1.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    left JOIN 
        [base_s4h_cax].[I_ProductHierarchyNodeText] phnt2
        on
            phn.[Product_L2_GroupID] = phnt2.ProductHierarchyNode
            AND
            phnt2.[Language] = 'E' 
            -- and phnt2.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    left JOIN 
        [base_s4h_cax].[I_ProductHierarchyNodeText] phnt3
        on
            phn.[Product_L3_TypeID] = phnt3.ProductHierarchyNode
            AND
            phnt3.[Language] = 'E' 
            -- and phnt3.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    left JOIN 
        [base_s4h_cax].[I_ProductHierarchyNodeText] phnt4
        on
            phn.[Product_L4_FamilyID] = phnt4.ProductHierarchyNode
            AND
            phnt4.[Language] = 'E' 
            -- and phnt4.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    left JOIN 
        [base_s4h_cax].[I_ProductHierarchyNodeText] phnt5
        on
            phn.[Product_L5_SubFamilyID] = phnt5.ProductHierarchyNode
            AND
            phnt5.[Language] = 'E' 
            -- and phnt5.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod  
