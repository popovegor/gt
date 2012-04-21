/****** Object:  Default [DF_Money_CashFlow_CreateDate]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[BillingSystem_Transfers] ADD  CONSTRAINT [DF_Money_CashFlow_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]




