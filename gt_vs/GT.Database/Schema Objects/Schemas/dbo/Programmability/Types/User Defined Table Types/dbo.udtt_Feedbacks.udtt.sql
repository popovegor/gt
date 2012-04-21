/****** Object:  UserDefinedTableType [dbo].[udtt_Votes]    Script Date: 12/17/2009 15:17:10 ******/
CREATE TYPE [dbo].[udtt_Feedbacks] AS TABLE(
	[FeedbackId] [int] NOT NULL,
	[RowNumber] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[FeedbackId] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)


