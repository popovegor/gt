CREATE TABLE [dbo].[Dictionaries_Games] (
    [GameId]         INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [NameRu]         NVARCHAR (100) NOT NULL,
    [Description]    NVARCHAR (MAX) NULL,
    [DescriptionRu]  NVARCHAR (MAX) NULL,
    [Url]			 nvarchar(45)	NULL,
    [CreateDateTime] DATETIME       NOT NULL,
    [UpdateDateTime] DATETIME       NULL,
    [Priority]       INT            NULL
);

