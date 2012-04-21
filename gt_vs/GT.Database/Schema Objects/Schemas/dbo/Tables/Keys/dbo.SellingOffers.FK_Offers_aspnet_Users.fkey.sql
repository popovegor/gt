/****** Object:  ForeignKey [FK_Offers_aspnet_Users]    Script Date: 12/15/2009 01:58:18 ******/
/****** Object:  ForeignKey [FK_Offers_aspnet_Users]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[Offers_Selling]  WITH CHECK ADD  CONSTRAINT [FK_Offers_aspnet_Users] FOREIGN KEY([SellerId])
REFERENCES [dbo].[aspnet_Users] ([UserId])


GO
ALTER TABLE [dbo].[Offers_Selling] CHECK CONSTRAINT [FK_Offers_aspnet_Users]


