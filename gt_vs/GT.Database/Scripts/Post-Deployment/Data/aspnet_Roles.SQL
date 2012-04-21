
;
MERGE INTO [dbo].[aspnet_Roles] AS t
    USING 
        ( SELECT    $(ApplicationId) AS [ApplicationId]
                  , N'2cb47974-9e92-4a49-ad52-f5a272aa6e85' AS [RoleId]
                  , N'NonactivatedUser' AS [RoleName]
                  , N'NonactivatedUser' AS [LoweredRoleName]
                  , NULL AS [Description]
          UNION
          SELECT    $(ApplicationId) AS [ApplicationId]
                  , N'5b1eccd4-ae92-488d-a660-b04110eb30dd' AS [RoleId]
                  , N'User' AS [RoleName]
                  , N'user' AS [LoweredRoleName]
                  , NULL AS [Description]
        ) AS s
    ON ( t.[RoleId] = s.[RoleId] )
    WHEN MATCHED 
        THEN 
  UPDATE  SET
            t.[ApplicationId] = s.[ApplicationId]
          , t.[RoleName] = s.[RoleName]
          , t.[LoweredRoleName] = s.[LoweredRoleName]
          , t.[Description] = s.[Description]
    WHEN NOT MATCHED BY TARGET 
        THEN 
  INSERT    (
              [ApplicationId]
            , [RoleId]
            , [RoleName]
            , [LoweredRoleName]
            , [Description]
            )
          VALUES
            ( s.[ApplicationId]
            , s.[RoleId]
            , s.[RoleName]
            , s.[LoweredRoleName]
            , s.[Description]
            )
    WHEN NOT MATCHED BY SOURCE 
        THEN
  DELETE ;

