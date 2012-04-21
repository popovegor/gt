CREATE PROCEDURE [dbo].[p_Offers_GetOffersForSuggesting]
    @User UNIQUEIDENTIFIER
  , @BuyingId INT
AS 
    BEGIN

        DECLARE @Offers udtt_Offers

        INSERT  INTO @Offers
                ( OfferId
                , RowNumber
                )
                SELECT DISTINCT
                        o.[SellingId]
                      , 1
                FROM    [Offers_Selling] AS o
                INNER JOIN [Offers_Buying] ON [Offers_Buying].GameServerId = [o].GameServerId
                WHERE   [o].SellerId = @User
                        AND [o].TransactionPhaseId = 1
                        AND [Offers_Buying].BuyingOfferId = @BuyingId
                        AND [Offers_Buying].BuyerId != @User
                        AND o.[SellingId] NOT IN ( SELECT   os.[SellingId]
                                               FROM     [Offers_SuggestedSelling] AS os
                                               WHERE    os.BuyingOfferId = @BuyingId )
		
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
 
    END


