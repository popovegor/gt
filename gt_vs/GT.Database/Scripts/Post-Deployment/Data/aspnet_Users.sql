
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_Users]
                WHERE   UserId = $(UserId) ) 
    BEGIN 

        INSERT  [dbo].[aspnet_Users]
                ( [ApplicationId]
                , [UserId]
                , [UserName]
                , [LoweredUserName]
                , [MobileAlias]
                , [IsAnonymous]
                , [LastActivityDate]
                )
        VALUES  ( $(ApplicationId)
                , $(UserId)
                , N'noreplay'
                , N'noreplay'
                , NULL
                , 0
                , CAST(0x00009CC7000C6473 AS DATETIME)
                )
        
    END 