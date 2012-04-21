ALTER TABLE [dbo].[Dictionaries_GameServers]
    ADD CONSTRAINT [DF_GameServers_LastUpdate] DEFAULT (GETUTCDATE()) FOR [CreateDateTime];

