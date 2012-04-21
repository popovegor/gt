CREATE TABLE [dbo].[Dictionaries_TransactionPhases](
	[TransactionPhaseId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[NameRu] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[DescriptionRu] [nvarchar](500) NULL,
	
 CONSTRAINT [PK_TransactionPhases] PRIMARY KEY CLUSTERED 
(
	[TransactionPhaseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


