CREATE PROCEDURE [dbo].[p_Offers_ConflictSellingOffer]
    @OfferId INT
  , @ConflictUser nvarchar(40)
  , @Resultcode INT OUT
  , @HistoryId INT OUT
AS 
    BEGIN

        BEGIN TRAN ;
	
        UPDATE  [Offers_Selling]
        SET     [TransactionPhaseId] = 4,
				[UpdateDate] = GETUTCDATE()
        WHERE   [SellingId] = @OfferId
                AND [TransactionPhaseId] = 3
	
        IF @@ROWCOUNT <= 0 
            GOTO failedOffer ;
	
		DECLARE @DESC  NVARCHAR(150) = ('Conflicted by ' + @ConflictUser)
	
        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = @DESC
		
        EXEC p_Offers_GetSellingOfferById @Id = @OfferId
	
        IF @@TRANCOUNT > 0 
            COMMIT TRAN ;
        SET @Resultcode = 1 ;
        RETURN @Resultcode ;
	
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SET @Resultcode = -1 ;
        RETURN @Resultcode ;	

    END


