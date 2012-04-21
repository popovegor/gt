CREATE PROCEDURE [dbo].[p_BillingSystem_GetTransferById]
	@TransferId int
AS
	BEGIN

	SET NOCOUNT ON ;
	
	 DECLARE @Transfers udtt_Transfers
	
        INSERT  INTO @Transfers
                ( TransferId, RowNumber )
        VALUES  ( @TransferId, 1 )
	
        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
        
	RETURN 0
	
	END