CREATE PROCEDURE [dbo].[p_Statistic_GameById] @GameId INT
AS 
    BEGIN

        SELECT  [GameId]
              , SUM([BuyingTotal]) AS [BuyingTotal]
              , SUM([SellingTotal]) AS SellingTotal
              , SUM([SellingActive]) AS [SellingActive]
              , NULL AS Bablo
        FROM    [dbo].[f_Statistics_GetByServers](@GameId, DEFAULT) AS stat
        GROUP BY [GameId]


------------------------- SELECT TOP BUYER

        SELECT TOP ( 10 )
                D.GameId
              , [Offers_SellingHistory].BuyerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        INNER JOIN [Dictionaries_GameServers] AS D ON D.GameServerId = [Offers_SellingHistory].GameServerId
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
                AND GameId = @GameId
        GROUP BY D.GameId
              , [Offers_SellingHistory].BuyerId
        ORDER BY [Total] DESC

--------------------------------- SELECT TOP SELLER

        SELECT TOP ( 10 )
                D.GameId
              , [Offers_SellingHistory].SellerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        INNER JOIN [Dictionaries_GameServers] AS D ON D.GameServerId = [Offers_SellingHistory].GameServerId
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
                AND GameId = @GameId
        GROUP BY D.GameId
              , [Offers_SellingHistory].SellerId
        ORDER BY [Total] DESC
    END


