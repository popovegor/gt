MERGE INTO [dbo].[Dictionaries_FeedbackTypes] AS t
    USING 
        ( SELECT    2 AS [FeedbackTypeId]
                  , N'Positive' AS [Name]
                  , N'Положительная' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
          UNION
          SELECT    3 AS [FeedbackTypeId]
                  , N'Neutral' AS [Name]
                  , N'Нейтральная' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
          UNION
          SELECT    1 AS [FeedbackTypeId]
                  , N'Negative' AS [Name]
                  , N'Отрицательная' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
        ) AS s
    ON t.[FeedbackTypeId] = s.[FeedbackTypeId]
    WHEN MATCHED 
        THEN UPDATE
          SET       t.Name = s.Name
                  , t.NameRu = s.NameRu
                  , t.Description = s.Description
                  , t.DescriptionRu = s.DescriptionRu
    WHEN NOT MATCHED BY TARGET 
        THEN 
			INSERT    (
                              [FeedbackTypeId]
                            , [Name]
                            , [NameRu]
                            , Description
                            , DescriptionRu
                            )
          VALUES            ( s.[FeedbackTypeId]
                            , s.[Name]
                            , s.[NameRu]
                            , s.[Description]
                            , s.[DescriptionRu]
                            )
    WHEN NOT MATCHED BY SOURCE 
        THEN
      DELETE ;