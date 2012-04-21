-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-12
-- Description:	Returns a buying offer by the passed id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetBuyingOfferById] @BuyingOfferId INT
AS 
    BEGIN
        SET NOCOUNT ON ;

        DECLARE @Offers udtt_Offers
    
        INSERT  INTO @Offers
                ( OfferId, RowNumber )
        VALUES  ( @BuyingOfferId, 1 )
    
        EXEC dbo.[p_Offers_GetBuyingOffersInternal] @BuyingOffers = @Offers

    END


