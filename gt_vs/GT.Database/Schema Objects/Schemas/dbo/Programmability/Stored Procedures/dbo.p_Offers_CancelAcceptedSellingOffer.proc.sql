CREATE PROCEDURE [dbo].[p_Offers_CancelAcceptedSellingOffer]
    @Offer XML
  , @Resultcode INT OUTPUT
  , @HistoryId INT OUTPUT
  , @ActionOwner UNIQUEIDENTIFIER
AS 
    BEGIN

        BEGIN TRAN

        DECLARE @OfferId INT = @Offer.value('(/selling/@id)[1]', 'int') 
						      ,@SellerId uniqueidentifier = @Offer.value('(/selling/@sellerId)[1]', 'uniqueidentifier')
						      ,@BuyerId uniqueidentifier = @Offer.value('(/selling/@buyerId)[1]', 'uniqueidentifier')
        IF EXISTS ( SELECT  1
                    FROM    dbo.Offers_Selling AS s
                    WHERE   s.[SellingId] = @OfferId
                            AND s.[TransactionPhaseId] = 2 ) 
            BEGIN

                DECLARE @NewHistoryOfferId INT 
        
                EXEC [p_Offers_AddSelling] @Offer = @Offer, @History = @NewHistoryOfferId OUTPUT

                DECLARE @NewOfferId INT 
        
                SELECT  @NewOfferId = sh.[SellingId]
                FROM    Offers_SellingHistory AS sh
                WHERE   sh.[HistorySellingId] = @NewHistoryOfferId

                IF @@ROWCOUNT <= 0
                    OR @NewOfferId IS NULL 
                    BEGIN
                        GOTO failedOffer ;
                    END
            
                EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Cancel an accepted', @ActionOwner = @ActionOwner
           
                DECLARE @AcceptedPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Accept')


                EXEC [p_UserRating_AddUnusedFeedback] @SellingHistoryId = @HistoryId, @TransactionPhaseId = @AcceptedPhaseId

                IF @@ERROR != 0
                    BEGIN
                        GOTO failedOffer ;
                    END

                DELETE  FROM [Offers_Buyers]
                WHERE   [OfferId] = @OfferId ;
	
                DELETE  FROM [dbo].[Offers_Selling]
                WHERE   [SellingId] = @OfferId
		      
				UPDATE [dbo].Users_Dynamics
				SET    [DealsSellerAccepted] -= 1
				WHERE  [UserId] = @SellerId
				
				UPDATE [dbo].Users_Dynamics
				SET    [DealsBuyerAccepted] -= 1
				WHERE  [UserId] = @BuyerId
		      
                EXEC dbo.p_Offers_GetSellingOfferById @Id = @NewOfferId
		
                IF @@TRANCOUNT > 0 
                    COMMIT TRAN ;
                SET @Resultcode = 1 ;
                RETURN @Resultcode ;
            END 
		
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SET @Resultcode = -1 ;
        RETURN @Resultcode ;

    END

