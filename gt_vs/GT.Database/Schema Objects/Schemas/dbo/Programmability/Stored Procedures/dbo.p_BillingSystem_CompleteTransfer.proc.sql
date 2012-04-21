CREATE PROCEDURE [dbo].[p_BillingSystem_CompleteTransfer] @TransferId INT
AS 
    BEGIN
    
        BEGIN TRAN 
    
        BEGIN TRY 
    
            IF EXISTS ( SELECT TOP ( 1 )
                                'a pending transfer exists'
                        FROM    [dbo].[BillingSystem_Transfers]
                        WHERE   @TransferId = [TransferId]
                                AND StatusId = 2 ) 
                BEGIN 
              
                --set complete status
                    UPDATE  [dbo].[BillingSystem_Transfers]
                    SET     StatusId = 1, StatusModifyDate = GETUTCDATE()
                    WHERE   @TransferId = TransferId
                            AND StatusId = 2
                
                    IF EXISTS ( SELECT TOP ( 1 )
                                        'from a real source to an user'
                                FROM    [dbo].[BillingSystem_Transfers] AS t
                                INNER JOIN [dbo].[BillingSystem_TransferParticipants] AS ftp ON ftp.[TransferParticipantId] = t.[FromTransferParticipantId]
                                INNER JOIN [dbo].[BillingSystem_TransferParticipants] AS ttp ON ttp.[TransferParticipantId] = t.[ToTransferParticipantId]
                                WHERE   t.TransferId = @TransferId
                                        AND ftp.RealMoneySourceId IS NOT NULL
                                        AND ttp.UserId IS NOT NULL ) 
                        BEGIN              
                            EXEC p_Users_AddMoney @TransferId = @TransferId
                        END 
		      
                END 
          
          
        END TRY 
        BEGIN CATCH 
          	
            IF @@TRANCOUNT > 0 
                BEGIN 
                    ROLLBACK TRAN
                    RETURN
                END 
          	
        END CATCH 
            
        IF @@TRANCOUNT > 0 
            BEGIN 
                COMMIT TRAN
            END 
            
        DECLARE @Transfers udtt_Transfers
	
        INSERT  INTO @Transfers
                ( TransferId, RowNumber )
        VALUES  ( @TransferId, 1 )
	
        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
    END 
