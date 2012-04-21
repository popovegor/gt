/****** Object:  ForeignKey [FK_Offers_SellingOnBuying_SellingOffers]    Script Date: 12/09/2009 00:17:56 ******/
/****** Object:  ForeignKey [FK_Offers_SellingOnBuying_SellingOffers]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_SuggestedSelling]  WITH CHECK ADD  CONSTRAINT [FK_Offers_SellingOnBuying_SellingOffers] FOREIGN KEY([SellingId])
REFERENCES [dbo].[Offers_Selling] ([SellingId])


GO
ALTER TABLE [dbo].[Offers_SuggestedSelling] CHECK CONSTRAINT [FK_Offers_SellingOnBuying_SellingOffers]