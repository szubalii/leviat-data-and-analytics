CREATE PROC [edw].[sp_load_dim_ProductHierarchy] @t_jobId [varchar](36),
                                                 @t_jobDtm [datetime],
                                                 @t_lastActionCd [varchar](1),
                                                 @t_jobBy [nvarchar](128)
AS
BEGIN

    DECLARE @isTmpTableNotEmpty BIT = 0;
    DECLARE @errmessage NVARCHAR(2048);

    BEGIN TRY
	    IF OBJECT_ID('[edw].[dim_ProductHierarchy_tmp]') IS NOT NULL
		    DROP TABLE [edw].[dim_ProductHierarchy_tmp];

        CREATE TABLE [edw].[dim_ProductHierarchy_tmp]
        WITH
        (
            DISTRIBUTION = REPLICATE,
            HEAP
        )
        as select * from  [edw].[dim_ProductHierarchy] WHERE 1=0;

        INSERT INTO [edw].[dim_ProductHierarchy_tmp] ( [ProductHierarchyNode]
                                                 , [Product_L1_PillarID]
                                                 , [Product_L2_GroupID]
                                                 , [Product_L3_TypeID]
                                                 , [Product_L4_FamilyID]
                                                 , [Product_L5_SubFamilyID]

                                                 , [Product_L1_Pillar]
                                                 , [Product_L2_Group]
                                                 , [Product_L3_Type]
                                                 , [Product_L4_Family]
                                                 , [Product_L5_SubFamily]

                                                 , [t_applicationId]
                                                 , [t_jobId]
                                                 , [t_jobDtm]
                                                 , [t_lastActionCd]
                                                 , [t_jobBy])
        select phn.ProductHierarchyNode
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
             , @t_jobId                       AS t_jobId
             , @t_jobDtm                      AS t_jobDtm
             , @t_lastActionCd                AS t_lastActionCd
             , @t_jobBy                       AS t_jobBy
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
                 where MANDT = 200
        ) phn
        left JOIN
            [base_s4h_cax].[I_ProductHierarchyNodeText] phnt1
            on
                phn.[Product_L1_PillarID] = phnt1.ProductHierarchyNode
                AND
                phnt1.[Language] = 'E' and phnt1.MANDT = 200
        left JOIN
            [base_s4h_cax].[I_ProductHierarchyNodeText] phnt2
            on
                phn.[Product_L2_GroupID] = phnt2.ProductHierarchyNode
                AND
                phnt2.[Language] = 'E' and phnt2.MANDT = 200
        left JOIN
            [base_s4h_cax].[I_ProductHierarchyNodeText] phnt3
            on
                phn.[Product_L3_TypeID] = phnt3.ProductHierarchyNode
                AND
                phnt3.[Language] = 'E' and phnt3.MANDT = 200
        left JOIN
            [base_s4h_cax].[I_ProductHierarchyNodeText] phnt4
            on
                phn.[Product_L4_FamilyID] = phnt4.ProductHierarchyNode
                AND
                phnt4.[Language] = 'E' and phnt4.MANDT = 200
        left JOIN
            [base_s4h_cax].[I_ProductHierarchyNodeText] phnt5
            on
                phn.[Product_L5_SubFamilyID] = phnt5.ProductHierarchyNode
                AND
                phnt5.[Language] = 'E' and phnt5.MANDT = 200
        ;

        SELECT TOP 1 @isTmpTableNotEmpty = 1 FROM [edw].[dim_ProductHierarchy_tmp];

        IF (@isTmpTableNotEmpty = 1)
            BEGIN --TRY_CONVERT
                RENAME OBJECT [edw].[dim_ProductHierarchy] TO [dim_ProductHierarchy_old];
                RENAME OBJECT [edw].[dim_ProductHierarchy_tmp] TO [dim_ProductHierarchy];
                DROP TABLE [edw].[dim_ProductHierarchy_old];
            END;
        ELSE
            begin
                SET @errmessage = 'Temporary table dim_ProductHierarchy was not filled with data.';
                THROW 50001, @errmessage, 1;
            end;
    END TRY
    BEGIN CATCH
        SET @errmessage = 'Internal error in ' + ERROR_PROCEDURE() + '. ' +  ERROR_MESSAGE();
		THROW 50001, @errmessage, 1;
    END CATCH
END
GO
