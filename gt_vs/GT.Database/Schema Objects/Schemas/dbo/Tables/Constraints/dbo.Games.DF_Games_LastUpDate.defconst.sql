ALTER TABLE [dbo].[Dictionaries_Games]
    ADD CONSTRAINT [DF_Games_LastUpDate] DEFAULT (GETUTCDATE()) FOR [CreateDateTime];

