IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'common' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'common'
                , N'1'
                , 1
                )
    END 

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'health monitoring' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'health monitoring'
                , N'1'
                , 1
                )
    END 
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'membership' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'membership'
                , N'1'
                , 1
                )
    END 
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'personalization' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'personalization'
                , N'1'
                , 1
                )
    END 
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'profile' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'profile'
                , N'1'
                , 1
                )
    END 
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_SchemaVersions]
                WHERE   [Feature] = N'role manager' ) 
    BEGIN 
        INSERT  [dbo].[aspnet_SchemaVersions]
                ( [Feature]
                , [CompatibleSchemaVersion]
                , [IsCurrentVersion]
                )
        VALUES  ( N'role manager'
                , N'1'
                , 1
                )
    END 