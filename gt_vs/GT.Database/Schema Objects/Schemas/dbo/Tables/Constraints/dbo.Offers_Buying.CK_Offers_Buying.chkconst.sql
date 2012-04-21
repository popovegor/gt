/****** Object:  Check [CK_Offers_Buying]    Script Date: 12/09/2009 00:17:56 ******/
/****** Object:  Check [CK_Offers_Buying]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_Buying]  WITH CHECK ADD  CONSTRAINT [CK_Offers_Buying] CHECK  ((isnull([price],(0))>=(0)))


GO
ALTER TABLE [dbo].[Offers_Buying] CHECK CONSTRAINT [CK_Offers_Buying]




GO
ALTER TABLE [dbo].[Offers_Buying] CHECK CONSTRAINT [CK_Offers_Buying]

