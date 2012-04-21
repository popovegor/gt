CREATE TRIGGER [RealMoneySourceCheck]
    ON [dbo].[BillingSystem_WebMoney]
    FOR INSERT, UPDATE 
    AS 
    BEGIN
    	SET NOCOUNT ON
    	
    	declare @rs1 int, @rs2 int, @tid int;
    	
       	SELECT @tid = [TransferId]
    	FROM inserted
    	
		SELECT @rs1 = tp.RealMoneySourceId
		FROM [BillingSystem_Transfers] as t
		INNER JOIN [BillingSystem_TransferParticipants] as tp ON t.FromTransferParticipantId = tp.TransferParticipantId
		WHERE t.TransferId = @tid

		SELECT @rs2 = tp.RealMoneySourceId
		FROM [BillingSystem_Transfers] as t
		INNER JOIN [BillingSystem_TransferParticipants] as tp ON t.ToTransferParticipantId = tp.TransferParticipantId
		WHERE t.TransferId = @tid
			
		IF ( (@rs1 is null or @rs1 != 2) and
			 (@rs2 is null or @rs2 != 2)
			)
			BEGIN
				ROLLBACK;
			END
		
    END
