CREATE VIEW [dm_sales].[vw_dim_QuoteStatus] AS

    SELECT [StatusObjectStatusID] as [Quote_StatusObjectStatusID]
         , [UserStatus]           as [Quote_UserStatus]
         , [UserStatusShort]      as [Quote_UserStatusShort]
         , [StatusProfile]        as [Quote_StatusProfile]
         , [StatusIsActive]       as [Quote_StatusIsActive]
         , [StatusIsInactive]     as [Quote_StatusIsInactive]
    FROM [edw].[dim_StatusObjectStatus]
    where [StatusProfile] = 'ZQUOTE'
      and [StatusIsActive] = 'X'
        and [StatusObjectStatusID] like '%0000'
