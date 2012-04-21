CREATE PROCEDURE [dbo].[p_BillingSystem_GetTransfersByStatus] @Status INT
AS 
    BEGIN
	
        DECLARE @Transfers udtt_Transfers
		
        INSERT  INTO @Transfers
                ( TransferId
                , RowNumber
                )
                SELECT  t.TransferId
                      , ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC )
                FROM    [BillingSystem_Transfers] AS t
                WHERE   t.StatusId = @Status

        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
		
    END