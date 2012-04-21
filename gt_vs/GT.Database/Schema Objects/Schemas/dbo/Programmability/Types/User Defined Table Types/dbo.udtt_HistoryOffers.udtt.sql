/****** Object:  UserDefinedTableType [dbo].[udtt_HistoryOffers]    Script Date: 01/15/2010 17:42:57 ******/
CREATE TYPE [dbo].[udtt_HistoryOffers] AS TABLE(
	[HistoryOfferId] [int] NOT NULL,
	[RowNumber] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[HistoryOfferId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)


