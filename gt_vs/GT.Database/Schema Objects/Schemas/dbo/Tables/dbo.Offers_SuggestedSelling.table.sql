CREATE TABLE [dbo].[Offers_SuggestedSelling](
	[SuggestedSellingId] [int] IDENTITY(1,1) NOT NULL,
	[SellingId] [int] NOT NULL,
	[BuyingOfferId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Offers_SellingOnBuying] PRIMARY KEY CLUSTERED 
(
	[SuggestedSellingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Offers_SellingOnBuying] UNIQUE NONCLUSTERED 
(
	[SellingId] ASC,
	[BuyingOfferId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]





