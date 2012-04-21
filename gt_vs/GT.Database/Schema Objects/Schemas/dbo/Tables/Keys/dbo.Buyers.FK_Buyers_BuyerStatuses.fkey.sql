ALTER TABLE [dbo].[Offers_Buyers]  WITH CHECK ADD  CONSTRAINT [FK_Buyers_BuyerStatuses] FOREIGN KEY([BuyerStatusId])
REFERENCES [dbo].[Dictionaries_BuyerStatuses] ([BuyerStatusId])


GO
ALTER TABLE [dbo].[Offers_Buyers] CHECK CONSTRAINT [FK_Buyers_BuyerStatuses]

