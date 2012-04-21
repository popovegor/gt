CREATE TABLE [dbo].[News](
	[NewsId] [int] IDENTITY(1, 1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Body] [nvarchar](MAX) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[TitleRu] [nvarchar](150) NULL,
	[BodyRu] [nvarchar](MAX) NULL
    CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
	(
		[NewsId] ASC
	) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON  [PRIMARY]