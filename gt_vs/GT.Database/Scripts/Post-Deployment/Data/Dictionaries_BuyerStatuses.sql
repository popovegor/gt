
;
MERGE INTO [dbo].[Dictionaries_BuyerStatuses] AS t
    USING 
        ( SELECT    1 AS [BuyerStatusId]
                  , N'Activate' AS [Name]
                  , N'Активный' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
          UNION
          SELECT    2 AS [BuyerStatusId]
                  , N'Refused' AS [Name]
                  , N'Отказано' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
          UNION
          SELECT    3 AS [BuyerStatusId]
                  , N'Abandoned' AS [Name]
                  , N'Отказавшийся' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
          UNION
          SELECT    4 AS [BuyerStatusId]
                  , N'Accepted' AS [Name]
                  , N'Принятый' AS [NameRu]
                  , NULL AS [Description]
                  , NULL AS [DescriptionRu]
        ) AS s
    ON ( t.[BuyerStatusId] = s.[BuyerStatusId] )
    WHEN MATCHED 
        THEN 
  UPDATE  SET
            t.[Name] = s.[Name]
          , t.[NameRu] = s.[NameRu]
          , t.[Description] = s.[Description]
          , t.[DescriptionRu] = s.[DescriptionRu]
    WHEN NOT MATCHED BY TARGET 
        THEN 
  INSERT    (
              [BuyerStatusId]
            , [Name]
            , [NameRu]
            , [Description]
            , [DescriptionRu]
            )
          VALUES
            ( s.[BuyerStatusId]
            , s.[Name]
            , s.[NameRu]
            , s.[Description]
            , s.[DescriptionRu]
            )
    WHEN NOT MATCHED BY SOURCE 
        THEN
  DELETE ;

