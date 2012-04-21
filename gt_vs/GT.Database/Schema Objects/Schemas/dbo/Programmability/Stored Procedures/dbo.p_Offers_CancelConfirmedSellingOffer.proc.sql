CREATE PROCEDURE [dbo].[p_Offers_CancelConfirmedSellingOffer]
    @Offer XML
  , @Transfer XML
  , @Resultcode INT OUT
  , @HistoryId INT OUT
AS 
    BEGIN

        BEGIN TRAN ;
        
        DECLARE @OfferId INT = @Offer.value('(/selling/@id)[1]', 'int') 
							  ,@SellerId uniqueidentifier = @Offer.value('(/selling/@sellerId)[1]', 'uniqueidentifier')
						      ,@BuyerId uniqueidentifier = @Offer.value('(/selling/@buyerId)[1]', 'uniqueidentifier')
        IF EXISTS ( SELECT  1
                    FROM    dbo.Offers_Selling AS s
                    WHERE   s.[SellingId] = @OfferId
                            AND s.[TransactionPhaseId] = 3 ) 
            BEGIN

                DECLARE @NewHistoryId INT 
        
                EXEC [p_Offers_AddSelling] @Offer = @Offer, @History = @NewHistoryId OUTPUT

                DECLARE @NewOfferId INT 
        
                SELECT  @NewOfferId = sh.[SellingId]
                FROM    Offers_SellingHistory AS sh
                WHERE   sh.[HistorySellingId] = @NewHistoryId

                IF @@ROWCOUNT <= 0
                    OR @NewOfferId IS NULL 
                    GOTO failedOffer ;

                EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Cancel a submitted'

                DECLARE @SubmittedPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Submit')

                EXEC [p_UserRating_AddUnusedFeedback] @SellingHistoryId = @HistoryId, @TransactionPhaseId = @SubmittedPhaseId

                IF @@ERROR != 0
                    BEGIN
                        GOTO failedOffer ;
                    END

                DELETE  FROM [Offers_Buyers]
                WHERE   [OfferId] = @OfferId ;
	
                DELETE  FROM [dbo].[Offers_Selling]
                WHERE   [SellingId] = @OfferId
      
				UPDATE [dbo].Users_Dynamics
				SET    [DealsSellerSubmitted] -= 1
				WHERE  [UserId] = @SellerId
				
				UPDATE [dbo].Users_Dynamics
				SET    [DealsBuyerSubmitted] -= 1
				WHERE  [UserId] = @BuyerId
      
                EXEC p_Offers_GetSellingOfferById @Id = @NewOfferId
		
                DECLARE @return_value INT
                EXEC @return_value = [dbo].[p_BillingSystem_AddTransfer] @Transfer = @Transfer, @Resultcode = @ResultCode OUTPUT
			
                IF @Resultcode != 0 
                    GOTO failedOffer ;
			
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


