/****** Object:  Table [dbo].[GameServers]    Script Date: 12/11/2009 01:18:06 ******/
SET IDENTITY_INSERT [dbo].[Dictionaries_GameServers] ON


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 1 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 1
                , 1
                , N'wow-europe.com Азурегос'
                , N'wow-europe.com Азурегос'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009B0E00C2BA64 AS DATETIME)
                , CAST(0x0000000200000000 AS DATETIME)
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 2 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 2
                , 1
                , N'wow-europe.com Борейская тундра'
                , N'wow-europe.com Борейская тундра'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009B0E00C2BA64 AS DATETIME)
                , CAST(0x0000000200000000 AS DATETIME)
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 3 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 3
                , 1
                , N'wow-europe.com Вечная Песня'
                , N'wow-europe.com Вечная Песня'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009B0E00C2BA64 AS DATETIME)
                , CAST(0x0000000200000000 AS DATETIME)
                , N'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 4 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 4
                , 1
                , N'wow-europe.com Галакронд'
                , N'wow-europe.com Галакронд'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009B0E00C2BA64 AS DATETIME)
                , CAST(0x0000000200000000 AS DATETIME)
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 5 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 5
                , 1
                , N'wow-europe.com Aerie Peak'
                , N'wow-europe.com Aerie Peak'
                , N'Official english europe server.'
                , N'Официальный англоязычный сервер европы.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 6 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 6
                , 1
                , N'wow-europe.com Гордунни'
                , N'wow-europe.com Гордунни'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 7 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 7
                , 1
                , N'wow-europe.com Гром'
                , N'wow-europe.com Гром'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 8 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 8
                , 1
                , N'wow-europe.com Дракономор'
                , N'wow-europe.com Дракономор'
                , N'Official russian europe server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 9 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 9
                , 1
                , N'wow-europe.com Король-лич'
                , N'wow-europe.com Король-лич'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 10 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 10
                , 1
                , N'wow-europe.com Пиратская бухта'
                , N'wow-europe.com Пиратская бухта'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 12 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 12
                , 1
                , N'wow-europe.com Das Syndikat'
                , N'wow-europe.com Das Syndikat'
                , N'Official europe server.'
                , N'Официальный сервер европы.'
                , CAST(0x00009C5F017CF5C3 AS DATETIME)
                , NULL
                , 'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 13 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 13
                , 1
                , N'Isengard Tirion'
                , N'Isengard Tirion'
                , N'Not official russian server. Rates - x2. Online about 2000 players.'
                , N'Неофициальный русский сервер. Рейты x2.  Онлайн в среднем 2000 игроков. Донат отсутствует.'
                , CAST(0x00009C5F017E3DD5 AS DATETIME)
                , NULL
                , N'http://www.isengard.ru/'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 14 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 14
                , 1
                , N'Isengard QRSK'
                , N'Isengard QRSK'
                , N'Not official russian PvP server. Rates - Fun. Online about 1000 players.'
                , N'Неофициальный русский PvP сервер. Рейты - Fun.  Онлайн в среднем 1000 игроков. Донат присутствует.'
                , CAST(0x00009C5F017EBA82 AS DATETIME)
                , NULL
                , N'http://www.isengard.ru/'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 15 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 15
                , 2
                , N'la2.raid.ru Pangea'
                , N'la2.raid.ru Pangea'
                , N'Not official russian server. Rates - x3. Online about 500 players.'
                , N'Неофициальный русский сервер. Онлайн в среднем 500 игроков. Рейты x3.'
                , CAST(0x00009C5F017F0F86 AS DATETIME)
                , NULL
                , N'http://la2.raid.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 16 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 16
                , 2
                , N'la2.raid.ru Raid II'
                , N'la2.raid.ru Raid II'
                , N'Not official russian server. Rates - x5. Online about 1500 players.'
                , N'Неофициальный русский сервер. Онлайн в среднем 1500 игроков. Рейты x5.'
                , CAST(0x00009C5F017F265B AS DATETIME)
                , NULL
                , N'http://la2.raid.ru'
                )


    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 17 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 17
                , 2
                , N'la2.raid.ru Raid III'
                , N'la2.raid.ru Raid III'
                , N'Not official russian server. Rates - x5. Online about 800 players.'
                , N'Неофициальный русский сервер. Онлайн в среднем 800 игроков. Рейты x5.'
                , CAST(0x00009C5F017F3467 AS DATETIME)
                , NULL
                , N'http://la2.raid.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 18 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 18
                , 2
                , N'la2.raid.ru Raid IV'
                , N'la2.raid.ru Raid IV'
                , N'Not official russian server. Rates - x10. Online about 800 players.'
                , N'Неофициальный русский сервер. Онлайн в среднем 800 игроков. Рейты x10.'
                , CAST(0x00009C5F017F4120 AS DATETIME)
                , NULL
                , N'http://la2.raid.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 19 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 19
                , 3
                , N'Official server combats.ru'
                , N'Официальный сервер Бойцовский клуб combats.ru'
                , N'Official server combats.ru'
                , N'Официальный сервер Бойцовский клуб combats.ru'
                , CAST(0x00009C5F017F8B57 AS DATETIME)
                , NULL
                , N'http://combats.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 20 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 20
                , 4
                , N'allods.ru Сумерки Богов'
                , N'allods.ru Сумерки Богов'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 21 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 21
                , 5
                , N'pwonline.ru Orion'
                , N'pwonline.ru Орион'
                , N'Official russian server. It is the most popular server at pwonline.ru (about 90% loading) '
                , N'Официальный русский сервер. Является наиболее популярным и густо населенным на pwonline.ru Средняя загрузка сервера достигает 80%'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 22 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 22
                , 1
                , N'wow-europe.com Подземье'
                , N'wow-europe.com Подземье'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 23 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 23
                , 1
                , N'wow-europe.com Разувий'
                , N'wow-europe.com Разувий'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 24 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 24
                , 1
                , N'wow-europe.com Ревущий фьорд'
                , N'wow-europe.com Ревущий фьорд'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 25 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 25
                , 1
                , N'wow-europe.com Свежеватель Душ'
                , N'wow-europe.com Свежеватель Душ'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 26 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 26
                , 1
                , N'wow-europe.com Седогрив'
                , N'wow-europe.com Седогрив'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 27 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 27
                , 1
                , N'wow-europe.com Страж смерти'
                , N'wow-europe.com Страж смерти'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 28 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 28
                , 1
                , N'wow-europe.com Термоштепсель'
                , N'wow-europe.com Термоштепсель'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 29 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 29
                , 1
                , N'wow-europe.com Ткач Смерти'
                , N'wow-europe.com Ткач Смерти'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 30 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 30
                , 1
                , N'wow-europe.com Черный Шрам'
                , N'wow-europe.com Черный Шрам'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 31 ) 
    BEGIN 

        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 31
                , 1
                , N'wow-europe.com Ясеневый лес'
                , N'wow-europe.com Ясеневый лес'
                , N'Official russian europe PvP server.'
                , N'Официальный русский PvP сервер.'
                , CAST(0x00009C5F017C8263 AS DATETIME)
                , NULL
                , N'http://www.wow-europe.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 32 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 32
                , 4
                , N'allods.ru Вечный Зов'
                , N'allods.ru Вечный Зов'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 33 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 33
                , 4
                , N'allods.ru Владыки Астрала'
                , N'allods.ru Владыки Астрала'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 34 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 34
                , 4
                , N'allods.ru Горн Войны'
                , N'allods.ru Горн Войны'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 35 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 35
                , 4
                , N'allods.ru Молодая Гвардия'
                , N'allods.ru Молодая Гвардия'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 36 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 36
                , 4
                , N'allods.ru Последний Рубеж'
                , N'allods.ru Последний Рубеж'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 37 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 37
                , 4
                , N'allods.ru Раскол'
                , N'allods.ru Раскол'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 38 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 38
                , 2
                , N'l2.ru Airin'
                , N'l2.ru Айрин'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 39 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 39
                , 2
                , N'l2.ru Atlant'
                , N'l2.ru Атлант'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 40 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 40
                , 2
                , N'l2.ru Desperion'
                , N'l2.ru Десперион'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 41 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 41
                , 2
                , N'l2.ru Vasper'
                , N'l2.ru Васпер'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 42 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 42
                , 2
                , N'l2.ru Wayrel'
                , N'l2.ru Уэйтрел'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 43 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 43
                , 2
                , N'l2.ru Faris'
                , N'l2.ru Фарис'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 44 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 44
                , 2
                , N'l2.ru Lancer'
                , N'l2.ru Лансер'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 45 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 45
                , 2
                , N'l2.ru Athebaldt'
                , N'l2.ru Атебальт'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 46 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 46
                , 2
                , N'l2.ru Ramsheart'
                , N'l2.ru Рамсхарт'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 47 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 47
                , 2
                , N'l2.ru Esthus'
                , N'l2.ru Эстус'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 48 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 48
                , 2
                , N'l2.ru BlackBird'
                , N'l2.ru Блекберд'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 49 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 49
                , 2
                , N'l2.ru Cadmus'
                , N'l2.ru Кадмус'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 50 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 50
                , 5
                , N'pwonline.ru Антарес'
                , N'pwonline.ru Антарес'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 51 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 51
                , 5
                , N'pwonline.ru Пегас'
                , N'pwonline.ru Пегас'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 52 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 52
                , 5
                , N'pwonline.ru Астра'
                , N'pwonline.ru Астра'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 53 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 53
                , 5
                , N'pwonline.ru Процион'
                , N'pwonline.ru Процион'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 54 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 54
                , 5
                , N'pwonline.ru Альтаир'
                , N'pwonline.ru Альтаир'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 55 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 55
                , 5
                , N'pwonline.ru Таразед'
                , N'pwonline.ru Таразед'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 56 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 56
                , 5
                , N'pwonline.ru Мира'
                , N'pwonline.ru Мира'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 57 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 57
                , 5
                , N'pwonline.ru Сириус'
                , N'pwonline.ru Сириус'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 58 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 58
                , 5
                , N'pwonline.ru Вега'
                , N'pwonline.ru Вега'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://pwonline.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 59 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 59
                , 6
                , N'dwar.ru ФЭО-Прайм'
                , N'dwar.ru ФЭО-Прайм'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://dwar.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 60 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 60
                , 6
                , N'dwar.ru ФЭО-Минор'
                , N'dwar.ru ФЭО-Минор'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://dwar.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 61 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 61
                , 6
                , N'dwar.ru ФЭО-Медиант'
                , N'dwar.ru ФЭО-Медиант'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://dwar.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 62 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 62
                , 6
                , N'warofdragons.com'
                , N'warofdragons.com'
                , N'Official english server.'
                , N'Официальный английский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://warofdragons.com'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 63 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 63
                , 7
                , N'Official server EVE Online'
                , N'Официальный сервер EVE Online'
                , N'Official international server.'
                , N'Официальный международный сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://www.eveonline.com'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 64 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 64
                , 8
                , N'Official russian server'
                , N'Официальный русский сервер ГВД'
                , N'Official russian server.'
                , N'Официальный русский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://heroeswm.ru'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 65 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 65
                , 8
                , N'Official english server'
                , N'Официальный английский сервер'
                , N'Official english server.'
                , N'Официальный английский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://www.lordswm.com/'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 66 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 66
                , 9
                , N'rfonline.ru Азурия'
                , N'rfonline.ru Азурия'
                , N'Official russian server.'
                , N'Самый молодой сервер на сегодняшний день, он начал свою работу 10 марта 2008 года. Акретия доминирующая раса на сервере. На ЧВ образуются союзы между Акретией и Белато. Альянсы на ЭПБ образуются из 2-х гильдий с каждой расы.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 67 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 67
                , 9
                , N'rfonline.ru Асу'
                , N'rfonline.ru Асу'
                , N'Official russian server.'
                , N'Сервер был открыт 12 февраля 2007 года. Доминирующая раса на сервере: Акретия. Чип Вары проходят с участие всех трех рас. Раса, выигравшая на предыдущем ЧВ, сражается с союзом других двух рас. Также существуют союзы между сильнейшими гильдиями. Это делается для того, чтобы ходить на Пит Босов Элан и проходить в новые локации. Регулируется по дням, одни союзы гильдий ходят по четным дням, другие по нечетным.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 68 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 68
                , 9
                , N'rfonline.ru Катан'
                , N'rfonline.ru Катан'
                , N'Official russian server.'
                , N'Сервер работает с 24 декабря 2007 года. На этом сервере полностью доминирует раса Кора, как в количественно, так и в качественном отношении. Все ЧВ, за редким исключением, побеждают представители расы Кора. Официальных союзов между расами не существует, однако на ЧВ и в прочие игровые моменты представители рас Белато и Акретии проявляют солидарность по отношению друг к другу и совместно противостоят игрокам расы Кора.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 
  
  
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 69 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 69
                , 9
                , N'rfonline.ru Фалгон'
                , N'rfonline.ru Фалгон'
                , N'Official russian server.'
                , N'Сервер был открыт 22 января 2007 года. На данный момент доминирует раса Кора, но четкой закономерности нет. Акретия самая сплоченная раса на сервере на данный момент. Альянсы на ЭПБ есть у всех рас.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 
  

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 70 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 70
                , 9
                , N'rfonline.ru Аномия'
                , N'rfonline.ru Аномия'
                , N'Official russian server.'
                , N'Также как и Фальгон сервер работает с 22 января 2007 года. Здесь обратная ситуация: на сегодняшний день доминирует раса Белато. Самая сплоченная также Белато. Альянс гильдий MGS и Титьки регулярно ходит на ЭПБ.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 71 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 71
                , 9
                , N'rfonline.ru Новус'
                , N'rfonline.ru Новус'
                , N'Official russian server.'
                , N'Первый Сервер RF Online Россия, открыт 16 января 2007 года. Доминирующая раса: Акретия. Самая сплоченная раса Белато. Альянсы на ЭПБ есть у всех рас, Белато ходят на них даже одной гильдией.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 

    
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 72 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 72
                , 9
                , N'rfonline.ru Триан'
                , N'rfonline.ru Триан'
                , N'Official russian server.'
                , N'Работает со 2 августа 2007 года. Доминирует раса Кора. Самой сплоченной расой на сервере считается раса Белато.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END    


 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 73 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 73
                , 9
                , N'rfonline.ru Бекар'
                , N'rfonline.ru Бекар'
                , N'Official russian server.'
                , N'Сервер был открыт 10 декабря 2007 года. Доминирует раса Кора. На данный момент существует союз между Акретией и Белато. При этом главная гильдия Акретии Gerodian состоит в союзе с расой Кора для смены патриархата.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://rfonline.ru/'
                )

    END 
    
    
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 74 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 74
                , 9
                , N'playrf.com Letorn'
                , N'playrf.com Letorn'
                , N'Official international server.'
                , N'Официальный международный сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://playrf.com/'
                )

    END     


 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 75 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 75
                , 9
                , N'playrf.com Chaos'
                , N'playrf.com Chaos'
                , N'Official international server.'
                , N'Официальный международный сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://playrf.com/'
                )

    END 
    

 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 76 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 76
                , 9
                , N'playrf.com Sparta'
                , N'playrf.com Sparta'
                , N'Official international server.'
                , N'Официальный международный сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://playrf.com/'
                )

    END 


 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 77 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 77
                , 10
                , N'aion.ru Гардарика'
                , N'aion.ru Гардарика'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://aion.ru/'
                )

    END 


IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 78 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 78
                , 10
                , N'aion.ru Кассиэль'
                , N'aion.ru Кассиэль'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://aion.ru/'
                )

    END 
    
    
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 79 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 79
                , 10
                , N'aion.ru Делика'
                , N'aion.ru Делика'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://aion.ru/'
                )

    END     
    
    
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 80 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 80
                , 10
                , N'aion.ru Лантис'
                , N'aion.ru Лантис'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://aion.ru/'
                )

    END     
    
    
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 81 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 81
                , 10
                , N'aion.ru Териос'
                , N'aion.ru Териос'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://aion.ru/'
                )

    END     
    
    
    IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 82 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 82
                , 11
                , N'ganjawars.ru'
                , N'ganjawars.ru'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://ganjawars.ru/'
                )

    END  
    
    
    IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 83 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 83
                , 12
                , N'gladiators.ru Russian Server'
                , N'gladiators.ru Русский Сервер'
                , N'Official russian server.'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://www.gladiators.ru/'
                )

    END  
    
    
    IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 84 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 84
                , 12
                , N'gladiators.ru English Server'
                , N'gladiators.ru Английский Сервер'
                , N'Official english server.'
                , N'Официальный английский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://www.gladiators.ru/'
                )

    END      
    
  
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 85 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 85
                , 4
                , N'EU-ISA'
                , N'EU-ISA'
                , N'Official europe server.'
                , N'Официальный европейский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://en.allods.gpotato.eu'
                )

    END   

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 86 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 86
                , 4
                , N'EU-ZAK'
                , N'EU-ZAK'
                , N'Official europe server.'
                , N'Официальный европейский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://en.allods.gpotato.eu'
                )

    END    
    
  
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 87 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 87
                , 4
                , N'DE-ARO'
                , N'DE-ARO'
                , N'Official deutch server.'
                , N'Официальный немецкий сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://de.allods.gpotato.eu'
                )

    END     
    
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 88 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 88
                , 4
                , N'FR-Airin'
                , N'FR-Airin'
                , N'Official french server.'
                , N'Официальный французский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://fr.allods.gpotato.eu'
                )

    END     
 
 
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 89 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 89
                , 4
                , N'FR-Vlad'
                , N'FR-Vlad'
                , N'Official french server.'
                , N'Официальный французский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://fr.allods.gpotato.eu'
                )

    END     
 
 
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 90 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 90
                , 4
                , N'US-Nezeb'
                , N'US-Nezeb'
                , N'Official american server.'
                , N'Официальный американский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.gpotato.com'
                )

    END 
 
 
  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 91 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 91
                , 4
                , N'US-Tensess'
                , N'US-Tensess'
                , N'Official american server.'
                , N'Официальный американский сервер.'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://allods.gpotato.com'
                )

    END 
 
 
   IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 92 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 92
                , 2
                , N'bsfg.ru BSFG 2'
                , N'bsfg.ru BSFG 2'
                , N'Battles For Glory 2'
                , N'Battles For Glory 2'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://bsfg.ru'
                )

    END 
 
 
 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 93 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 93
                , 2
                , N'deiceland.org DeIceLand'
                , N'deiceland.org DeIceLand'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://deiceland.org'
                )

    END 


 IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 95 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 95
                , 2
                , N'asterios.tm Prime'
                , N'asterios.tm Prime'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://asterios.tm'
                )

    END 


  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 96 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 96
                , 2
                , N'asterios.tm Asterios'
                , N'asterios.tm Asterios'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://asterios.tm'
                )

    END 
    
    
  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 97 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 97
                , 2
                , N'asterios.tm Hardin'
                , N'asterios.tm Hardin'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://asterios.tm'
                )

    END    
  
  
  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 98 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 98
                , 2
                , N'asterios.tm Argos'
                , N'asterios.tm Argos'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://asterios.tm'
                )

    END   
  
 
  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 99 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 99
                , 2
                , N'asterios.tm Hunter'
                , N'asterios.tm Hunter'
                , N'Not official russian server'
                , N'Неофициальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://asterios.tm'
                )

    END    
    

  IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[Dictionaries_GameServers]
                WHERE   [GameServerId] = 100 ) 
    BEGIN 
        INSERT  [dbo].[Dictionaries_GameServers]
                ( [GameServerId]
                , [GameId]
                , [Name]
                , [NameRu]
                , [Description]
                , [DescriptionRu]
                , [CreateDateTime]
                , [UpdateDateTime]
                , [Url]
                )
        VALUES  ( 100
                , 2
                , N'l2.ru Van Holter'
                , N'l2.ru Ван Холтер'
                , N'Official russian server'
                , N'Официальный русский сервер'
                , CAST(0x00009C5F017FFA07 AS DATETIME)
                , NULL
                , N'http://l2.ru'
                )

    END 

 
SET IDENTITY_INSERT [dbo].[Dictionaries_GameServers] OFF
