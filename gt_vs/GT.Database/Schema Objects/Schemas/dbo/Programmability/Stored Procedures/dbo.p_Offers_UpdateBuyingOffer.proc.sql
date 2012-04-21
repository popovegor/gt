-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Updates the buying offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_UpdateBuyingOffer]
    @Offer XML
  , @HistoryOfferId INT OUTPUT
AS 
    BEGIN
		
        SET NOCOUNT ON ;

        DECLARE @BuyingOfferId INT  = @Offer.value('(/buying/@id)[1]', 'int')
	
        UPDATE  dbo.Offers_Buying
        SET     BuyerId = @Offer.value('(/buying/@buyerId)[1]', 'uniqueidentifier')
              , GameServerId = @Offer.value('(/buying/@gameServerId)[1]', 'int')
              , Title = @Offer.value('(/buying/@title)[1]', 'nvarchar(250)')
              , [DESCRIPTION] = @Offer.value('(/buying/@description)[1]', 'nvarchar(4000)')
              , Price = NULLIF(@Offer.value('(/buying/@price)[1]', 'money'), 0)
              , UpdateDate = GETUTCDATE()
              /*, ModifyDate = GETUTCDATE()*/
              , ProductCategoryId = NULLIF(@Offer.value('(/buying/@productCategoryId)[1]', 'int'), 0)
              , ProductCategoryMisc = CASE WHEN NULLIF(@Offer.value('(/buying/@productCategoryId)[1]', 'int'), 0) = 4
                                              THEN NULLIF(@Offer.value('(/buying/@productCategoryMisc)[1]', 'nvarchar(100)'), '')
                                              ELSE NULL
                                         END
        WHERE   dbo.Offers_Buying.BuyingOfferId = @BuyingOfferId
                AND dbo.Offers_Buying.BuyerId = @Offer.value('(/buying/@buyerId)[1]', 'uniqueidentifier')

        EXEC @HistoryOfferId = p_Offers_AddBuyingOfferToHistory @BuyingOfferId = @BuyingOfferId
            
        DECLARE @BuyingOffers udtt_Offers
        
        INSERT  INTO @BuyingOffers
                ( OfferId, RowNumber )
        VALUES  ( @BuyingOfferId, 1 )
            
        EXEC [p_Offers_GetBuyingOffersInternal] @BuyingOffers = @BuyingOffers
    END








