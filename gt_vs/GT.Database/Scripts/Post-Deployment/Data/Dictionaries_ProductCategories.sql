
;
MERGE INTO [dbo].[Dictionaries_ProductCategories] AS t
    USING 
        ( SELECT    1 AS [ProductCategoryId]
                  , N'Character' AS [Name]
                  , N'Персонаж' AS [NameRu]
                  , N'' AS [Description]
                  , N'' AS [DescriptionRu]
                  , 1 AS [OrderBy]
          UNION
          SELECT    2 AS [ProductCategoryId]
                  , N'Game currency' AS [Name]
                  , N'Игровая валюта' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
                  , 2 AS [OrderBy]
          UNION
          SELECT    3 AS [ProductCategoryId]
                  , N'Armory' AS [Name]
                  , N'Игровые вещи' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
                  , 3 AS [OrderBy]
           UNION
          SELECT    4 AS [ProductCategoryId]
                  , N'Misc' AS [Name]
                  , N'Другое' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
                  , 4 AS [OrderBy]
        ) AS s
    ON ( t.[ProductCategoryId] = s.[ProductCategoryId] )
    WHEN MATCHED 
        THEN 
  UPDATE  SET
            t.[Name] = s.[Name]
          , t.[NameRu] = s.[NameRu]
          , t.[Description] = s.[Description]
          , t.[DescriptionRu] = s.[DescriptionRu]
          , t.[OrderBy] = s.[OrderBy]
    WHEN NOT MATCHED BY TARGET 
        THEN 
  INSERT    (
              [ProductCategoryId]
            , [Name]
            , [NameRu]
            , [Description]
            , [DescriptionRu]
            , [OrderBy]
            )
          VALUES
            ( s.[ProductCategoryId]
            , s.[Name]
            , s.[NameRu]
            , s.[Description]
            , s.[DescriptionRu]
            , s.[OrderBy]
            ) ;
--WHEN NOT MATCHED BY SOURCE THEN
  --DELETE;

