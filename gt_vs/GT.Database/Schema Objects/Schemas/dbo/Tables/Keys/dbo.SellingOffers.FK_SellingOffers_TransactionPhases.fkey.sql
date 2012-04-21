/****** Object:  ForeignKey [FK_SellingOffers_TransactionPhases]    Script Date: 12/15/2009 01:58:18 ******/
/****** Object:  ForeignKey [FK_SellingOffers_TransactionPhases]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[Offers_Selling]  WITH CHECK ADD  CONSTRAINT [FK_SellingOffers_TransactionPhases] FOREIGN KEY([TransactionPhaseId])
REFERENCES [dbo].[Dictionaries_TransactionPhases] ([TransactionPhaseId])


GO
ALTER TABLE [dbo].[Offers_Selling] CHECK CONSTRAINT [FK_SellingOffers_TransactionPhases]

