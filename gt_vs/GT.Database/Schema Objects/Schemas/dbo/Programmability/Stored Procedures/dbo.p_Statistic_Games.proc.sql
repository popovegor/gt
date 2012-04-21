CREATE PROCEDURE [dbo].[p_Statistic_Games]
AS 
    BEGIN

        SELECT  GameId
              , SUM([BuyingTotal]) AS [BuyingTotal]
              , SUM([BuyingCharacter]) AS [BuyingCharacter]
              , SUM([BuyingArmory]) AS [BuyingArmory]
              , SUM([BuyingCurrency]) AS [BuyingCurrency]
              , SUM([BuyingMisc]) AS [BuyingMisc]
              , SUM([SellingTotal]) AS SellingTotal
              , SUM([SellingActive]) AS [SellingActive]
              , SUM([SellingActiveCharacter]) AS [SellingActiveCharacter]
              , SUM([SellingActiveArmory]) AS [SellingActiveArmory]
              , SUM([SellingActiveCurrency]) AS [SellingActiveCurrency]
              , SUM([SellingActiveMisc]) AS [SellingActiveMisc]
              , NULL AS Bablo
        FROM    [dbo].[f_Statistics_GetByServers](DEFAULT, DEFAULT) AS stat
        GROUP BY [GameId]


------------------------- SELECT TOP BUYER


        SELECT  D.GameId
              , [Offers_SellingHistory].BuyerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        INNER JOIN [Dictionaries_GameServers] AS D ON D.GameServerId = [Offers_SellingHistory].GameServerId
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
        GROUP BY D.GameId
              , [Offers_SellingHistory].BuyerId
        ORDER BY [Total] DESC

--------------------------------- SELECT TOP SELLER

        SELECT  D.GameId
              , [Offers_SellingHistory].SellerId
              , COUNT([Offers_SellingHistory].[HistorySellingId]) AS Total
        FROM    [Offers_SellingHistory]
        INNER JOIN [Dictionaries_GameServers] AS D ON D.GameServerId = [Offers_SellingHistory].GameServerId
        WHERE   [Offers_SellingHistory].TransactionPhaseId = 5
        GROUP BY D.GameId
              , [Offers_SellingHistory].SellerId
        ORDER BY [Total] DESC
	
    END


