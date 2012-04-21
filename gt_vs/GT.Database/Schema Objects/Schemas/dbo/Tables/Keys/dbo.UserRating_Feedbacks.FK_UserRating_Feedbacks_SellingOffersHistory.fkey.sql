/****** Object:  ForeignKey [FK_UserRating_Feedbacks_SellingOffersHistory]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_Feedbacks_SellingOffersHistory] FOREIGN KEY([SellingHistoryId])
REFERENCES [dbo].[Offers_SellingHistory] ([HistorySellingId])


GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [FK_UserRating_Feedbacks_SellingOffersHistory]



