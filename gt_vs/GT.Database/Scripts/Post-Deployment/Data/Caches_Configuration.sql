DELETE  [dbo].[Caches_Configuration]

/****** Object:  Table [dbo].[Caches_Configuration]    Script Date: 12/11/2009 01:18:06 ******/
INSERT  [dbo].[Caches_Configuration]
        ( [TypeName]
        , [ReloadTimeout]
        , [LoadImmediately]
        , [LockTimeout]
        , [CacheExpiration]
        , [PeriodicReloadTimeSpan]
        )
VALUES  ( N'SiteMap'
        , N'00:01:00'
        , 1
        , N'00:00:01'
        , N'00:00:00'
        , N'00:10:00'
        )
INSERT  [dbo].[Caches_Configuration]
        ( [TypeName]
        , [ReloadTimeout]
        , [LoadImmediately]
        , [LockTimeout]
        , [CacheExpiration]
        , [PeriodicReloadTimeSpan]
        )
VALUES  ( N'Dictionaries'
        , N'00:01:00'
        , 1
        , N'00:00:01'
        , N'00:00:00'
        , N'00:10:00'
        )
INSERT  [dbo].[Caches_Configuration]
        ( [TypeName]
        , [ReloadTimeout]
        , [LoadImmediately]
        , [LockTimeout]
        , [CacheExpiration]
        , [PeriodicReloadTimeSpan]
        )
VALUES  ( N'Users'
        , N'00:01:00'
        , 1
        , N'00:00:01'
        , N'00:00:00'
        , N'00:01:00'
        )
INSERT  [dbo].[Caches_Configuration]
        ( [TypeName]
        , [ReloadTimeout]
        , [LoadImmediately]
        , [LockTimeout]
        , [CacheExpiration]
        , [PeriodicReloadTimeSpan]
        )
VALUES  ( N'Statistics'
        , N'00:01:00'
        , 1
        , N'00:00:01'
        , N'00:00:00'
        , N'00:02:00'
        )
