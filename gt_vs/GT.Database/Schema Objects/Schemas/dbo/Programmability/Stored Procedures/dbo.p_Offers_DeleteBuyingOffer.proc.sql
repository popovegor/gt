-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Deletes the passed buying offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_DeleteBuyingOffer]
@UserId UNIQUEIDENTIFIER, @OfferId INT, @HistoryOfferId INT OUTPUT
AS
BEGIN
		
        SET NOCOUNT ON;       
            
        SET XACT_ABORT ON

        BEGIN TRAN
	
        EXEC @HistoryOfferId = p_Offers_AddBuyingOfferToHistory @BuyingOfferId = @OfferId
	
		DELETE FROM Offers_SuggestedSelling
		WHERE BuyingOfferId = @OfferId
	
        DELETE  FROM dbo.Offers_Buying
        WHERE   dbo.Offers_Buying.BuyerId = @UserId
                AND BuyingOfferId = @OfferId
                
                
         UPDATE [dbo].[Users_Dynamics] SET [BuyingTotal] -= 1 
         WHERE [UserId] = @UserId
                
        IF @@TRANCOUNT > 0 
            BEGIN
                COMMIT TRAN
            END 
    END








