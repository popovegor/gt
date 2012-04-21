/****** Object:  Check [CK_Offers_BuyingHistory]    Script Date: 12/09/2009 00:57:10 ******/
/****** Object:  Check [CK_Offers_BuyingHistory]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_BuyingHistory]  WITH CHECK ADD  CONSTRAINT [CK_Offers_BuyingHistory] CHECK  ((isnull([Price],(0))>=(0)))


GO
ALTER TABLE [dbo].[Offers_BuyingHistory] CHECK CONSTRAINT [CK_Offers_BuyingHistory]




GO
ALTER TABLE [dbo].[Offers_BuyingHistory] CHECK CONSTRAINT [CK_Offers_BuyingHistory]

