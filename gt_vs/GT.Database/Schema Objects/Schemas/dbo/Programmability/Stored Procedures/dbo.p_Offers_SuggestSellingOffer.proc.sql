-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Suggests the passed selling offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_SuggestSellingOffer]
    @BuyingOfferId INT
  , @SellingOfferId INT
AS 
    BEGIN
		
        SET NOCOUNT ON ;       
	
        INSERT  INTO dbo.[Offers_SuggestedSelling]
                ( BuyingOfferId, [SellingId] )
        VALUES  ( @BuyingOfferId, @SellingOfferId )
        
        /*no need to manual check because there is already a constraint */
        /*IF EXISTS(SELECT 'Transaction phase <> 1' FROM dbo.SellingOffers AS s WHERE s.TransactionPhaseId <> 1) 
			AND  @@TRANCOUNT > 0
        BEGIN
			ROLLBACK TRAN
			RAISERROR(N'A transaction phase of the selling offer[Id=%d] is wrong (!=1).', 16, 127, @SellingOfferId) WITH NOWAIT
			RETURN
        END */
        
    END


