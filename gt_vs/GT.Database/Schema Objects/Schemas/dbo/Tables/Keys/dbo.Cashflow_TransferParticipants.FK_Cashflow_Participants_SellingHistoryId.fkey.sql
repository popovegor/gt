ALTER TABLE [dbo].[BillingSystem_TransferParticipants]
	ADD CONSTRAINT [FK_Cashflow_Participants_SellingHistoryId] 
	FOREIGN KEY ([SellingHistoryId])
	REFERENCES [dbo].[Offers_SellingHistory] ([HistorySellingId])	
