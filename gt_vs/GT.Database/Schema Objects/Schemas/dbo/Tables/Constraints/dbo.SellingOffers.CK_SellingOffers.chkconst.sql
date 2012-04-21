/****** Object:  Check [CK_SellingOffers]    Script Date: 12/15/2009 01:58:18 ******/
/****** Object:  Check [CK_SellingOffers]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[Offers_Selling]  WITH CHECK ADD  CONSTRAINT [CK_SellingOffers] CHECK  (([Price]>(0)))


GO
ALTER TABLE [dbo].[Offers_Selling] CHECK CONSTRAINT [CK_SellingOffers]
