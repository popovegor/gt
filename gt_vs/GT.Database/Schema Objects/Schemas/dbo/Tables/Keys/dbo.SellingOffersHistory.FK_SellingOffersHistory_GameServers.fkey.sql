/****** Object:  ForeignKey [FK_SellingOffersHistory_GameServers]    Script Date: 01/15/2010 17:42:54 ******/
/****** Object:  ForeignKey [FK_SellingOffersHistory_GameServers]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[Offers_SellingHistory]  WITH CHECK ADD  CONSTRAINT [FK_SellingOffersHistory_GameServers] FOREIGN KEY([GameServerId])
REFERENCES [dbo].[Dictionaries_GameServers] ([GameServerId])


GO
ALTER TABLE [dbo].[Offers_SellingHistory] CHECK CONSTRAINT [FK_SellingOffersHistory_GameServers]

