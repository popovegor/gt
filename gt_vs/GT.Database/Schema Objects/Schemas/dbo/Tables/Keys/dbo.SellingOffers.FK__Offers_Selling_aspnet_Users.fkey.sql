ALTER TABLE [dbo].[Offers_Selling]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Selling_aspnet_Users] FOREIGN KEY([BuyerId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

ALTER TABLE [dbo].[Offers_Selling] CHECK CONSTRAINT [FK_Offers_Selling_aspnet_Users]
