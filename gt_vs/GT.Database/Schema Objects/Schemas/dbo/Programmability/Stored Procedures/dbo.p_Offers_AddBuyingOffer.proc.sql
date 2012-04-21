-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Adds buying offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_AddBuyingOffer]
    @Offer XML
  , @HistoryOfferId INT OUTPUT
AS 
    BEGIN
		
        SET NOCOUNT ON ;

        DECLARE @BuyingOfferId INT 

        SET XACT_ABORT ON

        BEGIN TRAN
	
        
        INSERT  INTO dbo.Offers_Buying
                ( BuyerId
                , GameServerId
                , Title
                , Description
                , Price
                , CreateDate
                , UpdateDate
                    /*, ModifyDate*/
                , ProductCategoryId
                , ProductCategoryMisc
                    
                )
        VALUES  ( @Offer.value('(/buying/@buyerId)[1]', 'uniqueidentifier')
                , -- BuyerId - uniqueidentifier
                  @Offer.value('(/buying/@gameServerId)[1]', 'int')
                , -- GameServerId - int
                  @Offer.value('(/buying/@title)[1]', 'nvarchar(250)')
                , -- Title - nvarchar(250)
                  @Offer.value('(/buying/@description)[1]', 'nvarchar(4000)')
                , -- Description - nvarchar(4000)
                  NULLIF(@Offer.value('(/buying/@price)[1]', 'money'), 0)
                , -- Price - money
                  GETUTCDATE()
                , -- CreateDate - datetime
                  NULL
                    /*, GETUTCDATE()*/
                , NULLIF(@Offer.value('(/buying/@productCategoryId)[1]', 'int'), 0)
                , CASE WHEN NULLIF(@Offer.value('(/buying/@productCategoryId)[1]', 'int'), 0) = 4
                       THEN NULLIF(@Offer.value('(/buying/@productCategoryMisc)[1]', 'nvarchar(100)'), '')
                       ELSE NULL
                  END
                )
                
        SET @BuyingOfferId = SCOPE_IDENTITY()

        EXEC @HistoryOfferId = p_Offers_AddBuyingOfferToHistory @BuyingOfferId = @BuyingOfferId
        
        UPDATE  [dbo].[Users_Dynamics]
        SET     [BuyingTotal] += 1
        WHERE   [UserId] = @Offer.value('(/buying/@buyerId)[1]', 'uniqueidentifier')
                
        IF @@TRANCOUNT > 0 
            BEGIN
                COMMIT TRAN
            END 
            
            
        DECLARE @BuyingOffers udtt_Offers
        
        INSERT  INTO @BuyingOffers
                ( OfferId, RowNumber )
        VALUES  ( @BuyingOfferId, 1 )
            
        EXEC [p_Offers_GetBuyingOffersInternal] @BuyingOffers = @BuyingOffers
    END








