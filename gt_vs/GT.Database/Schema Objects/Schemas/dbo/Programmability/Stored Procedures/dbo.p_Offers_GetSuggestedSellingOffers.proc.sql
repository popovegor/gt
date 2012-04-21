-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Returns suggested selling offers by buying offer id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSuggestedSellingOffers]
	@BuyingOfferId INT 
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @Offers udtt_Offers
    
    INSERT INTO @Offers (OfferId, RowNumber) 
	SELECT sob.[SellingId], 1 FROM [Offers_SuggestedSelling] AS sob
	WHERE sob.BuyingOfferId = @BuyingOfferId
	
	EXEC dbo.[p_Offers_GetSellingOffersInternal] @Offers = @Offers

END


