CREATE PROCEDURE [dbo].[p_UserRating_AddUnusedFeedback]
    @SellingHistoryId INT
  , @TransactionPhaseId INT
AS 
    BEGIN
    
        DECLARE @Seller UNIQUEIDENTIFIER
          , @Buyer UNIQUEIDENTIFIER
          , @TransactionPhase INT
      
        SELECT TOP ( 1 )
                @TransactionPhase = ISNULL(@TransactionPhaseId, TransactionPhaseId)
              , @Seller = SellerId
              , @Buyer = BuyerId
        FROM    dbo.Offers_SellingHistory
        WHERE   [HistorySellingId] = @SellingHistoryId
      
        DECLARE @AcceptedPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Accept')
        DECLARE @SumbittedPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Submit')
        DECLARE @FinishPhaseId INT = dbo.f_Dictionaries_GetTransactionPhaseIdByName('Finish')
      
        IF @TransactionPhase IN ( @AcceptedPhaseId, @FinishPhaseId ) 
            BEGIN 
                INSERT  INTO dbo.[UserRating_UnusedFeedbacks]
                        ( SellingHistoryId
                        , FromUserId
                        , ToUserId
                        )
                VALUES  ( @SellingHistoryId
                        , @Seller
                        , @Buyer
                        )
                        
                UPDATE [dbo].[Users_Dynamics] SET [FeedbacksUnused] += 1
                WHERE [UserId] = @Seller
            END 
        
        IF @TransactionPhase IN ( @SumbittedPhaseId, @FinishPhaseId ) 
            BEGIN 
                INSERT  INTO dbo.[UserRating_UnusedFeedbacks]
                        ( SellingHistoryId
                        , FromUserId
                        , ToUserId
                        )
                VALUES  ( @SellingHistoryId
                        , @Buyer
                        , @Seller
                        )
                        
                UPDATE [dbo].[Users_Dynamics] SET [FeedbacksUnused] += 1
                WHERE [UserId] = @Buyer
            END 
    
    END 
    