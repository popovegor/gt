CREATE PROCEDURE [dbo].[p_Offers_SelectSellingOffer]
    @UserId UNIQUEIDENTIFIER
  , @OfferId INT
  , @ResultCode INT OUTPUT
AS 
    BEGIN

        DECLARE @status INT
          , @availableMoney MONEY
          , @price MONEY ;

        BEGIN TRAN ;

        --SELECT  @availableMoney = MoneyAvailable
        --FROM    Users_Dynamics
        --WHERE   UserId = @UserId ;
        
        --SELECT  @price = Price
        --FROM    [Offers_Selling]
        --WHERE   [SellingId] = @OfferId
                --AND TransactionPhaseId = 1 ;
	
        --IF ( @@ROWCOUNT <= 0 ) 
            --GOTO failedOffer ;
	
        --IF ( @availableMoney < @price ) 
            --GOTO failedMoney ;

        IF EXISTS ( SELECT  [SellingId]
                    FROM    [Offers_Selling]
                    WHERE   [SellingId] = @OfferId
                            AND SellerId = @UserId ) 
            GOTO failedUser ;

        SELECT  @status = BuyerStatusId
        FROM    [Offers_Buyers]
        WHERE   [BuyerId] = @UserId
                AND OfferId = @OfferId

        IF @status IS NULL 
            BEGIN
                INSERT  INTO [dbo].[Offers_Buyers]
                        ( [BuyerId]
                        , [OfferId]
                        , [BuyerStatusId]
                        )
                VALUES  ( @UserId
                        , @OfferId
                        , 1
                        ) ;
                GOTO complete ; 
            END
        ELSE 
            BEGIN
                IF @status = 3 
                    BEGIN
                        UPDATE  [Offers_Buyers]
                        SET     [BuyerStatusId] = 1
                        WHERE   [BuyerId] = @UserId
                                AND [OfferId] = @OfferId
                        GOTO complete ;
                    END ;
                ELSE 
                    GOTO failedUser ;
            END ;			
	
        complete:
        IF @@TRANCOUNT > 0 
            COMMIT TRAN ;
        SELECT  1 ;
        SET @ResultCode = 1 ;
        RETURN @ResultCode ;
		
        failedUser:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SELECT  -1 ;
        SET @ResultCode = -1 ;
        RETURN @ResultCode ;
		
        failedMoney:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SELECT  -2 ;
        SET @ResultCode = -2 ;
        RETURN @ResultCode ;
			
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;
        SELECT  -1 ;
        SET @ResultCode = -1 ;
        RETURN @ResultCode ;	
    END





