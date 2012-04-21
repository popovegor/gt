CREATE PROCEDURE [dbo].[p_BillingSystem_AcknowledgeOurCommissionReceipt] @TransferId INT
AS 
    BEGIN 
        UPDATE TOP ( 1 )
                [dbo].[BillingSystem_Transfers]
        SET     OurCommissionRecieved = 1
        WHERE   TransferId = @TransferId
                AND [StatusId] = 1
  
        DECLARE @Transfers udtt_Transfers
	
        INSERT  INTO @Transfers
                ( TransferId, RowNumber )
        VALUES  ( @TransferId, 1 )
	
        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
    END 