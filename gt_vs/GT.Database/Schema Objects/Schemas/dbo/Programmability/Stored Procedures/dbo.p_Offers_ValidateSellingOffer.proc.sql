CREATE PROCEDURE [dbo].[p_Offers_ValidateSellingOffer]
    @OfferId INT
  , @Key NCHAR(7)
  , @Resultcode INT OUT
AS 
    BEGIN

        BEGIN TRAN ;
	
        DECLARE @curKey NCHAR(7)
          , @res NVARCHAR(100) ;
	
        SELECT  @curKey = [ValidKey]
        FROM    [Offers_Selling]
        WHERE   [SellingId] = @OfferId
                AND [TransactionPhaseId] = 3 ;													 
													 
        IF ( @@ROWCOUNT <= 0 ) 
            GOTO failedOffer ;
		
        IF ( @curKey = @Key ) 
            BEGIN
                SET @res = 'Valid Offer' ;
                SET @Resultcode = 1 ;
            END ;
        ELSE 
            BEGIN
                SET @res = 'Invalid Offer' ;
                SET @Resultcode = -2 ;
            END ;


        DECLARE @HistoryId INT

        EXEC @HistoryId = [p_Offers_AddSellingToHistory] @OfferId = @OfferId, @Note = @res 

        SELECT  @HistoryId

        IF @@TRANCOUNT > 0 
            COMMIT TRAN ;
        RETURN @Resultcode ;
	
        failedOffer:
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN ;

    END

