ALTER TABLE [dbo].[Caches_Configuration]
    ADD CONSTRAINT [DF_CacheConfigurations_CacheExpiration] DEFAULT (N'00:00:00') FOR [CacheExpiration];

