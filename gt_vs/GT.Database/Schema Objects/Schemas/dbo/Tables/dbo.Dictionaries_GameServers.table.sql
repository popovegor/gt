CREATE TABLE [dbo].[Dictionaries_GameServers] (
    [GameServerId]   INT            IDENTITY (1, 1) NOT NULL,
    [GameId]         INT            NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [NameRu]         NVARCHAR (100) NOT NULL,
    [Description]    NVARCHAR (MAX) NOT NULL,
    [DescriptionRu]  NVARCHAR (MAX) NOT NULL,
    [Url]			 nvarchar (45)  NULL,
    [CreateDateTime] DATETIME       NOT NULL,
    [UpdateDateTime] DATETIME       NULL
);

