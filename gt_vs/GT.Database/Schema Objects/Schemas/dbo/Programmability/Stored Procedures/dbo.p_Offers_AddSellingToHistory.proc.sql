-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-21
-- Description:	Creates a history entry by the passed selling offer id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_AddSellingToHistory]
    @OfferId INT
  , @TransactionPhaseId INT = NULL
  , @ActionOwner UNIQUEIDENTIFIER = NULL
  , @Note NVARCHAR(150) = NULL
AS 
    BEGIN
	
        INSERT  INTO dbo.Offers_SellingHistory
                ( [HistoryCreateDate]
                , [SellingId]
                , SellerId
                , GameServerId
                , Title
                , Description
                , Price
                , TransactionPhaseId
                , CreateDate
                , ValidKey
                , UpdateDate
                , [Note]
                , ActionOwner
                , [DeliveryTime]
                , [BuyerId]
                , ModifyDate
                , ProductCategoryId
                , ProductCategoryMisc
                )
                SELECT  GETUTCDATE()
                      , [SellingId]
                      , SellerId
                      , GameServerId
                      , Title
                      , Description
                      , Price
                      , ISNULL(@TransactionPhaseId, TransactionPhaseId)
                      , CreateDate
                      , ValidKey
                      , UpdateDate
                      , @Note AS Comment
                      , @ActionOwner AS ActionOwner
                      , [DeliveryTime]
                      , [BuyerId]
                      , ModifyDate
                      , ProductCategoryId
                      , ProductCategoryMisc
                FROM    dbo.Offers_Selling AS o
                WHERE   o.[SellingId] = @OfferId
                
        DECLARE @Id INT = SCOPE_IDENTITY()
        
        DECLARE @Seller UNIQUEIDENTIFIER
          , @Buyer UNIQUEIDENTIFIER
          , @State INT
          , @Count INT
        
        SELECT  @Seller = [SellerId]
              , @Buyer = [BuyerId]
              , @State = ISNULL(@TransactionPhaseId, TransactionPhaseId)
        FROM    dbo.Offers_Selling
        WHERE   Offers_Selling.[SellingId] = @OfferId
       
        SELECT  @Count = COUNT(*)
        FROM    dbo.Offers_SellingHistory
        WHERE   [Offers_SellingHistory].[SellingId] = @OfferId
                AND [Offers_SellingHistory].TransactionPhaseId = @State
        
        IF @Count = 1 
            BEGIN
                IF @State = 1 
                    BEGIN
                        UPDATE  dbo.Users_Dynamics
                        SET     [DealsStarted] += 1
                        WHERE   [UserId] = @Seller
                    END
                ELSE 
                    IF @State = 2 
                        BEGIN
                            UPDATE  dbo.Users_Dynamics
                            SET     [DealsSellerAccepted] += 1
                                  , [DealsStarted] -= 1
                            WHERE   [UserId] = @Seller
						
                            UPDATE  dbo.Users_Dynamics
                            SET     [DealsBuyerAccepted] += 1
                            WHERE   [UserId] = @Buyer
                        END
                    ELSE 
                        IF @State = 3 
                            BEGIN
                                UPDATE  dbo.Users_Dynamics
                                SET     [DealsSellerAccepted] -= 1
                                      , [DealsSellerSubmitted] += 1
                                WHERE   [UserId] = @Seller 
						
                                UPDATE  dbo.Users_Dynamics
                                SET     [DealsBuyerAccepted] -= 1
                                      , [DealsBuyerSubmitted] += 1
                                WHERE   [UserId] = @Buyer
                            END
                        ELSE 
                            IF @State = 4 
                                BEGIN
                                    UPDATE  dbo.Users_Dynamics
                                    SET     [DealsSellerConflicted] += 1
                                          , [DealsSellerSubmitted] -= 1
                                    WHERE   [UserId] = @Seller
						
                                    UPDATE  dbo.Users_Dynamics
                                    SET     [DealsBuyerConflicted] += 1
                                          , [DealsBuyerSubmitted] -= 1
                                    WHERE   [UserId] = @Buyer
                                END
                            ELSE 
                                IF @State = 5 
                                    BEGIN
                                        UPDATE  dbo.Users_Dynamics
                                        SET     [DealsSellerFinished] += 1
                                              , [DealsSellerSubmitted] -= 1
                                        WHERE   [UserId] = @Seller
						
                                        UPDATE  dbo.Users_Dynamics
                                        SET     [DealsBuyerFinished] += 1
                                              , [DealsBuyerSubmitted] -= 1
                                        WHERE   [UserId] = @Buyer
                                    END
            END
                
        RETURN @Id
    
    END 