CREATE PROCEDURE [dbo].[p_Users_SubMoney]
	@TransferId int
AS
BEGIN 
  
  
  UPDATE  dbo.Users_Dynamics
                    SET     MoneyAvailable -= ISNULL(t.Amount, 0)
                    FROM    [BillingSystem_Transfers] AS t
                            INNER JOIN [BillingSystem_TransferParticipants] AS p ON p.TransferParticipantId = t.FromTransferParticipantId
                    WHERE   dbo.Users_Dynamics.UserId = p.UserId
                            AND t.TransferId = @TransferId AND t.StatusId IN ( 1, 2)
  
END 