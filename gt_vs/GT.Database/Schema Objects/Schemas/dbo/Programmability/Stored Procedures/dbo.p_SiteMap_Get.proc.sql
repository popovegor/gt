-- =============================================
-- Author:		E.Popov
-- Create date: 13.07.2008
-- Description:	get all sitemap nodes
-- =============================================
CREATE PROCEDURE [dbo].[p_SiteMap_Get]
AS 
    BEGIN

        SELECT  [dbo].[SiteMap].[ID]
              , [dbo].[SiteMap].[Title]
              , [dbo].[SiteMap].[TitleRu]
              , [dbo].[SiteMap].[Description]
              , [dbo].[SiteMap].[DescriptionRu]
              , [dbo].[SiteMap].[Url]
              , [dbo].[SiteMap].[Roles]
              , [dbo].[SiteMap].[Parent]
              , [dbo].[SiteMap].[TemplateName]
              , [dbo].[SiteMap].[JavaScript]
              , [dbo].[SiteMap].[KeyWords]
              , [dbo].[SiteMap].[KeyWordsRu]
              , [dbo].[SiteMap].[PageTitle]
              , [dbo].[SiteMap].[PageTitleRu]
              , CAST(1 AS BIT) AS Display
        FROM    [dbo].[SiteMap]
        ORDER BY [dbo].[SiteMap].[ID]

        SELECT  [dbo].[SiteMapNodeRemapping].NodeID
              , [dbo].[SiteMapNodeRemapping].ThemeName
              , [dbo].[SiteMapNodeRemapping].Display
              , [dbo].[SiteMapNodeRemapping].ChildNodesIndex
        FROM    [dbo].[SiteMapNodeRemapping]

    END
