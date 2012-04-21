CREATE PROCEDURE [dbo].[p_Offers_CancelSuggested]
    @BuyingId INT
  , @SuggestedId INT
  , @ResultCode INT OUTPUT
AS 
    BEGIN

        DELETE  FROM Offers_SuggestedSelling
        WHERE   [Offers_SuggestedSelling].BuyingOfferId = @BuyingId
                AND [Offers_SuggestedSelling].[SellingId] = @SuggestedId

        IF ( @@ROWCOUNT > 0 ) 
            BEGIN
                SET @ResultCode = 1 ;
                RETURN @ResultCode ;
            END ;
	
        SET @ResultCode = -1 ;
        RETURN @ResultCode ;
	
    END





