CREATE TABLE [dbo].[Offers_Buying]
    (
      [BuyingOfferId] [int] IDENTITY(1, 1)
                            NOT NULL
    , [BuyerId] [uniqueidentifier] NOT NULL
    , [GameServerId] [int] NOT NULL
    , [Title] [nvarchar](250) NOT NULL
    , [Description] [nvarchar](4000) NULL
    , [Price] [money] NULL
    , [CreateDate] [datetime] NOT NULL
                              DEFAULT ( GETUTCDATE() )
    , [UpdateDate] [datetime] NULL
    , [ModifyDate] AS ( ISNULL(UpdateDate, CreateDate) ) PERSISTED
                                                         NOT NULL
    , ProductCategoryId INT NULL
    , ProductCategoryMisc NVARCHAR(100) NULL --if ProductCategoryId = 4 (Misc)
    , CONSTRAINT [PK_Offers_Buying] PRIMARY KEY CLUSTERED ( [BuyingOfferId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]
