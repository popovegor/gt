CREATE TYPE [dbo].[udtt_WebMoney] AS TABLE (
	[Id] [int] NOT NULL,
	[RowNumber] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)