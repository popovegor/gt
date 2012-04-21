ALTER TABLE [dbo].[BillingSystem_Transfers]
	ADD CONSTRAINT [CK_BillingSystem_Transfers_CheckMinTransferAmount] 
	CHECK  ([dbo].f_BillingSystem_CheckMinTransferAmount(TransferId) = 1)
