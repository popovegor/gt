CREATE TABLE [dbo].[Dictionaries_WebMoneyMessages](
	[WebMoneyMessageId] [int] IDENTITY (1, 1) NOT NULL,
	[Retcode] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Message] [nvarchar](500) NULL,
	[MessageRu] [nvarchar](500) NULL,
	[Description] [nvarchar](500) NULL
 CONSTRAINT [PK_Dictionaries_WebMoneyMessages] PRIMARY KEY CLUSTERED 
(
	[WebMoneyMessageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]