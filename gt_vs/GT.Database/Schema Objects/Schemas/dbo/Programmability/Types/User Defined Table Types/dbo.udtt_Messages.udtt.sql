CREATE TYPE [dbo].[udtt_Messages] AS  TABLE (
    [MessageId] INT NOT NULL,
    [RowNumber] INT NULL,
    [ConversationId] INT NULL,
    [MessagesInConversation] INT NULL,
    PRIMARY KEY CLUSTERED ([MessageId] ASC));

