CREATE PROCEDURE [dbo].[p_MessageSystem_ReadMessage] @Message XML--(xs_Messages_Message)
AS 
    BEGIN
	
        SET NOCOUNT ON ;

        UPDATE  [MessageSystem_Messages]
        SET     Unread = 0
        WHERE   [MessageSystem_Messages].RecipientId = @Message.value('(/m/@rid)[1]', 'uniqueidentifier')
                AND [MessageSystem_Messages].MessageId = @Message.value('(/m/@mid)[1]', 'int')
	
        DECLARE @Messages udtt_Messages
	
        INSERT  INTO @Messages(MessageId, RowNumber)
        VALUES  ( @Message.value('(/m/@mid)[1]', 'int'), 1 )
	
	
        EXEC [p_MessageSystem_GetMessagesInternal] @Messages = @Messages
	
    END
