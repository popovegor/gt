CREATE TABLE [dbo].[Caches_Configuration] (
    [TypeName]               NVARCHAR (100) NOT NULL,
    [ReloadTimeout]          NVARCHAR (12)  NOT NULL,
    [LoadImmediately]        BIT            NOT NULL,
    [LockTimeout]            NVARCHAR (12)  NOT NULL,
    [CacheExpiration]        NVARCHAR (12)  NOT NULL,
    [PeriodicReloadTimeSpan] NVARCHAR (12)  NOT NULL
);

