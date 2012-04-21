/****** Object:  ForeignKey [FK_SellingOffersHistory_TransactionPhases]    Script Date: 01/15/2010 17:42:54 ******/
/****** Object:  ForeignKey [FK_SellingOffersHistory_TransactionPhases]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[Offers_SellingHistory]  WITH CHECK ADD  CONSTRAINT [FK_SellingOffersHistory_TransactionPhases] FOREIGN KEY([TransactionPhaseId])
REFERENCES [dbo].[Dictionaries_TransactionPhases] ([TransactionPhaseId])


GO
ALTER TABLE [dbo].[Offers_SellingHistory] CHECK CONSTRAINT [FK_SellingOffersHistory_TransactionPhases]

