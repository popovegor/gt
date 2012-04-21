/****** Object:  ForeignKey [FK_Offers_BuyingHistory_aspnet_Users]    Script Date: 12/09/2009 00:57:10 ******/
/****** Object:  ForeignKey [FK_Offers_BuyingHistory_aspnet_Users]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_BuyingHistory]  WITH CHECK ADD  CONSTRAINT [FK_Offers_BuyingHistory_aspnet_Users] FOREIGN KEY([BuyerId])
REFERENCES [dbo].[aspnet_Users] ([UserId])


GO
ALTER TABLE [dbo].[Offers_BuyingHistory] CHECK CONSTRAINT [FK_Offers_BuyingHistory_aspnet_Users]

