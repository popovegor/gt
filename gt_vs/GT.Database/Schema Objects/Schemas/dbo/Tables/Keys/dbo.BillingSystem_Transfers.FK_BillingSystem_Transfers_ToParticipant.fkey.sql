ALTER TABLE [dbo].[BillingSystem_Transfers]  WITH CHECK ADD  CONSTRAINT [FK_BillingSystem_Transfers_ToParticipant] FOREIGN KEY([ToTransferParticipantId])
REFERENCES [dbo].[BillingSystem_TransferParticipants] ([TransferParticipantId])

GO
ALTER TABLE [dbo].[BillingSystem_Transfers] CHECK CONSTRAINT [FK_BillingSystem_Transfers_ToParticipant]



