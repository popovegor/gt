CREATE PROCEDURE [dbo].[p_Offers_GetSellingOffersByBuyerName]
    @BuyerName NVARCHAR(100)
AS 
    BEGIN
        SET NOCOUNT ON ;

        DECLARE @Offers udtt_Offers
	
        INSERT  INTO @Offers
                ( OfferId
                , RowNumber
                )
                SELECT  o.[SellingId] AS OfferId
                      , 1 AS RowNumber
                FROM    [Offers_Selling] AS o
                LEFT JOIN [Offers_Buyers] AS b ON o.[SellingId] = b.OfferId
                                                   AND b.BuyerStatusId IN ( 1, 4 )
                INNER JOIN [aspnet_Users] AS u ON u.UserId = ISNULL(o.BuyerId, b.BuyerId)
                                                  AND u.UserName = @BuyerName
                
	
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
    END


