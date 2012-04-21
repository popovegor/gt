CREATE TABLE [dbo].[Dictionaries_MessageTemplates]
(
	[MessageTemplateId] INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL DEFAULT(N''),
	[Subject] NVARCHAR(500) NOT NULL,
	[SubjectRu] NVARCHAR(500) NOT NULL,
	[Body] NVARCHAR(MAX) NOT NULL,
	[BodyRu] NVARCHAR(MAX) NOT NULL
)
