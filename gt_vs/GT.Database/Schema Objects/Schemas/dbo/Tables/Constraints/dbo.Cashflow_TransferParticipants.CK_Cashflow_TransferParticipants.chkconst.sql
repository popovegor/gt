/****** Object:  Check [CK_Cashflow_TransferParticipants]    Script Date: 01/15/2010 17:42:54 ******/
/****** Object:  Check [CK_Cashflow_TransferParticipants]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[BillingSystem_TransferParticipants]  WITH CHECK ADD  CONSTRAINT [CK_Cashflow_TransferParticipants] CHECK  (([UserId] IS NOT NULL OR [RealMoneySourceId] IS NOT NULL OR [SellingHistoryId] IS NOT NULL))


GO
ALTER TABLE [dbo].[BillingSystem_TransferParticipants] CHECK CONSTRAINT [CK_Cashflow_TransferParticipants]




GO
ALTER TABLE [dbo].[BillingSystem_TransferParticipants] CHECK CONSTRAINT [CK_Cashflow_TransferParticipants]




GO
ALTER TABLE [dbo].[BillingSystem_TransferParticipants] CHECK CONSTRAINT [CK_Cashflow_TransferParticipants]

