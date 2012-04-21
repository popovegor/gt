CREATE TABLE [dbo].[SiteMap]
    (
      [ID] INT NOT NULL
    , [Title] VARCHAR(512) NULL
    , [TitleRu] VARCHAR(512) NULL
    , [Description] VARCHAR(512) NULL
    , [DescriptionRU] VARCHAR(512) NULL
    , [Url] VARCHAR(512) NULL
    , [Roles] VARCHAR(512) NULL
    , [Parent] INT NULL
    , [TemplateName] VARCHAR(50) NULL
    , [JavaScript] VARCHAR(MAX) NULL
    , [KeyWords] NVARCHAR(500) NULL
    , [KeyWordsRu] NVARCHAR(500) NULL
    , [PageTitle] NVARCHAR(512) NULL
    , [PageTitleRu] NVARCHAR(512) NULL
    )

