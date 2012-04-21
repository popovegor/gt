CREATE PROCEDURE [dbo].[p_Offers_GetSellingOffersBySellerName]
    @SellerName NVARCHAR(100)
AS 
    BEGIN
    
        SET NOCOUNT ON ;

        SELECT  o.[SellingId]
              , o.[SellerId]
              , u.[UserName] AS SellerName
              , o.[GameServerId]
              , o.[Title]
              , o.[Description]
              , o.[Price]
              , o.[TransactionPhaseId]
              , o.[CreateDate]
              , o.[ModifyDate]
              , o.[ValidKey]
              , o.[DeliveryTime]
              , ISNULL(o.[BuyerId], b.[BuyerId])
				AS BuyerId
              , ISNULL(u3.[UserName],u2.[UserName])
				AS BuyerName
        FROM    [Offers_Selling] AS o
        INNER JOIN aspnet_Users AS u ON o.SellerId = u.UserId AND u.UserName = @SellerName
        LEFT JOIN aspnet_Users AS u3 ON o.BuyerId = u3.UserId
        LEFT JOIN [Offers_Buyers] AS b ON o.[SellingId] = b.OfferId AND b.BuyerStatusId IN (1, 4) 
        LEFT JOIN aspnet_Users AS u2 ON b.BuyerId = u2.UserId
        ORDER BY o.ModifyDate DESC
        
    END


