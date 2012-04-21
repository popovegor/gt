ALTER TABLE [dbo].[Dictionaries_WebMoneyMessages]  WITH CHECK ADD  CONSTRAINT [FK_Dictionaries_WebMoneyMessages_Dictionaries_WebMoneyMessagesTypes] FOREIGN KEY([Type])
REFERENCES [dbo].[Dictionaries_WebMoneyMessagesTypes] ([WebMoneyMessageTypeId])
GO

ALTER TABLE [dbo].[Dictionaries_WebMoneyMessages] CHECK CONSTRAINT [FK_Dictionaries_WebMoneyMessages_Dictionaries_WebMoneyMessagesTypes]