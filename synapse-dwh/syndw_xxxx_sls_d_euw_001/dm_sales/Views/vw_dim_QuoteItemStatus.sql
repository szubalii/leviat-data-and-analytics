CREATE VIEW [dm_sales].[vw_dim_QuoteItemStatus] AS

    SELECT [StatusObjectStatusID] as [QuoteItem_StatusObjectStatusID]
         , [UserStatus]           as [QuoteItem_UserStatus]
         , [UserStatusShort]      as [QuoteItem_UserStatusShort]
         , [StatusProfile]        as [QuoteItem_StatusProfile]
         , [StatusIsActive]       as [QuoteItem_StatusIsActive]
         , [StatusIsInactive]     as [QuoteItem_StatusIsInactive]
    FROM [edw].[dim_StatusObjectStatus]
    where [StatusProfile] = 'ZQUOTE'
      and [StatusIsActive] = 'X'
      and [StatusObjectStatusID] not like '%0000'