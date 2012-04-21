CREATE PROCEDURE [dbo].[p_Offers_ConfirmSellingOffer]
    @OfferId INT
  , @Key NCHAR(7)
  , @Transfer XML
  , @Resultcode INT OUT
  , @HistoryId INT OUT
AS 
    BEGIN

        BEGIN TRANSACTION
	
        DECLARE @return_value INT

        EXEC @return_value = [dbo].[p_BillingSystem_AddTransfer] @Transfer = @Transfer, @Resultcode = @ResultCode OUTPUT
	
        IF @Resultcode != 0 
            GOTO failedTransfer
	
        UPDATE  [Offers_Selling]
        SET     [TransactionPhaseId] = 3
              , [ValidKey] = @Key,
				[UpdateDate] = GETUTCDATE()
        WHERE   [SellingId] = @OfferId
                AND [TransactionPhaseId] = 2
	
        IF @@ROWCOUNT <= 0 
            GOTO failedOffer


        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Sumbit' 
      
        EXEC dbo.p_Offers_GetSellingOfferById @Id = @OfferId -- int

        IF @@TRANCOUNT > 0 
            COMMIT TRAN
        SET @Resultcode = 1
        RETURN @Resultcode
	
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN
        SET @Resultcode = -1
        RETURN @Resultcode
	
        failedTransfer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN 
        RETURN @Resultcode
	
    END



