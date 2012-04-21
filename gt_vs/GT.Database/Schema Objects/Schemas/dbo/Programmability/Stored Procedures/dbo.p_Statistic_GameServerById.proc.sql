CREATE PROCEDURE [dbo].[p_Statistic_GameServerById] @GameServerId INT
AS 
    BEGIN

        SELECT  [GameId]
              , [GameServerId]
              , [BuyingTotal] AS [BuyingTotal]
              , [SellingTotal] AS SellingTotal
              , [SellingActive] AS [SellingActive]
              , NULL AS Bablo
        FROM    [dbo].[f_Statistics_GetByServers](DEFAULT, @GameServerId) AS stat
        --GROUP BY [GameId]


------------------------- SELECT TOP BUYER


        SELECT TOP ( 10 )
                [Offers_SellingHistory].GameServerId
              , [Offers_SellingHistory].BuyerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
                AND [Offers_SellingHistory].GameServerId = @GameServerId
        GROUP BY [Offers_SellingHistory].GameServerId
              , [Offers_SellingHistory].BuyerId
        ORDER BY [Total] DESC

--------------------------------- SELECT TOP SELLER

        SELECT TOP ( 10 )
                [Offers_SellingHistory].GameServerId
              , [Offers_SellingHistory].SellerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
                AND [Offers_SellingHistory].GameServerId = @GameServerId
        GROUP BY [Offers_SellingHistory].GameServerId
              , [Offers_SellingHistory].SellerId
        ORDER BY [Total] DESC
    END


