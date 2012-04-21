-- =============================================
-- Author:		E.Popov
-- Create date: 15 Aug 2008
-- Description:	get the dictionaries
-- =============================================
CREATE PROCEDURE [dbo].[p_Dictionaries_GetAll]
AS 
    BEGIN
        SELECT  [dbo].[Dictionaries_Games].[GameId]
              , [dbo].[Dictionaries_Games].[Name]
              , [dbo].[Dictionaries_Games].[NameRu]
              , [dbo].[Dictionaries_Games].[Description]
              , [dbo].[Dictionaries_Games].[DescriptionRu]
              , [dbo].[Dictionaries_Games].[CreateDateTime]
              , [dbo].[Dictionaries_Games].[UpdateDateTime]
              , [dbo].[Dictionaries_Games].[Url]
              , [dbo].[Dictionaries_Games].[Priority]
        FROM    [dbo].[Dictionaries_Games]
  
        SELECT  [dbo].[Dictionaries_GameServers].[GameServerId]
              , [dbo].[Dictionaries_GameServers].[GameId]
              , [dbo].[Dictionaries_GameServers].[Name]
              , [dbo].[Dictionaries_GameServers].[NameRu]
              , [dbo].[Dictionaries_GameServers].[Description]
              , [dbo].[Dictionaries_GameServers].[DescriptionRu]
              , [dbo].[Dictionaries_GameServers].[CreateDateTime]
              , [dbo].[Dictionaries_GameServers].[UpdateDateTime]
              , [dbo].[Dictionaries_GameServers].[Url]
        FROM    [dbo].[Dictionaries_GameServers]
        
        SELECT  tp.[TransactionPhaseId]
              , tp.[Description]
              , tp.[DescriptionRu]
              , tp.[Name]
              , tp.[NameRu]
        FROM    [Dictionaries_TransactionPhases] AS tp
        
        SELECT  bs.[BuyerStatusId]
              , bs.[Name]
              , bs.[NameRu]
              , bs.[Description]
              , bs.[DescriptionRu]
        FROM    [Dictionaries_BuyerStatuses] AS bs
        
        
        SELECT  rms.[RealMoneySourceId]
              , rms.[Name]
              , rms.[Description]
              , rms.[Commission]
              , rms.[OurCommission]
              , rms.[MinTransferAmount]
        FROM    dbo.[Dictionaries_RealMoneySources] AS rms
        
        SELECT  vt.FeedbackTypeId
              , vt.Name
              , vt.NameRu
              , vt.[Description]
              , vt.[DescriptionRu]
        FROM    dbo.Dictionaries_FeedbackTypes AS vt
        
        
        SELECT  [MessageTemplateId]
              , [Subject]
              , [SubjectRu]
              , [Body]
              , [BodyRu]
        FROM    dbo.[Dictionaries_MessageTemplates]
        
        SELECT  [TransferStatusId]
              , [Name]
              , [NameRu]
              , [Description]
              , [DescriptionRu]
        FROM    dbo.[Dictionaries_TransferStatuses]
        
        SELECT  [TimeZoneId]
              , [DotNetTimeZoneId]
              , [Name]
              , [NameRu]
              , [Offset]
        FROM    [dbo].[Dictionaries_TimeZones]
        
        SELECT  [WebMoneyMessageId]
              , [Message]
              , [MessageRu]
              , [Retcode]
              , [Type]
              , [Description]
        FROM    [dbo].[Dictionaries_WebMoneyMessages]
        
        SELECT  [WebMoneyMessageTypeId]
              , [Name]
              , [Description]
        FROM    [dbo].[Dictionaries_WebMoneyMessagesTypes]
        
        SELECT  [ProductCategoryId]
              , [Name]
              , [NameRu]
              , [Description]
              , [DescriptionRu]
              , [OrderBy]
        FROM    [dbo].[Dictionaries_ProductCategories]
        ORDER BY [OrderBy] ASC
        
    END