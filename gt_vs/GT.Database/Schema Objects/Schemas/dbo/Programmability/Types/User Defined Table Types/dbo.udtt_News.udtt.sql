CREATE TYPE [dbo].[udtt_News] AS TABLE(
	[NewsId] [int] NOT NULL,
	[RowNumber] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[NewsId] ASC
))