CREATE TABLE [dbo].[Offers_SellingImages]
    (
      [SellingImageId] [int] IDENTITY(1, 1)
                             NOT NULL
    , [SellingId] [int] NOT NULL
    , [ImageName] NVARCHAR(500) NOT NULL
    , [Image] VARBINARY(MAX) NOT NULL
    , CONSTRAINT [PK_Offers_SellingImages] PRIMARY KEY CLUSTERED ( [SellingImageId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]