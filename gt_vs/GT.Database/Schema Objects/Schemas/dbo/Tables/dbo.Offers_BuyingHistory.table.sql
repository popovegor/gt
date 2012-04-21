CREATE TABLE [dbo].[Offers_BuyingHistory]
    (
      [HistoryOfferId] [int] IDENTITY(1, 1)
                             NOT NULL
    , [HistoryOfferCreateDate] [datetime] NOT NULL
    , [BuyingOfferId] [int] NOT NULL
    , [BuyerId] [uniqueidentifier] NOT NULL
    , [GameServerId] [int] NOT NULL
    , [Title] [nvarchar](250) NOT NULL
    , [Description] [nvarchar](4000) NULL
    , [Price] [money] NULL
    , [CreateDate] [datetime] NOT NULL
    , [UpdateDate] [datetime] NULL
    , [ModifyDate] DATETIME NULL
    , ProductCategoryId INT NULL
    , ProductCategoryMisc nvarchar(100) NULL --if ProductCategoryId = 4 (Misc)
    , CONSTRAINT [PK_Offers_BuyingHistory] PRIMARY KEY CLUSTERED ( [HistoryOfferId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]





