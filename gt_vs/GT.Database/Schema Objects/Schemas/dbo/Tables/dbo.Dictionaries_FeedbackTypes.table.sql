CREATE TABLE [dbo].[Dictionaries_FeedbackTypes](
	[FeedbackTypeId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[NameRu] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[DescriptionRu] [nvarchar](500) NULL,
 CONSTRAINT [PK_FeedbackTypes] PRIMARY KEY CLUSTERED 
(
	[FeedbackTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]





