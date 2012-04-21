CREATE TABLE [dbo].[Offers_Selling]
    (
      [SellingId] [int] IDENTITY(1, 1)
                        NOT NULL
    , [SellerId] [uniqueidentifier] NOT NULL
    , [GameServerId] [int] NOT NULL
    , [Title] [nvarchar](250) NOT NULL
    , [Description] [nvarchar](4000) NULL
    , [Price] [money] NOT NULL
    , [TransactionPhaseId] [int] NOT NULL
    , [CreateDate] [datetime] NOT NULL
    , [UpdateDate] [datetime] NULL
    , [ValidKey] [nvarchar](50) NULL
    , [DeliveryTime] INT NOT NULL
    , [BuyerId] [uniqueidentifier] NULL
    , [ModifyDate] AS ( ISNULL(UpdateDate, CreateDate) ) PERSISTED
                                                         NOT NULL
    , ProductCategoryId INT NULL
    , ProductCategoryMisc nvarchar(100) NULL --if ProductCategoryId = 4 (Misc)
    , CONSTRAINT [PK_Offers] PRIMARY KEY CLUSTERED ( [SellingId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]








