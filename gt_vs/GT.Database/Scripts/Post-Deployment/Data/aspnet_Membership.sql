--DELETE [dbo].[aspnet_Membership]

IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    [dbo].[aspnet_Membership]
                WHERE   $(UserId) = UserId ) 
    BEGIN 
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 12/11/2009 20:51:57 ******/
        INSERT  [dbo].[aspnet_Membership]
                ( [ApplicationId]
                , [UserId]
                , [Password]
                , [PasswordFormat]
                , [PasswordSalt]
                , [MobilePIN]
                , [Email]
                , [LoweredEmail]
                , [PasswordQuestion]
                , [PasswordAnswer]
                , [IsApproved]
                , [IsLockedOut]
                , [CreateDate]
                , [LastLoginDate]
                , [LastPasswordChangedDate]
                , [LastLockoutDate]
                , [FailedPasswordAttemptCount]
                , [FailedPasswordAttemptWindowStart]
                , [FailedPasswordAnswerAttemptCount]
                , [FailedPasswordAnswerAttemptWindowStart]
                , [Comment]
                )
        VALUES  ( $(ApplicationId)
                , $(UserId)
                , N'noreplay'
                , 0
                , N'38Ax1wPLdTHvGFkl2ukgPA=='
                , NULL
                , N'noreplay@test.com'
                , N'noreplay@test.com'
                , NULL
                , NULL
                , 1
                , 0
                , CAST(0x00009C7B00E984DC AS DATETIME)
                , CAST(0x00009CC70008F889 AS DATETIME)
                , CAST(0x00009C7B00E984DC AS DATETIME)
                , CAST(0xFFFF2FB300000000 AS DATETIME)
                , 0
                , CAST(0xFFFF2FB300000000 AS DATETIME)
                , 0
                , CAST(0xFFFF2FB300000000 AS DATETIME)
                , NULL
                )

    END 