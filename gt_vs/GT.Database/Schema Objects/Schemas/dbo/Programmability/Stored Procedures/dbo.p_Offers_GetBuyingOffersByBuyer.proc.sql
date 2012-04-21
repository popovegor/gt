CREATE PROCEDURE [dbo].[p_Offers_GetBuyingOffersByBuyer]
    @BuyerId UNIQUEIDENTIFIER
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  [o].BuyingOfferId
              , [o].GameServerId
              , [o].Title
              , [s].Title AS SellerTitle
              , [s].[SellingId]
              , [o].Price
              , [o].CreateDate
              , [o].ModifyDate
        FROM    Offers_Buying AS o
        LEFT JOIN Offers_SuggestedSelling ON [Offers_SuggestedSelling].BuyingOfferId = [o].BuyingOfferId
        LEFT JOIN dbo.Offers_Selling AS s ON [s].[SellingId] = [Offers_SuggestedSelling].[SellingId]
        WHERE   [o].BuyerId = @BuyerId
        ORDER BY [o].ModifyDate DESC
    END


