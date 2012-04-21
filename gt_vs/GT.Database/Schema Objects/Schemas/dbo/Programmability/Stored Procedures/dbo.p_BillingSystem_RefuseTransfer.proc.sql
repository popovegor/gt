CREATE PROCEDURE [dbo].[p_BillingSystem_RefuseTransfer] @TransferId INT,
@Note nvarchar(500) = NULL
AS 
    BEGIN
        UPDATE  [dbo].[BillingSystem_Transfers]
        SET     [StatusId] = 4, [Note] = COALESCE(@Note, [Note])
        WHERE   [StatusId] = 2
                AND [TransferId] = @TransferId
        IF @@ROWCOUNT > 0 -- the transfer refused
            AND EXISTS ( SELECT TOP ( 1 ) -- and the transfer from user to real source
                                1
                         FROM   [dbo].[BillingSystem_Transfers] AS t
                         INNER JOIN [dbo].[BillingSystem_TransferParticipants] AS tp ON tp.[TransferParticipantId] = t.[ToTransferParticipantId]
                                                                                        AND tp.[RealMoneySourceId] IS NOT NULL
                         INNER JOIN [dbo].[BillingSystem_TransferParticipants] AS fp ON fp.[TransferParticipantId] = t.[FromTransferParticipantId]
                                                                                        AND fp.[UserId] IS NOT NULL ) 
            BEGIN 
                EXEC [dbo].[p_Users_AddMoney] @TransferId = @TransferId -- int
            END 
            
        DECLARE @Transfers udtt_Transfers
	
        INSERT  INTO @Transfers
                ( TransferId, RowNumber )
        VALUES  ( @TransferId, 1 )
	
        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
    END