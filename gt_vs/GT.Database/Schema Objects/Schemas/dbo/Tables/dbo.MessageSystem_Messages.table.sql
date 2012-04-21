CREATE TABLE [dbo].[MessageSystem_Messages] (
    [MessageId]   INT              IDENTITY (1, 1) NOT NULL,
    [SenderId]    UNIQUEIDENTIFIER NOT NULL,
    [RecipientId] UNIQUEIDENTIFIER NOT NULL,
    [Body]        NVARCHAR (max)   NULL,
    [BodyRu]      NVARCHAR(max)    NULL,
    [Unread]      BIT              NOT NULL,
    [CreateDate]  DATETIME         NOT NULL,
    [Deleted]     BIT              NOT NULL
);

