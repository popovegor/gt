CREATE TABLE [dbo].[Dictionaries_WebMoneyMessagesTypes](
	[WebMoneyMessageTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](150) NULL,
 CONSTRAINT [PK_Dictionaries_WebMoneyMessagesTypes] PRIMARY KEY CLUSTERED 
(
	[WebMoneyMessageTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]