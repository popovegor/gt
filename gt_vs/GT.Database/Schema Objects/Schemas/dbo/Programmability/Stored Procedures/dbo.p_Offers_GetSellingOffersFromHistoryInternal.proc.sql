-- =============================================
-- Author:		E.Popov
-- Create date: 2009-01-14
-- Description:	gets selling offers from the history
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOffersFromHistoryInternal]
    @HistoryOffers udtt_HistoryOffers READONLY
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  h.[SellingId]
              , h.[SellerId]
              , u.[UserName] AS SellerName
              , h.[GameServerId]
              , h.[Title]
              , h.[Description]
              , h.[Price]
              , h.[TransactionPhaseId]
              , h.[CreateDate]
              , h.[HistoryCreateDate] AS [UpdateDate]
              , h.[ValidKey]
              , h.[DeliveryTime]
              , h.[BuyerId]
              , u2.[UserName] AS BuyerName
              , h.ModifyDate
              , h.ProductCategoryId
              , h.ProductCategoryMisc
        FROM    @HistoryOffers AS ids
        INNER JOIN dbo.[Offers_SellingHistory] AS h ON h.[HistorySellingId] = ids.HistoryOfferId
        INNER JOIN aspnet_Users AS u ON h.SellerId = u.UserId
        LEFT JOIN aspnet_Users AS u2 ON h.BuyerId = u2.UserId
        ORDER BY ids.RowNumber ASC
    END





