CREATE PROCEDURE [dbo].[p_Offers_AcceptSellingOffer]
    @OfferId INT
  , @UserId UNIQUEIDENTIFIER
  , @Resultcode INT OUTPUT
  , @HistoryId INT OUTPUT
AS 
    BEGIN
        BEGIN TRAN
    
        UPDATE  [dbo].[Offers_Selling]
        SET     [dbo].[Offers_Selling].[TransactionPhaseId] = 2,
				[dbo].[Offers_Selling].[UpdateDate] = GETUTCDATE(),
				[dbo].[Offers_Selling].[BuyerId] = @UserId
        WHERE   [dbo].[Offers_Selling].[SellingId] = @OfferId
                AND [dbo].[Offers_Selling].[TransactionPhaseId] = 1
    
        IF @@ROWCOUNT <= 0 
            GOTO failedOffer ;	
		
        UPDATE  [dbo].[Offers_Buyers]
        SET     [dbo].[Offers_Buyers].[BuyerStatusId] = 4
        WHERE   [dbo].[Offers_Buyers].[BuyerId] = @UserId
                AND [dbo].[Offers_Buyers].[OfferId] = @OfferId
                AND [dbo].[Offers_Buyers].[BuyerStatusId] = 1
      
        IF @@ROWCOUNT <= 0 
            GOTO failedUser ;  
       
        DELETE  FROM [dbo].[Offers_Buyers]
        WHERE   [dbo].[Offers_Buyers].[OfferId] = @OfferId;
      
        DELETE  FROM [dbo].[Offers_SuggestedSelling]
        WHERE   [dbo].[Offers_SuggestedSelling].[SellingId] = @OfferId
    
        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Accept' 
      
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
	   
        failedUser:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SET @Resultcode = -2 ;
        RETURN @Resultcode ;      
		 
    END


