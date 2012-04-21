/****** Object:  ForeignKey [FK_Cashflow_Participants_RealMoneySources]    Script Date: 01/15/2010 17:42:54 ******/
/****** Object:  ForeignKey [FK_Cashflow_Participants_RealMoneySources]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[BillingSystem_TransferParticipants]  WITH CHECK ADD  CONSTRAINT [FK_Cashflow_Participants_RealMoneySources] FOREIGN KEY([RealMoneySourceId])
REFERENCES [dbo].[Dictionaries_RealMoneySources] ([RealMoneySourceId])


GO
ALTER TABLE [dbo].[BillingSystem_TransferParticipants] CHECK CONSTRAINT [FK_Cashflow_Participants_RealMoneySources]
