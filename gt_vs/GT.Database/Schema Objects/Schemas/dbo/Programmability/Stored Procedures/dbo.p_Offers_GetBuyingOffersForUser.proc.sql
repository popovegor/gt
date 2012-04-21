-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Returns buying offers for the passed user
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetBuyingOffersForUser]
    @UserId UNIQUEIDENTIFIER
AS 
    BEGIN
		
        SET NOCOUNT ON ;
            
        DECLARE @BuyingOffers udtt_Offers
        
        INSERT  INTO @BuyingOffers
                ( OfferId, RowNumber )
        SELECT b.BuyingOfferId, ROW_NUMBER() OVER (ORDER BY ISNULL(b.UpdateDate, b.CreateDate) DESC) FROM dbo.Offers_Buying AS b
        WHERE b.BuyerId = @UserId
            
        EXEC [p_Offers_GetBuyingOffersInternal] @BuyingOffers = @BuyingOffers
    END


