ALTER TABLE [dbo].[Caches_Configuration]
    ADD CONSTRAINT [DF_CacheConfigurations_LoadImmediately] DEFAULT ((0)) FOR [LoadImmediately];

