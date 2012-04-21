ALTER TABLE [dbo].[Offers_Buyers]  WITH CHECK ADD  CONSTRAINT [FK_Buyers_SellingOffers] FOREIGN KEY([OfferId])
REFERENCES [dbo].[Offers_Selling] ([SellingId])


GO
ALTER TABLE [dbo].[Offers_Buyers] CHECK CONSTRAINT [FK_Buyers_SellingOffers]

