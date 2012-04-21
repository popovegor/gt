ALTER TABLE [dbo].[Dictionaries_GameServers]
    ADD CONSTRAINT [FK_GameServers_Games] FOREIGN KEY ([GameId]) REFERENCES [dbo].[Dictionaries_Games] ([GameId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

