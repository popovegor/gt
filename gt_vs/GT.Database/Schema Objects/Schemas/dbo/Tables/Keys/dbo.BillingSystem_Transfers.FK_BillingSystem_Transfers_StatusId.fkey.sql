ALTER TABLE [dbo].[BillingSystem_Transfers]
	ADD CONSTRAINT [FK_BillingSystem_Transfers_StatusId] 
	FOREIGN KEY (StatusId)
	REFERENCES [dbo].[Dictionaries_TransferStatuses] (TransferStatusId)	

