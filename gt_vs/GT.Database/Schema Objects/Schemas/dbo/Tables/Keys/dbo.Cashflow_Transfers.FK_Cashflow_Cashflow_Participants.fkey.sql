/****** Object:  ForeignKey [FK_Cashflow_Cashflow_Participants]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[BillingSystem_Transfers]  WITH CHECK ADD  CONSTRAINT [FK_Cashflow_Cashflow_Participants] FOREIGN KEY([FromTransferParticipantId])
REFERENCES [dbo].[BillingSystem_TransferParticipants] ([TransferParticipantId])


GO
ALTER TABLE [dbo].[BillingSystem_Transfers] CHECK CONSTRAINT [FK_Cashflow_Cashflow_Participants]



