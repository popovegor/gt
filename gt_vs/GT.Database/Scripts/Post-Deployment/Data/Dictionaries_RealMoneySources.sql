

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_RealMoneySources]
                WHERE   [RealMoneySourceId] = 1 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_RealMoneySources]
                ( [RealMoneySourceId]
                , [Name]
                , [Description]
                )
        VALUES  ( 1
                , N'YandexMoney'
                , NULL
                )
    END 
ELSE 
    BEGIN 
        UPDATE  [dbo].[Dictionaries_RealMoneySources]
        SET     [Name] = N'YandexMoney'
    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_RealMoneySources]
                WHERE   [RealMoneySourceId] = 2 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_RealMoneySources]
                ( [RealMoneySourceId]
                , [Name]
                , [Description]
                , [Commission]
                )
        VALUES  ( 2
                , N'WebMoney'
                , NULL
                , 0.008
                )

    END 
    
ELSE 
    BEGIN
        UPDATE  [dbo].[Dictionaries_RealMoneySources]
        SET     [Commission] = 0.008
              , [Name] = N'WebMoney'
        WHERE   [RealMoneySourceId] = 2
    END 
