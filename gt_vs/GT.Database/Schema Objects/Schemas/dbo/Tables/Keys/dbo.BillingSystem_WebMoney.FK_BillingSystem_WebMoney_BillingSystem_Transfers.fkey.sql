ALTER TABLE [BillingSystem_WebMoney]
	WITH CHECK ADD CONSTRAINT [FK_BillingSystem_WebMoney_BillingSystem_Transfers] 
	FOREIGN KEY ([TransferId])
	REFERENCES [BillingSystem_Transfers] ([TransferId])	

