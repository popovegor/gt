CREATE TABLE [dbo].[Dictionaries_ProductCategories]
    (
      [ProductCategoryId] INT PRIMARY KEY
    , [Name] NVARCHAR(50) NOT NULL
    , [NameRu] NVARCHAR(50) NOT NULL
    , [Description] NVARCHAR(50) NULL
    , [DescriptionRu] NVARCHAR(50) NULL
    , [OrderBy] int
    )
