-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-11
-- Description:	Delete the offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_DeleteSellingOffer]
    @Offer XML
  , @Transfer XML = NULL
  , @SellingHistoryId INT OUTPUT
  , @ResultCode INT OUTPUT
AS 
    BEGIN
	
        DECLARE @OfferId INT = @Offer.value('(/selling/@id)[1]', 'int')
        DECLARE @TransactionPhaseId INT = @Offer.value('(/selling/@transactionPhaseId)[1]', 'int')
          , @SellerId UNIQUEIDENTIFIER = @Offer.value('(/selling/@sellerId)[1]', 'uniqueidentifier') 
	
        BEGIN TRANSACTION
	
        IF ( @TransactionPhaseId != 1
             AND @TransactionPhaseId != 5
           ) 
            BEGIN
                SET @SellingHistoryId = -1 ;
                GOTO failedDelete ; 
            END
	
        IF EXISTS ( SELECT  1
                    FROM    [Offers_Selling]
                    WHERE   [SellingId] = @OfferId
                            AND [TransactionPhaseId] = @TransactionPhaseId ) 
            BEGIN 
        
                EXEC @SellingHistoryId = [dbo].[p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = 'Delete', @TransactionPhaseId = 6
                
                DELETE  FROM [dbo].[Offers_SuggestedSelling]
                WHERE   [SellingId] = @OfferId
      
                DELETE  FROM [Offers_Buyers]
                WHERE   [OfferId] = @OfferId
		
                DELETE  FROM [Offers_Selling]
                WHERE   [SellingId] = @OfferId
                        AND [TransactionPhaseId] = @TransactionPhaseId
	
                IF ( @TransactionPhaseId = 1 ) 
                    BEGIN
                        UPDATE  dbo.Users_Dynamics
                        SET     [DealsStarted] = CASE WHEN [DealsStarted] > 0 THEN [DealsStarted] - 1
                                                      ELSE 0
                                                 END
                        WHERE   [UserId] = @SellerId
                    END
	
                IF @Transfer IS NOT NULL 
                    BEGIN 
				
                        EXEC [dbo].[p_BillingSystem_AddTransfer] @Transfer = @Transfer, @Resultcode = @ResultCode OUTPUT
						
						
                        IF @ResultCode != 0 
                            BEGIN
                                IF @@TRANCOUNT > 0 
                                    ROLLBACK TRANSACTION
            
                                SET @ResultCode = -1
                
                                RETURN @ResultCode
                            END 
						
                    END 
		
		
                IF @@TRANCOUNT > 0 
                    COMMIT TRANSACTION
	
                SET @ResultCode = 1
				
                RETURN @ResultCode
	
            END 
        ELSE 
            BEGIN
                failedDelete:
                IF @@TRANCOUNT > 0 
                    ROLLBACK TRANSACTION
            
                SET @ResultCode = -1
                
                RETURN @ResultCode
				
            END 
    END


