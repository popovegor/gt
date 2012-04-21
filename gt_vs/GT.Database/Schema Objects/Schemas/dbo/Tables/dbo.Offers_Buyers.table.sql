CREATE TABLE [dbo].[Offers_Buyers](
	[BuyerId] [uniqueidentifier] NOT NULL,
	[OfferId] [int] NOT NULL,
	[BuyerStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Buyers_1] PRIMARY KEY CLUSTERED 
(
	[BuyerId] ASC,
	[OfferId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


