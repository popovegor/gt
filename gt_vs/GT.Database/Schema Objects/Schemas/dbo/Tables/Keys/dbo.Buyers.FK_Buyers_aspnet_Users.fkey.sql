ALTER TABLE [dbo].[Offers_Buyers]  WITH CHECK ADD  CONSTRAINT [FK_Buyers_aspnet_Users] FOREIGN KEY([BuyerId])
REFERENCES [dbo].[aspnet_Users] ([UserId])


GO
ALTER TABLE [dbo].[Offers_Buyers] CHECK CONSTRAINT [FK_Buyers_aspnet_Users]

