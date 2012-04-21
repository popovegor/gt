MERGE INTO [dbo].[Dictionaries_TransferStatuses] AS t
    USING 
        ( SELECT    4 AS [TransferStatusId]
                  , N'Refused' AS [Name]
                  , N'Отклонен' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
          UNION
          SELECT    3 AS [TransferStatusId]
                  , N'Canceled' AS [Name]
                  , N'Отменен' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
          UNION
          SELECT    2 AS [TransferStatusId]
                  , N'Pending' AS [Name]
                  , N'В ожидании' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
          UNION
          SELECT    1 AS [TransferStatusId]
                  , N'Completed' AS [Name]
                  , N'Завершен' AS [NameRu]
                  , N'' AS Description
                  , N'' AS DescriptionRu
        ) AS s
    ON t.[TransferStatusId] = s.[TransferStatusId]
    WHEN MATCHED 
        THEN UPDATE
          SET       t.Name = s.Name
                  , t.NameRu = s.NameRu
                  , t.Description = s.Description
                  , t.DescriptionRu = s.DescriptionRu
    WHEN NOT MATCHED BY TARGET 
        THEN 
			INSERT    (
                              [TransferStatusId]
                            , [Name]
                            , [NameRu]
                            , Description
                            , DescriptionRu
                            )
          VALUES            ( s.[TransferStatusId]
                            , s.[Name]
                            , s.[NameRu]
                            , s.[Description]
                            , s.[DescriptionRu]
                            )
    WHEN NOT MATCHED BY SOURCE 
        THEN
      DELETE ;