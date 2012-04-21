CREATE PROCEDURE [dbo].[p_Offers_UpdateSellingOfferKey]
    @Id INT
  , @Key NCHAR(7)
  , @Resultcode INT OUT
  , @HistoryId INT OUT
AS 
    BEGIN
	
        BEGIN TRANSACTION

        UPDATE  [Offers_Selling]
        SET     [ValidKey] = @Key
        WHERE   [SellingId] = @Id
                AND [TransactionPhaseId] = 3 ;
		
        IF @@ROWCOUNT <= 0 
            GOTO failedOffer ;
		
        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @Id, @Note = 'Update the key' 
	
	      
                EXEC dbo.p_Offers_GetSellingOfferById @Id = @Id -- int
	
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
