
;MERGE INTO [dbo].[Dictionaries_TransactionPhases] AS t
    USING 
        ( SELECT    1 AS [TransactionPhaseId]
                  , N'Start' AS [Name]
                  , N'Поиск покупателя' AS [NameRu]
                  , N'Seller must select the buyer.' AS [Description]
                  , N'Объявление находится в начальной фазе выбора покупателя. Как только продавец определится с покупателем, начнется сделка.' AS [DescriptionRu]
          UNION
          SELECT    2 AS [TransactionPhaseId]
                  , N'Accept' AS [Name]
                  , N'Оплата товара' AS [NameRu]
                  , N'Buyer must pay for offer. Seller does not get money on this phase. Amount will freeze on buyers account.' AS [Description]
                  , N'Покупатель должен оплатить товар. Продавец на этой фазе денег не получает, требуемая сумма замораживается на счете покупателя, тем самым подтверждается его платежеспособность.' AS [DescriptionRu]
          UNION
          SELECT    3 AS [TransactionPhaseId]
                  , N'Submit' AS [Name]
                  , N'Передача товара' AS [NameRu]
                  , N'Seller must give goods to the buyer. Buyer must confirm reception.' AS [Description]
                  , N'Продавец должен передать товар покупателю, после чего покупатель обязан подтвердить факт получения товара. Продавец автоматически получает деньги за товар, сразу же после подтверждения. Для идентификации друг друга в компьютерной игре рекомендуется использовать код подтверждения. Покупатель называет продавцу код, указанный в сделке, после чего продавец проверяет его через интерфейс сделки.' AS [DescriptionRu]
          UNION
          SELECT    4 AS [TransactionPhaseId]
                  , N'Conflict' AS [Name]
                  , N'Конфликтная сделка' AS [NameRu]
                  , N'You must contact with administrator.' AS [Description]
                  , N'Необходимо срочно связаться с администрацией сервиса.' AS [DescriptionRu]
          UNION
          SELECT    5 AS [TransactionPhaseId]
                  , N'Finish' AS [Name]
                  , N'Сделка завершена' AS [NameRu]
                  , N'Offer completed.' AS [Description]
                  , N'Сделка завершена. Теперь ее можно удалить или оставить для истории.' AS [DescriptionRu]
          UNION
          SELECT    6 AS [TransactionPhaseId]
                  , N'Delete' AS [Name]
                  , N'Удалено' AS [NameRu]
                  , N'Offer deleted.' AS [Description]
                  , N'Сделка удалена.' AS [DescriptionRu]
        ) AS s
    ON ( t.[TransactionPhaseId] = s.[TransactionPhaseId] )
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
              [TransactionPhaseId]
            , [Name]
            , [NameRu]
            , [Description]
            , [DescriptionRu]
            )
          VALUES
            ( s.[TransactionPhaseId]
            , s.[Name]
            , s.[NameRu]
            , s.[Description]
            , s.[DescriptionRu]
            );
    --WHEN NOT MATCHED BY SOURCE 
        --THEN
  --DELETE ;

