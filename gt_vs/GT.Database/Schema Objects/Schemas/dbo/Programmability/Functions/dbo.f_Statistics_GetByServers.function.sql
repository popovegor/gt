-- =============================================
-- Author:		E.Popov
-- Create date: 2010-11-26
-- Description:	get statistics info by servers
-- =============================================
CREATE FUNCTION f_Statistics_GetByServers
    (
      @ServerId INT = -1
    , @GameId INT = -1
    )
RETURNS TABLE
AS
RETURN
    ( SELECT    gs.[GameId]
              , gs.[GameServerId]
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Buying] AS b
                  WHERE     b.[GameServerId] = gs.GameServerId
                ) AS BuyingTotal
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Buying] AS b
                  WHERE     b.[GameServerId] = gs.GameServerId
                            AND b.ProductCategoryId = 1
                ) AS BuyingCharacter
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Buying] AS b
                  WHERE     b.[GameServerId] = gs.GameServerId
                            AND b.ProductCategoryId = 3
                ) AS BuyingArmory
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Buying] AS b
                  WHERE     b.[GameServerId] = gs.GameServerId
                            AND b.ProductCategoryId = 2
                ) AS BuyingCurrency
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Buying] AS b
                  WHERE     b.[GameServerId] = gs.GameServerId
                            AND b.ProductCategoryId = 4
                ) AS BuyingMisc
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                ) AS SellingTotal
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                            AND s.[TransactionPhaseId] = 1
                ) AS SellingActive
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                            AND s.[TransactionPhaseId] = 1
                            AND ProductCategoryId = 1
                ) AS SellingActiveCharacter
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                            AND s.[TransactionPhaseId] = 1
                            AND ProductCategoryId = 3
                ) AS SellingActiveArmory
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                            AND s.[TransactionPhaseId] = 1
                            AND ProductCategoryId = 2
                ) AS SellingActiveCurrency
              , ( SELECT    COUNT(1)
                  FROM      [dbo].[Offers_Selling] AS s
                  WHERE     s.[GameServerId] = gs.GameServerId
                            AND s.[TransactionPhaseId] = 1
                            AND ProductCategoryId = 4
                ) AS SellingActiveMisc
      FROM      [dbo].[Dictionaries_GameServers] AS gs
      INNER JOIN [dbo].[Dictionaries_Games] AS g ON g.[GameId] = gs.[GameId]
      WHERE     ( ISNULL(@ServerId, -1) = -1
                  OR @ServerId = gs.GameServerId
                )
                AND ( ISNULL(@GameId, -1) = -1
                      OR @GameId = gs.GameId
                    )
    )
GO
