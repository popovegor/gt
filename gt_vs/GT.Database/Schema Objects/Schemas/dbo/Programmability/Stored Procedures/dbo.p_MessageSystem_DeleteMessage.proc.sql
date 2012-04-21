CREATE PROCEDURE [dbo].[p_MessageSystem_DeleteMessage] @Message XML
AS 
    BEGIN


        UPDATE  [MessageSystem_Messages]
        SET     Deleted = 1
        WHERE   MessageId = @Message.value('(/m/@mid)[1]', 'int')
	
        DECLARE @Messages udtt_Messages
	
        INSERT  INTO @Messages(MessageId, RowNumber)
                SELECT  MessageId
                      , 1
                FROM    [MessageSystem_Messages] AS m
                WHERE   m.MessageId = @Message.value('(/m/@mid)[1]', 'int')
                        AND Deleted = 1
	
        EXEC [p_MessageSystem_GetMessagesInternal] @Messages = @Messages
	
    END
