CREATE PROCEDURE [dbo].[p_Users_AddMoney] @TransferId INT
AS 
    BEGIN 
        UPDATE  dbo.Users_Dynamics
        SET     MoneyAvailable += ISNULL(t.Amount, 0)
        FROM    [BillingSystem_Transfers] AS t
                            --INNER JOIN [BillingSystem_TransferParticipants] AS p ON p.TransferParticipantId = t.ToTransferParticipantId
        WHERE   t.TransferId = @TransferId
                AND ( ( t.StatusId = 1 --top up account
                        AND [dbo].[Users_Dynamics].UserId = ( SELECT TOP ( 1 )
                                                                        p.[UserId]
                                                              FROM      [dbo].[BillingSystem_TransferParticipants] AS p
                                                              WHERE     p.[TransferParticipantId] = t.[ToTransferParticipantId]
                                                            )
                      )
                      OR ( t.StatusId = 4 --refuse transfer
                           AND [dbo].[Users_Dynamics].UserId = ( SELECT TOP ( 1 )
                                                                        p.[UserId]
                                                                 FROM   [dbo].[BillingSystem_TransferParticipants] AS p
                                                                 WHERE  p.[TransferParticipantId] = t.[FromTransferParticipantId]
                                                               )
                         )
                    )
                            
    END