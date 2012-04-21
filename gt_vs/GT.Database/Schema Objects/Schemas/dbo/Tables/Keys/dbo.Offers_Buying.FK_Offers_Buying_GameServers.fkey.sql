/****** Object:  ForeignKey [FK_Offers_Buying_GameServers]    Script Date: 12/09/2009 00:17:56 ******/
/****** Object:  ForeignKey [FK_Offers_Buying_GameServers]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_Buying]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Buying_GameServers] FOREIGN KEY([GameServerId])
REFERENCES [dbo].[Dictionaries_GameServers] ([GameServerId])


GO
ALTER TABLE [dbo].[Offers_Buying] CHECK CONSTRAINT [FK_Offers_Buying_GameServers]
