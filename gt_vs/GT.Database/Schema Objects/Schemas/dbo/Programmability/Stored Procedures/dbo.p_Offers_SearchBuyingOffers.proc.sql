CREATE PROCEDURE [dbo].[p_Offers_SearchBuyingOffers] @Filter XML
AS 
    BEGIN
    
        DECLARE @GameName NVARCHAR(200) = @Filter.value('(/sf/@gn)[1]', 'nvarchar(200)')
          , @GameServerName NVARCHAR(200) = @Filter.value('(/sf/@gsn)[1]', 'nvarchar(200)')
          , @Title NVARCHAR(200) = @Filter.value('(/sf/@t)[1]', 'nvarchar(200)')
          , @Description NVARCHAR(200) = @Filter.value('(/sf/@d)[1]', 'nvarchar(200)')
          , @GameId INT = NULLIF(@Filter.value('(/sf/@gid)[1]', 'int'), 0)
          , @GameServerId INT = NULLIF(@Filter.value('(/sf/@gsid)[1]', 'int'), 0)
          , @UserId UNIQUEIDENTIFIER = NULLIF(@Filter.value('(/sf/@u)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @ProductCategoryId int = NULLIF(@Filter.value('(/sf/@productCategory)[1]', 'int'), 0)
         
    
        SET NOCOUNT ON ;
	
        DECLARE @Offers udtt_Offers
	
        INSERT  INTO @Offers
                ( OfferId
                , RowNumber
                )
                SELECT  o.[BuyingOfferId]
                      , ROW_NUMBER() OVER ( ORDER BY ISNULL(o.[UpdateDate], o.[CreateDate]) DESC )
                FROM    [dbo].[Offers_Buying] AS o
                INNER JOIN aspnet_Users AS u ON u.UserId = o.BuyerId
                INNER JOIN [Dictionaries_GameServers] AS gs ON gs.GameServerId = o.GameServerId
                INNER JOIN [Dictionaries_Games] AS g ON g.GameId = gs.GameId
                WHERE   ( ISNULL(@GameServerName, ISNULL(@GameName, ISNULL(@Title, ISNULL(@Description, @Description)))) IS NULL
                          OR ( @GameName IS NOT NULL
                               AND ( g.Name LIKE '%' + @GameName + '%'
                                     OR g.[NameRu] LIKE '%' + @GameName + '%'
                                   )
                             )
                          OR ( @GameServerName IS NOT NULL
                               AND ( gs.Name LIKE '%' + @GameServerName + '%'
                                     OR gs.NameRu LIKE '%' + @GameServerName + '%'
                                   )
                             )
                          OR ( @Title IS NOT NULL
                               AND o.Title LIKE '%' + @Title + '%'
                             )
                          OR ( @Description IS NOT NULL
                               AND o.[Description] LIKE '%' + @Description + '%'
                             )
                        )
                        AND ( @GameId IS NULL
                              OR @GameId = gs.GameId
                            )
                        AND ( @GameServerId IS NULL
                              OR @GameServerId = gs.GameServerId
                            )
                        AND ( @UserId IS NULL
                              OR @UserId = u.UserId
                            )
                         AND (@ProductCategoryId IS NULL
                          OR o.ProductCategoryId IS NULL OR @ProductCategoryId = o.ProductCategoryId)
    
        EXEC [p_Offers_GetBuyingOffersInternal] @BuyingOffers = @Offers

    END


