ALTER TABLE [dbo].[Offers_SellingHistory]  WITH CHECK ADD  CONSTRAINT [FK_Offers_SellingHistory_aspnet_Users] FOREIGN KEY([BuyerId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO

ALTER TABLE [dbo].[Offers_SellingHistory] CHECK CONSTRAINT [FK_Offers_SellingHistory_aspnet_Users]