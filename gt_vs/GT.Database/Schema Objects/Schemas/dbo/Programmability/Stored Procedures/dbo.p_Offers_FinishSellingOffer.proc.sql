CREATE PROCEDURE [dbo].[p_Offers_FinishSellingOffer]
    @OfferId INT
  , @Transfer XML
  , @Resultcode INT OUT
  , @HistoryId INT OUT
AS 
    BEGIN

        BEGIN TRAN ;
	
        UPDATE  [Offers_Selling]
        SET     [TransactionPhaseId] = 5
              , [UpdateDate] = GETUTCDATE()
        WHERE   [SellingId] = @OfferId
                AND [TransactionPhaseId] = 3

        IF @@ROWCOUNT <= 0 
            GOTO failedOffer ;

        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Finish' 
      
        DECLARE @FinishPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Finish')

        EXEC [p_UserRating_AddUnusedFeedback] @SellingHistoryId = @HistoryId, @TransactionPhaseId = @FinishPhaseId

        IF @@ERROR != 0 
            BEGIN
                GOTO failedOffer ;
            END

        EXEC p_Offers_GetSellingOfferById @Id = @OfferId
	
        DECLARE @return_value INT
        EXEC @return_value = [dbo].[p_BillingSystem_AddTransfer] @Transfer = @Transfer, @Resultcode = @ResultCode OUTPUT
			
        IF @Resultcode != 0 
            GOTO failedOffer
	
        IF @@TRANCOUNT > 0 
            COMMIT TRAN
        SET @Resultcode = 1
        RETURN @Resultcode
		
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN
        SET @Resultcode = -1
        RETURN @Resultcode

    END


